FROM ubuntu:16.04

MAINTAINER Oleg Hailenko <oleg.hailenko@pragmasoft.com.ua>

RUN apt-get update && apt-get install -y postgresql postgis postgresql-9.5-postgis-2.2

RUN /bin/echo -e "                                                                \
        host    all             all     0.0.0.0/0   trust                      \n \
    " >> /etc/postgresql/9.5/main/pg_hba.conf                                     \
    && /bin/echo -e "                                                             \
        listen_addresses = '*'                                                 \n \
        port = 5432                                                            \n \
        wal_level = hot_standby                                                \n \
        max_wal_senders = 5                                                    \n \
        wal_keep_segments = 32                                                 \n \
    " >> /etc/postgresql/9.5/main/postgresql.conf

USER postgres

RUN /etc/init.d/postgresql start &&                                               \
psql -c "CREATE USER \"user\" WITH PASSWORD 'password';" &&                           \
psql -c "CREATE DATABASE db WITH OWNER \"user\";"  &&                                 \
psql -c "CREATE EXTENSION postgis; CREATE EXTENSION postgis_topology;" db

EXPOSE 5432

CMD /usr/lib/postgresql/9.5/bin/postgres -D /var/lib/postgresql/9.5/main -c config_file=/etc/postgresql/9.5/main/postgresql.conf
