-- ============================================
--  Almacen - Script de inicializacion
--  Crea la base de datos, tablas y datos
-- ============================================

CREATE DATABASE IF NOT EXISTS almacen
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_0900_ai_ci;

USE almacen;

-- ── Tablas ──

CREATE TABLE IF NOT EXISTS productos (
  id_producto INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(100) NOT NULL,
  unidad_medida VARCHAR(10) NOT NULL,
  precio_unidad DOUBLE NOT NULL,
  PRIMARY KEY (id_producto)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS pedidos (
  id_pedido INT NOT NULL AUTO_INCREMENT,
  nombre_cliente VARCHAR(100) NOT NULL,
  total DOUBLE NOT NULL,
  fecha VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_pedido)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS detalles_pedido (
  id_pedido INT NOT NULL,
  id_producto INT NOT NULL,
  cantidad DOUBLE NOT NULL,
  precio_total DOUBLE NOT NULL,
  PRIMARY KEY (id_pedido, id_producto)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS stock (
  id_producto INT NOT NULL,
  stock_inicial INT NOT NULL DEFAULT 100,
  stock_actual INT NOT NULL DEFAULT 100,
  PRIMARY KEY (id_producto),
  FOREIGN KEY (id_producto) REFERENCES productos(id_producto) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ── Datos: Productos ──

INSERT INTO productos (id_producto, nombre, unidad_medida, precio_unidad) VALUES
(1,'Leche entera','litro',1.05),
(2,'Leche semidesnatada','litro',0.99),
(3,'Yogur natural','ud',0.45),
(4,'Mantequilla','250g',2.1),
(5,'Queso manchego','kg',9.5),
(6,'Huevos camperos','docena',3.2),
(7,'Pan de molde','450g',1.35),
(8,'Barra de pan','ud',0.9),
(9,'Arroz redondo','kg',1.2),
(10,'Pasta macarrones','500g',0.85),
(11,'Tomate frito','400g',0.95),
(12,'Aceite de oliva virgen','litro',5.8),
(14,'Sardinas en aceite','lata',1.25),
(15,'Lentejas cocidas','bote',0.9),
(16,'Garbanzos cocidos','bote',0.95),
(17,'Tomates cherry','500g',1.8),
(18,'Patatas','kg',0.75),
(19,'Cebollas','kg',0.65),
(20,'Zanahorias','kg',0.8);

-- ── Datos: Pedidos ──

INSERT INTO pedidos (id_pedido, nombre_cliente, total, fecha) VALUES
(1,'María García',18.45,'2025-04-01'),
(2,'Carlos López',32.10,'2025-04-02'),
(3,'Ana Martínez',9.75,'2025-04-03'),
(4,'Pedro Sánchez',38.39,'2025-04-04'),
(5,'Laura Fernández',11.40,'2025-04-05'),
(6,'José Romero',8.75,'2025-04-07'),
(7,'Isabel Torres',57.54,'2025-04-08'),
(8,'Miguel Jiménez',42.04,'2025-04-09'),
(9,'Carmen Ruiz',20.95,'2025-04-10'),
(10,'Antonio Moreno',57.35,'2025-04-11'),
(11,'Lucía Alonso',47.25,'2025-04-12'),
(12,'Francisco Muñoz',16.34,'2025-04-14'),
(13,'Elena Navarro',18.10,'2025-04-15'),
(14,'David Iglesias',21.25,'2025-04-16'),
(15,'Sofía Delgado',57.70,'2025-04-17');

-- ── Datos: Detalles de pedidos ──

INSERT INTO detalles_pedido (id_pedido, id_producto, cantidad, precio_total) VALUES
(1,1,4,4.2),(1,2,6,5.94),(1,3,6,2.7),(1,4,1,2.1),(1,5,1,9.5),
(1,6,3,9.6),(1,7,4,5.4),(1,8,4,3.6),(1,9,5,6.0),(1,10,3,2.55),
(1,11,6,5.7),(1,12,2,11.6),(1,14,6,7.5),(1,15,4,3.6),(1,16,2,1.9),
(1,17,2,3.6),(1,18,3,2.25),(1,19,5,3.25),(1,20,1,0.8),
(2,1,5,5.25),(2,2,1,0.99),(2,3,1,0.45),(2,4,4,8.4),(2,5,6,57.0),
(2,6,2,6.4),(2,7,2,2.7),(2,8,4,3.6),(2,9,4,4.8),(2,10,2,1.7),
(2,11,5,4.75),(2,12,1,5.8),(2,14,3,3.75),(2,15,6,5.4),(2,16,2,1.9),
(2,17,5,9.0),(2,18,1,0.75),(2,19,1,0.65),(2,20,6,4.8),
(3,2,5,4.95),(3,3,2,0.9),(3,6,6,19.2),(3,7,1,1.35),(3,8,1,0.9),
(3,9,6,7.2),(3,10,4,3.4),(3,12,6,34.8),(3,14,5,6.25),(3,18,1,0.75),
(4,1,6,6.3),(4,2,1,0.99),(4,3,4,1.8),(4,4,6,12.6),(4,8,1,0.9),
(4,9,5,6.0),(4,12,1,5.8),(4,20,5,4.0),
(5,7,5,6.75),(5,8,1,0.9),(5,18,5,3.75),
(6,8,1,0.9),(6,15,3,2.7),(6,16,2,1.9),(6,19,5,3.25),
(7,2,1,0.99),(7,4,3,6.3),(7,5,3,28.5),(7,6,3,9.6),(7,9,1,1.2),
(7,11,4,3.8),(7,14,5,6.25),(7,15,1,0.9),
(8,2,6,5.94),(8,4,5,10.5),(8,5,1,9.5),(8,9,1,1.2),(8,11,6,5.7),
(8,14,2,2.5),(8,16,5,4.75),(8,19,3,1.95),
(9,3,3,1.35),(9,4,6,12.6),(9,8,4,3.6),(9,10,4,3.4),
(10,6,3,9.6),(10,7,6,8.1),(10,11,1,0.95),(10,12,6,34.8),(10,19,6,3.9),
(11,5,1,9.5),(11,6,6,19.2),(11,7,3,4.05),(11,8,5,4.5),
(11,18,6,4.5),(11,19,6,3.9),(11,20,2,1.6),
(12,2,1,0.99),(12,9,6,7.2),(12,11,2,1.9),(12,14,5,6.25),
(13,3,5,2.25),(13,7,3,4.05),(13,14,2,2.5),(13,16,6,5.7),(13,17,2,3.6),
(14,3,6,2.7),(14,4,2,4.2),(14,9,4,4.8),(14,12,1,5.8),
(14,14,1,1.25),(14,15,1,0.9),(14,20,2,1.6),
(15,3,1,0.45),(15,5,3,28.5),(15,8,6,5.4),(15,9,5,6.0),
(15,10,1,0.85),(15,14,6,7.5),(15,15,5,4.5),(15,18,6,4.5);

-- ── Datos: Stock ──

INSERT INTO stock (id_producto, stock_inicial, stock_actual) VALUES
(1,100,85),(2,100,79),(3,100,72),(4,100,73),(5,100,85),
(6,100,77),(7,100,76),(8,100,73),(9,100,63),(10,100,86),
(11,100,76),(12,100,83),(14,100,65),(15,100,80),(16,100,83),
(17,100,91),(18,100,78),(19,100,74),(20,100,84);
