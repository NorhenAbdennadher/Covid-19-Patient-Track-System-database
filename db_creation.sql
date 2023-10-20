-- Database Creation
CREATE DATABASE covidtrack WITH OWNER POSTGRES ENCODING = 'UTF8';

-- Connect to examode db to create data for its 'public' schema
\c covidtrack

-- Create new domains
CREATE DOMAIN pwd AS character varying(254)
	CONSTRAINT properpassword CHECK (((VALUE)::text ~* '[A-Za-z0-9._%-]{5,}'::text));

-- Create new data types
CREATE TYPE gendertype AS ENUM (
	'Male',
	'Female'
);

-- Table Creation
-- City
CREATE TABLE City(
	CityId SERIAL,
	Name VARCHAR NOT NULL,
    PRIMARY KEY (CityId)
);

-- Clinic
CREATE TABLE Clinic(
	ClinicId SERIAL,
    CityId SERIAL,
	Name VARCHAR NOT NULL,
    Address VARCHAR NOT NULL,
    PRIMARY KEY (ClinicId),
    FOREIGN KEY (CityId) REFERENCES City(CityId)
);

-- Clinician
CREATE TABLE Clinician(
	ClinicianUsername VARCHAR,
	ClinicId SERIAL,
	Name VARCHAR NOT NULL,
    Surname VARCHAR NOT NULL,
    Password PWD,
    PRIMARY KEY (ClinicianUsername),
    FOREIGN KEY (ClinicId) REFERENCES Clinic(ClinicId)
);

-- Risk Status
CREATE TABLE RiskStatus(
	RiskStatusId SERIAL,
	Name VARCHAR NOT NULL,
    PRIMARY KEY (RiskStatusId)
);

-- Citizen
CREATE TABLE Citizen(
	CitizenId SERIAL,
    RiskStatusId SERIAL,
	Name VARCHAR NOT NULL,
    Surname VARCHAR NOT NULL,
    DayOfBirth DATE NOT NULL,
    Gender GENDERTYPE,
    Password PWD NOT NULL,
    Address VARCHAR NOT NULL,
    Phone VARCHAR NOT NULL,
    CityId SERIAL NOT NULL,
    PRIMARY KEY (CitizenId),
    FOREIGN KEY (RiskStatusId) REFERENCES RiskStatus(RiskStatusId),
    FOREIGN KEY (CityId) REFERENCES City(CityId)
);

-- Building Type
CREATE TABLE BuildingType(
	BuildingTypeId SERIAL,
	Name VARCHAR NOT NULL,
    PRIMARY KEY (BuildingTypeId)
);

-- Building
CREATE TABLE Building(
	BuildingId SERIAL,
    RiskStatusId SERIAL,
    BuildingTypeId SERIAL,
    CityId SERIAL,
	Name VARCHAR NOT NULL,
    Address VARCHAR NOT NULL,
    MaxCapacity INTEGER NOT NULL,
    PRIMARY KEY (BuildingId),
    FOREIGN KEY (RiskStatusId) REFERENCES RiskStatus(RiskStatusId),
    FOREIGN KEY (BuildingTypeId) REFERENCES BuildingType(BuildingTypeId),
    FOREIGN KEY (CityId) REFERENCES City(CityId)
);

-- Agent
CREATE TABLE Agent(
	AgentUsername VARCHAR NOT NULL UNIQUE,
    BuildingId SERIAL,
	Name VARCHAR NOT NULL,
    Surname VARCHAR NOT NULL,
    Password PWD NOT NULL,
    PRIMARY KEY (AgentUsername),
    FOREIGN KEY (BuildingId) REFERENCES Building(BuildingId)
);

--Have Test
CREATE TABLE HaveTest(
	CitizenId SERIAL,
    ClinicianUsername VARCHAR NOT NULL,
	Datetime TIMESTAMP NOT NULL,
    Result BOOLEAN NOT NULL,
    PRIMARY KEY (CitizenId, ClinicianUsername, Datetime),
    FOREIGN KEY (CitizenId) REFERENCES Citizen(CitizenId),
    FOREIGN KEY (ClinicianUsername) REFERENCES Clinician(ClinicianUsername)
);

--Visit
CREATE TABLE Visit(
    BuildingId SERIAL,
	CitizenId SERIAL,
	EntryDatetime TIMESTAMP NOT NULL,
    ExitDatetime TIMESTAMP,
    PRIMARY KEY (BuildingId, CitizenId, EntryDatetime),
    FOREIGN KEY (BuildingId) REFERENCES Building(BuildingId),
    FOREIGN KEY (CitizenId) REFERENCES Citizen(CitizenId)
);

-- Building Info
CREATE TABLE BuildingInfo(
	BuildingInfoId SERIAL,
    BuildingId SERIAL,
    Description VARCHAR NOT NULL,
    PRIMARY KEY (BuildingInfoId),
    FOREIGN KEY (BuildingId) REFERENCES Building(BuildingId)
);