#!/usr/bin/env sh

#SCRIPTDIR=`dirname $0`

echo "preparing postgresql configs"

PGUSER=postgres

docker exec -it db-async-postgres-1 psql -U postgres -d 'postgres' -c 'create database  netty_driver_test'
docker exec -it db-async-postgres-1 psql -U postgres -d 'postgres' -c 'create database netty_driver_time_test'
docker exec -it db-async-postgres-1 psql -U postgres -d 'postgres' -c "alter database netty_driver_time_test set timezone to 'GMT'"
docker exec -it db-async-postgres-1 psql -U postgres -d 'netty_driver_test' -c "create table transaction_test ( id varchar(255) not null, constraint id_unique primary key (id))"
docker exec -it db-async-postgres-1 psql -U postgres -d 'postgres' -c "CREATE USER postgres_md5 WITH PASSWORD 'postgres_md5'; GRANT ALL PRIVILEGES ON DATABASE netty_driver_test to postgres_md5;"
docker exec -it db-async-postgres-1 psql -U postgres -d 'postgres' -c "CREATE USER postgres_cleartext WITH PASSWORD 'postgres_cleartext'; GRANT ALL PRIVILEGES ON DATABASE netty_driver_test to postgres_cleartext;"
docker exec -it db-async-postgres-1 psql -U postgres -d 'postgres' -c "CREATE USER postgres_kerberos WITH PASSWORD 'postgres_kerberos'; GRANT ALL PRIVILEGES ON DATABASE netty_driver_test to postgres_kerberos;"
docker exec -it db-async-postgres-1 psql -U postgres -d 'netty_driver_test' -c "CREATE TYPE example_mood AS ENUM ('sad', 'ok', 'happy');"

echo "Great success!!"

#sudo chmod 666 $PGCONF/pg_hba.conf
#
#echo "pg_hba.conf goes as follows"
#cat "$PGCONF/pg_hba.conf"
#
#sudo echo "local    all             all                                     trust"    >  $PGCONF/pg_hba.conf
#sudo echo "host     all             postgres           127.0.0.1/32         trust"    >> $PGCONF/pg_hba.conf
#sudo echo "host     all             postgres_md5       127.0.0.1/32         md5"      >> $PGCONF/pg_hba.conf
#sudo echo "host     all             postgres_cleartext 127.0.0.1/32         password" >> $PGCONF/pg_hba.conf
#sudo echo "host     all             postgres_kerberos  127.0.0.1/32         krb5"     >> $PGCONF/pg_hba.conf
#
#echo "pg_hba.conf is now like"
#cat "$PGCONF/pg_hba.conf"
#
#sudo chmod 600 $PGCONF/pg_hba.conf
#
#sudo cp -f $SCRIPTDIR/server.crt $SCRIPTDIR/server.key $PGDATA
#
#sudo /etc/init.d/postgresql restart