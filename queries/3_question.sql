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
        * SUMS(salary)

    FILTERS ::
        * Where school is vanderbilt

    DESCRIPTION ::
        ...

    ANSWER ::
        David Price
		$245,553,888

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
SELECT DISTINCT(namefirst), (namelast), schoolname
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
*/
SELECT namefirst, namelast, schoolname, 
	--not dividing by three sums salary for every year he appears in the collegeplaying table
	SUM(salary)::numeric::money/3 AS totalearned
FROM schools
INNER JOIN collegeplaying
ON schools.schoolid = collegeplaying.schoolid
INNER JOIN people
ON collegeplaying.playerid = people.playerid
INNER JOIN salaries
ON people.playerid = salaries.playerid
WHERE schoolname ILIKE 'Vander%'
GROUP BY namefirst, namelast, schoolname
ORDER BY totalearned DESC

With vandy AS (
select distinct platerid
from collegeplaying
where schoolid = (
select distinct schoolid from schools where schoolname = 'Vanderbilt University'
))