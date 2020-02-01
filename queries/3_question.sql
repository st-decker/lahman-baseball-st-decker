/*
    QUESTION ::
        Find all players in the database who played at Vanderbilt University. 
		Create a list showing each player’s first and last names as well as the total salary they earned in the major leagues.
		Sort this list in descending order by the total salary earned.
		Which Vanderbilt player earned the most money in the majors?

    SOURCES ::
        * people, collegeplaying, schools, salaries

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

/*
Below query ends up with a bunch of duplicates

SELECT namefirst, namelast, schoolname
FROM people
INNER JOIN collegeplaying
ON people.playerid = collegeplaying.playerid
INNER JOIN schools
ON collegeplaying.schoolid = schools.schoolid
WHERE schoolname ILIKE 'Vander%'
*/

/*
Below errors, why?
SELECT namefirst, DISTINCT(namelast), schoolname
FROM people
INNER JOIN collegeplaying
ON people.playerid = collegeplaying.playerid
INNER JOIN schools
ON collegeplaying.schoolid = schools.schoolid
WHERE schoolname ILIKE 'Vander%'
*/

--Eliminates duplicates
/*
SELECT DISTINCT(namefirst), (namelast), schoolname
FROM people
INNER JOIN collegeplaying
ON people.playerid = collegeplaying.playerid
INNER JOIN schools
ON collegeplaying.schoolid = schools.schoolid
WHERE schoolname ILIKE 'Vander%'
*/

/*
WITH cte1 AS (
	SELECT DISTINCT(namefirst), (namelast), schoolname
	FROM people
	INNER JOIN collegeplaying
	ON people.playerid = collegeplaying.playerid
	INNER JOIN schools
	ON collegeplaying.schoolid = schools.schoolid
	WHERE schoolname ILIKE 'Vander%'
), 
	cte2 AS (
	SELECT namefirst, namelast, SUM(salary) AS total_earned
	FROM salaries
	INNER JOIN people 
	ON salaries.playerid = people.playerid
	GROUP BY namefirst, namelast
)
*/


SELECT DISTINCT(namefirst), (namelast), schoolname, sum(salary) as salary
	FROM people
	INNER JOIN collegeplaying
	ON people.playerid = collegeplaying.playerid
	INNER JOIN schools
	ON collegeplaying.schoolid = schools.schoolid
	INNER JOIN  salaries
	ON people.playerid = salaries.playerid
	WHERE schoolname ILIKE 'Vander%'
	GROUP BY namefirst, namelast, schoolname
	ORDER BY salary desc
