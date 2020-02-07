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
        ...

*/

--Get name of managers who won TSN for both NL and AL
/*
SELECT * 
FROM awardsmanagers
WHERE awardid like 'TSN%'
ORDER BY playerid
*/

WITH nl AS (
	SELECT lgid, playerid
	FROM awardsmanagers
	WHERE awardid like 'TSN%' AND lgid = 'NL'
	
),	al AS (
	SELECT lgid, playerid
	FROM awardsmanagers
	WHERE awardid like 'TSN%' AND lgid = 'AL'

), managers AS (
	SELECT DISTINCT nl.playerid, al.lgid, nl.lgid
	FROM nl
	INNER JOIN al
	ON nl.playerid = al.playerid
	ORDER BY nl.playerid
)
