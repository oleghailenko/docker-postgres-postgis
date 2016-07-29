# docker-postgres-postgis
Simple Docker image, that contain PostgreSQL 9.5 and PostGIS 2.2

Make sure, that you have installed Docker engine.

#Build
> docker build -t oleghailenko/postgres-postgis .

#Run first time
> docker run --name postgres-postgis -d -p 5445:5432 -t oleghailenko/postgres-postgis

#Commect using psql cli tool
> PG_PASS=password psql -h localhost -p 5445 -U user -w db

#Stoping
> docker stop postgres-postgis

#Starting
> docker start postgres-postgis
