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

SELECT playerid, height
FROM people
where height is not null
order by height 
