---stg_movies_copy   cleaning 
--Check Total Records
SELECT COUNT(*) AS Total_Records
FROM stg_movies_copy;--16000records
--Check Duplicate Records
SELECT
show_id,
COUNT(*) AS Duplicate_Count
FROM stg_movies_copy
GROUP BY show_id
HAVING COUNT(*) > 1;--no duplicates found
--Check NULL Values
SELECT
SUM(CASE WHEN show_id IS NULL THEN 1 ELSE 0 END) AS show_id_null,
SUM(CASE WHEN type IS NULL THEN 1 ELSE 0 END) AS type_null,
SUM(CASE WHEN title IS NULL THEN 1 ELSE 0 END) AS title_null,
SUM(CASE WHEN director IS NULL THEN 1 ELSE 0 END) AS director_null,
SUM(CASE WHEN cast_members IS NULL THEN 1 ELSE 0 END) AS cast_null,
SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS country_null,
SUM(CASE WHEN date_added IS NULL THEN 1 ELSE 0 END) AS date_added_null,
SUM(CASE WHEN release_year IS NULL THEN 1 ELSE 0 END) AS release_year_null,
SUM(CASE WHEN rating IS NULL THEN 1 ELSE 0 END) AS rating_null,
SUM(CASE WHEN duration IS NULL THEN 1 ELSE 0 END) AS duration_null,
SUM(CASE WHEN genres IS NULL THEN 1 ELSE 0 END) AS genres_null,
SUM(CASE WHEN language IS NULL THEN 1 ELSE 0 END) AS language_null,
SUM(CASE WHEN description IS NULL THEN 1 ELSE 0 END) AS description_null,
SUM(CASE WHEN popularity IS NULL THEN 1 ELSE 0 END) AS popularity_null,
SUM(CASE WHEN vote_count IS NULL THEN 1 ELSE 0 END) AS vote_count_null,
SUM(CASE WHEN vote_average IS NULL THEN 1 ELSE 0 END) AS vote_average_null,
SUM(CASE WHEN budget IS NULL THEN 1 ELSE 0 END) AS budget_null,
SUM(CASE WHEN revenue IS NULL THEN 1 ELSE 0 END) AS revenue_null
FROM stg_movies_copy;
--Country (466 NULL)
SELECT *
FROM stg_movies_copy
WHERE country IS NULL;
--update with unknown
UPDATE stg_movies_copy
SET country = 'Unknown'
WHERE country IS NULL;
--Genres (107 NULL)
UPDATE stg_movies_copy
SET genres = 'Unknown'
WHERE genres IS NULL;
--Description (132 NULL)
UPDATE stg_movies_copy
SET description = 'No Description Available'
WHERE description IS NULL;

--Check Leading & Trailing Spaces
SELECT *
FROM stg_movies_copy
WHERE
title <> LTRIM(RTRIM(title))
OR director <> LTRIM(RTRIM(director))
OR cast_members <> LTRIM(RTRIM(cast_members))
OR country <> LTRIM(RTRIM(country))
OR genres <> LTRIM(RTRIM(genres))
OR language <> LTRIM(RTRIM(language))
OR description <> LTRIM(RTRIM(description));--no spaces found
--Check Double Spaces
SELECT *
FROM stg_movies_copy
WHERE
title LIKE '%  %'
OR director LIKE '%  %'
OR cast_members LIKE '%  %'
OR country LIKE '%  %'
OR genres LIKE '%  %'
OR language LIKE '%  %'
OR description LIKE '%  %';---found 585 rows double spaces

UPDATE stg_movies_copy
SET
title = REPLACE(title,'  ',' '),
director = REPLACE(director,'  ',' '),
cast_members = REPLACE(cast_members,'  ',' '),
country = REPLACE(country,'  ',' '),
genres = REPLACE(genres,'  ',' '),
language = REPLACE(language,'  ',' '),
description = REPLACE(description,'  ',' ');

--Check Special Characters / Encoding Issues
SELECT *
FROM stg_movies_copy
WHERE
title LIKE '%Ã%'
OR director LIKE '%Ã%'
OR cast_members LIKE '%Ã%'
OR country LIKE '%Ã%'
OR genres LIKE '%Ã%'
OR description LIKE '%Ã%';---no special charecter found
--Check Blank Strings
SELECT *
FROM stg_movies_copy
WHERE
title = ''
OR director = ''
OR cast_members = ''
OR country = ''
OR genres = ''
OR language = ''
OR description = '';--no blank strings found

--Rating Validation
SELECT *
FROM stg_movies_copy
WHERE rating < 0
   OR rating > 10;--correct
