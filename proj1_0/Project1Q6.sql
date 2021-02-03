CREATE DATABASE project1q6_db;

SHOW DATABASES;

USE project1q6_db;

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

CREATE TABLE P1Q6T1 (
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
	
DESCRIBE P1Q6T1;

LOAD DATA LOCAL INPATH '/home/cjen/mediawiki_enwiki_2101/2020-12.enwiki.2021-01.tsv' INTO TABLE P1Q6T1;

SELECT * FROM P1Q6T1;

INSERT OVERWRITE DIRECTORY '/user/hive/p1q6t1_d2101_1'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT * FROM P1Q6T1
WHERE event_entity = 'revision';

INSERT OVERWRITE DIRECTORY '/user/hive/p1q6t1_d2101_1_1'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT page_id, event_user_id, COUNT(event_user_id), COUNT(page_id),
	   ROUND(COUNT(event_user_id) / COUNT(page_id) * 1.0, 4) AS avgCount_users_per_page,	
       SUM(event_user_revision_count) AS total_event_user_revision_counts, 
       SUM(page_revision_count) AS total_page_revision_counts,
       ROUND(SUM(event_user_revision_count) / SUM(page_revision_count) * 1.0, 4) AS avgSum_users_per_page
FROM P1Q6T1
WHERE event_entity = 'revision' 
AND page_is_deleted = TRUE AND revision_is_deleted_by_page_deletion = TRUE 
AND (revision_is_identity_reverted = TRUE OR revision_is_identity_revert = TRUE)
GROUP BY page_id, event_user_id;

INSERT OVERWRITE DIRECTORY '/user/hive/p1q6t1_d2101_1_2'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT revision_id, page_id, event_user_id, COUNT(revision_id), COUNT(page_id), COUNT(event_user_id)
FROM P1Q6T1
WHERE event_entity = 'revision' 
GROUP BY revision_id, page_id, event_user_id;

INSERT OVERWRITE DIRECTORY '/user/hive/p1q6t1_d2101_1_3'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT revision_id, page_id, event_user_id, COUNT(revision_id), COUNT(page_id), COUNT(event_user_id)
FROM P1Q6T1
WHERE event_entity = 'revision' 
AND page_is_deleted = TRUE AND revision_is_deleted_by_page_deletion = TRUE 
AND (revision_is_identity_reverted = TRUE OR revision_is_identity_revert = TRUE)
GROUP BY revision_id, page_id, event_user_id;

INSERT OVERWRITE DIRECTORY '/user/hive/p1q6t1_d2101_2'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT * FROM P1Q6T1
WHERE event_entity = 'page';

INSERT OVERWRITE DIRECTORY '/user/hive/p1q6t1_d2101_3'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT * FROM P1Q6T1
WHERE event_entity = 'user';

INSERT OVERWRITE DIRECTORY '/user/hive/p1q6t1_d2101_2_1'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT * FROM P1Q6T1
WHERE event_entity = 'page' AND event_type = 'create';

INSERT OVERWRITE DIRECTORY '/user/hive/p1q6t1_d2101_2_1_1'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT page_id, event_user_id, COUNT(event_user_id), COUNT(page_id),
	   ROUND(COUNT(event_user_id) / COUNT(page_id) * 1.0, 4) AS avgCount_users_per_page,	
       SUM(event_user_revision_count) AS total_event_user_revision_counts, 
       SUM(page_revision_count) AS total_page_revision_counts,
       ROUND(SUM(event_user_revision_count) / SUM(page_revision_count) * 1.0, 4) AS avgSum_users_per_page
FROM P1Q6T1
WHERE event_entity = 'page' AND event_type = 'create' 
AND page_is_deleted = TRUE AND revision_is_deleted_by_page_deletion = TRUE 
AND (revision_is_identity_reverted = TRUE OR revision_is_identity_revert = TRUE)
GROUP BY page_id, event_user_id;

INSERT OVERWRITE DIRECTORY '/user/hive/p1q6t1_d2101_2_1_2'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT revision_id, page_id, event_user_id, COUNT(revision_id), COUNT(page_id), COUNT(event_user_id)
FROM P1Q6T1
WHERE event_entity = 'page' AND event_type = 'create' 
GROUP BY revision_id, page_id, event_user_id;

INSERT OVERWRITE DIRECTORY '/user/hive/p1q6t1_d2101_2_2'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT * FROM P1Q6T1
WHERE event_entity = 'page' AND event_type = 'delete';

INSERT OVERWRITE DIRECTORY '/user/hive/p1q6t1_d2101_2_2_1'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT page_id, event_user_id, COUNT(event_user_id), COUNT(page_id),
	   ROUND(COUNT(event_user_id) / COUNT(page_id) * 1.0, 4) AS avgCount_users_per_page,	
       SUM(event_user_revision_count) AS total_event_user_revision_counts, 
       SUM(page_revision_count) AS total_page_revision_counts,
       ROUND(SUM(event_user_revision_count) / SUM(page_revision_count) * 1.0, 4) AS avgSum_users_per_page
FROM P1Q6T1
WHERE event_entity = 'page' AND event_type = 'delete' 
AND page_is_deleted = TRUE AND revision_is_deleted_by_page_deletion = TRUE 
AND (revision_is_identity_reverted = TRUE OR revision_is_identity_revert = TRUE)
GROUP BY page_id, event_user_id;

INSERT OVERWRITE DIRECTORY '/user/hive/p1q6t1_d2101_2_2_2'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT revision_id, page_id, event_user_id, COUNT(revision_id), COUNT(page_id), COUNT(event_user_id)
FROM P1Q6T1
WHERE event_entity = 'page' AND event_type = 'delete' 
GROUP BY revision_id, page_id, event_user_id;

INSERT OVERWRITE DIRECTORY '/user/hive/p1q6t1_d2101_2_3'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT * FROM P1Q6T1
WHERE event_entity = 'page' AND event_type = 'move';

INSERT OVERWRITE DIRECTORY '/user/hive/p1q6t1_d2101_2_3_1'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT page_id, event_user_id, COUNT(event_user_id), COUNT(page_id),
	   ROUND(COUNT(event_user_id) / COUNT(page_id) * 1.0, 4) AS avgCount_users_per_page,	
       SUM(event_user_revision_count) AS total_event_user_revision_counts, 
       SUM(page_revision_count) AS total_page_revision_counts,
       ROUND(SUM(event_user_revision_count) / SUM(page_revision_count) * 1.0, 4) AS avgSum_users_per_page
FROM P1Q6T1
WHERE event_entity = 'page' AND event_type = 'move' 
AND page_is_deleted = TRUE AND revision_is_deleted_by_page_deletion = TRUE 
AND (revision_is_identity_reverted = TRUE OR revision_is_identity_revert = TRUE)
GROUP BY page_id, event_user_id;

INSERT OVERWRITE DIRECTORY '/user/hive/p1q6t1_d2101_2_3_2'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT revision_id, page_id, event_user_id, COUNT(revision_id), COUNT(page_id), COUNT(event_user_id)
FROM P1Q6T1
WHERE event_entity = 'page' AND event_type = 'move' 
GROUP BY revision_id, page_id, event_user_id;

INSERT OVERWRITE DIRECTORY '/user/hive/p1q6t1_d2101_2_4'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT * FROM P1Q6T1
WHERE event_entity = 'page' AND event_type = 'restore';

INSERT OVERWRITE DIRECTORY '/user/hive/p1q6t1_d2101_2_4_1'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT page_id, event_user_id, COUNT(event_user_id), COUNT(page_id),
	   ROUND(COUNT(event_user_id) / COUNT(page_id) * 1.0, 4) AS avgCount_users_per_page,	
       SUM(event_user_revision_count) AS total_event_user_revision_counts, 
       SUM(page_revision_count) AS total_page_revision_counts,
       ROUND(SUM(event_user_revision_count) / SUM(page_revision_count) * 1.0, 4) AS avgSum_users_per_page
FROM P1Q6T1
WHERE event_entity = 'page' AND event_type = 'restore' 
AND page_is_deleted = TRUE AND revision_is_deleted_by_page_deletion = TRUE 
AND (revision_is_identity_reverted = TRUE OR revision_is_identity_revert = TRUE)
GROUP BY page_id, event_user_id;

INSERT OVERWRITE DIRECTORY '/user/hive/p1q6t1_d2101_2_4_2'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT revision_id, page_id, event_user_id, COUNT(revision_id), COUNT(page_id), COUNT(event_user_id)
FROM P1Q6T1
WHERE event_entity = 'page' AND event_type = 'restore' 
GROUP BY revision_id, page_id, event_user_id;

INSERT OVERWRITE DIRECTORY '/user/hive/p1q6t1_d2101_3_1'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT * FROM P1Q6T1
WHERE event_entity = 'user' AND event_type = 'create';

INSERT OVERWRITE DIRECTORY '/user/hive/p1q6t1_d2101_3_1_1'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT page_id, event_user_id, COUNT(event_user_id), COUNT(page_id),
	   ROUND(COUNT(event_user_id) / COUNT(page_id) * 1.0, 4) AS avgCount_users_per_page,	
       SUM(event_user_revision_count) AS total_event_user_revision_counts, 
       SUM(page_revision_count) AS total_page_revision_counts,
       ROUND(SUM(event_user_revision_count) / SUM(page_revision_count) * 1.0, 4) AS avgSum_users_per_page
FROM P1Q6T1
WHERE event_entity = 'user' AND event_type = 'create' 
AND page_is_deleted = TRUE AND revision_is_deleted_by_page_deletion = TRUE 
AND (revision_is_identity_reverted = TRUE OR revision_is_identity_revert = TRUE)
GROUP BY page_id, event_user_id;

INSERT OVERWRITE DIRECTORY '/user/hive/p1q6t1_d2101_3_1_2'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT revision_id, page_id, event_user_id, COUNT(revision_id), COUNT(page_id), COUNT(event_user_id)
FROM P1Q6T1
WHERE event_entity = 'user' AND event_type = 'create' 
GROUP BY revision_id, page_id, event_user_id;

INSERT OVERWRITE DIRECTORY '/user/hive/p1q6t1_d2101_3_2'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT * FROM P1Q6T1
WHERE event_entity = 'user' AND event_type = 'rename';

INSERT OVERWRITE DIRECTORY '/user/hive/p1q6t1_d2101_3_2_1'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT page_id, event_user_id, COUNT(event_user_id), COUNT(page_id),
	   ROUND(COUNT(event_user_id) / COUNT(page_id) * 1.0, 4) AS avgCount_users_per_page,	
       SUM(event_user_revision_count) AS total_event_user_revision_counts, 
       SUM(page_revision_count) AS total_page_revision_counts,
       ROUND(SUM(event_user_revision_count) / SUM(page_revision_count) * 1.0, 4) AS avgSum_users_per_page
FROM P1Q6T1
WHERE event_entity = 'user' AND event_type = 'rename' 
AND page_is_deleted = TRUE AND revision_is_deleted_by_page_deletion = TRUE 
AND (revision_is_identity_reverted = TRUE OR revision_is_identity_revert = TRUE)
GROUP BY page_id, event_user_id;

INSERT OVERWRITE DIRECTORY '/user/hive/p1q6t1_d2101_3_2_2'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT revision_id, page_id, event_user_id, COUNT(revision_id), COUNT(page_id), COUNT(event_user_id)
FROM P1Q6T1
WHERE event_entity = 'user' AND event_type = 'rename' 
GROUP BY revision_id, page_id, event_user_id;

INSERT OVERWRITE DIRECTORY '/user/hive/p1q6t1_d2101_3_3'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT * FROM P1Q6T1
WHERE event_entity = 'user' AND event_type = 'altergroups';

INSERT OVERWRITE DIRECTORY '/user/hive/p1q6t1_d2101_3_3_1'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT page_id, event_user_id, COUNT(event_user_id), COUNT(page_id),
	   ROUND(COUNT(event_user_id) / COUNT(page_id) * 1.0, 4) AS avgCount_users_per_page,	
       SUM(event_user_revision_count) AS total_event_user_revision_counts, 
       SUM(page_revision_count) AS total_page_revision_counts,
       ROUND(SUM(event_user_revision_count) / SUM(page_revision_count) * 1.0, 4) AS avgSum_users_per_page
FROM P1Q6T1
WHERE event_entity = 'user' AND event_type = 'altergroups' 
AND page_is_deleted = TRUE AND revision_is_deleted_by_page_deletion = TRUE 
AND (revision_is_identity_reverted = TRUE OR revision_is_identity_revert = TRUE)
GROUP BY page_id, event_user_id;

INSERT OVERWRITE DIRECTORY '/user/hive/p1q6t1_d2101_3_3_2'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT revision_id, page_id, event_user_id, COUNT(revision_id), COUNT(page_id), COUNT(event_user_id)
FROM P1Q6T1
WHERE event_entity = 'user' AND event_type = 'altergroups' 
GROUP BY revision_id, page_id, event_user_id;

INSERT OVERWRITE DIRECTORY '/user/hive/p1q6t1_d2101_3_4'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT * FROM P1Q6T1
WHERE event_entity = 'user' AND event_type = 'alterblocks';

INSERT OVERWRITE DIRECTORY '/user/hive/p1q6t1_d2101_3_4_1'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT page_id, event_user_id, COUNT(event_user_id), COUNT(page_id),
	   ROUND(COUNT(event_user_id) / COUNT(page_id) * 1.0, 4) AS avgCount_users_per_page,	
       SUM(event_user_revision_count) AS total_event_user_revision_counts, 
       SUM(page_revision_count) AS total_page_revision_counts,
       ROUND(SUM(event_user_revision_count) / SUM(page_revision_count) * 1.0, 4) AS avgSum_users_per_page
FROM P1Q6T1
WHERE event_entity = 'user' AND event_type = 'alterblocks' 
AND page_is_deleted = TRUE AND revision_is_deleted_by_page_deletion = TRUE 
AND (revision_is_identity_reverted = TRUE OR revision_is_identity_revert = TRUE)
GROUP BY page_id, event_user_id;

INSERT OVERWRITE DIRECTORY '/user/hive/p1q6t1_d2101_3_4_2'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT revision_id, page_id, event_user_id, COUNT(revision_id), COUNT(page_id), COUNT(event_user_id)
FROM P1Q6T1
WHERE event_entity = 'user' AND event_type = 'alterblocks' 
GROUP BY revision_id, page_id, event_user_id;

-- CREATE TABLE P1Q6T1_EVENT_ENTITY_PARTITION (
--	wiki_db STRING,
--	event_type STRING, 
--	event_timestamp STRING,
--	event_comment_escaped STRING,
--	event_user_id INT, 
--	event_user_text_historical_escaped STRING,
--	event_user_text_escaped STRING,
--	event_user_blocks_historical_string STRING,
--	event_user_blocks_string STRING,
--	event_user_groups_historical_string STRING,
--	event_user_groups_string STRING,
--	event_user_is_bot_by_historical_string STRING,
--	event_user_is_bot_by_string STRING,
--	event_user_is_created_by_self BOOLEAN,
--	event_user_is_created_by_system BOOLEAN,
--	event_user_is_created_by_peer BOOLEAN,
--	event_user_is_anonymous BOOLEAN,
--	event_user_registration_timestamp STRING,
--	event_user_creation_timestamp STRING,
--	event_user_first_edit_timestamp STRING,
--	event_user_revision_count INT,
--	event_user_seconds_since_previous_revision INT,
--	page_id INT,
--	page_title_historical_escaped STRING,
--	page_title_escaped STRING,
--	page_namespace_historical INT,
--	page_namespace_is_content_historical BOOLEAN,
--	page_namespace INT,
--	page_namespace_is_content BOOLEAN,
--	page_is_redirect BOOLEAN,
--	page_is_deleted BOOLEAN,
--	page_creation_timestamp STRING,
--	page_first_edit_timestamp STRING,
--	page_revision_count INT,
--	page_seconds_since_previous_revision INT,
--	user_id INT,
--	user_text_historical_escaped STRING,
--	user_text_escaped STRING,
--	user_blocks_historical_string STRING,
--	user_blocks_string STRING,
--	user_groups_historical_string STRING,
--	user_groups_string STRING,
--	user_is_bot_by_historical_string STRING,
--	user_is_bot_by_string STRING,
--	user_is_created_by_self BOOLEAN,
--	user_is_created_by_system BOOLEAN,
--	user_is_created_by_peer BOOLEAN,
--	user_is_anonymous BOOLEAN,
--	user_registration_timestamp STRING,
--	user_creation_timestamp STRING,
--	user_first_edit_timestamp STRING,
--	revision_id INT,
--	revision_parent_id INT,
--	revision_minor_edit BOOLEAN,
--	revision_deleted_parts_string STRING,
--	revision_deleted_parts_are_suppressed BOOLEAN,
--	revision_text_bytes INT,
--	revision_text_bytes_diff INT,
--	revision_text_sha1 STRING,
--	revision_content_model STRING,
--	revision_content_format STRING,
--	revision_is_deleted_by_page_deletion BOOLEAN,
--	revision_deleted_by_page_deletion_timestamp INT,
--	revision_is_identity_reverted BOOLEAN,
--	revision_first_identity_reverting_revision_id INT,
--	revision_seconds_to_identity_revert INT,
--	revision_is_identity_revert BOOLEAN,
--	revision_is_from_before_page_creation BOOLEAN,
--	revision_tags_string INT) PARTITIONED BY (event_entity STRING)
--ROW FORMAT DELIMITED
--FIELDS TERMINATED BY '\t';

-- DROP TABLE P1Q6T1_EVENT_ENTITY_PARTITION;


-- SET hive.exec.dynamic.partition=true;
-- SET hive.exec.dynamic.partition.mode=nonstrict;

-- SET hive.enforce.bucketing = true;

--INSERT INTO P1Q6T1_EVENT_ENTITY_PARTITION PARTITION(event_entity)
--SELECT wiki_db, event_entity, event_type, event_timestamp, event_comment_escaped, event_user_id, event_user_text_historical_escaped, 
--event_user_text_escaped, event_user_blocks_historical_string, event_user_blocks_string, event_user_groups_historical_string,
--event_user_groups_string, event_user_is_bot_by_historical_string, event_user_is_bot_by_string, event_user_is_created_by_self, 
--event_user_is_created_by_system, event_user_is_created_by_peer, event_user_is_anonymous, event_user_registration_timestamp,
--event_user_creation_timestamp, event_user_first_edit_timestamp, event_user_revision_count, event_user_seconds_since_previous_revision,
--page_id, page_title_historical_escaped, page_title_escaped, page_namespace_historical, page_namespace_is_content_historical, 
--page_namespace, page_namespace_is_content, page_is_redirect, page_is_deleted, page_creation_timestamp, page_first_edit_timestamp, 
--page_revision_count, page_seconds_since_previous_revision, user_id, user_text_historical_escaped, user_text_escaped, 
--user_blocks_historical_string, user_blocks_string, user_groups_historical_string, user_groups_string, user_is_bot_by_historical_string,
--user_is_bot_by_string, user_is_created_by_self, user_is_created_by_system, user_is_created_by_peer, user_is_anonymous, 
--user_registration_timestamp, user_creation_timestamp, user_first_edit_timestamp, revision_id, revision_parent_id, revision_minor_edit,
--revision_deleted_parts_string, revision_deleted_parts_are_suppressed, revision_text_bytes, revision_text_bytes_diff, revision_text_sha1,
--revision_content_model, revision_content_format, revision_is_deleted_by_page_deletion, revision_deleted_by_page_deletion_timestamp,
--revision_is_identity_reverted, revision_first_identity_reverting_revision_id, revision_seconds_to_identity_revert, 
--revision_is_identity_revert, revision_is_from_before_page_creation, revision_tags_string FROM P1Q6T1;
--
--SELECT * FROM P1Q6T1_EVENT_ENTITY_PARTITION


