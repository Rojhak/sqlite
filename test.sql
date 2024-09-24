CREATE TABLE IF NOT EXISTS Manufacturers (
  Code INTEGER,
  Name TEXT NOT NULL,
  PRIMARY KEY (Code)
);

CREATE TABLE IF NOT EXISTS Products (
  Code INTEGER,
  Name TEXT NOT NULL,
  Price INTEGER NOT NULL,
  Manufacturer INTEGER NOT NULL,
  PRIMARY KEY (Code)
)
DROP TABLE Products

INSERT INTO Manufacturers(Code,Name) VALUES(1,'Sony');
INSERT INTO Manufacturers(Code,Name) VALUES(2,'Creative Labs');
INSERT INTO Manufacturers(Code,Name) VALUES(3,'Hewlett-Packard');
INSERT INTO Manufacturers(Code,Name) VALUES(4,'Iomega');
INSERT INTO Manufacturers(Code,Name) VALUES(5,'Fujitsu');
INSERT INTO Manufacturers(Code,Name) VALUES(6,'Winchester');

INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(1,'Hard drive',240,5);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(2,'Memory',120,6);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(3,'ZIP drive',150,4);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(4,'Floppy disk',5,6);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(5,'Monitor',240,1);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(6,'DVD drive',180,2);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(7,'CD drive',90,2);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(8,'Printer',270,3);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(9,'Toner cartridge',66,3);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(10,'DVD burner',180,2);

SELECT Name FROM Products
SELECT Name, Price FROM Products
SELECT Name FROM Products WHERE Price <=200
SELECT Name, Price FROM Products WHERE Price <=120 and Price >60
SELECT Name, Price * 100 AS price_in_cents FROM Products 
SELECT AVG(Price) FROM Products WHERE Manufacturer == 2
SELECT COUNT(*) FROM Products WHERE Price > 180
SELECT name,MIN(Price) FROM Products 
SELECT Name, Price FROM Products WHERE Price >=180 ORDER BY Price
SELECT Name, Price FROM Products WHERE Price >=180 ORDER BY Name
SELECT * FROM Products LEFT JOIN Manufacturers ON Manufacturers.Code = Products.Manufacturer;
SELECT Products.Name as Product_Name, Products.Price as Product_Price, Manufacturers.Name as Manufacturers_Name FROM Products LEFT JOIN Manufacturers ON Manufacturers.Code = Products.Code;
SELECT Manufacturers.Code, AVG(Products.Price) AS avg_price FROM Products LEFT JOIN Manufacturers ON Manufacturers.Code = Products.Manufacturer GROUP BY Manufacturers.Code
-- 1.14
SELECT Manufacturers.Name FROM Products LEFT JOIN Manufacturers ON Manufacturers.Code = Products.Manufacturer GROUP BY Manufacturers.Name
HAVING AVG(Products.Price) >= 150;

--1.15
SELECT name, MIN(price) FROM Products
--1.16
SELECT Manufacturers.Name, Products.Price FROM Products LEFT JOIN Manufacturers ON Manufacturers.Code = Products.Manufacturer GROUP BY Manufacturers.Name
HAVING MAX(Products.Price)
--1.17 Loudspeakers, $70, manufacturer 2
UPDATE Products SET Name = "Laser Printer" WHERE Code = 8 
SELECT * FROM Products
-- 1.19
SELECT Name, Price -Price * 0.1 AS Discountet_Price FROM Products 


-- 2. Day 
CREATE TABLE IF NOT EXISTS Departments (
  Code INTEGER,
  Name TEXT NOT NULL,
  Budget decimal NOT NULL,
  PRIMARY KEY (Code)   
);

CREATE TABLE IF NOT EXISTS Employees (
  SSN INTEGER,
  Name varchar(255) NOT NULL ,
  LastName varchar(255) NOT NULL ,
  Department INTEGER NOT NULL , 
  PRIMARY KEY (SSN)   
);


INSERT INTO Departments(Code,Name,Budget) VALUES(14,'IT',65000);
INSERT INTO Departments(Code,Name,Budget) VALUES(37,'Accounting',15000);
INSERT INTO Departments(Code,Name,Budget) VALUES(59,'Human Resources',240000);
INSERT INTO Departments(Code,Name,Budget) VALUES(77,'Research',55000);

INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('123234877','Michael','Rogers',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('152934485','Anand','Manikutty',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('222364883','Carol','Smith',37);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('326587417','Joe','Stevens',37);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('332154719','Mary-Anne','Foster',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('332569843','George','ODonnell',77);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('546523478','John','Doe',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('631231482','David','Smith',77);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('654873219','Zacary','Efron',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('745685214','Eric','Goldsmith',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('845657245','Elizabeth','Doe',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('845657246','Kumar','Swamy',14);
--2.1
SELECT LastName FROM Employees
--2.2
SELECT DISTINCT(LastName) FROM Employees
--2.3
SELECT * FROM Employees WHERE LastName = "Smith"
--2.4
SELECT * FROM Employees WHERE LastName = "Smith" or LastName = "Doe"
--2.5
SELECT * FROM Employees WHERE Department = 14
--2.6
SELECT * FROM Employees WHERE Department = 77 or Department = 37
--2.7
SELECT * FROM Employees WHERE LastName LIKE "S%"
--2.8
SELECT SUM(Budget) FROM Departments
--2.9
SELECT DISTINCT(Employees.Department), COUNT(Employees.Department) AS department_count FROM Employees LEFT JOIN Departments ON Employees.Department = Departments.Code GROUP BY Employees.Department;
--2.10
SELECT DISTINCT* FROM Employees LEFT JOIN Departments ON Employees.Department = Departments.Code ;
--2.11
SELECT Employees.NAME, Employees.LastName, Departments.Name, Departments.Budget FROM Employees LEFT JOIN Departments ON Employees.Department = Departments.Code ;
--2.12 
SELECT Employees.NAME, Employees.LastName, Departments.Budget FROM Employees LEFT JOIN Departments ON Employees.Department = Departments.Code WHERE Departments.Budget > 60.000
--2.13
SELECT Employees.NAME, Employees.LastName, Departments.Budget FROM Employees LEFT JOIN Departments ON Employees.Department = Departments.Code GROUP BY Employees.Name, Employees.LastName, Departments.Budget
HAVING Departments.Budget > (SELECT AVG(Budget) FROM Departments);
--2.14
SELECT DISTINCT(Employees.Department) FROM Employees LEFT JOIN Departments ON Employees.Department = Departments.Code GROUP BY Employees.Department HAVING (SELECT COUNT(Department) FROM Departments) > 2
--2.15
SELECT Employees.NAME, Employees.LastName, Departments.Budget FROM Employees LEFT JOIN Departments ON Employees.Department = Departments.Code ORDER BY Budget ASC LIMIT 2;
--2.16 
UPDATE Departments  SET  "Budget" = 40000  WHERE Code = 11

--2.17 
INSERT INTO Employees (SSN, Name, LastName, Department) VALUES(847219811, "Mary", "Moore", 11)
--2.18
SELECT Budget - Budget*0.1 as Reduced_Budget FROM Departments
--2.19 
UPDATE Employees SET Department= 14 WHERE Department = 77
SELECT * FROM Employees
UPDATE Employees SET SSN= 847219811 WHERE Department = 11
--2.20
DELETE FROM Employees WHERE Department = 14
--2.21
DELETE FROM Employees
WHERE Employees.Department IN (
    SELECT Departments.Code
    FROM Departments
    WHERE Departments.BUDGET >= 60000
);
DELETE FROM Employees

--D3
CREATE TABLE Warehouses (
   Code INTEGER NOT NULL,
   Location VARCHAR(255) NOT NULL ,
   Capacity INTEGER NOT NULL,
   PRIMARY KEY (Code)
 );
CREATE TABLE Boxes (
    Code CHAR(4) NOT NULL,
    Contents VARCHAR(255) NOT NULL ,
    Value REAL NOT NULL ,
    Warehouse INTEGER NOT NULL,
    PRIMARY KEY (Code)
 );
 
 INSERT INTO Warehouses(Code,Location,Capacity) VALUES(1,'Chicago',3);
 INSERT INTO Warehouses(Code,Location,Capacity) VALUES(2,'Chicago',4);
 INSERT INTO Warehouses(Code,Location,Capacity) VALUES(3,'New York',7);
 INSERT INTO Warehouses(Code,Location,Capacity) VALUES(4,'Los Angeles',2);
 INSERT INTO Warehouses(Code,Location,Capacity) VALUES(5,'San Francisco',8);
 
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('0MN7','Rocks',180,3);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('4H8P','Rocks',250,1);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('4RT3','Scissors',190,4);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('7G3H','Rocks',200,1);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('8JN6','Papers',75,1);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('8Y6U','Papers',50,3);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('9J6F','Papers',175,2);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('LL08','Rocks',140,4);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('P0H6','Scissors',125,1);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('P2T6','Scissors',150,2);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('TU55','Papers',90,5);


--3.1
SELECT * FROM Warehouses
--3.2
SELECT * FROM Boxes WHERE Value > 150
--3.3
SELECT DISTINCT(Contents) FROM Boxes 
--3.4
SELECT AVG(Value) as Avarege_Values FROM Boxes
--3.5
SELECT Warehouse, AVG(Value) FROM Boxes GROUP BY Warehouse
--3.6
SELECT Warehouse, AVG(Value) FROM Boxes GROUP BY Warehouse HAVING AVG(VALUE) > 150
--3.7 Select the code of each box, along with the name of the city the box is located in.
SELECT Boxes.Code, Warehouses.Location FROM Boxes JOIN Warehouses ON Boxes.Warehouse = Warehouses.Code 
--3.8 Select the warehouse codes, along with the number of boxes in each warehouse. 
SELECT Boxes.Warehouse, COUNT(Boxes.Code) AS Boxes_Count FROM Boxes GROUP BY Warehouse
--3.9 Select the codes of all warehouses that are saturated 
SELECT Boxes.Warehouse, COUNT(Boxes.Code) AS Boxes_Count FROM Boxes LEFT JOIN Warehouses ON Boxes.Warehouse= Warehouses.Code GROUP BY Boxes.Warehouse HAVING COUNT(Boxes.code) > Capacity
--3.10 Select the codes of all the boxes located in Chicago.
SELECT Warehouses.Code FROM Warehouses WHERE Location = "Chicago"
--3.11 Create a new warehouse in New York with a capacity for 3 boxes.
INSERT INTO Warehouses (Code, Location, Capacity) VALUES(6, "New York", 3)
--3.12 Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2.
INSERT INTO Boxes (Code, Contents, Value,Warehouse) VALUES("H5RT", "Papers", 200, 2)
--3.13 Reduce the value of all boxes by 15%.
SELECT Contents, Value - Value*0.1 AS Reduced_Value FROM Boxes
--3.14 Delete all records of boxes from saturated warehouses.
DELETE FROM Boxes WHERE Boxes.Warehouse IN 
 (SELECT Boxes.Warehouse FROM Boxes JOIN Warehouses ON Boxes.Warehouse = Warehouses.Code 
GROUP BY Boxes.Warehouse, Warehouses.Capacity 
HAVING COUNT(Boxes.Code) > Warehouses.Capacity;)
--3.15 Remove all boxes with a value lower than $100.
DELETE FROM Boxes WHERE Value < 100
--3.16 Add Index for column "Warehouse" in table "boxes"
    -- !!!NOTE!!!: index should NOT be used on small tables in practice
CREATE INDEX Index_Watenhause ON Boxes(Warehouse)
SELECT * FROM Boxes 



--3.17 Print all the existing indexes
PRAGMA index_list('Boxes');
--3.18 Remove (drop) the index you just created
DROP INDEX IF EXISTS Index_Watenhouse;



CREATE TABLE IF NOT EXISTS Movies (
  Code INTEGER,
  Title VARCHAR(255) NOT NULL,
  Rating VARCHAR(255),
  PRIMARY KEY (Code)
);

CREATE TABLE IF NOT EXISTS MovieTheaters (
  Code INTEGER,
  Name VARCHAR(255) NOT NULL,
  Movie INTEGER,
  PRIMARY KEY (Code)
  );

INSERT INTO Movies(Code,Title,Rating) VALUES(1,'Citizen Kane','PG');
INSERT INTO Movies(Code,Title,Rating) VALUES(2,'Singin'' in the Rain','G');
INSERT INTO Movies(Code,Title,Rating) VALUES(3,'The Wizard of Oz','G');
INSERT INTO Movies(Code,Title,Rating) VALUES(4,'The Quiet Man',NULL);
INSERT INTO Movies(Code,Title,Rating) VALUES(5,'North by Northwest',NULL);
INSERT INTO Movies(Code,Title,Rating) VALUES(6,'The Last Tango in Paris','NC-17');
INSERT INTO Movies(Code,Title,Rating) VALUES(7,'Some Like it Hot','PG-13');
INSERT INTO Movies(Code,Title,Rating) VALUES(8,'A Night at the Opera',NULL);
 
INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(1,'Odeon',5);
INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(2,'Imperial',1);
INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(3,'Majestic',NULL);
INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(4,'Royale',6);
INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(5,'Paraiso',3);
INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(6,'Nickelodeon',NULL);

-- 4.1 Select the title of all movies.
SELECT Title FROM Movies
-- 4.2 Show all the distinct ratings in the database.
SELECT DISTINCT(Rating) FROM Movies
-- 4.3 Show all unrated movies.
SELECT Title FROM Movies WHERE Rating IS NULL
-- 4.4 Select all movie theaters that are not currently showing a movie.
SELECT Name FROM MovieTheaters WHERE Movie IS NULL
-- 4.5 Select all data from all movie theaters and, additionally, the data from the movie that is being shown in the theater (if one is being shown).
SELECT * FROM MovieTheaters LEFT JOIN Movies ON MovieTheaters.Code = Movies.Code WHERE MovieTheaters.Movie IS NOT NULL
-- 4.6 Select all data from all movies and, if that movie is being shown in a theater, show the data from the theater.
SELECT * FROM Movies LEFT JOIN MovieTheaters ON Movies.Code = MovieTheaters.Movie WHERE MovieTheaters.Movie IS NOT NULL
-- 4.7 Show the titles of movies not currently being shown in any theaters.
SELECT Title FROM Movies  JOIN  MovieTheaters ON  Movies.Code = MovieTheaters.Code WHERE movie IS NULL
-- 4.8 Add the unrated movie "One, Two, Three".
INSERT INTO Movies (Code, Title, Rating) VALUES(9, "One, Two, Three", NULL)
-- 4.9 Set the rating of all unrated movies to "G".
UPDATE Movies SET Rating = "G" WHERE Rating IS NULL
-- 4.10 Remove movie theaters projecting movies rated "NC-17".
DELETE FROM Movies WHERE Rating = "NC-17"

