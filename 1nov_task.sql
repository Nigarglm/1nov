CREATE DATABASE TASK_1NOV
USE TASK_1NOV

CREATE TABLE Genders(
Id INT PRIMARY KEY IDENTITY,
Gender NVARCHAR(25)
)

INSERT INTO Genders VALUES
('Male'),
('Female')

CREATE TABLE Users(
Id INT PRIMARY KEY IDENTITY,
Name VARCHAR(25) NOT NULL,
Username VARCHAR(25) UNIQUE NOT NULL,
Password VARCHAR(50) NOT NULL,
GenderId INT REFERENCES Genders(Id)
)

INSERT INTO Users VALUES
('Nigar','nigarglm','nigar123',1),
('Zulfiyye','zuzu','zuzu123',2),
('Sabuhi','sabuhi','sabuhi123',1)
 

CREATE TABLE Artists(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(25) NOT NULL,
Surname NVARCHAR(25) NOT NULL,
Birthday VARCHAR(10) NOT NULL,
GenderId INT REFERENCES Genders(Id)
)


INSERT INTO Artists VALUES
('Aygun','Kazimova','26.01.1971',2),
('Roya','Ayxan','14.06.1982',1)

CREATE TABLE Categories(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(25) NOT NULL
)

INSERT INTO Categories VALUES
('Pop'),
('Slow')


CREATE TABLE Musics(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(100) NOT NULL,
Duration INT CHECK (Duration>0),
CategoryId INT REFERENCES Categories(Id)
)

INSERT INTO Musics VALUES
('Parol',307,1),
('Sene gore',445,2)

CREATE TABLE MusicArtist(
MusicId INT REFERENCES Musics(Id),
ArtistId INT REFERENCES Artists(Id)
)

INSERT INTO MusicArtist VALUES
(1,1),
(2,2)


CREATE TABLE UserMusics(
UserId INT REFERENCES Users(Id),
MusicId INT REFERENCES Musics(Id)
)

INSERT INTO UserMusics VALUES (1,1),(2,2)

CREATE VIEW MusicLibary
AS
SELECT m.Name Music,m.Duration,c.Name Category,a.Name+' '+a.Surname Artist FROM Musics m
JOIN Categories c
ON m.CategoryId=c.Id
JOIN MusicArtist ma
ON m.Id=ma.MusicId
JOIN Artists a
ON ma.ArtistId=a.Id

CREATE VIEW Playlist
 AS
SELECT u.Id, u.Username,m.Name FROM UserMusics um
JOIN Users u
ON um.UserId=u.Id
JOIN Musics m
ON um.MusicId=m.Id

SELECT * FROM MusicLibary

SELECT * FROM Playlist