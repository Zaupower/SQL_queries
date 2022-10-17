--Create DB
Create Database USADB
GO

--Select db to querie
Use USADB
Go

--Create Table
Create Table USACustomers
(
	ID int primary key identity,-- ID: variable name; int: variable type; primary key: unique identifier; identity: auto-increment 
	Name nvarchar(50)
)

--Create Table with GUID
Create Table USACustomers
(
	ID uniqueidentifier primary key default newid(),-- ID: variable name; int: variable type; primary key: unique identifier; identity: auto-increment 
	Name nvarchar(50)
)

--Update Database with values or queries
GO

--Insert Values
Insert Into USACustomers Values ('Mike')

--Insert Values with GUID
Insert Into USACustomers Values (default,'Mike')

--View Table values
Select * From USADB.dbo.USACustomers


--Alter Table data types 
ALTER TABLE table_name
ADD column _name datatype;

ALTER TABLE table_name
ADD PRIMARY KEY (column_name);