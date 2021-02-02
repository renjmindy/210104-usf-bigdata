CREATE DATABASE project1q5_db;

SHOW DATABASES;

USE project1q5_db;

--
--
-- * event global : used on every event of the dataset 
-- wiki_db: enwiki   
-- event_entity: revision         
-- event_type: create  
-- event_timestamp: 2020-12-01 00:00:00.0  
-- event_comment_escaped: Image renamed on Commons. ([[Commons:Commons:GlobalReplace|GlobalReplace v0.6.5]]) event_comment 
-- * event user : on the user having performed the event. set for all events in the dataset except when denormalizing user data has failed.     
-- event_user_id: 10841544        
-- event_user_text_historical_escaped: Fry1989 
-- event_user_text_escaped: Fry1989 
-- event_user_blocks_historical_string: nocreate        
-- event_user_blocks_string: nocreate        
-- event_user_groups_historical_string: extendedconfirmed       
-- event_user_groups_string: extendedconfirmed 
-- event_user_is_bot_by_historical_string:
-- event_user_is_bot_by_string:                      
-- event_user_is_created_by_self: true    
-- event_user_is_created_by_system: false   
-- event_user_is_created_by_peer: false   
-- event_user_is_anonymous: false   
-- event_user_registration_timestamp: 2009-10-22 21:58:45.0   
-- event_user_creation_timestamp: 2009-10-22 21:58:47.0   
-- event_user_first_edit_timestamp: 2009-10-29 16:18:23.0   
-- event_user_revision_count: 27875   
-- event_user_seconds_since_previous_revision: 2  
-- * page fields : about the page the event applies to.  set for page events and revision events.     
-- page_id: 11491552        
-- page_title_historical_escaped: Ks0stm  
-- page_title_escaped: Ks0stm  
-- page_namespace_historical: 3
-- page_namespace_is_content_historical false   
-- page_namespace 3       
-- page_namespace_is_content false   
-- page_is_redirect false   
-- page_is_deleted false   
-- page_creation_timestamp 2007-05-29 20:53:04.0   
-- page_first_edit_timestamp 2007-05-29 20:53:04.0   
-- page_revision_count 2478    
-- page_seconds_since_previous_revision 108835
-- * user fields : about the user the event applies to.  set for user events only.
-- user_id 
-- user_text_historical_escaped
-- user_text_escaped
-- user_blocks_historical_string
-- user_blocks_string
-- user_groups_historical_string
-- user_groups_string
-- user_is_bot_by_historical_string
-- user_is_bot_by_string
-- user_is_created_by_self
-- user_is_created_by_system
-- user_is_created_by_peer
-- user_is_anonymous
-- user_registration_timestamp
-- user_creation_timestamp
-- user_first_edit_timestamp
-- * revision fields : about the revision the event applies to. 
-- revision_id 991616268       
-- revision_parent_id 991364297       
-- revision_minor_edit false    
-- revision_deleted_parts_string
-- revision_deleted_parts_are_suppressed false   
-- revision_text_bytes 353096  
-- revision_text_bytes_diff 10      
-- revision_text_sha1 qjtudtxaxm5vocsqw2dyhsp730uj4zz   
-- revision_content_model
-- revision_content_format              
-- revision_is_deleted_by_page_deletion false  
-- revision_deleted_by_page_deletion_timestamp         
-- revision_is_identity_reverted false  
-- revision_first_identity_reverting_revision_id
-- revision_seconds_to_identity_revert                 
-- revision_is_identity_revert false   
-- revision_is_from_before_page_creation false
-- revision_tags_string
--
--

