CREATE DATABASE IF NOT EXISTS quickfeed_db;
USE quickfeed_db;

CREATE TABLE IF NOT EXISTS Posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    content TEXT,
    post_type VARCHAR(10),
    is_visible BOOLEAN DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_user_id ON Posts(user_id);
CREATE INDEX IF NOT EXISTS idx_content ON Posts(content(255));
CREATE INDEX IF NOT EXISTS idx_post_type ON Posts(post_type);
CREATE INDEX IF NOT EXISTS idx_is_visible ON Posts(is_visible);
CREATE INDEX IF NOT EXISTS idx_created_at ON Posts(created_at);

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
