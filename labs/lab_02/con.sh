#!/bin/bash

rm -f res.sql

for ((i = 1; i < 26; i++)) 
do
    echo -e "-- Request ${i}\n\n" >> res.sql

    if [[ $i -le 9 ]]
    then
        cat req0${i}.sql >> res.sql
    else
        cat req${i}.sql >> res.sql
    fi

    echo -e "\n\n" >> res.sql
done
