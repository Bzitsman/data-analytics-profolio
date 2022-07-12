/*Final Project for Class SDSU-DS-01-SQLDB SQL and Databases
By Brent Zitsman
Due date 3/5/2022*/

-- PART 1	
    -- Task 1 
    /*Write a query that shows band names, 
    their respective album names, 
    and their respective albums’ release dates 
    in descending order of release date.*/ 

SELECT 
    bandname, albumname, releasedate
FROM
    album a
        JOIN
    band b ON a.idband = b.idband
ORDER BY releasedate DESC;


-- TASK 2
/*Query that displays the name of all Bands that have a Drumer*/

SELECT 
    b.bandname, i.instrument
FROM
    band b
        JOIN
    player p ON b.idband = p.idband
        JOIN
    instrument i ON p.InstID = i.InstID
WHERE
    i.InstID = 4;

-- TASK 3 
/* Write a query that describes the number of unique instruments used by each band.*/

SELECT DISTINCT b.bandname, COUNT(p.InstID) AS "Number of Instruments"
FROM
    band b 
JOIN  player p 
ON b.idband = p.idband
JOIN instrument i 
ON p.InstID = i.InstID
GROUP BY b.bandname
ORDER BY b.bandname;

-- PART 2
	-- TASK 1
/*Insert Names and all information Tables the correct tables
Weezer
TLC
Paramore
Blackpink
Vampire Weekend*/

INSERT INTO band (idband, aid, bandname)
VALUES (22, 1, 'Weezer'),
		(23, 1, 'TLC'),
		(24, 1, 'Paramore'),
        (25, 1, 'Blackpink'),
        (26 , 1, 'Vampire Weekend');
 
-- TASK 2 
/*Insert the following information into the correct table*/

INSERT INTO player (idplayer,InstID,idband, pfname,plname,homecity,homestate)
VALUES (30, 3, 22,'Rivers','Cuomo','Rochester','New York'),
(31, 1, 22, 'Brian', 'Bell' ,'Iowa City', 'Iowa'),
(32 , 4 ,22, 'Patrick', 'Wilson', 'Buffalo', 'New York'),
(33, 2, 22, 'Scott', 'Shriner', 'Toledo', 'Ohio'),
(34, 3, 23, 'Tionne', 'Watkins', 'Des Moines', 'Iowa'),
(35, 3, 23, 'Rozonda', 'Thomas', 'Columbus', 'Geogia'),
(36, 3, 24, 'Hayley', 'Williams', 'Franklin', 'Tennessee'),
(37, 1, 24, 'Taylor', 'York', 'Nashville', 'Tennessee'),
(38, 4, 24, 'Zac', 'Farro', 'Voorhees Township', 'New Jersey'),
(39, 3, 25, 'Jisoo', 'Kim', null , 'South Korea'),
(40, 3, 25, 'Jennie', 'Kim', null, 'South Korea'),
(41, 3, 25, 'Roseanne', 'Park', null, 'New Zealand'),
(42, 3, 25, 'Lisa', 'Manoban', null, 'Thailand'),
(43, 3, 26, 'Ezra', 'Koenig', 'New York', 'New York'),
(44, 2, 26, 'Chris', 'Baio', 'Bronxville', 'New York'),
(45, 4, 26, 'Chris', 'Tomson', 'Upper Freehold Township', 'New Jersey');

/* test query to make sure the above information was added*/

SELECT 
    *
FROM
    band b
        JOIN
    player p ON b.idband = p.idband
        JOIN
    instrument i ON p.InstID = i.InstID
WHERE
    idplayer >= 30
ORDER BY idplayer;

	-- TASK 3
        -- Add new venue to venue table
INSERT INTO venue (idvenue, vname, city, state, zipcode, seats)
VALUES(12, 'Twin City Rock House', 'Minneapolis', 'Minnesota', 55414, 2000);

/* test query to make sure the above information was added*/

SELECT 
    *
FROM
    venue;

-- PART 3
		-- TASK 1        
/*Add 3 bands to Twin City Rock Mouse music festival gig*/

INSERT INTO gig( GigID, idvenue, idband, gigdate, numattendees)
VALUES (01, 12, 2, '2022-04-02', 2000),
(02, 12, 22, '2022-04-02', 2000),
(03, 12, 8, '2022-04-02', 2000);

/* test query to make sure the above information was added*/

SELECT 
    *
FROM
    gig;

-- TASK 2
/*Create a veiw that displays 
Band ID, 
Band name, 
venue, date, 
Number of attendees
 for upcoming gigs*/
 
CREATE VIEW band_db.Upcoming_Gigs AS
    SELECT 
        b.idband, b.bandname, v.vname, g.gigdate, g.numattendees
    FROM
        band b
            JOIN
        gig g ON b.idband = g.idband
            JOIN
        venue v ON v.idvenue = g.idvenue;



-- TASK 3
/*Create a view that includes the band name,
player name,
venue name,
player's home city and state*/


CREATE VIEW band_db.Home_Cities AS
    SELECT DISTINCT
        b.bandname,
        CONCAT(p.pfname, ' ', p.plname) AS msuician_name,
        p.homecity,
        p.homestate,
        v.vname,
        v.city,
        v.state
    FROM
        band b
            JOIN
        gig g ON b.idband = g.idband
            LEFT JOIN
        venue v ON v.idvenue = g.idvenue
            LEFT JOIN
        player p ON p.idband = b.idband


-- PART 4
-- TASK 1

Delimiter $
CREATE PROCEDURE band_db.GET_Player_by_State( 
IN state varchar (45))
BEGIN
SELECT b.bandname, CONCAT(p.pfname, ' ', p.plname) as msuician_name,p.homestate
FROM band b 
Join player p 
ON p.idband = b.idband
WHERE homestate = state;
END$

CALL GET_Player_by_State('CA');

-- TASK 2
Delimiter $
CREATE PROCEDURE band_db.Get_players_by_instrument(
IN InstID int)
BEGIN
SELECT p.InstID, CONCAT(p.pfname, ' ', p.plname) as name, i.instrument
FROM  player p
JOIN instrument i
ON p.InstID = i.InstID
WHERE p.InstID = InstID AND p.idband NOT IN (SELECT g.idband FROM gig g);
 END $

CALL Get_players_by_instrument(3);
-- TASK 3

INSERT INTO band (idband, aid, bandname)
VALUES (27, 1, 'John K');

INSERT INTO player (idplayer,InstID,idband, pfname,plname,homecity,homestate)
VALUES (46,3,27, 'Jonh', 'K', 'Orlando', 'Florida');

INSERT INTO gig (gigID, idvenue, idband,gigdate,numattendees)
VALUES (04, 12, 27, '2022-04-02', 2000);



