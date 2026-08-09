--Movies Load Store Procedure
CREATE OR ALTER PROCEDURE usp_Load_Final_Movies
AS
BEGIN
    SET NOCOUNT ON;

    TRUNCATE TABLE final_movies;

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
END;
GO

--Run:
EXEC usp_Load_Final_Movies;

--2. TV Shows Load Store Procedure
CREATE OR ALTER PROCEDURE usp_Load_Final_TVShows
AS
BEGIN
    SET NOCOUNT ON;

    TRUNCATE TABLE final_tvshows;

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
END;
GO

--Run:
EXEC usp_Load_Final_TVShows;
