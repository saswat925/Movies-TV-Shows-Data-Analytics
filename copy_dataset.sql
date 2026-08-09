--Copy of stg_movies
SELECT *
INTO stg_movies_copy
FROM stg_movies;

--Copy of stg_tvshows
SELECT *
INTO stg_tvshows_copy
FROM stg_tvshows;

--Verify
SELECT COUNT(*) AS Movies_Copy
FROM stg_movies_copy;--16000

SELECT COUNT(*) AS TVShows_Copy
FROM stg_tvshows_copy;--16000
--profiling
select * from stg_movies_copy
select * from stg_tvshows_copy
