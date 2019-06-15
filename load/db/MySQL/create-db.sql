--
-- set MYSQL_PWD=iAmRoot
-- "%programfiles%\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root < create-db.sql
--

drop  database if exists vbz_ogd;

create database vbz_ogd
   character set utf8mb4
   collate       utf8mb4_0900_as_cs
;

grant all on vbz_ogd.* to rene@'%';
