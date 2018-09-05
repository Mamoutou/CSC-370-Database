
CREATE TABLE classes(  
              class VARCHAR(256),
              type VARCHAR (256),
              country VARCHAR (256), 
              numGuns INT,
              bore INT, 
              displacement INT
); 
              
CREATE TABLE ships( 
                   name VARCHAR (256),
                   class VARCHAR (256),
                   launched INT
                   );  
                   
CREATE TABLE battles(
                   name VARCHAR (256),
                   date_fought DATE
                   );
                   
CREATE TABLE outcomes(
                    ship VARCHAR (256),
                    battle VARCHAR(256), 
                    result VARCHAR (256)
                    );
                    
INSERT INTO classes 
VALUES ('Bismarck','bb','Germany',8,15,42000); 
INSERT INTO classes 
VALUES('Kongo','bc','Japan',8,14,32000);
INSERT INTO classes 
VALUES('North Carolina','bb','USA',9,16,37000);
INSERT INTO classes 
VALUES('Renown','bc','Gt. Britain',6,15,32000);
INSERT INTO classes 
VALUES('Revenge','bb','Gt. Britain',8,15,29000);
INSERT INTO classes 
VALUES('Tennessee','bb','USA',12,14,32000);
INSERT INTO classes 
VALUES('Yamato','bb','Japan',9,18,65000);

INSERT INTO ships
VALUES ('California','Tennessee',1921);
INSERT INTO ships
VALUES('Haruna','Kongo',1915);
INSERT INTO ships
VALUES('Hiei','Kongo',1914);
INSERT INTO ships
VALUES('Iowa','Iowa',1943);
INSERT INTO ships
VALUES('Kirishima','Kongo',1914);
INSERT INTO ships
VALUES('Kongo','Kongo',1913);
INSERT INTO ships
VALUES('Missouri','Iowa',1944);
INSERT INTO ships
VALUES('Musashi','Yamato',1942);
INSERT INTO ships
VALUES('New Jersey','Iowa',1943);
INSERT INTO ships
VALUES('North Carolina','North Carolina',1941);
INSERT INTO ships
VALUES('Ramilles','Revenge',1917);
INSERT INTO ships
VALUES('Renown','Renown',1916);
INSERT INTO ships
VALUES('Repulse','Renown',1916);
INSERT INTO ships
VALUES('Resolution','Revenge',1916);
INSERT INTO ships
VALUES('Revenge','Revenge',1916);
INSERT INTO ships
VALUES('Royal Oak','Revenge',1916);
INSERT INTO ships
VALUES('Royal Sovereign','Revenge',1916);
INSERT INTO ships
VALUES('Tennessee','Tennessee',1920);
INSERT INTO ships
VALUES('Washington','North Carolina',1941);
INSERT INTO ships
VALUES('Wisconsin','Iowa',1944);
INSERT INTO ships
VALUES('Yamato','Yamato',1941);

INSERT INTO battles
VALUES('North Atlantic','27-May-1941');
INSERT INTO battles
VALUES('Guadalcanal','15-Nov-1942');
INSERT INTO battles
VALUES('North Cape','26-Dec-1943');
INSERT INTO battles
VALUES('Surigao Strait','25-Oct-1944');

INSERT INTO outcomes
VALUES('Bismarck','North Atlantic', 'sunk');
INSERT INTO outcomes
VALUES('California','Surigao Strait', 'ok');
INSERT INTO outcomes
VALUES('Duke of York','North Cape', 'ok');
INSERT INTO outcomes
VALUES('Fuso','Surigao Strait', 'sunk');
INSERT INTO outcomes
VALUES('Hood','North Atlantic', 'sunk');
INSERT INTO outcomes
VALUES('King George V','North Atlantic', 'ok');
INSERT INTO outcomes
VALUES('Kirishima','Guadalcanal', 'sunk');
INSERT INTO outcomes
VALUES('Prince of Wales','North Atlantic', 'damaged');
INSERT INTO outcomes
VALUES('Rodney','North Atlantic', 'ok');
INSERT INTO outcomes
VALUES('Scharnhorst','North Cape', 'sunk');
INSERT INTO outcomes
VALUES('South Dakota','Guadalcanal', 'ok');
INSERT INTO outcomes
VALUES('West Virginia','Surigao Strait', 'ok');
INSERT INTO outcomes
VALUES('Yamashiro','Surigao Strait', 'sunk');

SELECT * FROM classes;
SELECT * FROM ships;
SELECT * FROM battles;
SELECT * FROM outcomes; 

