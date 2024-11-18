DROP DATABASE IF EXISTS ventas_ecommerce;
CREATE DATABASE ventas_ecommerce;
USE ventas_ecommerce; 

DROP TABLE IF EXISTS productos;
CREATE TABLE productos (
producto_id VARCHAR(20) NOT NULL, 
categoria VARCHAR(25) NOT NULL, 
sub_categoria VARCHAR(15),
nombre VARCHAR(150) NOT NULL, 
precio_de_costo DECIMAL NOT NULL,
PRIMARY KEY (producto_id)); 

DROP TABLE IF EXISTS clientes;
CREATE TABLE clientes (
cliente_id VARCHAR(10) NOT NULL, 
nombre VARCHAR(50) NOT NULL, 
edad INT,
ciudad VARCHAR(25), 
mail VARCHAR(100) NOT NULL,
PRIMARY KEY (cliente_id)); 

DROP TABLE IF EXISTS ordenes;
CREATE TABLE ordenes (
orden_id VARCHAR(20) NOT NULL,
cliente_id VARCHAR(10) NOT NULL,
producto_id VARCHAR(20) NOT NULL, 
cantidad_producto INT NOT NULL, 
fecha_orden DATE NOT NULL, 
metodo_pago VARCHAR(10) NOT NULL, 
metodo_envio VARCHAR(20) NOT NULL, 
PRIMARY KEY (orden_id, producto_id),
FOREIGN KEY (producto_id) REFERENCES productos(producto_id),
FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id));

DROP TABLE IF EXISTS facturas;
CREATE TABLE facturas (
orden_id VARCHAR(20) NOT NULL, 
precio_de_venta DECIMAL NOT NULL, 
subtotal DECIMAL NOT NULL, 
costo_de_envio DECIMAL NOT NULL, 
total DECIMAL NOT NULL,
FOREIGN KEY (orden_id) REFERENCES ordenes (orden_id));

DROP TABLE IF EXISTS post_venta;
CREATE TABLE post_venta (
orden_id VARCHAR(20) NOT NULL, 
producto_id VARCHAR(20) NOT NULL, 
ganancia DECIMAL, 
devoluciones BOOLEAN, 
fecha_entrega DATE, 
demora_entrega INT, 
reintegro_costo_envio BOOLEAN,
FOREIGN KEY (orden_id) REFERENCES ordenes (orden_id),
FOREIGN KEY (producto_id) REFERENCES productos (producto_id));

DROP TABLE IF EXISTS ordenes_productos;
CREATE TABLE ordenes_productos (
    orden_id VARCHAR(20),
    producto_id VARCHAR(20),
    cantidad_producto INT,
    PRIMARY KEY (orden_id, producto_id),
    FOREIGN KEY (orden_id) REFERENCES ordenes(orden_id),
    FOREIGN KEY (producto_id) REFERENCES productos(producto_id));