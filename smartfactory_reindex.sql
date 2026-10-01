CREATE DATABASE IF NOT EXISTS smartfactory_db;

USE smartfactory_db;

CREATE TABLE IF NOT EXISTS SensorLogs (
    log_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    sensor_id INT NOT NULL,
    recorded_at DATETIME NOT NULL,
    temperature DECIMAL(5,2),
    humidity DECIMAL(5,2),
    status VARCHAR(20)
);

ALTER TABLE SensorLogs DROP INDEX idx_fat_covering;

CREATE INDEX idx_lean_search
ON SensorLogs(sensor_id, recorded_at);

SHOW TABLE STATUS LIKE 'SensorLogs';

EXPLAIN
SELECT temperature, humidity, status
FROM SensorLogs
WHERE sensor_id = 105
  AND recorded_at >= '2026-06-20';
