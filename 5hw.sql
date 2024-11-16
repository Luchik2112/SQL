 --Задание 1: Создание таблицы и изменение данных
--Задание: Создайте таблицу EmployeeDetails для хранения информации о
--сотрудниках. Таблица должна содержать следующие столбцы:
--● EmployeeID (INTEGER, PRIMARY KEY)
--● EmployeeName (TEXT)
--● Position (TEXT)
--● HireDate (DATE)
--● Salary (NUMERIC)
--После создания таблицы добавьте в неё три записи с произвольными данными о
--сотрудниках.


CREATE TABLE EmployeeDetails (
    EmployeeID INTEGER PRIMARY KEY,
    EmployeeName TEXT,
    Position TEXT,
    HireDate DATE,
    Salary NUMERIC
);

INSERT INTO EmployeeDetails (EmployeeID, EmployeeName, Position, HireDate, Salary)
VALUES 
(1, 'Ivan Petrov', 'Manager', '2022-05-10', 75000),
(2, 'Anna Ivanova', 'Developer', '2021-08-15', 90000),
(3, 'Sergey Smirnov', 'Analyst', '2023-01-20', 65000);

SELECT * FROM EmployeeDetails;



--Задание 2: Создание представления
--Задание: Создайте представление HighValueOrders для отображения всех заказов,
--сумма которых превышает 10000. В представлении должны быть следующие столбцы:
--● OrderID (идентификатор заказа),
--● OrderDate (дата заказа),
--● TotalAmount (общая сумма заказа, вычисленная как сумма всех Quantity *
--Price).
--Используйте таблицы Orders, OrderDetails и Products.
--Подсказки:
--1. Используйте JOIN для объединения таблиц.
--2. Используйте функцию SUM() для вычисления общей суммы заказа.

SELECT name FROM sqlite_master WHERE type = 'table';

-- Создание таблицы Orders
CREATE TABLE IF NOT EXISTS Orders (
    OrderID INTEGER PRIMARY KEY,
    OrderDate DATE
);

-- Создание таблицы Products
CREATE TABLE IF NOT EXISTS Products (
    ProductID INTEGER PRIMARY KEY,
    ProductName TEXT,
    Price NUMERIC
);

-- Создание таблицы OrderDetails
CREATE TABLE IF NOT EXISTS OrderDetails (
    OrderDetailID INTEGER PRIMARY KEY,
    OrderID INTEGER,
    ProductID INTEGER,
    Quantity INTEGER,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Добавление данных в таблицу Orders
INSERT INTO Orders (OrderID, OrderDate) VALUES (1, '2024-01-10');
INSERT INTO Orders (OrderID, OrderDate) VALUES (2, '2024-02-15');
INSERT INTO Orders (OrderID, OrderDate) VALUES (3, '2024-03-20');

-- Добавление данных в таблицу Products
INSERT INTO Products (ProductID, ProductName, Price) VALUES (1, 'Product A', 1500);
INSERT INTO Products (ProductID, ProductName, Price) VALUES (2, 'Product B', 2500);
INSERT INTO Products (ProductID, ProductName, Price) VALUES (3, 'Product C', 5000);

-- Добавление данных в таблицу OrderDetails
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity) VALUES (1, 1, 1, 5);
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity) VALUES (2, 1, 2, 10);
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity) VALUES (3, 2, 3, 3);
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity) VALUES (4, 3, 2, 20);

CREATE VIEW IF NOT EXISTS HighValueOrders AS
SELECT 
    o.OrderID,
    o.OrderDate,
    SUM(od.Quantity * p.Price) AS TotalAmount
FROM 
    Orders o
JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
JOIN 
    Products p ON od.ProductID = p.ProductID
GROUP BY 
    o.OrderID, o.OrderDate
HAVING 
    SUM(od.Quantity * p.Price) > 10000;

   SELECT * FROM HighValueOrders;
  
  
  
--  Задание 3: Удаление данных и таблиц
--Задание: Удалите все записи из таблицы EmployeeDetails, где Salary меньше
--50000. Затем удалите таблицу EmployeeDetails из базы данных.
--Подсказки:
--1. Используйте команду DELETE FROM для удаления данных.
--2. Используйте команду DROP TABLE для удаления таблицы.

  -- Проверка наличия таблицы EmployeeDetails
SELECT name FROM sqlite_master WHERE type = 'table' AND name = 'EmployeeDetails';

-- Удаление записей из таблицы EmployeeDetails, где Salary < 50000
DELETE FROM EmployeeDetails WHERE Salary < 50000;

-- Проверка оставшихся записей
SELECT * FROM EmployeeDetails;

-- Удаление таблицы EmployeeDetails
DROP TABLE IF EXISTS EmployeeDetails;

-- Проверка наличия таблицы EmployeeDetails
SELECT name FROM sqlite_master WHERE type = 'table' AND name = 'EmployeeDetails';



--Задание 4: Создание хранимой процедуры
--Задание: Создайте хранимую процедуру GetProductSales с одним параметром
--ProductID. Эта процедура должна возвращать список всех заказов, в которых
--участвует продукт с заданным ProductID, включая следующие столбцы:
--● OrderID (идентификатор заказа),
--● OrderDate (дата заказа),
--● CustomerID (идентификатор клиента).
--Подсказки:
--1. Используйте команду CREATE PROCEDURE для создания процедуры.
--2. Используйте JOIN для объединения таблиц и WHERE для фильтрации данных по
--ProductID.

SELECT name FROM sqlite_master WHERE type = 'view';

ALTER TABLE Orders ADD COLUMN CustomerID INTEGER;

-- Создание представления для получения данных по ProductID
CREATE VIEW IF NOT EXISTS ProductSalesView AS
SELECT
    o.OrderID,
    o.OrderDate,
    o.CustomerID,
    od.ProductID
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID;

SELECT name FROM sqlite_master WHERE type = 'view';

-- Запрос данных по ProductID
-- При выполнении фильтруем данные по ProductID
SELECT OrderID, OrderDate, CustomerID
FROM ProductSalesView
WHERE ProductID = :ProductID;

PRAGMA table_info(Orders);



