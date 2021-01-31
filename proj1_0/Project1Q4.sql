CREATE DATABASE project1q4_db;

SHOW DATABASES;

USE project1q4_db;

CREATE TABLE P1Q4T1D20122900 (
	domain_code STRING,
	page_title STRING,
	count_views INT,
	total_response_size INT)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ' ';
	
LOAD DATA LOCAL INPATH '/home/cjen/pageviews_2012/pageview-2020-1229-00_05.tsv' INTO TABLE P1Q4T1D20122900;

SELECT * FROM P1Q4T1D20122900;

-- INSERT OVERWRITE DIRECTORY '/user/hive/p1q4t1_d201229_00_05'
INSERT OVERWRITE DIRECTORY '/user/hive/p1q4t1_d201229_00_05_2'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
-- SELECT * FROM p1q4t1d20122901
SELECT page_title, SUM(count_views) AS total_view_counts 
FROM p1q4t1d20122900
WHERE domain_code LIKE 'en%'
GROUP BY page_title
-- ORDER BY count_views DESC
ORDER BY total_view_counts DESC
LIMIT 100;

---
---
---

CREATE TABLE P1Q4T1D20122901 (
	domain_code STRING,
	page_title STRING,
	count_views INT,
	total_response_size INT)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ' ';
	
LOAD DATA LOCAL INPATH '/home/cjen/pageviews_2012/pageview-2020-1229-06_11.tsv' INTO TABLE P1Q4T1D20122901;

SELECT * FROM P1Q4T1D20122901;

-- INSERT OVERWRITE DIRECTORY '/user/hive/p1q4t1_d201229_06_11'
INSERT OVERWRITE DIRECTORY '/user/hive/p1q4t1_d201229_06_11_2'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
-- SELECT * FROM p1q4t1d20122901 
SELECT page_title, SUM(count_views) AS total_view_counts
FROM p1q4t1d20122901
WHERE domain_code LIKE 'en%'
GROUP BY page_title
-- ORDER BY count_views DESC
ORDER BY total_view_counts DESC
LIMIT 100;

---
---
---

CREATE TABLE P1Q4T1D20122902 (
	domain_code STRING,
	page_title STRING,
	count_views INT,
	total_response_size INT)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ' ';
	
LOAD DATA LOCAL INPATH '/home/cjen/pageviews_2012/pageview-2020-1229-12_17.tsv' INTO TABLE P1Q4T1D20122902;

SELECT * FROM P1Q4T1D20122902;

-- INSERT OVERWRITE DIRECTORY '/user/hive/p1q4t1_d201229_12_17'
INSERT OVERWRITE DIRECTORY '/user/hive/p1q4t1_d201229_12_17_2'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
-- SELECT * FROM p1q4t1d20122902
SELECT page_title, SUM(count_views) AS total_view_counts 
FROM p1q4t1d20122902 
WHERE domain_code LIKE 'en%'
GROUP BY page_title
-- ORDER BY count_views DESC
ORDER BY total_view_counts DESC
LIMIT 100;

---
---
---

CREATE TABLE P1Q4T1D20122903 (
	domain_code STRING,
	page_title STRING,
	count_views INT,
	total_response_size INT)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ' ';
	
LOAD DATA LOCAL INPATH '/home/cjen/pageviews_2012/pageview-2020-1229-18_23.tsv' INTO TABLE P1Q4T1D20122903;

SELECT * FROM P1Q4T1D20122903;

-- INSERT OVERWRITE DIRECTORY '/user/hive/p1q4t1_d201229_18_23'
INSERT OVERWRITE DIRECTORY '/user/hive/p1q4t1_d201229_18_23_2'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
-- SELECT * FROM p1q4t1d20122903 
SELECT page_title, SUM(count_views) AS total_view_counts
FROM p1q4t1d20122903
WHERE domain_code LIKE 'en%'
GROUP BY page_title
-- ORDER BY count_views DESC
ORDER BY total_view_counts DESC
LIMIT 100;