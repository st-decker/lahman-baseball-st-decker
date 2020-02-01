/*
    QUESTION ::
        Find the name and height of the shortest player in the database. 
		How many games did he play in? 
		What is the name of the team for which he played?

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
        Eddie Gaedel
		43 for height
		SLA -> St. Louis Browns (now the Cardinals)

*/

SELECT DISTINCT(CONCAT(namefirst, ' ', namelast)) AS fullname, height, G_all, teamid, yearid
FROM people
INNER JOIN appearances 
ON people.playerid = appearances.playerid
WHERE height IS NOT NULL
ORDER BY height