#!/bin/bash

docker compose -d --env-file ./db.env -p 1521:1521 -p 5500:5500 -it --name "docker-oracle-db" --shm-size="4g" container-registry.oracle.com/database/standard 