--Popularity Validation
SELECT *
FROM stg_movies_copy
WHERE popularity < 0;--correct
--Vote Count Validation
SELECT *
FROM stg_movies_copy
WHERE vote_count < 0;
--Budget Validation
SELECT *
FROM stg_movies_copy
WHERE budget < 0;--correct
--Date Validation
SELECT *
FROM stg_movies_copy
WHERE date_added IS NULL;--correct 



     ---Create Final Table  final_movies
CREATE TABLE final_movies
(
    show_id INT PRIMARY KEY,
    type VARCHAR(20),
    title NVARCHAR(500),
    director NVARCHAR(500),
    cast_members NVARCHAR(MAX),
    country NVARCHAR(255),
    date_added DATE,
    release_year SMALLINT,
    rating DECIMAL(4,2),
    duration VARCHAR(50),
    genres NVARCHAR(500),
    language VARCHAR(50),
    description NVARCHAR(MAX),
    popularity DECIMAL(10,3),
    vote_count INT,
    vote_average DECIMAL(4,2),
    budget BIGINT,
    revenue BIGINT,
);

--Load Clean Data
INSERT INTO final_movies
(
    show_id,
    type,
    title,
    director,
    cast_members,
    country,
    date_added,
    release_year,
    rating,
    duration,
    genres,
    language,
    description,
    popularity,
    vote_count,
    vote_average,
    budget,
    revenue
)
SELECT
    show_id,
    type,
    title,
    director,
    cast_members,
    country,
    date_added,
    release_year,
    rating,
    duration,
    genres,
    language,
    description,
    popularity,
    vote_count,
    vote_average,
    budget,
    revenue
FROM stg_movies_copy;

--Verify Record Count
SELECT COUNT(*) AS Total_Records
FROM final_movies;

---profiling
select * from final_movies
--verify null
SELECT
SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS Country_Null,
SUM(CASE WHEN genres IS NULL THEN 1 ELSE 0 END) AS Genres_Null,
SUM(CASE WHEN description IS NULL THEN 1 ELSE 0 END) AS Description_Null
FROM final_movies;
--Verify Duplicate
SELECT
show_id,
COUNT(*)
FROM final_movies
GROUP BY show_id
HAVING COUNT(*) > 1;

---Check Numeric Columns
SELECT *
FROM final_movies
WHERE
TRY_CAST(show_id AS INT) IS NULL
OR TRY_CAST(release_year AS SMALLINT) IS NULL
OR TRY_CAST(rating AS DECIMAL(4,2)) IS NULL
OR TRY_CAST(popularity AS DECIMAL(10,3)) IS NULL
OR TRY_CAST(vote_count AS INT) IS NULL
OR TRY_CAST(vote_average AS DECIMAL(4,2)) IS NULL
OR TRY_CAST(budget AS BIGINT) IS NULL
OR TRY_CAST(revenue AS BIGINT) IS NULL;--corret numeric columns
--Check Date Column
SELECT *
FROM final_movies
WHERE TRY_CAST(date_added AS DATE) IS NULL
AND date_added IS NOT NULL;--correct date column
--Check String Length
SELECT
MAX(LEN(title)) AS title_len,
MAX(LEN(director)) AS director_len,
MAX(LEN(country)) AS country_len,
MAX(LEN(genres)) AS genres_len,
MAX(LEN(language)) AS language_len,
MAX(LEN(duration)) AS duration_len
from final_movies
--Check Decimal Precision
SELECT TOP 20
rating,
vote_average,
popularity
FROM final_movies;
--check final data types
EXEC sp_help final_movies;
---profiling 
select * from final_movies

                -----2 stg_tvshows_copy  cleaning part


----Total Records
SELECT COUNT(*) AS Total_Records
FROM stg_tvshows_copy;--16000
--Duplicate Check
SELECT
show_id,
COUNT(*) AS Duplicate_Count
FROM stg_tvshows_copy
GROUP BY show_id
HAVING COUNT(*) > 1;---9 rows are duplicated
--show_id	Duplicate_Count
--279739	2
--252630	2
--278867	2
--279457	2
--281750	2
--283602	2
--280651	2
--283929	2
--284416	2
---remove duplicate with cte and windows functions
;WITH CTE AS
(
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY show_id ORDER BY show_id) AS rn
    FROM stg_tvshows_copy
)
DELETE FROM CTE
WHERE rn > 1;

