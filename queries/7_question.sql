/*
    QUESTION ::
        From 1970 – 2016, what is the largest number of wins for a team that did not win the world series? 
		What is the smallest number of wins for a team that did win the world series? 
		Doing this will probably result in an unusually small number of wins for a world series champion – determine why this is the case.
		Then redo your query, excluding the problem year. 
		How often from 1970 – 2016 was it the case that a team with the most wins also won the world series? What percentage of the time?

    SOURCES ::
        * Teams

    DIMENSIONS ::
        * ...

    FACTS ::
        * ...

    FILTERS ::
        * ...

    DESCRIPTION ::
        ...

    ANSWER ::
        Answer 1 = 116 wins
		Answer 2 = 83. Less games were played in 1981

*/

--Question 1 answer
/*
SELECT DISTINCT(yearid), W
FROM teams
WHERE yearid BETWEEN 1970 AND 2016
	AND wswin IS NOT NULL
	AND wswin ='N'
ORDER BY W DESC
*/

--Question 2
/*
SELECT DISTINCT(yearid), W, G, teamid
FROM teams
WHERE yearid BETWEEN 1970 AND 2016
	AND wswin IS NOT NULL
	AND wswin ='Y'
	AND g > 110
ORDER BY W 
*/

--Question 3 answer

SELECT
	ROUND(AVG(CASE 
		WHEN 
			yearid BETWEEN 1970 AND 2016
			--AND wswin IS NOT NULL
			AND wswin ='Y' THEN 1
		WHEN yearid BETWEEN 1970 AND 2016
			 --AND wswin IS NOT NULL
			  AND wswin = 'N'
			 THEN 0 END), 2) * 100 AS percentage 
FROM teams

SELECT DISTINCT(yearid), W, G, teamid
FROM teams
WHERE yearid BETWEEN 1970 AND 2016
	AND wswin IS NOT NULL
	AND wswin ='Y'
	AND g > 110
ORDER BY W 