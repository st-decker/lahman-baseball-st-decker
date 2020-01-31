/*
    QUESTION ::
        What range of years does the provided database cover?

    SOURCES ::
        * ...

    DIMENSIONS ::
        * ...

    FACTS ::
        * ...

    FILTERS ::
        * ...

    DESCRIPTION ::
        ...

    ANSWER ::
        ...

*/

SELECT MAX(yearid) AS recent_year, MIN(yearid) AS earliest_year, MAX(yearid) - MIN(yearid) AS years_covered
FROM appearances;
