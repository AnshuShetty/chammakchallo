create database prgrm3;
use prgrm3;
create table actor(actor_id int primary key, act_name varchar(20), act_gender varchar(10));

CREATE TABLE DIRECTOR
( dir_id int,
dir_name VARCHAR (20),
dir_phone integer(10),
PRIMARY KEY (dir_id));

CREATE TABLE MOVIES (
MOV_ID int,
mov_title VARCHAR (25),
mov_year int,
mov_lang VARCHAR (12),
dir_id int,
PRIMARY KEY
(mov_id),
FOREIGN KEY (dir_id) REFERENCES DIRECTOR (dir_id));

CREATE TABLE MOVIE_CAST (
actor_id int,
mov_id int,
role VARCHAR(10),
PRIMARY KEY (actor_id, mov_id),
FOREIGN KEY (actor_id) REFERENCES actor (actor_id),
FOREIGN KEY (mov_id) REFERENCES MOVIES
(mov_id));

CREATE TABLE RATING
( mov_id int,
REV_STARS VARCHAR
(25), PRIMARY KEY
(mov_id),
FOREIGN KEY (mov_id) REFERENCES MOVIES (mov_id));

show tables;

INSERT INTO actor VALUES
(301,'ANUSHKA','F'); 
INSERT INTO actor VALUES (302,'prabhas','M'); INSERT INTO
actor VALUES (303,'PUNITH','M'); INSERT INTO
actor VALUES (304,'JERMY','M');

INSERT INTO DIRECTOR VALUES (60,'RAJAMOULI',
875101); INSERT INTO DIRECTOR VALUES
(61,'HITCHCOCK', 7766111); INSERT INTO DIRECTOR
VALUES (62,'FARAN', 9986531);
INSERT INTO DIRECTOR VALUES (63,'STEVEN SPIELBERG', 8989776);

INSERT INTO MOVIES VALUES (1001,'BAHUBALI-2', 2017, 'TELAGU', 60);
INSERT INTO MOVIES VALUES (1002,'BAHUBALI-1', 2015, 'TELAGU', 60);
INSERT INTO MOVIES VALUES (1003,'AKASH', 2008, 'KANNADA', 61);
INSERT INTO MOVIES VALUES (1004,'WAR HORSE', 2011, 'ENGLISH', 63);

INSERT INTO MOVIE_CAST VALUES (301, 1002, 'HEROINE');
INSERT INTO MOVIE_CAST VALUES (301, 1001, 'HEROINE');
INSERT INTO MOVIE_CAST VALUES (303, 1003, 'HERO');
INSERT INTO MOVIE_CAST VALUES (303, 1002, 'GUEST');
INSERT INTO MOVIE_CAST VALUES (304, 1004, 'HERO');


INSERT INTO RATING VALUES (1001, 4);
INSERT INTO RATING VALUES (1002, 2);
INSERT INTO RATING VALUES (1003, 5);
INSERT INTO RATING VALUES (1004,4);

-- List the titles of all movies directed by ‘Hitchcock’.
SELECT MOV_TITLE FROM
MOVIES
WHERE DIR_ID IN (SELECT DIR_ID
FROM DIRECTOR
WHERE DIR_NAME = 'HITCHCOCK');

-- Find the movie names where one or more actors acted in two or more movies.
SELECT MOV_TITLE
FROM MOVIES M, MOVIE_CAST MV
WHERE M.MOV_ID = MV.MOV_ID AND actor_id IN (SELECT actor_id
                                             FROM MOVIE_CAST
                                             GROUP BY actor_id
                                             HAVING COUNT(actor_id) > 1)
GROUP BY MOV_TITLE
HAVING COUNT(*) > 1;


-- List all actors who acted in a movie before 2000 and also in a movie after 2015 (use JOIN operation).
SELECT ACT_NAME, MOV_TITLE, MOV_YEAR
FROM ACTOR A JOIN
MOVIE_CAST C
ON A.ACTOR_ID=C.ACTOR_ID JOIN
MOVIES M
ON C.MOV_ID=M.MOV_ID
WHERE M.MOV_YEAR NOT BETWEEN 2000 AND 2015;

-- 4th query
SELECT MOV_TITLE, max(rev_stars) FROM
MOVIES
INNER JOIN RATING USING (MOV_ID) GROUP BY
MOV_TITLE
HAVING MAX (REV_STARS)>0 ORDER
BY MOV_TITLE;

SELECT MOV_TITLE, MAX(REV_STARS) FROM
MOVIES
INNER JOIN RATING USING (MOV_ID) GROUP BY
MOV_TITLE
HAVING MAX(REV_STARS)>0 ORDER
BY MOV_TITLE;

UPDATE RATING SET
REV_STARS= 5
WHERE MOV_ID IN (SELECT MOV_ID FROM MOVIES
WHERE DIR_ID IN (SELECT DIR_ID
FROM DIRECTOR
WHERE DIR_NAME = ‗STEVEN SPIELBERG„));