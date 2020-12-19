package Linq;

import java.sql.*;
import java.util.*;
import java.util.function.BiConsumer;
import java.util.function.Predicate;
import java.util.stream.*;

import Models.CweORM;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import com.j256.ormlite.dao.Dao;
import com.j256.ormlite.dao.DaoManager;
import com.j256.ormlite.dao.GenericRawResults;
import com.j256.ormlite.stmt.*;
import com.j256.ormlite.support.ConnectionSource;

import Models.Error;
import Models.Analyzer;
import Models.ErrorORM;

public class Requester {
    static private Dao<ErrorORM, Integer> errorDao;
    static private Dao<CweORM, Integer> cweDao;

    static private DeleteBuilder<ErrorORM, Integer> deleteBuilder;
    static private UpdateBuilder<ErrorORM, Integer> updateBuilder;
    static private QueryBuilder<ErrorORM, Integer> statementBuilder;

    static private QueryBuilder<CweORM, Integer> queryBuilderCWE;
    static private QueryBuilder<ErrorORM, Integer> queryBuilderError;

    static private List<Analyzer> getAnalyzers(Connection conn) throws SQLException {
        String query = "SELECT * FROM analyzers";
        List<Analyzer> analyzers = new ArrayList<Analyzer>();

        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            ResultSet res = pstmt.executeQuery();

            while (res.next()) {
                Analyzer analyzer = new Analyzer();

                analyzer.setName(res.getString("name"));
                analyzer.setHomepage(res.getString("homepage"));
                analyzer.setDescription(res.getString("description"));
                analyzer.setLanguages(res.getString("languages"));
                analyzer.setDownloads(res.getInt("downloads"));
                analyzer.setPrice(res.getInt("price"));

                analyzers.add(analyzer);
            }

        } catch (SQLException err) {
            System.err.println(err.getMessage());
        }

        return analyzers;
    }

    public static <T, A, R> Collector<T, ?, R> filtering(
            Predicate<? super T> predicate, Collector<? super T, A, R> downstream) {

        BiConsumer<A, ? super T> accumulator = downstream.accumulator();
        return Collector.of(downstream.supplier(),
                (r, t) -> { if(predicate.test(t)) accumulator.accept(r, t); },
                downstream.combiner(), downstream.finisher(),
                downstream.characteristics().toArray(new Collector.Characteristics[0]));
    }

    static private List<Error> getErrors(Connection conn) throws SQLException {
        String query = "SELECT * FROM errors";
        List<Error> errors = new ArrayList<Error>();

        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            ResultSet res = pstmt.executeQuery();

            while (res.next()) {
                Error err = new Error();

                err.setId(res.getInt("id"));
                err.setCweId(res.getInt("cwe_id"));
                err.setDescription(res.getString("description"));
                err.setAnalyzerName(res.getString("analyzer_name"));
                err.setPercentage(res.getDouble("percentage"));
                err.setDangerLevel(res.getInt("danger_level"));
                err.setPrice(res.getInt("price"));

                errors.add(err);
            }

        } catch (SQLException err) {
            System.err.println(err.getMessage());
        }

        return errors;
    }

    static public void linqToObject(Connection connection) throws SQLException {
        List<Error> errors = getErrors(connection);

        System.out.println("Order errors by ID:");
        Collections.sort(errors, (v1, v2) -> {
            return v1.getId() - v2.getId();
        });
        errors.stream().forEach(System.out::println);

        System.out.println("Errors where price < 1000");
        errors.stream().filter(err -> err.getPrice() < 1000).forEach(System.out::println);

        System.out.println("Group errors by danger level");
        Map<Integer, List<Error>> groupedErrors = errors.stream().collect(Collectors.groupingBy(Error::getDangerLevel));
        System.out.println(groupedErrors);

        System.out.println("Group errors by danger level && having price < 1000");
        Map<Integer, List<Error>> groupedFormattedErrors =
                errors.stream().collect(Collectors.groupingBy(Error::getDangerLevel,
                        filtering(e -> e.getPrice() < 1000, Collectors.toList())));
        System.out.println(groupedFormattedErrors);

        System.out.println("Price of sum all errors: ");
        int sum = errors.stream().reduce(0, (acc, err) -> err.getPrice() + acc, Integer::sum);
        System.out.println(sum);
    }

    static public void linqToJson(Connection connection) throws SQLException {
        List<Error> errors = getErrors(connection);
        Gson gson = new Gson();
        String jsonError = gson.toJson(errors);
        System.out.println(jsonError);

        List<Error> getFromJson = gson.fromJson(jsonError, new TypeToken<List<Error>>(){}.getType());
        System.out.println(getFromJson);

        // 2
        for (Error err: getFromJson) {
            err.setPrice(err.getPrice() * 2);
        }

        jsonError = gson.toJson(getFromJson);
        System.out.println(jsonError);

        // 3
        getFromJson.add(errors.get(0));
        jsonError =  gson.toJson(getFromJson);
        System.out.println(jsonError);
    }

    static public void linqToSql(ConnectionSource connSource) throws SQLException {
        errorDao = DaoManager.createDao(connSource, ErrorORM.class);
        cweDao = DaoManager.createDao(connSource, CweORM.class);

        /*
        List<ErrorORM> accounts = errorDao.queryForAll();
        List<CweORM> cwe = cweDao.queryForAll();


        for (CweORM cwex: cwe) {
            System.out.println(cwex);
        }

        for (ErrorORM err: accounts) {
            System.out.println(err);
        }
        */

        // 1
        statementBuilder = errorDao.queryBuilder();
        statementBuilder.where().lt("CWE_ID", 500);
        List<ErrorORM> errors = errorDao.query(statementBuilder.prepare());
        System.out.println(errors);

        // 2
        GenericRawResults<String[]> rawResults =
                errorDao.queryRaw(
                        "SELECT errors.id, errors.cwe_id, analyzer_name, status FROM ERRORS JOIN cwe ON errors.cwe_id = cwe.cwe_id");

        for (String[] res: rawResults) {
            System.out.println(
                    String.format(
                            "Error id: %s \t|\t CWE ID %s \t|\t Analyzer name: %s \t|\t Status: %s", res[0], res[1], res[2], res[3]));
        }


        // 3
        ErrorORM error = new ErrorORM(1, "No Description", "clang-tidy", 25.5, 5, 100);
        System.out.println(error.getPrice());
        //errorDao.create(error);

        deleteBuilder = errorDao.deleteBuilder();
        deleteBuilder.where().eq("ID", 1);
        deleteBuilder.delete();

        updateBuilder = errorDao.updateBuilder();
        updateBuilder.where().eq("CWE_ID", 530);
        updateBuilder.updateColumnValue("PRICE", 1500);
        updateBuilder.update();

        // 4

        errorDao.updateRaw("{call UpdatePrice('clang-tidy', 200)}");

        //UpdateBuilder<>
    }

}
