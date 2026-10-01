USE quickfeed_db;

SELECT TABLE_NAME,
       ROUND(DATA_LENGTH / 1024 / 1024, 2) AS data_mb,
       ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS index_mb,
       ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS total_mb
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'quickfeed_db'
  AND TABLE_NAME = 'Posts';

SHOW TABLE STATUS LIKE 'Posts';

ALTER TABLE Posts DROP INDEX idx_content;
ALTER TABLE Posts DROP INDEX idx_post_type;
ALTER TABLE Posts DROP INDEX idx_is_visible;

SELECT TABLE_NAME,
       ROUND(DATA_LENGTH / 1024 / 1024, 2) AS data_mb,
       ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS index_mb,
       ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS total_mb
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'quickfeed_db'
  AND TABLE_NAME = 'Posts';

SHOW TABLE STATUS LIKE 'Posts';
SHOW INDEX FROM Posts;