CREATE TABLE P1Q5T1 (
	wiki_db STRING,
	event_entity STRING,
	event_type STRING, 
	event_timestamp STRING,
	event_comment_escaped STRING,
	event_user_id INT, 
	event_user_text_historical_escaped STRING,
	event_user_text_escaped STRING,
	event_user_blocks_historical_string STRING,
	event_user_blocks_string STRING,
	event_user_groups_historical_string STRING,
	event_user_groups_string STRING,
	event_user_is_bot_by_historical_string STRING,
	event_user_is_bot_by_string STRING,
	event_user_is_created_by_self BOOLEAN,
	event_user_is_created_by_system BOOLEAN,
	event_user_is_created_by_peer BOOLEAN,
	event_user_is_anonymous BOOLEAN,
	event_user_registration_timestamp STRING,
	event_user_creation_timestamp STRING,
	event_user_first_edit_timestamp STRING,
	event_user_revision_count INT,
	event_user_seconds_since_previous_revision INT,
	page_id INT,
	page_title_historical_escaped STRING,
	page_title_escaped STRING,
	page_namespace_historical INT,
	page_namespace_is_content_historical BOOLEAN,
	page_namespace INT,
	page_namespace_is_content BOOLEAN,
	page_is_redirect BOOLEAN,
	page_is_deleted BOOLEAN,
	page_creation_timestamp STRING,
	page_first_edit_timestamp STRING,
	page_revision_count INT,
	page_seconds_since_previous_revision INT,
	user_id INT,
	user_text_historical_escaped STRING,
	user_text_escaped STRING,
	user_blocks_historical_string STRING,
	user_blocks_string STRING,
	user_groups_historical_string STRING,
	user_groups_string STRING,
	user_is_bot_by_historical_string STRING,
	user_is_bot_by_string STRING,
	user_is_created_by_self BOOLEAN,
	user_is_created_by_system BOOLEAN,
	user_is_created_by_peer BOOLEAN,
	user_is_anonymous BOOLEAN,
	user_registration_timestamp STRING,
	user_creation_timestamp STRING,
	user_first_edit_timestamp STRING,
	revision_id INT,
	revision_parent_id INT,
	revision_minor_edit BOOLEAN,
	revision_deleted_parts_string STRING,
	revision_deleted_parts_are_suppressed BOOLEAN,
	revision_text_bytes INT,
	revision_text_bytes_diff INT,
	revision_text_sha1 STRING,
	revision_content_model STRING,
	revision_content_format STRING,
	revision_is_deleted_by_page_deletion BOOLEAN,
	revision_deleted_by_page_deletion_timestamp INT,
	revision_is_identity_reverted BOOLEAN,
	revision_first_identity_reverting_revision_id INT,
	revision_seconds_to_identity_revert INT,
	revision_is_identity_revert BOOLEAN,
	revision_is_from_before_page_creation BOOLEAN,
	revision_tags_string INT)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY '\t';
	
DESCRIBE P1Q5T1;

LOAD DATA LOCAL INPATH '/home/cjen/mediawiki_enwiki_2101/2020-12.enwiki.2021-01.tsv' INTO TABLE P1Q5T1;

SELECT * FROM P1Q5T1;

INSERT OVERWRITE DIRECTORY '/user/hive/p1q5t1_d2101_1'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT * FROM P1Q5T1
WHERE page_is_deleted = TRUE AND revision_is_deleted_by_page_deletion = TRUE 
AND (revision_is_identity_reverted = TRUE OR revision_is_identity_revert = TRUE);

---
---
---

INSERT OVERWRITE DIRECTORY '/user/hive/p1q5t1_d2101_2'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT event_user_id, page_id, COUNT(event_user_id), COUNT(page_id),
	   ROUND(COUNT(event_user_id) / COUNT(page_id) * 1.0, 4) AS avgCount_users_per_page,	
       SUM(event_user_revision_count) AS total_event_user_revision_counts, 
       SUM(page_revision_count) AS total_page_revision_counts,
       ROUND(SUM(event_user_revision_count) / SUM(page_revision_count) * 1.0, 4) AS avgSum_users_per_page
FROM P1Q5T1
WHERE page_is_deleted = TRUE AND revision_is_deleted_by_page_deletion = TRUE 
AND (revision_is_identity_reverted = TRUE OR revision_is_identity_revert = TRUE)
GROUP BY event_user_id, page_id;

