--	Request. 0.
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
Insert Into employee Values (default,'Emanuela','Chrossinger', NULL, NULL)

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
Insert Into equipment Values ('Keyboard', 200.50, '0E72C2F8-F2A6-43A1-826A-32C662A5B574')-- id 6

--Add(Update) position_id and project_id to employees
Update employee SET position_id = 1, project_id = 1 WHERE id = '0E72C2F8-F2A6-43A1-826A-32C662A5B574'
Update employee SET position_id = 2, project_id = 2 WHERE id = '231AF41A-D3BE-4FE9-8DB6-931B4DB0C34F'
Update employee SET position_id = 3, project_id = 3 WHERE id = '6A9EE07B-0FD9-4B85-B68A-E15181C05821'
Update employee SET position_id = 4, project_id = 4 WHERE id = '13DFF9E3-0414-455C-B8AE-EC7A21A6471D'
Update employee SET position_id = 5, project_id = 5 WHERE id = 'AA65D08F-E664-4CC9-934D-FA0D0B6EF054'
Update employee SET position_id = 2, project_id = 1 WHERE id = '825B1A2E-D84D-45D5-9874-6BE3FB7BC581'

--Add(Update) user_id to equipments
Update equipment SET user_id = '0E72C2F8-F2A6-43A1-826A-32C662A5B574' WHERE id = 1
Update equipment SET user_id = '231AF41A-D3BE-4FE9-8DB6-931B4DB0C34F' WHERE id = 2
Update equipment SET user_id = '6A9EE07B-0FD9-4B85-B68A-E15181C05821' WHERE id = 3
Update equipment SET user_id = '13DFF9E3-0414-455C-B8AE-EC7A21A6471D' WHERE id = 4
Update equipment SET user_id = 'AA65D08F-E664-4CC9-934D-FA0D0B6EF054' WHERE id = 5
Update equipment SET user_id = '0E72C2F8-F2A6-43A1-826A-32C662A5B574' WHERE id = 6
--	End of Request. 0.

--	Request. 1.
SELECT * FROM employee WHeRE project_id = NULL
--	End of Request. 1.

--	Request. 2.

DECLARE @rate_sum_table TABLE(
	e_project_rate_sum float,
	e_project_id int
)
INSERT INTO @rate_sum_table
	SELECT 
		SUM(p.rate), e.project_id
	FROM 
		position p
		INNER JOIN employee e ON p.id = e.position_id
		GROUP BY e.project_id
SELECT 
	name 
FROM project
WHERE project.max_sum_rate IN (SELECT max_sum_rate FROM @rate_sum_table WHERE e_project_rate_sum > max_sum_rate AND e_project_id = project.id)

--	End of Request. 2.

--	Request. 3.
--Table with project rate sum and id
DECLARE @rate_sum_table2 TABLE(
	e_project_rate_sum float,
	e_project_id int
)
INSERT INTO @rate_sum_table2
	SELECT 
		SUM(p.rate), e.project_id
	FROM 
		position p
		INNER JOIN employee e ON p.id = e.position_id
		GROUP BY e.project_id

DECLARE @scored_projects TABLE(
	sc_pr_name nvarchar(255),
	sc_pr_id int
)
INSERT INTO @scored_projects
	SELECT 
		name , id
	FROM project
	WHERE project.max_sum_rate IN (SELECT max_sum_rate FROM @rate_sum_table2 WHERE e_project_rate_sum > max_sum_rate AND e_project_id = project.id)
	SELECT 
		CONCAT(e.first_name,' ', e.last_name) AS 'Employee', sp.sc_pr_name
	FROM 
		employee e
		INNER JOIN  @scored_projects sp ON sp.sc_pr_id = e.project_id
		

--	End of Request. 3.

--	Request. 4.

--Table with sum of equipement by project
DECLARE @eq_sum_table TABLE(
	e_equipement_sum float,
	e_project_id int
)
INSERT INTO @eq_sum_table
	SELECT 
		SUM(eq.price), e.project_id
	FROM 
		equipment eq
		INNER JOIN employee e ON eq.user_id = e.id
		GROUP BY e.project_id
--SELECT * FROM @eq_sum_table
--Table with sum of rate by project
DECLARE @rate_sum_table3 TABLE(
	e_project_rate_sum float,
	e_project_id int
)
INSERT INTO @rate_sum_table3
	SELECT 
		SUM(p.rate), e.project_id
	FROM 
		position p
		INNER JOIN employee e ON p.id = e.position_id
		GROUP BY e.project_id
--SELECT * FROM @rate_sum_table3
--Table with SUM of rates and equiments by project
DECLARE @rate_eq_sum_table3 TABLE(
	e_project_rate_eq_sum float,
	e_project_id int
)
INSERT INTO @rate_eq_sum_table3
	SELECT 
		(rs.e_project_rate_sum + eq.e_equipement_sum)/12, eq.e_project_id
	FROM 
		@rate_sum_table3 rs
		INNER JOIN @eq_sum_table eq ON rs.e_project_id = eq.e_project_id
		

SELECT * FROM @rate_eq_sum_table3


DECLARE @scored_projects2 TABLE(
	sc_pr_name nvarchar(255),
	sc_pr_id int
)
INSERT INTO @scored_projects2
	SELECT 
		name , id
	FROM project
	WHERE project.max_sum_rate IN (SELECT max_sum_rate FROM @rate_eq_sum_table3 WHERE e_project_rate_eq_sum < max_sum_rate AND e_project_id = project.id)
	SELECT 
		CONCAT(e.first_name,' ', e.last_name) AS 'Employee', sp.sc_pr_name
	FROM 
		employee e
		INNER JOIN  @scored_projects2 sp ON sp.sc_pr_id = e.project_id
		
--	End of Request. 4.

--View tables
SELECT * FROM employee
SELECT * FROM position
SELECT * FROM vacancies
SELECT * FROM project
SELECT * FROM equipment




--Utils
	--ALTER TABLE dbo.position
	--ADD PRIMARY KEY (id);
	--GO
	Use Task3
	Go
	--DROP TABLE IF EXISTS dbo.vacancies
	--DROP TABLE IF EXISTS dbo.position



