/*
Задание 2
Нормализируйте данную таблицу: таблица в материалах к уроку.
*/

-- drop database HW_03_T_02_BD;

CREATE DATABASE HW_03_T_02_BD;

CREATE TABLE HW_03_T_02_BD.Orders
(
	Customer varchar(200), -- Покупатель
	OrderDate date, -- дата
	OrderDetails varchar(200),  -- Информация для заказа
	Employee varchar(200) -- работник
);

INSERT HW_03_T_02_BD.Orders(Customer, OrderDate, OrderDetails, Employee)
VALUES
(
 'Василий Петрович Лященко; Харьков, Лужная 15; (092)3212211;',
 '2009-12-28',
 'LV231 Джинсы, 45$, 5, 225$; DG30 Ремень, 30$, 5, 145$; LV12 Обувь, 26$, 5, 125$;',
 'Иван Иванович Белецкий'),
 ('Зигмунд Федорович Унакий; Киев, Дегтяревская 5; (092)7612343;',
 '2010-09-01',
 'GC11 Шапка, 32$, 10, 320#$; GC111 Футболка, 20$, 15, 300$;',
 'Светлана Олеговна Лялечкина'),
  ('Олег Евстафьевич Выжлецов; Чернигов, Киевская 5; (044)2134212;',
 '2010-09-18',
 'LV12 Обувь, 26$, 20, 520$; GC11 Шапка, 32$, 18, 576$;',
 'Светлана Олеговна Лялечкина'
 );
 SELECT * FROM HW_03_T_02_BD.Orders;
 -- DROP TABLE HW_03_T_02_BD.Orders;

 ------------------------------------------------------------------------- 
 
 CREATE TABLE HW_03_T_02_BD.Customer  -- Покупатель
(
    id INT AUTO_INCREMENT NOT NULL,
	surnamesN VARCHAR(30) NOT NULL,   			 -- Фамили
    nameN VARCHAR(30) NOT NULL, 				 -- Имя
    patronymicN VARCHAR(30) DEFAULT 'Unknown', 	 -- Отчество
	dateR date, -- Дата регистрации	
    PRIMARY KEY (id)
);

INSERT HW_03_T_02_BD.Customer( nameN, patronymicN, surnamesN, dateR)
VALUES
('Василий', 'Петрович', 'Лященко', now()),
('Зигмунд', 'Федорович', 'Унакий', now()),
('Олег', 'Евстафьевич', 'Выжлецов', now());
 SELECT * FROM HW_03_T_02_BD.Customer;
 
-- TRUNCATE TABLE  HW_03_T_02_BD.Customer;
-- DROP TABLE HW_03_T_02_BD.Customer;
 
  -------------------------------------------------------------------------
 
  CREATE TABLE HW_03_T_02_BD.delivery  -- доставка
(
    id INT AUTO_INCREMENT NOT NULL,
    CustomerID int NOT NULL, 
	city VARCHAR(30) not null,    -- город
    street varchar(30), -- улица
    house int, -- дом	
    FOREIGN KEY(CustomerID) references Customer(id),
    PRIMARY KEY (id, CustomerID)
);

INSERT HW_03_T_02_BD.delivery(CustomerID, city, street, house)
VALUES
(1, 'Харьков', 'Лужная', 15),
(1, 'Днепр', 'Богдана Хмельницкого', 16),
(2, 'Киев', 'Дегтяревская', 5),
(3, 'Чернигов', 'Киевская', 5);
 SELECT * FROM HW_03_T_02_BD.delivery;
 
-- TRUNCATE TABLE  HW_03_T_02_BD.delivery;
-- DROP TABLE HW_03_T_02_BD.delivery;
 
  -------------------------------------------------------------------------

  CREATE TABLE HW_03_T_02_BD.phone  -- номер моб
(
	phone VARCHAR(20) NOT NULL, -- телефон
    CustomerID int NOT NULL, 
    FOREIGN KEY(CustomerID) references Customer(id),
    PRIMARY KEY (phone, CustomerID)
);

INSERT HW_03_T_02_BD.phone(CustomerID, phone)
VALUES
(1, '(092)0000001'),
-- (1, '(092)0000001'),
(1, '(095)0000001'),
(2, '(095)0000002'),
(3, '(095)0000003');

 SELECT * FROM HW_03_T_02_BD.phone;
 
-- TRUNCATE TABLE  HW_03_T_02_BD.phone;
-- DROP TABLE HW_03_T_02_BD.phone;
 
  ------------------------------------------------------------------------- 
 
 CREATE TABLE HW_03_T_02_BD.Employee  -- работник
(
    id INT AUTO_INCREMENT NOT NULL,
	surnamesN VARCHAR(30) NOT NULL,   			 -- Фамили
    nameN VARCHAR(30) NOT NULL, 				 -- Имя
    patronymicN VARCHAR(30) DEFAULT 'Unknown', 	 -- Отчество
    jobTitle VARCHAR(30) NOT NULL, 	             -- должность
	PRIMARY KEY (id)
);

INSERT HW_03_T_02_BD.Employee(surnamesN, nameN, patronymicN , jobTitle)
VALUES
('Белецкий', 'Иван', 'Иванович', 'Старший продавец'),
('Лялечкина', 'Светлана', 'Олеговна', 'Продавец');

 SELECT * FROM HW_03_T_02_BD.Employee;
 
