/*doctors DATA base USING the OBJECT orientation approach
 * Create on September 26,2017 by Mamoutou
 * exercise 3 
*/


/*
--DROP TABLE HopDoctorFamPhysicians;
--DROP TABLE FamilyPhysicians;
--DROP TABLE HospitalDoctors;
--DROP TABLE Doctors;
*/ 

CREATE TABLE Doctors( 
				doctorId INT primary Key,
				name VARCHAR(256), 
				specialty VARCHAR(256), 
				numberOfYearOfExperience INT
			);

CREATE TABLE HospitalDoctors( 
				hospitalDocId INT REFERENCES Doctors on DELETE CASCADE,
				name VARCHAR(256), 
				specialty VARCHAR(256), 
				numberOfYearOfExperience INT,
				hospitalName VARCHAR (256),
				PRIMARY key(hospitalDocId)
			);
CREATE TABLE FamilyPhysicians( 
				familyPhysicianId INT REFERENCES Doctors on DELETE CASCADE,
				name VARCHAR(256), 
				specialty VARCHAR(256), 
				numberOfYearOfExperience INT,
				officeAddress VARCHAR (256),
				PRIMARY key(familyPhysicianId)
			);

CREATE TABLE HopDoctorFamPhysicians ( 
				hopDocFamPhId INT REFERENCES Doctors on DELETE CASCADE,
				name VARCHAR(256), 
				specialty VARCHAR(256), 
				numberOfYearOfExperience INT,
				hospitalName VARCHAR (256),
				officeAddress VARCHAR (256),			
				PRIMARY key(hopDocFamPhId)
			);
			
INSERT INTO Doctors VALUES (1,'Mamoutou Sangre','cardiology', 5);
INSERT INTO Doctors VALUES (2,'Moussa Traore','Radiology', 10);
INSERT INTO Doctors VALUES (3,'Ali Cisse','cardiology', 2);
INSERT INTO Doctors VALUES (4,'Issa Doumbia','Oncylogy', 20);
INSERT INTO Doctors VALUES (5,'Abou Keita','dentistry', 1);
INSERT INTO Doctors VALUES (6,'Amidou Sylla','Sport Medecine', 15);

INSERT INTO HospitalDoctors VALUES (5,'Abou Keita','dentistry', 1,'Jubilee Hospital'); 
INSERT INTO FamilyPhysicians VALUES (4,'Issa Doumbia','Oncylogy', 20, 'room 3215'); 
INSERT INTO  HopDoctorFamPhysicians VALUES (1,'Mamoutou Sangre','cardiology', 5, 'Victoria General Hospital','room 3215'); 

SELECT * FROM Doctors;
SELECT hospitalName,name from HospitalDoctors;


