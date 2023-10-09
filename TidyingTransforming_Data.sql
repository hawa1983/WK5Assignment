-- Drop tables if they already exist
DROP TABLE IF EXISTS FlightData;
DROP TABLE IF EXISTS Airlines;
DROP TABLE IF EXISTS Destinations;
DROP TABLE IF EXISTS Statuses;

-- Create Airlines table
CREATE TABLE Airlines (
    AirlineId  VARCHAR(300) PRIMARY KEY,
    AirlineName VARCHAR(300)
);

-- Insert data into Airlines table
INSERT INTO Airlines (AirlineId, AirlineName) VALUES 
('AS', 'ALASKA'),
('AWE', 'AMWEST');

-- Create Destinations table
CREATE TABLE Destinations (
    DestId VARCHAR(300) PRIMARY KEY,
    DestName VARCHAR(300)
);

-- Insert data into Destinations table
INSERT INTO Destinations (DestId, DestName) VALUES
('LAX', 'Los Angeles'),
('PHX', 'Phoenix'),
('SAN', 'San Diego'),
('SFO', 'San Francisco'),
('SEA', 'Seattle');

-- Create Statuses table
CREATE TABLE Statuses (
    StatusId VARCHAR(300) PRIMARY KEY,
    StatusName VARCHAR(300)
);

-- Insert data into Statuses table
INSERT INTO Statuses (StatusId, StatusName) VALUES
('ONT', 'on time'),
('DEL', 'delayed');

CREATE TABLE FlightData (
    FlId INT PRIMARY KEY AUTO_INCREMENT,
    AirlineId VARCHAR(300),
    DestId VARCHAR(300),
    StatusId VARCHAR(300),
    FlightCount VARCHAR(300),
    FOREIGN KEY (AirlineId) REFERENCES Airlines(AirlineId),
    FOREIGN KEY (DestId) REFERENCES Destinations(DestId),
    FOREIGN KEY (StatusId) REFERENCES Statuses(StatusId)
);

-- Insert data into FlightData table
INSERT INTO FlightData (AirlineId, DestId, StatusId, FlightCount) VALUES 
('AS', 'LAX', 'ONT', 497),
('AS', 'LAX', 'DEL', 62),  
('AS', 'PHX', 'ONT', 221), 
('AS', 'PHX', 'DEL', 12), 
('AS', 'SAN', 'ONT', 212),
('AS', 'SAN', 'DEL', 20),  
('AS', 'SFO', 'ONT', 503), 
('AS', 'SFO', 'DEL', 102),  
('AS', 'SEA', 'ONT', 1841), 
('AS', 'SEA', 'DEL', 305),  
('AWE', 'LAX', 'ONT', 694), 
('AWE', 'LAX', 'DEL', 117),  
('AWE', 'PHX', 'ONT', 4840), 
('AWE', 'PHX', 'DEL', 415), 
('AWE', 'SAN', 'ONT', 383), 
('AWE', 'SAN', 'DEL', 65),  
('AWE', 'SFO', 'ONT', 320), 
('AWE', 'SFO', 'DEL', 129),  
('AWE', 'SEA', 'ONT', 201), 
('AWE', 'SEA', 'DEL', 61);  


-- Query to get .csv file data:
SELECT 
    a.AirlineName AS 'Airline',
    s.StatusName AS 'Status',
    SUM(IF(d.DestName = 'Los Angeles', fd.FlightCount, 0)) AS 'Los Angeles',
    SUM(IF(d.DestName = 'Phoenix', fd.FlightCount, 0)) AS 'Phoenix',
    SUM(IF(d.DestName = 'San Diego', fd.FlightCount, 0)) AS 'San Diego',
    SUM(IF(d.DestName = 'San Francisco', fd.FlightCount, 0)) AS 'San Francisco',
    SUM(IF(d.DestName = 'Seattle', fd.FlightCount, 0)) AS 'Seattle'
FROM FlightData fd
JOIN Airlines a ON fd.AirlineId = a.AirlineId
JOIN Destinations d ON fd.DestId = d.DestId
JOIN Statuses s ON fd.StatusId = s.StatusId
GROUP BY a.AirlineName, s.StatusName;

