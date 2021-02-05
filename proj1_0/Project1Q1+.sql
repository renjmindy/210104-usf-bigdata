CREATE DATABASE project1q9_db;

SHOW DATABASES;

USE project1q9_db;

CREATE TABLE P1Q9T1 (
	domain_code STRING,
	page_title STRING,
	count_views INT,
	total_response_size INT)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ' ';
	
LOAD DATA LOCAL INPATH '/home/cjen/pageviews_2101/pageviews-20210120.tsv' INTO TABLE P1Q9T1;

SELECT * FROM P1Q9T1;

INSERT OVERWRITE DIRECTORY '/user/hive/p1q9t1'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT page_title, SUM(count_views) AS total_count_views FROM P1Q9T1
GROUP BY page_title
ORDER BY total_count_views DESC
LIMIT 100;

INSERT OVERWRITE DIRECTORY '/user/hive/p1q9t2'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT page_title, SUM(count_views) AS total_count_views FROM P1Q9T1
WHERE domain_code LIKE 'en%'
GROUP BY page_title
ORDER BY total_count_views DESC
LIMIT 100;