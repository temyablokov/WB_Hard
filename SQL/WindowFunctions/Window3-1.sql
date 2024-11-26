CREATE TABLE query (
    searchid SERIAL PRIMARY KEY,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    userid INTEGER,
    ts BIGINT, -- UNIX-время
    devicetype VARCHAR(50),
    deviceid VARCHAR(100),
    query VARCHAR(255)
);