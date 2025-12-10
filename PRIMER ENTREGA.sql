CREATE SCHEMA CADENA_SUPERMERCADO;
USE CADENA_SUPERMERCADO;

CREATE TABLE cliente(
id_cliente INT NOT NULL,
nombre VARCHAR(50) NOT NULL,
apellido VARCHAR(50) NOT NULL,
email VARCHAR(100) NOT NULL,
telefono VARCHAR(20),
fecha_nac DATE NOT NULL,
sexo ENUM("Masculino", "Femenino", "Prefiere no contestar") NOT NULL DEFAULT "Prefiere no contestar",
PRIMARY KEY (id_cliente)
);

CREATE TABLE locales(
id_local INT NOT NULL,
codigo_postal VARCHAR(10) NOT NULL,
provincia VARCHAR(50) NOT NULL,
ciudad VARCHAR(50) NOT NULL,
direccion VARCHAR(100) NOT NULL,
metros_cuadrados INT NOT NULL,
PRIMARY KEY (id_local)
);

CREATE TABLE fabricante(
id_fabricante INT NOT NULL,
nombre_fab VARCHAR(100) NOT NULL,
PRIMARY KEY (id_fabricante)
);

CREATE TABLE marca(
id_marca INT NOT NULL,
nombre_marca VARCHAR(100),
id_fabricante INT NOT NULL,
PRIMARY KEY (id_marca),
FOREIGN KEY (id_fabricante) REFERENCES fabricante(id_fabricante)
);

CREATE TABLE producto(
sku INT NOT NULL,
categoria VARCHAR(50) NOT NULL,
subcategoria VARCHAR(50) NOT NULL,
descriptor VARCHAR(100) NOT NULL,
gramaje DECIMAL(10,2),
id_marca INT NOT NULL,
PRIMARY KEY (sku),
FOREIGN KEY (id_marca) REFERENCES marca(id_marca)
);

-- Compra de la cadena a los fabricantes

CREATE TABLE compra_cadena(
id_orden INT NOT NULL,
id_fabricante INT NOT NULL,
fecha_compra DATE NOT NULL,
PRIMARY KEY (id_orden),
FOREIGN KEY (id_fabricante) REFERENCES fabricante(id_fabricante)
);

CREATE TABLE detalle(
id_orden INT NOT NULL,
sku INT NOT NULL,
volumen_c DECIMAL(10,2) NOT NULL,
unidades_c INT NOT NULL,
importe_c DECIMAL(10,2) NOT NULL,
PRIMARY KEY (id_orden, sku),
FOREIGN KEY (id_orden) REFERENCES compra_cadena(id_orden),
FOREIGN KEY (sku) REFERENCES producto(sku)
);

CREATE TABLE transaccion(
id_transaccion INT NOT NULL,
id_cliente INT NOT NULL,
id_local INT NOT NULL,
canal_venta ENUM("Presencial", "Online") NOT NULL,
fecha_compra DATE NOT NULL,
PRIMARY KEY (id_transaccion),
FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
FOREIGN KEY (id_local) REFERENCES locales(id_local)
);

CREATE TABLE lista(
id_transaccion INT NOT NULL,
sku INT NOT NULL,
volumen DECIMAL(10,2) NOT NULL,
unidades INT NOT NULL,
importe DECIMAL(10,2) NOT NULL,
PRIMARY KEY (id_transaccion, sku),
FOREIGN KEY (id_transaccion) REFERENCES transaccion(id_transaccion),
FOREIGN KEY (sku) REFERENCES producto(sku)
);
