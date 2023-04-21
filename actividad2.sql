-- 1 Crear un nuevo script New Query.

-- 2 Eliminar y crear la base de datos db_SalesClothes.
	DROP DATABASE IF EXISTS db_SalesClothes;
	CREATE DATABASE db_SalesClothes;

-- 3 Poner en uso la base de datos db_SalesClothes.
	USE db_SalesClothes
	GO

-- 4 Configurar el idioma español el motor de base de datos.
	SET LANGUAGE Español
	GO
	SELECT @@language AS 'Idioma'
	GO

-- 5 Configurar el formato de fecha en dmy (día, mes y año) en el motor de base de datos.
	SET DATEFORMAT dmy
	GO

-- 6 Insertar los siguientes registros en la tabla client
INSERT INTO client (type_document, number_document, names, last_name, email, cell_phone, birthdate)
VALUES
('DNI', '78451233', 'Fabiola', 'Perales Campos', 'fabiolaperales@gmail.com', '991692597', '2005-01-19'),
('DNI', '14782536', 'Marcos', 'Dávila Palomino', 'marcosdavila@gmail.com', '982514752', '1990-03-03'),
('DNI', '78451236', 'Luis Alberto', 'Barrios Paredes', 'luisbarrios@outlook.com', '985414752', '1995-10-03'),
('CNE', '352514789', 'Claudia María', 'Martínez Rodriguez', 'claudiamartinez@yahoo.com', '995522147', '1992-09-23'),
('CNE', '142536792', 'Mario Tadeo', 'Farfán Castillo', 'mariotadeo@outlook.com', '973125478', '1997-11-25'),
('DNI', '58251433', 'Ana Lucrecia', 'Chumpitaz Prada', 'anachumpitaz@gmail.com', '982514361', '1992-10-17'),
('DNI', '15223369', 'Humberto', 'Cabrera Tadeo', 'humbertocabrera@yahoo.com', '977112234', '1990-05-27'),
('CNE', '442233698', 'Rosario', 'Prada Velásque', 'rosarioorada@outlook.com', '971144782', '1990-11-05');

--VER INSERSION
SELECT * FROM client;

-- 7 Insertar los siguientes registros en la tabla seller
INSERT INTO seller (type_document, number_document, names, last_name, salary, cell_phone, email)
VALUES 
('DNI', '11224578', 'Oscar', 'Paredes Flores', '1025.00', '985566251', 'oparedes@miemrpesa.com'),
('CNE', '889922365', 'Azucena', 'Valle Alcazar', '1025.00', '966338874', 'avalle@miemrpesa.com'),
('DNI', '44771123', 'Rosario', 'Huarca Tarazona', '1025.00', '933665521', 'rhuaraca@miemrpesa.com');

--VER INSERSION
SELECT * FROM seller;

-- 8 Insertar los siguientes registros en la tabla clothes
INSERT INTO clothes (descriptions, brand, amount, size, price)
VALUES 
('Polo camisero', 'Adidas', 20, 'Medium', 25.99),
('Short playero', 'Nike', 30, 'Medium', 25.99),
('Camisa sport', 'Adams', 60, 'Large', 25.99),
('Camisa sport', 'Adams', 70, 'Medium', 25.99),
('buzo de verano', 'Reebok', 45, 'Small', 25.99),
('Pantalón Jean', 'Lewis', 35, 'Large', 25.99);

--VER INSERSION
SELECT * FROM clothes;

-- 9 Listar todos los datos de los clientes (client) cuyo tipo de documento sea DNI
SELECT * FROM client WHERE type_document = 'DNI';

-- 10 Listar todos los datos de los clientes (client) cuyo servidor de correo electrónico sea outlook.com.
SELECT * FROM client WHERE email LIKE '%@outlook.com';

-- 11 Listar todos los datos de los vendedores (seller) cuyo tipo de documento sea CNE.
SELECT * FROM seller WHERE type_document = 'CNE';

-- 12 Listar todas las prendas de ropa (clothes) cuyo costo sea menor e igual que S/. 55.00
SELECT * FROM clothes WHERE price <= 55.00;

-- 13 Listar todas las prendas de ropa (clothes) cuya marca sea Adams.
SELECT * FROM clothes WHERE brand = 'Adams';

-- 14 Eliminar lógicamente los datos de un cliente client de acuerdo a un determinado id.
-- en este caso eliminare al cliente con id 3
UPDATE client SET active = 0 WHERE id = 3;
--aqui puedes verificar el eliminado logico
SELECT * FROM client;

-- 15 Eliminar lógicamente los datos de un cliente seller de acuerdo a un determinado id.
-- en este caso eliminare al cliente seller con id 2
UPDATE seller SET active = 0 WHERE id = 2;
--aqui puedes verificar el eliminado logico
SELECT * FROM seller;

-- 16 Eliminar lógicamente los datos de un cliente clothes de acuerdo a un determinado id 
UPDATE clothes SET active = 0 WHERE id = 1;
-- en este caso eliminare al cliente clothes con id 1
SELECT * FROM clothes;





