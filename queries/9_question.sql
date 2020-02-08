/*
    QUESTION ::
        Which managers have won the TSN Manager of the Year award in both the National League (NL) 
			and the American League (AL)? 
		Give their full name and the teams that they were managing when they won the award.

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
        "Davey"	"Johnson"	"johnsda02"	"TSN Manager of the Year"	1997	"AL"	"Baltimore Orioles"
		"Davey"	"Johnson"	"johnsda02"	"TSN Manager of the Year"	2012	"NL"	"Washington Nationals"
		"Jim"	"Leyland"	"leylaji99"	"TSN Manager of the Year"	1988	"NL"	"Pittsburgh Pirates"
		"Jim"	"Leyland"	"leylaji99"	"TSN Manager of the Year"	1990	"NL"	"Pittsburgh Pirates"
		"Jim"	"Leyland"	"leylaji99"	"TSN Manager of the Year"	1992	"NL"	"Pittsburgh Pirates"
		"Jim"	"Leyland"	"leylaji99"	"TSN Manager of the Year"	2006	"AL"	"Detroit Tigers"

*/

--Get name of managers who won TSN for both NL and AL
/*
SELECT * 
FROM awardsmanagers
WHERE awardid like 'TSN%'
ORDER BY playerid
*/

--Cannot make this look pretty
/*
WITH nl AS (
	SELECT lgid, playerid, yearid AS nlyear
	FROM awardsmanagers
	WHERE awardid like 'TSN%' AND lgid = 'NL'
	
),	al AS (
	SELECT lgid, playerid, yearid AS alyear
	FROM awardsmanagers
	WHERE awardid like 'TSN%' AND lgid = 'AL'

), managers AS (
	SELECT DISTINCT nl.playerid, al.lgid, nl.lgid, nlyear, alyear
	FROM nl
	INNER JOIN al
	ON nl.playerid = al.playerid
		AND nl.nlyear <> al.alyear
	ORDER BY nl.playerid
	
), peeps AS (
	SELECT managers.playerid AS manager, namefirst, namelast, nlyear, alyear
	FROM people
	INNER JOIN managers 
	ON people.playerid = managers.playerid
	
)
SELECT * FROM peeps
*/



--Try with a self join
--Looks nicer than the CTE method, got managers with both
/*
SELECT am1.playerid, am1.awardid, am1.yearid, am1.lgid
FROM awardsmanagers AS am1
JOIN awardsmanagers AS am2
ON am1.playerid = am2.playerid
	AND am1.awardid = am2.awardid
	AND am1.lgid <> am2.lgid
WHERE am1.awardid LIKE 'TSN%'
	AND (am1.lgid = 'NL' OR am1.lgid = 'AL')
	AND (am2.lgid = 'NL' OR am2.lgid = 'AL')
GROUP BY am1.playerid, am1.awardid, am1.yearid, am1.lgid
ORDER BY am1.playerid
*/



/*
SELECT p.namefirst, p.namelast, subquery.*, name
FROM
--Get managers who won in both leagues
	(SELECT am1.playerid, am1.awardid, am1.yearid, am1.lgid
	FROM awardsmanagers AS am1
	JOIN awardsmanagers AS am2
	ON am1.playerid = am2.playerid
	 --Award is the same
		AND am1.awardid = am2.awardid
	 --find people whose leagues are not the same between the two tables
		AND am1.lgid <> am2.lgid
	 --where you award is TSN and league is nl or al in both tables
	WHERE am1.awardid LIKE 'TSN%'
		AND (am1.lgid = 'NL' OR am1.lgid = 'AL')
		AND (am2.lgid = 'NL' OR am2.lgid = 'AL')
	 --eliminate duplicates by grouping
	GROUP BY am1.playerid, am1.awardid, am1.yearid, am1.lgid
	ORDER BY am1.playerid) AS subquery
--join people. left join or inner join gives the same result. 
INNER JOIN people AS p
ON subquery.playerid = p.playerid
--join in managers to get to teams
LEFT JOIN managers AS m
--use year to eliminate duplicates
ON subquery.playerid = m.playerid
	AND subquery.yearid = m.yearid
--join in teams to get name
LEFT JOIN teams AS t
--use team and yearid to eliminate duplicates
ON m.teamid = t.teamid
	AND m.yearid = t.yearid
ORDER BY namefirst
*/

--Done as a CTE with help from Taylor

WITH tsn_managers AS (
	SELECT playerid, yearid, lgid
	FROM awardsmanagers
	WHERE awardid = 'TSN Manager of the Year'
	AND lgid IN ('NL', 'AL')
	
), man_by_year AS (
	SELECT DISTINCT tsn.playerid, tsn.yearid
	FROM tsn_managers AS tsn
	JOIN tsn_managers AS tsn2
	ON tsn.playerid = tsn2.playerid
	AND tsn.lgid <> tsn2.lgid
)
SELECT p.namefirst, p.namelast, t.name, m.yearid
FROM man_by_year AS mby

INNER JOIN managers AS m
ON mby.playerid = m.playerid
	AND mby.yearid = m.yearid
	
INNER JOIN people AS p
ON mby.playerid = p.playerid

INNER JOIN teams AS t 
ON mby.yearid = t.yearid
AND m.teamid = t.teamid

ORDER BY namefirst