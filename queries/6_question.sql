/*
    QUESTION ::
        Find the player who had the most success stealing bases in 2016, where success is measured as the percentage of stolen base attempts which are successful.
		(A stolen base attempt results either in a stolen base or being caught stealing.) 
		Consider only players who attempted at least 20 stolen bases.

    SOURCES ::
        * batting, people

    DIMENSIONS ::
        * ...

    FACTS ::
        * ...

    FILTERS ::
        * ...

    DESCRIPTION ::
        ...

    ANSWER ::
        Chris Owings
		91.3% success rate

*/

SELECT ROUND((SB/(SB + CS) * 100),2) AS success_stolen, CONCAT(namefirst, ' ', namelast)
FROM
	(SELECT people.playerid, namefirst, namelast, yearid, SB::numeric, CS::numeric
	FROM people
	INNER JOIN batting 
	ON people.playerid = batting.playerid
	WHERE yearid = 2016 AND SB >= 20) AS sub
ORDER BY success_stolen DESC
