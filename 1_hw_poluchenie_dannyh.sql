--Задание №1: Уникальные страны клиентов 
--Определите, сколько уникальных стран представлено среди клиентов.
--1 вариант
SELECT COUNT(DISTINCT Country) AS unique_countries
FROM Customers;
--2 вариант
SELECT COUNT(*) AS unique_countries
FROM (
    SELECT Country
    FROM Customers
    GROUP BY Country
) AS CountryGroups;

--Задание №2: Клиенты из Бразилии
--Определите количество клиентов, которые проживают в Бразилии.
--Подсказка: Используйте условие WHERE для фильтрации клиентов по стране.
--1 вариант 
SELECT COUNT(*) AS brazil_customers
FROM Customers
WHERE Country = 'Brazil';
--2 вариант
SELECT SUM(CASE WHEN Country = 'Brazil' THEN 1 ELSE 0 END) AS brazil_customers
FROM Customers;

--Задание №3: Средняя цена и количество товаров в категории 5
--Посчитайте среднюю цену и общее количество товаров в категории с
--идентификатором 5.
--1 вариант 
SELECT
    AVG(Price) FILTER (WHERE CategoryID = 5) AS avg_price,
    COUNT(*) FILTER (WHERE CategoryID = 5) AS total_products
FROM Products;
--2 вариант
SELECT
    AVG(CASE WHEN CategoryID = 5 THEN Price END) AS avg_price,
    COUNT(CASE WHEN CategoryID = 5 THEN 1 END) AS total_products
FROM Products;

--Задание №4: Средний возраст сотрудников на 2024-01-01
--Вычислите средний возраст сотрудников на дату 2024-01-01.
--Подсказка: Используйте функцию JULIANDAY для расчета возраста сотрудников и AVG
--для получения среднего значения.
--1 вариант 
SELECT AVG((JULIANDAY('2024-01-01') - JULIANDAY(BirthDate)) / 365.25) AS AverageAge
FROM Employees;
--2 вариант
SELECT AVG(CASE WHEN BirthDate IS NOT NULL 
                THEN (JULIANDAY('2024-01-01') - JULIANDAY(BirthDate)) / 365.25 
                ELSE NULL END) AS AverageAge
FROM Employees;

--Задание №5: Заказы в период 30 дней до 2024-02-15
--Найдите заказы, сделанные в период с 16 января по 15 февраля 2024 года, и
--отсортируйте их по дате заказа.
--1 вариант 
SELECT *
FROM Orders
WHERE OrderDate BETWEEN '2024-01-16' AND '2024-02-15'
ORDER BY OrderDate;
--2 вариант
SELECT *
FROM Orders
WHERE OrderDate >= '2024-01-16' AND OrderDate <= '2024-02-15'
ORDER BY OrderDate;

--Задание №6: Количество заказов за ноябрь 2023 года (используя
--начальную и конечную дату)
--Определите количество заказов, сделанных в ноябре 2023 года, используя
--начальную и конечную дату месяца.
--1 вариант 
SELECT COUNT(*) AS november_orders
FROM Orders
WHERE OrderDate >= '2023-11-01' AND OrderDate <= '2023-11-30';
--2 вариант
SELECT COUNT(*) AS november_orders
FROM Orders
WHERE OrderDate BETWEEN '2023-11-01' AND '2023-11-30';

--Задание №7: Количество заказов за январь 2024 года (используя LIKE)
--Найдите количество заказов за январь 2024 года, используя оператор LIKE для
--фильтрации даты.
--1 вариант 
SELECT COUNT(*) AS january_orders
FROM Orders
WHERE OrderDate LIKE '2024-01%';
--2 вариант
SELECT COUNT(*) AS january_orders
FROM Orders
WHERE strftime('%Y-%m', OrderDate) = '2024-01';

--Задание №8: Количество заказов за 2024 год
--Определите количество заказов за 2024 года, используя функцию STRFTIME для
--извлечения года.
SELECT COUNT(*) AS orders_2024
FROM Orders
WHERE STRFTIME('%Y', OrderDate) = '2024';
--2 вариант
SELECT COUNT(*) AS orders_2024
FROM Orders
WHERE OrderDate >= '2024-01-01' AND OrderDate < '2025-01-01';