---
---
---

INSERT OVERWRITE DIRECTORY '/user/hive/p1q5t1_d2101_3'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT page_id, event_user_id, COUNT(event_user_id), COUNT(page_id),
	   ROUND(COUNT(event_user_id) / COUNT(page_id) * 1.0, 4) AS avgCount_users_per_page,	
       SUM(event_user_revision_count) AS total_event_user_revision_counts, 
       SUM(page_revision_count) AS total_page_revision_counts,
       ROUND(SUM(event_user_revision_count) / SUM(page_revision_count) * 1.0, 4) AS avgSum_users_per_page
FROM P1Q5T1
WHERE page_is_deleted = TRUE AND revision_is_deleted_by_page_deletion = TRUE 
AND (revision_is_identity_reverted = TRUE OR revision_is_identity_revert = TRUE)
GROUP BY page_id, event_user_id;

---
---
---

CREATE TABLE P1Q5T3 (
	page_id INT,
	event_user_id INT,
	total_users INT,
	total_pages INT,
	avgCount_users_per_page DOUBLE,
	total_event_user_revision_counts INT,
	total_page_revision__counts INT,
	avgSum_users_per_page DOUBLE)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY '\t';

DESCRIBE P1Q5T3;

LOAD DATA LOCAL INPATH '/home/cjen/mediawiki_enwiki_2101/p1q5t1_3.tsv' INTO TABLE P1Q5T3;

SELECT * FROM P1Q5T3;

-- DROP TABLE P1Q5T3;

INSERT OVERWRITE DIRECTORY '/user/hive/p1q5t3_d2101_1'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT page_id, ROUND(Avg(avgSum_users_per_page), 1)
FROM P1Q5T3
GROUP BY page_id;

---
---
---

CREATE TABLE P1Q5T2 (
	wiki_db STRING,
	event_entity STRING,
	event_type STRING, 
	event_timestamp STRING,
	event_comment_escaped STRING,
	event_user_id INT, 
	event_user_text_historical_escaped STRING,
	event_user_text_escaped STRING,
	event_user_blocks_historical_string STRING,
	event_user_blocks_string STRING,
	event_user_groups_historical_string STRING,
	event_user_groups_string STRING,
	event_user_is_bot_by_historical_string STRING,
	event_user_is_bot_by_string STRING,
	event_user_is_created_by_self BOOLEAN,
	event_user_is_created_by_system BOOLEAN,
	event_user_is_created_by_peer BOOLEAN,
	event_user_is_anonymous BOOLEAN,
	event_user_registration_timestamp STRING,
	event_user_creation_timestamp STRING,
	event_user_first_edit_timestamp STRING,
	event_user_revision_count INT,
	event_user_seconds_since_previous_revision INT,
	page_id INT,
	page_title_historical_escaped STRING,
	page_title_escaped STRING,
	page_namespace_historical INT,
	page_namespace_is_content_historical BOOLEAN,
	page_namespace INT,
	page_namespace_is_content BOOLEAN,
	page_is_redirect BOOLEAN,
	page_is_deleted BOOLEAN,
	page_creation_timestamp STRING,
	page_first_edit_timestamp STRING,
	page_revision_count INT,
	page_seconds_since_previous_revision INT,
	user_id INT,
	user_text_historical_escaped STRING,
	user_text_escaped STRING,
	user_blocks_historical_string STRING,
	user_blocks_string STRING,
	user_groups_historical_string STRING,
	user_groups_string STRING,
	user_is_bot_by_historical_string STRING,
	user_is_bot_by_string STRING,
	user_is_created_by_self BOOLEAN,
	user_is_created_by_system BOOLEAN,
	user_is_created_by_peer BOOLEAN,
	user_is_anonymous BOOLEAN,
	user_registration_timestamp STRING,
	user_creation_timestamp STRING,
	user_first_edit_timestamp STRING,
	revision_id INT,
	revision_parent_id INT,
	revision_minor_edit BOOLEAN,
	revision_deleted_parts_string STRING,
	revision_deleted_parts_are_suppressed BOOLEAN,
	revision_text_bytes INT,
	revision_text_bytes_diff INT,
	revision_text_sha1 STRING,
	revision_content_model STRING,
	revision_content_format STRING,
	revision_is_deleted_by_page_deletion BOOLEAN,
	revision_deleted_by_page_deletion_timestamp INT,
	revision_is_identity_reverted BOOLEAN,
	revision_first_identity_reverting_revision_id INT,
	revision_seconds_to_identity_revert INT,
	revision_is_identity_revert BOOLEAN,
	revision_is_from_before_page_creation BOOLEAN,
	revision_tags_string INT)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY '\t';
	
