SET SERVEROUTPUT ON;

DECLARE
    reviews_t CLOB;
BEGIN
    SELECT reviews INTO reviews_t FROM fixers WHERE id = 1;
    DBMS_OUTPUT.put_line(pljson(reviews_t).to_char);
END;
/

DECLARE
    reviews_t CLOB;
    alexey_review VARCHAR2(64);
BEGIN
    SELECT reviews INTO reviews_t FROM fixers WHERE id = 1;
    alexey_review := pljson(reviews_t).get_string('Alexey');
    DBMS_OUTPUT.put_line(alexey_review);
END;
/

DECLARE
    reviews_t CLOB;
BEGIN
    SELECT reviews INTO reviews_t FROM fixers WHERE id = 1;
    IF pljson(reviews_t).exist('Tatyana') THEN
        DBMS_OUTPUT.put_line('Tatyana review exists!');
    ELSE
        DBMS_OUTPUT.put_line('Tatyana review doesnt exists!');
    END IF;
END;
/

DECLARE
    reviews_t CLOB;
    temp PLJSON;
BEGIN 
    SELECT reviews INTO reviews_t FROM fixers WHERE id = 1;
    temp := pljson(reviews_t);
    temp.put('Anton', '10 / 10');
    UPDATE fixers SET reviews = TO_CLOB(temp.to_char) WHERE id = 1;
END;
/

DECLARE
    reviews_t CLOB;
    temp_obj PLJSON;
    temp_lst PLJSON_LIST := PLJSON_LIST();
BEGIN
    FOR table_row IN (
        SELECT reviews FROM fixers
    ) LOOP
        temp_obj := pljson(table_row.reviews);
        temp_lst.append(temp_obj.to_json_value);
    END LOOP;

    FOR i IN 1..temp_lst.count
    LOOP 
        pljson(temp_lst.get(i)).print;
    END LOOP;
END;
/


