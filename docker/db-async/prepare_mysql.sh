#!/usr/bin/env sh

echo "Preparing MySQL configs"
docker exec -it db-async-mysql-1 mysql -u root -e "create database if not exists mysql_async_tests;
create table if not exists mysql_async_tests.transaction_test (id varchar(255) not null, primary key (id));
GRANT ALL PRIVILEGES ON *.* TO 'mysql_async'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;
create user if not exists 'mysql_async_nopw';
GRANT ALL PRIVILEGES ON *.* TO 'mysql_async_nopw'@'%' WITH GRANT OPTION;
create user if not exists 'mysql_vagrant';
GRANT ALL PRIVILEGES ON *.* TO 'mysql_vagrant' IDENTIFIED BY 'generic_password' WITH GRANT OPTION;"

echo "Great success!"