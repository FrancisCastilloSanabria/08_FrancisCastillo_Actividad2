/*Actividad 4 : Implementación, validación y 
manejo de registros de BD en MS SQL Server con 
T-SQL*/


--Actividad 1


/* 1 Crear un nuevo script New Query.*/
	
/* 2 Eliminar y crear la base de datos db_SalesClothes.*/
	DROP DATABASE IF EXISTS db_SalesClothes;
	CREATE DATABASE db_SalesClothes;

/* 3 Poner en uso la base de datos db_SalesClothes.*/
	USE db_SalesClothes;
	GO

/* 4 Configurar el idioma español el motor de base de datos.*/
	SET LANGUAGE Español
	GO
	SELECT @@language AS 'Idioma'
	GO

/* 5 Configurar el formato de fecha en dmy (día, mes y año) en el motor de base de datos.*/
	SET DATEFORMAT dmy
	GO

/* 6 Crear la tabla client con la siguiente estructura:*/
/* 7 Tener presente las siguientes restricciones para la tabla client:
El campo id es clave principal y autoincrementable, empieza en 1 e incrementa de 1 en uno.
El campo type_document sólo puede admitir datos como DNI ó CNE
El campo number_document sólo permite dígitos entre 0 a 9, y serán 8 cuando es DNI y 9 cuando sea CNE.
El el campo email sólo permite correos electrónicos válidos, por ejemplo: mario@gmail.com
El campo cell_phone acepta solamente 9 dígitos numéricos, por ejemplo: 997158238.
El campo birthdate sólo permite la fecha de nacimiento de clientes mayores de edad.
El campo active tendrá como valor predeterminado 1, que significa que el cliente está activo.*/
DROP TABLE IF EXISTS client;
CREATE TABLE client (
    id INT PRIMARY KEY IDENTITY(1,1),
    type_document VARCHAR(3), --CHECK (type_document IN ('DNI', 'CNE')),
    number_document VARCHAR(9), --CHECK ((type_document = 'DNI' AND LEN(number_document) = 8) AND (type_document = 'CNE' AND LEN(number_document) = 9)),
	names VARCHAR(60),
	last_name VARCHAR(90),
	email VARCHAR(80) CHECK (email LIKE '%@%.%'),
    cell_phone VARCHAR(9) CHECK (cell_phone LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    birthdate DATE CHECK (DATEDIFF(YEAR, birthdate, GETDATE()) >= 18),
    active BIT DEFAULT 1
);
GO

--Restricciones table client
/* El tipo de documento puede ser DNI ó CNE */
ALTER TABLE client
	DROP COLUMN type_document
GO

/* Agregar restricción para tipo documento */
ALTER TABLE client
	ADD type_document char(3)
	CONSTRAINT type_document_client 
	CHECK(type_document ='DNI' OR type_document ='CNE')
GO

/* Eliminar columna number_document de tabla client */
ALTER TABLE client
	DROP COLUMN number_document
GO

/* El número de documento sólo debe permitir dígitos de 0 - 9 */
ALTER TABLE client
	ADD number_document char(9)
	CONSTRAINT number_document_client
	CHECK (number_document like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][^A-Z]')
GO

/* 8 Crear la tabla seller con	 la siguiente estructura:*/
/* 9 Tener presente las siguientes restricciones para la tabla seller:
El campo id es clave principal y autoincrementable, empieza en 1 e incrementa de 1 en uno.
El campo type_document sólo puede admitir datos como DNI ó CNE
El campo number_document sólo permite dígitos entre 0 a 9, y serán 8 cuando es DNI y 9 cuando sea CNE.
El campo salary tiene como valor predeterminado 1025
El campo cell_phone acepta solamente 9 dígitos numéricos, por ejemplo: 997158238.
El el campo email sólo permite correos electrónicos válidos, por ejemplo: roxana@gmail.com
El campo active tendrá como valor predeterminado 1, que significa que el cliente está activo.*/
DROP TABLE IF EXISTS seller;
CREATE TABLE seller (
  id INT PRIMARY KEY IDENTITY(1,1),
  type_document VARCHAR(3), --CHECK (type_document IN ('DNI', 'CNE')),
  number_document VARCHAR(9), --CHECK ((type_document = 'DNI' AND LEN(number_document) = 8) OR (type_document = 'CNE' AND LEN(number_document) = 9)),
  names VARCHAR(60),
  last_name VARCHAR(90),
  salary DECIMAL(8,2) DEFAULT 1025,
  cell_phone CHAR(9) CHECK (cell_phone LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
  email VARCHAR(80) CHECK (email LIKE '%@%.%'),
  active BIT DEFAULT 1
);
GO

--Restricciones table seller
/* El tipo de documento puede ser DNI ó CNE */
ALTER TABLE seller
	DROP COLUMN type_document
GO

/* Agregar restricción para tipo documento */
ALTER TABLE seller
	ADD type_document char(3)
	CONSTRAINT type_document_seller 
	CHECK(type_document ='DNI' OR type_document ='CNE')
GO

/* Eliminar columna number_document de tabla client */
ALTER TABLE seller
	DROP COLUMN number_document
GO

/* El número de documento sólo debe permitir dígitos de 0 - 9 */
ALTER TABLE seller
	ADD number_document char(9)
	CONSTRAINT number_document_seller
	CHECK (number_document like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][^A-Z]')
GO

/* 10 Crear la tabla clothes con la siguiente estructura:*/
/* 11 Tener presente las siguientes restricciones para la tabla clothes:
El campo id es clave principal y autoincrementable, empieza en 1 e incrementa de 1 en uno.
El campo active tendrá como valor predeterminado 1, que significa que el cliente está activo.*/
DROP TABLE IF EXISTS clothes;
CREATE TABLE clothes (
    id INT PRIMARY KEY IDENTITY(1,1),
	descriptions VARCHAR(60),
	brand VARCHAR(60),
	amount INT,
	size VARCHAR(10),
	price DECIMAL(8,2),
    active INT DEFAULT 1
);
GO

/* 12 Crear tabla sale con la siguiente estructura:*/
/* 13 Tener presente las siguientes restricciones para la tabla sale:
El campo id es clave principal y autoincrementable, empieza en 1 e incrementa de 1 en uno.
El campo date_time debe tener como valor predeterminado la fecha y hora del servidor.
El campo active tendrá como valor predeterminado 1, que significa que el cliente está activo.*/
DROP TABLE IF EXISTS sale;
CREATE TABLE sale (
    id INT PRIMARY KEY IDENTITY(1,1),
    date_time DATETIME NOT NULL DEFAULT GETDATE(),
	seller_id INT,
	client_id int,
    active INT DEFAULT 1
);
GO

/* 14 Crear tabla sale_detail con la siguiente estructura:*/
DROP TABLE IF EXISTS sale_detail;
CREATE TABLE sale_detail (
    id INT PRIMARY KEY,
	sale_id INT,
	clothes_id INT,
    amount INT,
);
GO

/* 15 Utilizando código T-SQL crear las relaciones entre las tablas de acuerdo a la siguiente imagen:*/

-- FOREIGN KEYS
-- Reference: sale_client (table: sale)
ALTER TABLE sale ADD CONSTRAINT sale_client
    FOREIGN KEY (client_id)
    REFERENCES client (id);

-- Reference: sale_seller (table: sale)
ALTER TABLE sale ADD CONSTRAINT sale_seller
    FOREIGN KEY (seller_id)
    REFERENCES seller (id);

-- Reference: sale_detail_sale (table: sale_detail)
ALTER TABLE sale_detail ADD CONSTRAINT sale_detail_sale
    FOREIGN KEY (sale_id)
    REFERENCES sale (id);

-- Reference: sale_detail_clothes (table: sale_detail)
ALTER TABLE sale_detail ADD CONSTRAINT sale_detail_clothes
    FOREIGN KEY (clothes_id)
    REFERENCES clothes (id);