/*2-1  The treaty of Washington in 1921 prohibited capital ships heavier than 35,000
tons. List the ships that violated the treaty of Washington.*/
SELECT name
FROM ships, classes
WHERE classes.displacement > 35000 AND ships.launched>= 1921 AND classes.class = ships.class;

/*2-2 List the name, displacement, and number of guns of the ships engaged in the
battle of Guadalcanal.*/ 

SELECT ship,displacement,numguns 
FROM (
         SELECT  name,displacement,numguns FROM  classes, ships 
         WHERE classes.class = ships.class
     )
     right outer JOIN (
           SELECT ship FROM outcomes WHERE battle = 'Guadalcanal'
     ) 
     ON ship = name; 
     

/* 2-3 List all the capital ships mentioned in the database. (Remember that not all ships
appear in the Ships relation.)*/ 
           
SELECT name AS ship FROM ships
     UNION 
SELECT ship FROM outcomes;
    
/* 2-4 Find those countries that had both battleships and battlecruisers. */ 
    
SELECT country FROM classes WHERE type = 'bb'
INTERSECT 
SELECT country FROM classes WHERE type = 'bc';

/*2- 5. Find those ships that "lived to fight another day"; they were damaged in one
battle, but later fought in another.*/

CREATE VIEW OutcomesWithDate AS
SELECT Outcomes.ship, Outcomes.battle, outcomes.result, Battles.date_fought
FROM Outcomes JOIN Battles ON Outcomes.battle = Battles.name;
SELECT * FROM OutcomesWithDate;

SELECT  x.ship
FROM (
		(
		  SELECT * FROM OutcomesWithDate 
		  WHERE result = 'damaged'
		) x
		 JOIN 
		(
		 SELECT * FROM OutcomesWithDate 
        )y
        ON (x.ship =y.ship AND x.date_fought < y.date_fought) 
) ;

/*2-6 Find the countries whose ships had the largest number of guns. */
SELECT country
FROM classes
WHERE numGuns = (SELECT MAX(numGuns) FROM classes);

/*7. Find the names of the ships whose number of guns was the largest for those ships
of the same bore. */


CREATE VIEW largestGuns AS ( 
    SELECT bore, max(numGuns) AS MaxGuns 
    FROM classes 
    GROUP by(bore)
);

SELECT name FROM (SELECT * FROM largestGuns)x
   JOIN 
     (SELECT name,bore,numguns 
     FROM ships JOIN classes 
     ON ships.class = classes.class)y
  on x.bore = y.bore AND y.numGuns = x.MaxGuns; 


DROP VIEW largestGuns; 

/*2-8. Find for each class with at least three 
 * ships the number of ships of that class sunk in battle. */

CREATE VIEW shipsNameC AS (
     SELECT name, class  FROM ships
);

SELECT class, nvl (countSunk,0) AS numSunkShips
FROM (
        SELECT class,count(name) FROM ships
        GROUP BY class
        HAVING count(class) >= 3
    )
    LEFT OUTER JOIN 
    (
       SELECT class, count(*) AS countSunk FROM shipsNameC
       JOIN (SELECT ship FROM outcomes WHERE result = 'sunk')y 
       on shipsNameC.name = ship
       GROUP BY class
    ) 
    USING (class)
    ORDER BY numSunKShips; 
    
--DROP VIEW shipsNameC; 

/* 3-1 (2 points) Two of the three battleships of the Italian Vittorio Veneto class –
Vittorio Veneto and Italia – were launched in 1940; the third ship of that class,
Roma, was launched in 1942. Each had 15-inch guns and a displacement of
41,000 tons. Insert these facts into the database.*/

INSERT INTO classes (class,type,country,numGuns,displacement)
VALUES ('Vittorio Veneto','bb','Italy',15,41000); 
INSERT INTO Ships VALUES ('Vittorio Veneto', 'Vittorio Veneto', 1940);
INSERT INTO Ships VALUES ('Italia','Vittorio Veneto', 1940);
INSERT INTO Ships VALUES ('Roma','Vittorio Veneto',1942);

SELECT * FROM classes; 
SELECT * FROM ships; 

/* 3-2 (1 point) Delete all classes with fewer than three ships. */ 

DELETE FROM classes 
WHERE class IN (
			SELECT class 
			FROM classes JOIN (SELECT class, count (name) AS cnt 
			FROM 
			 (
			  SELECT  class, name FROM ships 
			  UNION 
			  SELECT class, classes.class AS name FROM classes
			 )
			 GROUP BY class
			 HAVING count (name)  < 3)
			 USING (class)
); 

--This should run last since it will modify the classes relation 

