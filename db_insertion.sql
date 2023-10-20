-- Populating the RiskStatus relation
INSERT INTO RiskStatus (Name)
VALUES ('GREEN'),
	   ('YELLOW'),
	   ('RED');

-- The database owners will populate the City table with
-- the list of cities that exists in a specific country

INSERT INTO City (Name)
VALUES ('Rome'),
('Milan'),
('Naples'),
('Turin'),
('Palermo'),
('Genoa'),
('Bologne'),
('Florence'),
('Bari'),
('Catania'),
('Verona'),
('Venice'),
('Messina'),
('Padua'),
('Trieste'),
('Brescia'),
('Parma'),
('Taranto'),
('Prato'),
('Modena');

-- BuildingType relation

INSERT INTO BuildingType (Name)
VALUES ('Educational Buildings'),
('Institutional Buildings'),
('Assembly Buildings'),
('Business Buildings'),
('Mercantile Buildings'),
('Industrial Buildings');


-- The agent of the building will add all the required informations
-- about the building

INSERT INTO Building (RiskStatusId, BuildingTypeId, CityId, Name, Address, MaxCapacity)
VALUES (1, 3, 14, 'MUSME', 'Via S. Francesco, 94, 35121 Padova PD', 50),
(1, 3, 1, 'Romes Times Hotel', 'Via Milano, 42, 00184 Roma RM', 100),
(1, 5, 17,'SAPORI & DINTORNI STORE', 'Piazza Ghiaia, Snc, 43100 Parma PR', 50),
(1, 3, 8, 'La Buchetta', 'Via dei Benci, 3, 50122 Firenze FI', 30),
(1, 3, 2, 'David Lloyd Clubs', 'Via dello Sport, 1, 20068 Milano San Felice MI', 20),
(1, 3, 14, 'Palais Bo', 'Via VIII Febbraio, 2, 35122 Padova PD', 150),
(1, 3, 9, 'La pignata', 'Via Emanuele Duni, 20, 75100 Matera MT', 30);

-- Whenever a building has new informations to display to the 
-- users 

INSERT INTO BuildingInfo (BuildingId, Description)
VALUES (8, ' You can make your reservation online in labuchetta.com'),
(11, 'We are on quarantine'),
(14, 'Make sure to ware your mask and use your santitizer frequently !'),
(10, 'We are cleaning and desinfecting the building ! Your safety is our priority!'),
(12, 'We will make some online training sessions due to the actual situation... Stay tuned!');

-- Adding an agent to the database

INSERT INTO Agent (AgentUsername, BuildingId, Name,Surname,Password)
VALUES ( 'Alina', 8, 'Alina', 'Agurenko', 'AgentALINA123' ),
('Nourhen', 10, 'Nourhen', 'ABD', 'AgentABD123'),
('Mario', 14, 'Mario', 'Super', 'AgentMario123' ),
('Neji', 13 , 'Neji', 'Mkaouer', 'AgentNeji123' ),
('khalil', 13, 'khalil','Azer', 'AgentAzer123'),
('Chiara', 8, 'Chiara','Ferra', 'AgentChiara123' );
-- Whenever a citizen in italy is doing a PCR Test then his info 
-- will be added to the database : a citizen can be added by cinicians
-- and by the agents of the building if they aren't already in the system.

INSERT INTO Citizen (RiskStatusId, Name, Surname,DayOfBirth,
Gender, Password, Address, Phone, CityId)
VALUES 
(1, 'Norhen', 'Abdennadher', '1997-07-15','Female','NorhenAb123', 'Via Luigi Einaudi, 10, 35129 Padova PD, Italie', 23654785, 14),
(1, 'orio', 'malbio', '1967-07-02', 'Male', 'malbio123', 'Via XXXX, italie', 98745632, 12),
(2, 'Marc', 'sofenji', '2000-09-11', 'Male', 'Marc123', 'Via YYY, italie', 89654123, 8),
(3, 'alisa', 'Suman', '1963-12-16', NULL, 'alisa123', 'Via ZZZ, Milan', 98745111, 9),
(2, 'ilyes', 'marbok', '1982-01-30', 'Male', 'ilyes569', 'Via santo polo 169, Padoue', 57948123, 14),
(1, 'Ross', 'Geller', '1994-05-10', 'Male', 'Ross123', 'Via NY kalla 123', 56892317, 12),
(3, 'Rejina', 'Phalanji', '1989-12-19', 'Female', 'rejina123', 'Via TTT 222', 90111111, 11);

-- When a citizen is visiting a building: the agent of the building
-- should add a visit and specify the entry datetime.

INSERT INTO Visit (BuildingId, CitizenId, EntryDatetime, ExitDatetime)
VALUES (8, 1, '2021-12-08 15:34:00', NULL),
(8, 2, '2021-12-08 15:45:00', NULL ),
(8, 3, '2021-12-08 16:08:50', NULL ),
(8, 4, '2021-12-08 11:25:10', NULL ),
(8, 5, '2021-12-08 17:00:24', NULL ),
(8, 6, '2021-12-08 10:12:30', NULL );


-- Adding the exit datetime for each visitor

UPDATE Visit SET ExitDatetime = '2021-12-08 16:15:13'
WHERE BuildingId=8 AND CitizenId=2 AND EntryDatetime='2021-12-08 15:45:00';
UPDATE Visit SET ExitDatetime = '2021-12-08 18:15:13'
WHERE BuildingId=8 AND CitizenId=3 AND EntryDatetime='2021-12-08 16:08:50';
UPDATE Visit SET ExitDatetime = '2021-12-08 13:00:13'
WHERE BuildingId=8 AND CitizenId=4 AND EntryDatetime='2021-12-08 11:25:10';
UPDATE Visit SET ExitDatetime = '2021-12-08 18:30:00'
WHERE BuildingId=8 AND CitizenId=5  AND EntryDatetime='2021-12-08 17:00:24';
UPDATE Visit SET ExitDatetime = '2021-12-08 11:00:27'
WHERE BuildingId=8 AND CitizenId=6 AND EntryDatetime='2021-12-08 10:12:30';
UPDATE Visit SET ExitDatetime = '2021-12-08 18:15:13'
WHERE BuildingId=8 AND CitizenId=1 AND EntryDatetime='2021-12-08 15:34:00';


-- Inserting clinics into the database

INSERT INTO Clinic ( Name, Address)
VALUES ('La Porta Giusta Cooperative Society ScS', 'Via Torino,186,Venice 30172, Italy');

-- Inserting a new clinician 

INSERT INTO Clinician (ClinicianUsername, ClinicId, Name,
Surname, Password)
VALUES ('achraf', 1, 'achraf', 'Sahnoun', 'AchrafSAH123'),
('Amir', 1, 'Amir', 'Adham', 'AmirAD123');

-- Insert a new test result by a clinician

INSERT INTO HaveTest (CitizenId, ClinicianUsername, Datetime, Result)
VALUES (5, 'achraf', '2020-12-01', FALSE),
(6, 'achraf', '2020-10-01', TRUE);
