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
	AND yearid <> 1981
ORDER BY W 
*/


--Question 3 answer
/*
SELECT
	ROUND(AVG(CASE 
		WHEN 
			yearid BETWEEN 1970 AND 2016
			AND wswin IS NOT NULL
			AND wswin ='Y' THEN 1
			 
		WHEN yearid BETWEEN 1970 AND 2016
			 --AND wswin IS NOT NULL
			  AND wswin = 'N'
			 THEN 0 END), 2) * 100 AS percentage 
FROM teams

select yearid, w, wswin, g, teamid
from teams
where yearid > 1969

SELECT
	ROUND(AVG(CASE 
		WHEN 
			yearid BETWEEN 1970 AND 2016
			AND wswin IS NOT NULL
			AND wswin ='Y' THEN 1
			 
		WHEN yearid BETWEEN 1970 AND 2016
			 --AND wswin IS NOT NULL
			  AND wswin = 'N'
			 THEN 0 END), 2)  AS percentage 
FROM teams

select * from teams where yearid > 1969

SELECT
	(ROUND(AVG(CASE
	WHEN
		SELECT max(w), teams.yearid
		FROM teams
		INNER JOIN
			(SELECT MAX(w) AS mostwins, wswin, yearid
			FROM teams
			where yearid > 1969
			 	AND wswin = 'y'
			group by yearid, wswin) AS test
		ON teams.yearid = test.yearid
		group by teams.yearid
		 then 1)
	 ELSE 0 END), 2 AS perc) as test3
from test3


SELECT max(w), teams.yearid
FROM teams
INNER JOIN
	(SELECT MAX(w) AS mostwins, wswin, yearid
	FROM teams
	where yearid > 1969
	group by yearid, wswin) AS test
ON teams.yearid = test.yearid
group by teams.yearid

SELECT w AS mostwins, wswin, yearid, teamid
	FROM teams
	where yearid > 1969
	group by yearid, wswin, teamid, mostwins
	order by yearid

WITH test AS (
	SELECT yearid, teamid, max(w)
	FROM teams
	GROUP BY yearid, teamid
), wswins AS (
	SELECT yearid, teamid, wswin
	FROM teams 
	WHERE wswin = 'Y'
)
SELECT *
FROM test
INNER JOIN wswins 
ON test.yearid = wswins.yearid

SELECT MAX(w), yearid
FROM teams
GROUP BY yearid
*/

WITH wswins AS 
	(
	SELECT DISTINCT yearid, w
	FROM teams
	WHERE wswin = 'Y'
	AND  yearid BETWEEN 1970 AND 2016
), 

	maxwins AS (
		SELECT MAX(w), yearid
		FROM teams
		WHERE yearid BETWEEN 1970 AND 2016
		--AND yearid <> 2013 AND yearid <> 2007
		GROUP BY yearid
)

SELECT ROUND((SUM(
	CASE WHEN w = MAX THEN 1
	ELSE 0 END)/COUNT(*)::numeric) * 100, 2) AS percentage
FROM wswins 
INNER JOIN maxwins
ON wswins.yearid = maxwins.yearid

