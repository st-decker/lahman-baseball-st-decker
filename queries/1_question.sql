/*
    QUESTION ::
        What range of years does the provided database cover?

    SOURCES ::
        * Batting, pitching, fielding


    DIMENSIONS ::
        * ...

    FACTS ::
        * min year
		* max year

    FILTERS ::
        * Using specific tables

    DESCRIPTION ::
        Assumptions from README: Stats 1871-2016
		Do a check from the 3 main tables as specified in the data dictionary
			Batting, pitching, fielding

    ANSWER ::
        ...

*/
SELECT min(min), max(max), max(max) - min(min) AS years_covered
FROM
	(SELECT min(yearid), max(yearid)
	FROM appearances

	UNION ALL

	SELECT min(yearid), max(yearid)
	FROM batting

	UNION ALL

	SELECT min(yearid), max(yearid)
	FROM pitching

	UNION ALL 

	SELECT min(yearid), max(yearid)
	FROM fielding) AS subquery
