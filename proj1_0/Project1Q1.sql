CREATE DATABASE project1q1_db;

SHOW DATABASES;

USE project1q1_db;

CREATE EXTERNAL TABLE IF NOT EXISTS P1Q1T1 (
	domain_code STRING,
	page_title STRING,
	count_views INT,
	total_response_size INT)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ' '
	LOCATION '/user/cjen/project1q1t1';
	
LOAD DATA INPATH '/user/cjen/project1q1/pageclick.tsv' INTO TABLE P1Q1T1;

SELECT * FROM P1Q1T1;

-- DROP TABLE P1Q1T1;

INSERT OVERWRITE DIRECTORY '/user/hive/p1q1t1'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT * FROM P1Q1T1
WHERE domain_code LIKE 'en%'
ORDER BY count_views DESC
LIMIT 10;





