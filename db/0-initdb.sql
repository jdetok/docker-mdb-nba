create database nba;

create user 'go'@'10.0.13.152' identified by 'dbgo';
grant select on nba.* to 'go'@'10.0.13.152';

create user 'py'@'10.0.13.211' identified by 'dbpy';
grant all privileges on nba.* to 'py'@'10.0.13.211';

flush privileges;
