/*
    QUESTION ::
        Using the attendance figures from the homegames table, 
			find the teams and parks which had the top 5 average attendance per game in 2016 
			(where average attendance is defined as total attendance divided by number of games). 
			Only consider parks where there were at least 10 games played. 
			Report the park name, team name, and average attendance. Repeat for the lowest 5 average attendance.

    SOURCES ::
        * parks, homegames, teams

    DIMENSIONS ::
        * ...

    FACTS ::
        * ...

    FILTERS ::
        * ...

    DESCRIPTION ::
        ...

    ANSWER ::
        "Los Angeles Dodgers"	"Dodger Stadium"			45719.90
		"St. Louis Cardinals"	"Busch Stadium III"			42524.57
		"Toronto Blue Jays"		"Rogers Centre"				41877.77
		"San Francisco Giants"	"AT&T Park"					41546.37
		"Chicago Cubs"			"Wrigley Field"				39906.42

*/

SELECT DISTINCT park_name, name, SUM(homegames.attendance)/SUM(homegames.games) AS a_per_g
FROM homegames
INNER JOIN parks
ON homegames.park = parks.park
INNER JOIN teams
ON homegames.team = teams.teamid
WHERE year = 2016
	AND games > 10 
GROUP BY park_name, name
ORDER BY a_per_g DESC
LIMIT 10

WITH atten AS (
	SELECT year, team, park, ROUND(attendance/games::numeric, 2) AS perc
	FROM homegames
	WHERE year = 2016
	AND  games > 10
),  parks AS (
	SELECT park, park_name
	FROM parks
),  team_info AS (
	SELECT name, teamid, yearid
	FROM teams
)

SELECT DISTINCT name, park_name, perc
FROM atten 
INNER JOIN parks
ON atten.park = parks.park
INNER JOIN team_info
ON atten.team = team_info.teamid AND atten.year = team_info.yearid
ORDER BY perc DESC