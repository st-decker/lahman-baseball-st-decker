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
        ...

*/


SELECT namefirst, namelast, height, f.g, b.g
FROM people
INNER JOIN fielding AS f
ON people.playerid = f.playerid
INNER JOIN batting AS b
ON people.playerid = b.playerid
INNER JOIN pitching AS p
WHERE height IS NOT null





