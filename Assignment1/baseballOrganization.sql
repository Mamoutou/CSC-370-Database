/*Baseball organization
 * exercise 2*/ 
 
/*
 * DROP TABLE FinishedGame;
--DROP TABLE Score;
--DROP TABLE Game;
--DROP TABLE PlayerTeam;
--DROP TABLE Coaches;
--DROP TABLE Teams;
--DROP TABLE Pitchers;
--DROP TABLE Players;
--DROP TABLE Managers;
--DROP TABLE Umpires;
 */ 

CREATE TABLE Umpires( umpireId INT primary key,
                     firstName VARCHAR(100), 
                     lastName VARCHAR(100),
                     dateOfBirth DATE,
                     placeOfBirth VARCHAR(40)
                     );
                 
CREATE TABLE Managers( managerId INT primary key,
                     firstName VARCHAR(100), 
                     lastName VARCHAR(100),
                     dateOfBirth DATE,
                     placeOfBirth VARCHAR(40)
                     ); 
             
CREATE TABLE Players( playerId INT primary key,
                     firstName VARCHAR(100), 
                     lastName VARCHAR(100),
                     dateOfBirth DATE,
                     placeOfBirth VARCHAR(40),
                     battingOrientation VARCHAR(20),
                     lifetimeBattingAverage INT 
                     );
                     
CREATE TABLE Pitchers( 
 					pitcherId INT REFERENCES Players(playerId) ON DELETE CASCADE,
 					earnedRunAverage INT,
 					PRIMARY KEY (pitcherId)
 					);
 					
CREATE TABLE Teams (
                  name VARCHAR (100) PRIMARY KEY, 
                  city VARCHAR (50),
                  league VARCHAR(40),
                  division CHAR(5),
                  managerId INT references Managers ON DELETE CASCADE
                  );
                  
CREATE TABLE Coaches (  
             coachId INT PRIMARY KEY,
             firstName VARCHAR (100), 
             lastName VARCHAR (100),
             dateOfBirth DATE,
             placeOfBirth VARCHAR(40),
             teamId VARCHAR (100) references Teams ON DELETE CASCADE
           ); 
            
 CREATE TABLE PlayerTeam(
                         playerId INT references players ON DELETE CASCADE,
                         teamId VARCHAR(100) references Teams ON DELETE CASCADE,
                         PRIMARY KEY (playerId, teamId)
                         );
                                             
 CREATE TABLE Game(
                    homeTeamName VARCHAR(100) references Teams ON DELETE CASCADE,
                    visitingTeamName  VARCHAR(100) REFERENCES Teams ON DELETE CASCADE,
                    gameDate DATE,
                    PRIMARY KEY (homeTeamName, visitingTeamName,gameDate)
                  ); 
    
 CREATE TABLE Score(
                     runs INT,
                     hits INT,
                     errors INT,
                     teamId VARCHAR (100) REFERENCES Teams,
                     PRIMARY KEY (runs,hits,errors,teamId)
                     );
         
 CREATE TABLE FinishedGame(
                 finishGameId INT primary KEY,
                 winnerPitcher VARCHAR (200),
				 LoserPitcher VARCHAR (200), 
				 savePitcher VARCHAR (200),
				 numberOfHitByEachPlayer INT, 
				 homeTeamId VARCHAR (100),
				 visitingTeamId VARCHAR (100),
				 playedDate DATE,
				 FOREIGN KEY (homeTeamId,visitingTeamId,playedDate) REFERENCES Game ON DELETE CASCADE
              );
              
INSERT INTO Umpires VALUES (1,'Mamoutou','Sangare',(to_date('02/01/1995','dd/mm/yyyy')),'Ivory Coast'); 
INSERT INTO Umpires VALUES (2,'Ali','Sangare',(to_date('02/01/1992','dd/mm/yyyy')),'Ivory Coast');
SELECT * FROM Umpires; 
