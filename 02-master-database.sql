CREATE DATABASE IF NOT EXISTS test;
USE test;
CREATE TABLE IF NOT EXISTS test(id varchar(36), insert_date datetime);
INSERT INTO test (id, insert_date) VALUES (uuid(), NOW());