---NULL Values Check
SELECT
SUM(CASE WHEN show_id IS NULL THEN 1 ELSE 0 END) AS show_id_null,
SUM(CASE WHEN type IS NULL THEN 1 ELSE 0 END) AS type_null,
SUM(CASE WHEN title IS NULL THEN 1 ELSE 0 END) AS title_null,
SUM(CASE WHEN director IS NULL THEN 1 ELSE 0 END) AS director_null,
SUM(CASE WHEN cast_members IS NULL THEN 1 ELSE 0 END) AS cast_null,
SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS country_null,
SUM(CASE WHEN date_added IS NULL THEN 1 ELSE 0 END) AS date_added_null,
SUM(CASE WHEN release_year IS NULL THEN 1 ELSE 0 END) AS release_year_null,
SUM(CASE WHEN rating IS NULL THEN 1 ELSE 0 END) AS rating_null,
SUM(CASE WHEN duration IS NULL THEN 1 ELSE 0 END) AS duration_null,
SUM(CASE WHEN genres IS NULL THEN 1 ELSE 0 END) AS genres_null,
SUM(CASE WHEN language IS NULL THEN 1 ELSE 0 END) AS language_null,
SUM(CASE WHEN description IS NULL THEN 1 ELSE 0 END) AS description_null,
SUM(CASE WHEN popularity IS NULL THEN 1 ELSE 0 END) AS popularity_null,
SUM(CASE WHEN vote_count IS NULL THEN 1 ELSE 0 END) AS vote_count_null,
SUM(CASE WHEN vote_average IS NULL THEN 1 ELSE 0 END) AS vote_average_null
FROM stg_tvshows_copy;
--Country Update
UPDATE stg_tvshows_copy
SET country = 'Unknown'
WHERE country IS NULL;
--Genres Update
UPDATE stg_tvshows_copy
SET genres = 'Unknown'
WHERE genres IS NULL;
--Description Update
UPDATE stg_tvshows_copy
SET description = 'No Description Available'
WHERE description IS NULL;

--Verify NULL Values Again
SELECT
SUM(CASE WHEN director IS NULL THEN 1 ELSE 0 END) AS director_null,
SUM(CASE WHEN cast_members IS NULL THEN 1 ELSE 0 END) AS cast_null,
SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS country_null,
SUM(CASE WHEN genres IS NULL THEN 1 ELSE 0 END) AS genres_null,
SUM(CASE WHEN description IS NULL THEN 1 ELSE 0 END) AS description_null
FROM stg_tvshows_copy;

-- ============================================
-- NULL VALUE VALIDATION RESULT
-- ============================================
-- director_null    : 10960 (Kept as NULL)
-- cast_null        : 1156  (Kept as NULL)
-- country_null     : 0     (Updated to 'Unknown')
-- genres_null      : 0     (Updated to 'Unknown')
-- description_null : 0     (Updated to 'No Description Available')
-- ============================================

-- Check Leading & Trailing Spaces
SELECT *
FROM stg_tvshows_copy
WHERE
title <> LTRIM(RTRIM(title))
OR director <> LTRIM(RTRIM(director))
OR cast_members <> LTRIM(RTRIM(cast_members))
OR country <> LTRIM(RTRIM(country))
OR genres <> LTRIM(RTRIM(genres))
OR language <> LTRIM(RTRIM(language))
OR description <> LTRIM(RTRIM(description));---no leading and trailing spaces found
-- Check Double Spaces
SELECT *
FROM stg_tvshows_copy
WHERE
title LIKE '%  %'
OR director LIKE '%  %'
OR cast_members LIKE '%  %'
OR country LIKE '%  %'
OR genres LIKE '%  %'
OR language LIKE '%  %'
OR description LIKE '%  %';

---identfy columns of double spaces 
SELECT
SUM(CASE WHEN title LIKE '%  %' THEN 1 ELSE 0 END) AS title_double_space,
SUM(CASE WHEN director LIKE '%  %' THEN 1 ELSE 0 END) AS director_double_space,
SUM(CASE WHEN cast_members LIKE '%  %' THEN 1 ELSE 0 END) AS cast_double_space,
SUM(CASE WHEN country LIKE '%  %' THEN 1 ELSE 0 END) AS country_double_space,
SUM(CASE WHEN genres LIKE '%  %' THEN 1 ELSE 0 END) AS genres_double_space,
SUM(CASE WHEN language LIKE '%  %' THEN 1 ELSE 0 END) AS language_double_space,
SUM(CASE WHEN description LIKE '%  %' THEN 1 ELSE 0 END) AS description_double_space
FROM stg_tvshows_copy;
-- ============================================
-- DOUBLE SPACE VALIDATION RESULT
-- ============================================
-- title_double_space       : 0
-- director_double_space    : 3
-- cast_double_space        : 9
-- country_double_space     : 0
-- genres_double_space      : 0
-- language_double_space    : 0
-- description_double_space : 262

