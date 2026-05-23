-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: almacen
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `detalles_pedido`
--

LOCK TABLES `detalles_pedido` WRITE;
/*!40000 ALTER TABLE `detalles_pedido` DISABLE KEYS */;
INSERT INTO `detalles_pedido` VALUES (1,1,4,4.2),(1,2,6,5.94),(1,3,6,2.7),(1,4,1,2.1),(1,5,1,9.5),(1,6,3,9.6),(1,7,4,5.4),(1,8,4,3.6),(1,9,5,6),(1,10,3,2.55),(1,11,6,5.7),(1,12,2,11.6),(1,13,3,3.3),(1,14,6,7.5),(1,15,4,3.6),(1,16,2,1.9),(1,17,2,3.6),(1,18,3,2.25),(1,19,5,3.25),(1,20,1,0.8),(2,1,5,5.25),(2,2,1,0.99),(2,3,1,0.45),(2,4,4,8.4),(2,5,6,57),(2,6,2,6.4),(2,7,2,2.7),(2,8,4,3.6),(2,9,4,4.8),(2,10,2,1.7),(2,11,5,4.75),(2,12,1,5.8),(2,13,1,1.1),(2,14,3,3.75),(2,15,6,5.4),(2,16,2,1.9),(2,17,5,9),(2,18,1,0.75),(2,19,1,0.65),(2,20,6,4.8),(3,2,5,4.95),(3,3,2,0.9),(3,6,6,19.2),(3,7,1,1.35),(3,8,1,0.9),(3,9,6,7.2),(3,10,4,3.4),(3,12,6,34.8),(3,14,5,6.25),(3,18,1,0.75);
/*!40000 ALTER TABLE `detalles_pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (1,'María García',18.45,'2025-04-01'),(2,'Carlos López',32.1,'2025-04-02'),(3,'Ana Martínez',9.75,'2025-04-03'),(4,'Pedro Sánchez',55.2,'2025-04-04'),(5,'Laura Fernández',14.3,'2025-04-05'),(6,'José Romero',27.85,'2025-04-07'),(7,'Isabel Torres',41.6,'2025-04-08'),(8,'Miguel Jiménez',6.9,'2025-04-09'),(9,'Carmen Ruiz',22.15,'2025-04-10'),(10,'Antonio Moreno',38,'2025-04-11'),(11,'Lucía Alonso',11.5,'2025-04-12'),(12,'Francisco Muñoz',49.75,'2025-04-14'),(13,'Elena Navarro',16.2,'2025-04-15'),(14,'David Iglesias',30.95,'2025-04-16'),(15,'Sofía Delgado',8.4,'2025-04-17');
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'Leche entera','litro',1.05),(2,'Leche semidesnatada','litro',0.99),(3,'Yogur natural','ud',0.45),(4,'Mantequilla','250g',2.1),(5,'Queso manchego','kg',9.5),(6,'Huevos camperos','docena',3.2),(7,'Pan de molde','450g',1.35),(8,'Barra de pan','ud',0.9),(9,'Arroz redondo','kg',1.2),(10,'Pasta macarrones','500g',0.85),(11,'Tomate frito','400g',0.95),(12,'Aceite de oliva virgen','litro',5.8),(14,'Sardinas en aceite','lata',1.25),(15,'Lentejas cocidas','bote',0.9),(16,'Garbanzos cocidos','bote',0.95),(17,'Tomates cherry','500g',1.8),(18,'Patatas','kg',0.75),(19,'Cebollas','kg',0.65),(20,'Zanahorias','kg',0.8);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-18 16:09:22
