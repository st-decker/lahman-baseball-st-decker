/*
    QUESTION ::
        Find the average number of strikeouts per game by decade since 1920.
		Round the numbers you report to 2 decimal places. 
		Do the same for home runs per game. Do you see any trends?

    SOURCES ::
        * batting

    DIMENSIONS ::
        * ...

    FACTS ::
        * ...

    FILTERS ::
        * ...

    DESCRIPTION ::
        ...

    ANSWER ::
        Trends: As the years have gone on, there have been more strikeouts and more homeruns with an expection of the 2010 decade

*/

--Group by decade
SELECT 
	--ROUND(SUM(so)/SUM(g)::NUMERIC, 2) AS avg_per_game,
	ROUND(AVG(SO),2) AS strikeouts,
	--ROUND(SUM(hr)/SUM(g)::NUMERIC, 2) AS avg_per_game,
	ROUND(AVG(HR),2) AS homeruns, 
	(yearid/10) * 10 AS decade
FROM batting
WHERE (yearid/10) * 10 >= 1920
GROUP BY decade
ORDER BY decade 