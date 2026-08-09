--Create Database
CREATE DATABASE OTT_DB;
GO

USE OTT_DB;
GO

--Movies Staging Table
CREATE TABLE stg_movies
(
    show_id INT,
    type VARCHAR(20),
    title NVARCHAR(500),
    director NVARCHAR(500),
    cast_members NVARCHAR(MAX),
    country NVARCHAR(500),
    date_added DATE,
    release_year INT,
    rating FLOAT,
    duration VARCHAR(50),
    genres NVARCHAR(500),
    language VARCHAR(50),
    description NVARCHAR(MAX),
    popularity FLOAT,
    vote_count INT,
    vote_average FLOAT,
    budget BIGINT,
    revenue BIGINT
);
-- TV Shows Staging Table
CREATE TABLE stg_tvshows
(
    show_id INT,
    type VARCHAR(20),
    title NVARCHAR(500),
    director NVARCHAR(500),
    cast_members NVARCHAR(MAX),
    country NVARCHAR(500),
    date_added DATE,
    release_year INT,
    rating FLOAT,
    duration VARCHAR(50),
    genres NVARCHAR(500),
    language VARCHAR(50),
    description NVARCHAR(MAX),
    popularity FLOAT,
    vote_count INT,
    vote_average FLOAT
);
---Bulk Insert Movies
BULK INSERT stg_movies
FROM 'C:\Users\SASWAT\Downloads\netflix_movies_detailed_up_to_2025.csv'
WITH
(
    FORMAT='CSV',
    FIRSTROW=2,
    FIELDTERMINATOR=',',
    ROWTERMINATOR='0x0A',
    TABLOCK
);
--Bulk Insert TV Shows
BULK INSERT stg_tvshows
FROM 'C:\Users\SASWAT\Downloads\netflix_tv_shows_detailed_up_to_2025.csv'
WITH
(
    FORMAT='CSV',
    FIRSTROW=2,
    FIELDTERMINATOR=',',
    ROWTERMINATOR='0x0A',
    TABLOCK
);

---Verification
SELECT COUNT(*) AS Total_Movies
FROM stg_movies;--16000

SELECT COUNT(*) AS Total_TV_Shows
FROM stg_tvshows;--16000
---check
select * from stg_movies
select * from stg_tvshows

