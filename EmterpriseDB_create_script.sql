--Create DB
Create Database Task3
GO

--Select DB
Use Task3
Go

--Create Tables
CREATE TABLE position
( 
	id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	name nvarchar(255) NOT NULL,
	rate float, --Considering rate as salary
)
CREATE TABLE vacancies
( 
	id int NOT NULL IDENTITY(1,1)  PRIMARY KEY,
	position_id int FOREIGN KEY(position_id) REFERENCES position (id)
)
CREATE TABLE project
( 
	id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	name nvarchar(255) NOT NULL,
	max_sum_rate float NOT NULL
)
CREATE TABLE employee
( 
	id uniqueidentifier primary key NOT NULL default newid(),
	first_name nvarchar(255) NOT NULL,
	last_name nvarchar(255) NOT NULL,
	position_id int FOREIGN KEY(position_id) REFERENCES position (id),
	project_id int FOREIGN KEY(project_id) REFERENCES project (id)
);
CREATE TABLE equipment
( 
	id int NOT NULL IDENTITY(1,1)  PRIMARY KEY,
	name nvarchar(255) NOT NULL,
	price float NOT NULL,
	user_id uniqueidentifier FOREIGN KEY(user_id) REFERENCES employee (id)
)

--Populate Tables

Insert Into employee Values (default,'Mike','Jordan', NULL, NULL)
Insert Into employee Values (default,'John','Pit', NULL, NULL)
Insert Into employee Values (default,'Michalla','Pat', NULL, NULL)
Insert Into employee Values (default,'Gorden','Young', NULL, NULL)
Insert Into employee Values (default,'Jay','Noller', NULL, NULL)

Insert Into position Values ('PO',10000) -- id	1
Insert Into position Values ('Developer',6000) -- id 2
Insert Into position Values ('Hiring Recruiter',5000) -- id 3
Insert Into position Values ('Security',9000) -- id 4
Insert Into position Values ('Manager',8500) -- id 5

Insert Into vacancies Values (1) -- id 1
Insert Into vacancies Values (2) -- id 2
Insert Into vacancies Values (3) -- id 3
Insert Into vacancies Values (4) -- id 4
Insert Into vacancies Values (5) -- id 5

Insert Into project Values ('Global Warming', 500.68 ) -- id 1
Insert Into project Values ('Political Corruption', 600.01 ) -- id 2
Insert Into project Values ('Onion Crime', 53436831.50) -- id 3
Insert Into project Values ('Bananas Conspiracy', 20000000.54) -- id 4
Insert Into project Values ('Radiometry 101', 40000) -- id 5

Insert Into equipment Values ('Desktop PC', 2300.50, '0E72C2F8-F2A6-43A1-826A-32C662A5B574')-- id 1
Insert Into equipment Values ('PEN', 50.50, NULL)-- id 2
Insert Into equipment Values ('KIT office', 800.50, NULL)-- id 3
Insert Into equipment Values ('HDMI Cable', 5.04, NULL)-- id 4
Insert Into equipment Values ('PEN 50GB', 560.50, NULL)-- id 5



--View employee table
SELECT * FROM employee









--Utils
	--ALTER TABLE dbo.position
	--ADD PRIMARY KEY (id);
	--GO

	Use Task3
	Go

	--DROP TABLE IF EXISTS dbo.vacancies
	--DROP TABLE IF EXISTS dbo.position