DESCRIBE P1Q5T2;

LOAD DATA LOCAL INPATH '/home/cjen/mediawiki_enwiki_2012/202012.enwiki.202012.tsv' INTO TABLE P1Q5T2;

SELECT * FROM P1Q5T2;

INSERT OVERWRITE DIRECTORY '/user/hive/p1q5t2_d2012_1'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT * FROM P1Q5T2
WHERE page_is_deleted = TRUE AND revision_is_deleted_by_page_deletion = TRUE 
AND (revision_is_identity_reverted = TRUE OR revision_is_identity_revert = TRUE);

---
---
---

INSERT OVERWRITE DIRECTORY '/user/hive/p1q5t2_d2012_2'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT event_user_id, page_id, COUNT(event_user_id), COUNT(page_id),
	   ROUND(COUNT(event_user_id) / COUNT(page_id) * 1.0, 4) AS avgCount_users_per_page,	
       SUM(event_user_revision_count) AS total_event_user_revision_counts, 
       SUM(page_revision_count) AS total_page_revision_counts,
       ROUND(SUM(event_user_revision_count) / SUM(page_revision_count) * 1.0, 4) AS avgSum_users_per_page
FROM P1Q5T2
WHERE page_is_deleted = TRUE AND revision_is_deleted_by_page_deletion = TRUE 
AND (revision_is_identity_reverted = TRUE OR revision_is_identity_revert = TRUE)
GROUP BY event_user_id, page_id;

---
---
---

INSERT OVERWRITE DIRECTORY '/user/hive/p1q5t2_d2012_3'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT page_id, event_user_id, COUNT(event_user_id), COUNT(page_id),
	   ROUND(COUNT(event_user_id) / COUNT(page_id) * 1.0, 4) AS avgCount_users_per_page,	
       SUM(event_user_revision_count) AS total_event_user_revision_counts, 
       SUM(page_revision_count) AS total_page_revision_counts,
       ROUND(SUM(event_user_revision_count) / SUM(page_revision_count) * 1.0, 4) AS avgSum_users_per_page
FROM P1Q5T2
WHERE page_is_deleted = TRUE AND revision_is_deleted_by_page_deletion = TRUE 
AND (revision_is_identity_reverted = TRUE OR revision_is_identity_revert = TRUE)
GROUP BY page_id, event_user_id;

---
---
---

CREATE TABLE P1Q5T4 (
	page_id INT,
	event_user_id INT,
	total_users INT,
	total_pages INT,
	avgCount_users_per_page DOUBLE,
	total_event_user_revision_counts INT,
	total_page_revision__counts INT,
	avgSum_users_per_page DOUBLE)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY '\t';

DESCRIBE P1Q5T4;

LOAD DATA LOCAL INPATH '/home/cjen/mediawiki_enwiki_2012/p1q5t2_3.tsv' INTO TABLE P1Q5T4;

SELECT * FROM P1Q5T4;

-- DROP TABLE P1Q5T3;

INSERT OVERWRITE DIRECTORY '/user/hive/p1q5t4_d2012_1'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT page_id, ROUND(Avg(avgSum_users_per_page), 1) AS avg_users_per_page
FROM P1Q5T4
GROUP BY page_id;

