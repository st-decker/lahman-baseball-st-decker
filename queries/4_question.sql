/*
    QUESTION ::
        Using the fielding table, group players into three groups based on their position: 
		label players with position OF as "Outfield", those with position "SS", "1B", "2B", and "3B" as "Infield", and those with position "P" or "C" as "Battery".
		Determine the number of putouts made by each of these three groups in 2016.

    SOURCES ::
        * fielding

    DIMENSIONS ::
        * ...

    FACTS ::
        * Sum

    FILTERS ::
        * ...

    DESCRIPTION ::
        ...

    ANSWER ::
        "Outfield"	118320
		"Battery"	458894
		"Infield"	1199310

*/

/*
	(SELECT 
		CASE WHEN 
				pos = 'OF' THEN 'Outfield'
			 WHEN 
				pos = 'SS' 
				OR pos = '1B'
				OR pos = '2B' 
				OR pos = '3B' THEN 'Infield'
			 WHEN
				pos = 'P' 
				OR pos = 'C' THEN 'Battery'
			END AS position
	FROM fielding) AS subquery
	*/

--Gives total positions
/*
SELECT
	SUM(CASE WHEN pos = 'OF' THEN 1 ELSE 0 END) AS Outfield,
	SUM(CASE WHEN 
			pos = 'SS' 
			OR pos = '1B'
			OR pos = '2B' 
			OR pos = '3B' THEN 1 ELSE 0 END) AS Infield,
	SUM(CASE WHEN
			pos = 'P' 
			OR pos = 'C' THEN 1 ELSE 0 END) AS Battery
FROM fielding
*/

SELECT position, SUM(po) AS putouts
FROM
	(SELECT po,
		CASE WHEN 
				pos = 'OF' THEN 'Outfield'
			 WHEN 
				pos = 'SS' 
				OR pos = '1B'
				OR pos = '2B' 
				OR pos = '3B' THEN 'Infield'
			 WHEN
				pos = 'P' 
				OR pos = 'C' THEN 'Battery'
			END AS position
	FROM fielding
	GROUP BY position, po) AS sub
GROUP BY position 