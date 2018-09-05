/* Exercise 1, Olympic Facilicite
create on Setempter 24 2017 by Mamoutou Sangare 
*/


/*DROP TABLE Needs;
DROP TABLE Involves;
DROP TABLE Equipment;
DROP TABLE Officials;
DROP TABLE Events;
DROP TABLE Hosts;
DROP TABLE Sport;
DROP TABLE Complexes;*/ 
 

CREATE TABLE Complexes (
                        complexId INT PRIMARY KEY,
                        totalOccupiedArea INT, 
                        address VARCHAR(256),
                        chiefOrganPerson VARCHAR(256)
                     ); 
                        
CREATE TABLE Sport (name VARCHAR(50) PRIMARY KEY);

CREATE TABLE Hosts(
                   complexId REFERENCES Complexes, 
                   sportName REFERENCES Sport ON DELETE CASCADE
                );
                 
CREATE TABLE Events (
                     eventId INT PRIMARY KEY,
                     description VARCHAR(256), 
                     participantsNumber INT, 
                     plannedDate DATE,
                     duration INT, 
                     complexId REFERENCES Complexes
                 );
                     
CREATE TABLE Officials(
                      officialId INT PRIMARY KEY,
                       name VARCHAR(100)
                      );
                      
CREATE TABLE Equipment(
                      equipmentId INT PRIMARY KEY,
                      goalPosts VARCHAR(100), 
                      poles VARCHAR(100),
                      parallelBars VARCHAR(256)
                      );  
                      
CREATE TABLE Involves (
                       eventId INT REFERENCES Events, 
                       officialId INT REFERENCES Officials ON DELETE CASCADE
                       ); 
                  
CREATE TABLE Needs (
                    eventId REFERENCES Events,
                    equipmentId INT REFERENCES Equipment ON DELETE CASCADE
                ); 
-- insert and select statements            
INSERT INTO Complexes VALUES (1,240,'3212 Abidjan IvoryCOast','Boublo');
INSERT INTO Complexes VALUES (2,300,'352 Bouake IvoryCOast','Moussa');
INSERT INTO Complexes VALUES (3,4200,'352 Toumodi IvoryCOast','Moussa');
SELECT address From Complexes; 