-- TRUNCATE TABLE  HW_03_T_02_BD.Employee;
-- DROP TABLE HW_03_T_02_BD.Employee;
 
------------------------------------------------------------------------- 
  
  CREATE TABLE HW_03_T_02_BD.store  -- склад магазина
(
    id INT AUTO_INCREMENT NOT NULL,
	art VARCHAR(30) NOT NULL,  -- артикул производителя может быть не уникальным 
    nameProduct VARCHAR(100) NOT NULL,  -- категория или названия  
    price double NOT NULL, -- цена реализации
    currency VARCHAR(10), -- валюта реализации
    totalStock int DEFAULT 0, -- количество на складе
	PRIMARY KEY (id)
);


  
INSERT HW_03_T_02_BD.store(art, nameProduct, price, currency, totalStock)
VALUES
('LV12', 'Обувь', 26, '$', 1001),
('GC11', 'Шапка', 32, '$', 1002),
('GC111', 'Футболка', 20, '$', 1003),
('LV231', 'Джинсы', 45, '$', 1004),
('DG30', 'Ремень', 30, '$', 1005);

 SELECT * FROM HW_03_T_02_BD.store;
 
-- TRUNCATE TABLE  HW_03_T_02_BD.store;
-- DROP TABLE HW_03_T_02_BD.store;
 
 ------------------------------------------------------------------------- 
 CREATE TABLE HW_03_T_02_BD.OrdersV2
(    
	OrderID int AUTO_INCREMENT NOT NULL,   -- уникальный номер заказа
    PRIMARY KEY (OrderID),
       
    OrderDate date NOT NULL, -- дата заказа	
    
    EmployeeID int,  -- id работника	
	FOREIGN KEY(EmployeeID) REFERENCES HW_03_T_02_BD.Employee(ID),     
    
 	CustomerID int,
 	FOREIGN KEY(CustomerID) REFERENCES HW_03_T_02_BD.Customer(ID),
    
    deliveryID int,
    FOREIGN KEY(deliveryID, CustomerID) REFERENCES HW_03_T_02_BD.delivery(ID, CustomerID), -- у клиента может быть несколько адрессов доставки
    
    phoneID VARCHAR(20) NOT NULL,
    FOREIGN KEY(phoneID, CustomerID) REFERENCES HW_03_T_02_BD.phone(phone, CustomerID)  -- у клиента может быть несколько номеров тел, но также может быть разные получатели по одному номеру
);

INSERT HW_03_T_02_BD.OrdersV2(OrderDate, EmployeeID, CustomerID, deliveryID, phoneID)
VALUES
(now(), 1, 1, 1, '(092)0000001'),
(now(), 2, 2, 3, '(095)0000002'),
(now(), 2, 3, 4, '(095)0000003');

 SELECT * FROM HW_03_T_02_BD.OrdersV2;
 
-- TRUNCATE TABLE  HW_03_T_02_BD.OrdersV2;
-- DROP TABLE HW_03_T_02_BD.OrdersV2;
 
  ------------------------------------------------------------------------- 
  
 CREATE TABLE HW_03_T_02_BD.OrderDetails
 
(
	OrderID int NOT NULL, 		-- номер заказа или ID заказа
	LineItem int NOT NULL,  	-- уникальная позиции в заказе
	storeID int NOT NULL,    	-- ID продукта
	totalQty int NOT NULL,  	-- количесвто однотипных товаров в заказе

    FOREIGN KEY(OrderID) REFERENCES HW_03_T_02_BD.OrdersV2(OrderID),
	FOREIGN KEY(storeID) REFERENCES HW_03_T_02_BD.store(ID),
	PRIMARY KEY (OrderId, LineItem)
);

/*
 1 'LV12 Обувь, 26$, 20, 520$; GC11 Шапка, 32$, 18, 576$;',
 2 'GC11 Шапка, 32$, 10, 320#$; GC111 Футболка, 20$, 15, 300$;',
 3 'LV231 Джинсы, 45$, 5, 225$; DG30 Ремень, 30$, 5, 145$; LV12 Обувь, 26$, 5, 125$;',
  
1 ('LV12', 'Обувь', 26, '$', 1001),
2 ('GC11', 'Шапка', 32, '$', 1002),
3 ('GC111', 'Футболка', 20, '$', 1003),
4 ('LV231', 'Джинсы', 45, '$', 1004),
5 ('DG30', 'Ремень', 30, '$', 1005);
  */

INSERT HW_03_T_02_BD.OrderDetails(OrderID, LineItem, storeID, totalQty)
VALUES
-- (OrderID, LineItem, storeID, totalQty)
		(1, 1, 1, 20),
        (1, 2, 2, 18),
        (2, 1, 2, 10),
        (2, 2, 3, 15), 
		(3, 1, 4, 5),
		(3, 2, 5, 5),
		(3, 3, 1, 5);

 SELECT * FROM HW_03_T_02_BD.OrderDetails;
 
-- TRUNCATE TABLE  HW_03_T_02_BD.OrderDetails;
-- DROP TABLE HW_03_T_02_BD.OrderDetails;