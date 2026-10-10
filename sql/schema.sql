-- Smart Home - esquema PostgreSQL ( BD smarthome)
CREATE TABLE IF NOT EXISTS dim_sensors (
    device_id TEXT PRIMARY KEY,
    room TEXT NOT NULL,
    sensor_type TEXT NOT NULL,
    owner_hash TEXT,
    valid_min DOUBLE PRECISION,
    valid_max DOUBLE PRECISION
);

CREATE TABLE IF NOT EXISTS raw_readings (
    id         INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ts         TIMESTAMP NOT NULL,
    device_id  TEXT REFERENCES dim_sensors(device_id),
    room       TEXT,
    metric     TEXT NOT NULL,
    value_num  DOUBLE PRECISION,
    raw_value  TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS fact_hourly (
    room       TEXT NOT NULL,
    hour       TIMESTAMP NOT NULL,
    avg_temp   DOUBLE PRECISION,
    avg_hum    DOUBLE PRECISION,
    max_co2    INTEGER,
    sum_kwh    DOUBLE PRECISION,
    delta_temp DOUBLE PRECISION,
    PRIMARY KEY (room, hour)
);

CREATE TABLE IF NOT EXISTS alerts (
    id         INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ts         TIMESTAMP NOT NULL,
    room       TEXT,
    type       TEXT NOT NULL,
    message    TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS quarantine_log (
    id         INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ts         TIMESTAMP NOT NULL,
    device_id  TEXT,
    reason     TEXT NOT NULL,
    raw_value  TEXT
);


-- psql -U postgres -h localhost -c "CREATE DATABASE smarthome;"
-- psql -U postgres -h localhost -d smarthome -f schema.sql

-- psql -U postgres -h localhost -d smarthome -c "\dt"