-- Remove Double Spaces
UPDATE stg_tvshows_copy
SET
title = REPLACE(title,'  ',' '),
director = REPLACE(director,'  ',' '),
cast_members = REPLACE(cast_members,'  ',' '),
country = REPLACE(country,'  ',' '),
genres = REPLACE(genres,'  ',' '),
language = REPLACE(language,'  ',' '),
description = REPLACE(description,'  ',' ');

-- Check Special Characters / Encoding Issues
SELECT *
FROM stg_tvshows_copy
WHERE
title LIKE '%Ã%'
OR director LIKE '%Ã%'
OR cast_members LIKE '%Ã%'
OR country LIKE '%Ã%'
OR genres LIKE '%Ã%'
OR description LIKE '%Ã%';
      -- No Special Characters / Encoding Issues Found
 -- Check Blank Strings
SELECT *
FROM stg_tvshows_copy
WHERE
title = ''
OR director = ''
OR cast_members = ''
OR country = ''
OR genres = ''
OR language = ''
OR description = '';-- No Blank Strings Found
-- Rating Validation
SELECT *
FROM stg_tvshows_copy
WHERE rating < 0
   OR rating > 10;-- Rating Validation Passed
-- Popularity Validation
SELECT *
FROM stg_tvshows_copy
WHERE popularity < 0;-- Popularity Validation Passed

-- Vote Count Validation
SELECT *
FROM stg_tvshows_copy
WHERE vote_count < 0;-- Vote Count Validation Passed
-- Vote Average Validation
SELECT *
FROM stg_tvshows_copy
WHERE vote_average < 0
   OR vote_average > 10;-- Vote Average Validation Passed
-- Date Validation
SELECT *
FROM stg_tvshows_copy
WHERE date_added IS NULL;
--Check Invalid Dates
SELECT *
FROM stg_tvshows_copy
WHERE TRY_CAST(date_added AS DATE) IS NULL
AND date_added IS NOT NULL;

-- Validate Date, Year and Month
SELECT TOP 20
    date_added,
    YEAR(date_added) AS Year_Number,
    MONTH(date_added) AS Month_Number,
    DATENAME(MONTH, date_added) AS Month_Name
FROM stg_tvshows_copy;
-- Date Validation Passed
-- Year, Month Number and Month Name extracted successfully.


-- Create Final Table
CREATE TABLE final_tvshows
(
    show_id INT PRIMARY KEY,
    type VARCHAR(20),
    title NVARCHAR(500),
    director NVARCHAR(500),
    cast_members NVARCHAR(MAX),
    country NVARCHAR(255),
    date_added DATE,
    release_year SMALLINT,
    rating DECIMAL(4,2),
    duration VARCHAR(50),
    genres NVARCHAR(500),
    language VARCHAR(50),
    description NVARCHAR(MAX),
    popularity DECIMAL(10,3),
    vote_count INT,
    vote_average DECIMAL(4,2)
);

-- Load Clean Data
INSERT INTO final_tvshows
(
    show_id,
    type,
    title,
    director,
    cast_members,
    country,
    date_added,
    release_year,
    rating,
    duration,
    genres,
    language,
    description,
    popularity,
    vote_count,
    vote_average
)
SELECT
    show_id,
    type,
    title,
    director,
    cast_members,
    country,
    date_added,
    release_year,
    rating,
    duration,
    genres,
    language,
    description,
    popularity,
    vote_count,
    vote_average
FROM stg_tvshows_copy;

-- Verify Record Count
SELECT COUNT(*) AS Total_Records
FROM final_tvshows;
--15991 records (16000 - 9 duplicate rows)

--profiling
select * from final_tvshows

-- Validate Date Column
SELECT *
FROM final_tvshows
WHERE TRY_CAST(date_added AS DATE) IS NULL
AND date_added IS NOT NULL;--passs
-- Validate Numeric Columns
SELECT *
FROM final_tvshows
WHERE
TRY_CAST(show_id AS INT) IS NULL
OR TRY_CAST(release_year AS SMALLINT) IS NULL
OR TRY_CAST(rating AS DECIMAL(4,2)) IS NULL
OR TRY_CAST(popularity AS DECIMAL(10,3)) IS NULL
OR TRY_CAST(vote_count AS INT) IS NULL
OR TRY_CAST(vote_average AS DECIMAL(4,2)) IS NULL;--pass

-- Check Final Table Data Types
EXEC sp_help 'final_tvshows';

---for power bi 

--Movies View
CREATE VIEW view_movies AS
SELECT *
FROM final_movies;
GO
---TV Shows View
CREATE VIEW view_tvshows AS
SELECT *
FROM final_tvshows;
GO

--Check:

SELECT * FROM view_movies;
SELECT * FROM view_tvshows;