/* 3-3 Modify the Classes relation so that gun bores are measured in
centimeters (one inch = 2.5 cm) and displacements are measured in metric tons
(one metric ton = 1.1 ton).
*/

alter TABLE classes 
DISABLE CONSTRAINT CHECK_NUM_GUNS_BORE;
UPDATE Classes 
SET numGuns = numGuns * 2.5;
UPDATE Classes 
SET displacement = displacement * 1.1; 

/* 4-1. (1 point) Every class mentioned in Ships must be mentioned in Classes. */ 

ALTER TABLE Classes ADD CONSTRAINT classes_pk PRIMARY KEY (class);
ALTER TABLE Ships ADD CONSTRAINT ship_to_classes_fk
FOREIGN KEY(class) REFERENCES Classes(class) EXCEPTIONS INTO Exceptions;

CREATE TABLE Exceptions(
		row_id ROWID,
		owner VARCHAR2(225),
		table_name VARCHAR2(225),
		constraint VARCHAR2(225)
);

SELECT Ships.*, constraint
FROM Ships, Exceptions
WHERE Ships.rowid = Exceptions.row_id; 

DELETE FROM Ships
WHERE class IN (
	SELECT class
	FROM Ships, Exceptions
	WHERE Ships.rowid = Exceptions.row_id
);
ALTER TABLE Ships ADD CONSTRAINT ship_to_classes_fk
FOREIGN KEY(class) REFERENCES Classes(class);


/*4-2. (1 point) Every battle mentioned in Outcomes must be mentioned in Battles.*/ 

ALTER TABLE Battles ADD CONSTRAINT battle_pk PRIMARY KEY (name);
ALTER TABLE Outcomes ADD CONSTRAINT outcomes_to_battle_fk
FOREIGN KEY(battle) REFERENCES Battles(name);

/*4-3 Every ship mentioned in Outcomes must be mentioned in Ships.*/

ALTER TABLE Ships ADD CONSTRAINT ship_pk PRIMARY KEY (name);
ALTER TABLE Outcomes ADD CONSTRAINT outcomes_to_ship_fk
FOREIGN KEY(ship) REFERENCES Ships(name) EXCEPTIONS INTO Exceptions;

DELETE FROM Outcomes 
WHERE ship IN (
	SELECT ship 
	FROM Outcomes, Exceptions
	WHERE Outcomes.rowid = Exceptions.row_id
);

ALTER TABLE Outcomes ADD CONSTRAINT outcomes_to_ship_fk
FOREIGN KEY(ship) REFERENCES Ships(name); 

/*4-4 No class of ships may have guns with larger than 16-inch bore.*/ 
 
ALTER TABLE Classes ADD CONSTRAINT check_guns CHECK (bore <= 16); 

/* 4-5 if a class of ships has more than 9 guns, then their bore must be no
larger than 14 inches.*/ 

ALTER TABLE Classes ADD CONSTRAINT check_num_guns_bore CHECK (numGuns <= 9 OR bore <= 14); 

/*4-6. (2 points) No ship can be in battle before it is launched. */

CREATE VIEW OutcomesView AS
SELECT ship, battle, result
FROM Outcomes O
WHERE NOT EXISTS (
	SELECT *
	FROM Ships S, Battles B
	WHERE S.name=O.ship AND O.battle=B.name AND
	S.launched > TO_NUMBER(TO_CHAR(B.date_fought, 'yyyy'))
)
WITH CHECK OPTION;
--Now we can try some insertion on this view.
INSERT INTO OutcomesView (ship, battle, result)
VALUES('Musashi', 'North Atlantic','ok');

/*4-7. (2 points) No ship can be launched before the 
 * ship that bears the name of the first ship’s class. */

CREATE VIEW launchedView AS
SELECT name, class, launched 
FROM Ships S1
WHERE NOT EXISTS (
		SELECT *
		FROM Ships S2
		WHERE S1.class = S2.class AND S2.name = S1.class AND 
		S2.LAUNCHED > S1.launched 
)
WITH CHECK OPTION;

/* 4-8 No ship fought in a battle that was at a later date than another battle in
which that ship was sunk. */ 

CREATE VIEW ShipsBattlesView AS
SELECT ship, battle, result
FROM Outcomes O
WHERE NOT EXISTS (
		SELECT *
		FROM Battles B1, Battles B2 
		WHERE O.result = 'sunk' AND O.battle = B1.NAME AND B1.NAME <> B2.NAME AND 
		TO_NUMBER(TO_CHAR(B1.date_fought, 'yyyy')) < TO_NUMBER(TO_CHAR(B2.date_fought, 'yyyy'))
)
WITH CHECK OPTION;

