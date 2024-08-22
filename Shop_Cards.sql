CREATE DATABASE  IF NOT EXISTS `shopcards` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `shopcards`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: shopcards
-- ------------------------------------------------------
-- Server version	8.0.37

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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user` varchar(225) DEFAULT NULL,
  `pass` varchar(225) DEFAULT NULL,
  `email` varchar(225) DEFAULT NULL,
  `isAdmin` int NOT NULL,
  `isActive` int DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `createdBy` varchar(225) DEFAULT NULL,
  `updateAt` datetime DEFAULT NULL,
  `isDelete` int DEFAULT NULL,
  `deletedBy` varchar(225) DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `phone` decimal(10,0) DEFAULT NULL,
  `address` varchar(225) DEFAULT NULL,
  `balance` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (12,'a','s6GbqfixPesacOZuAAKdBYYi9A8=','abc12@gmail.com',0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(13,'admin','2Om13rWExgMldVQKW2+k6aUb1pU=','admin@gmail.com',1,1,NULL,NULL,NULL,NULL,NULL,NULL,358645404,'Ha Noi',4795000),(14,'hao','s6GbqfixPesacOZuAAKdBYYi9A8=','haodqhe172718@fpt.edu.vn',0,1,NULL,NULL,NULL,NULL,NULL,NULL,123456788,'Nam dinh',175000),(17,'hao1','s6GbqfixPesacOZuAAKdBYYi9A8=','doanquochao2509@gmail.com',0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(225) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `createdBy` varchar(225) DEFAULT NULL,
  `updateAt` datetime DEFAULT NULL,
  `isDelete` int DEFAULT NULL,
  `DeleteBy` varchar(225) DEFAULT NULL,
  `DeleteAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Viettel','2024-05-18 14:20:05','haodq',NULL,1,NULL,NULL),(2,'Vinaphone','2024-05-18 14:20:05','haodq',NULL,1,NULL,NULL),(3,'Mobiphone','2024-05-18 14:20:05','haodq',NULL,1,NULL,NULL),(4,'Vietnammobile','2024-05-18 14:20:05','haodq',NULL,1,NULL,NULL),(5,'Garena','2024-05-18 14:20:05','haodq',NULL,1,NULL,NULL),(6,'KKKK',NULL,NULL,NULL,0,NULL,NULL);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detailcard`
--

DROP TABLE IF EXISTS `detailcard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detailcard` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Seri` varchar(45) DEFAULT NULL,
  `CardNumber` varchar(45) DEFAULT NULL,
  `ProductId` int DEFAULT NULL,
  `createdBy` varchar(225) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updateAt` datetime DEFAULT NULL,
  `isDelete` int DEFAULT NULL,
  `deleteBy` varchar(225) DEFAULT NULL,
  `deleteAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_product` (`ProductId`),
  CONSTRAINT `fk_product` FOREIGN KEY (`ProductId`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detailcard`
--

LOCK TABLES `detailcard` WRITE;
/*!40000 ALTER TABLE `detailcard` DISABLE KEYS */;
INSERT INTO `detailcard` VALUES (1,'123','1234',2,NULL,NULL,NULL,1,NULL,'2024-07-11 11:18:14'),(2,'234','2345',2,NULL,NULL,NULL,1,NULL,'2024-07-15 14:12:17'),(3,'567','9876',2,NULL,NULL,NULL,1,NULL,'2024-07-15 23:21:16'),(4,'368','6789',2,NULL,NULL,NULL,1,NULL,'2024-07-15 14:11:51'),(5,'567','8905',3,NULL,NULL,NULL,1,NULL,'2024-07-11 11:21:43'),(6,'235','4567',3,NULL,NULL,NULL,1,NULL,'2024-07-11 11:21:43'),(7,'154','0834',3,NULL,NULL,NULL,1,NULL,'2024-07-11 11:21:43'),(8,'267','90348',4,NULL,NULL,NULL,NULL,NULL,NULL),(9,'294','043275',4,NULL,NULL,NULL,1,NULL,'2024-08-01 17:58:14'),(10,'82934','09175',4,NULL,NULL,NULL,1,NULL,'2024-07-31 21:12:40'),(11,'289346','2394',4,NULL,NULL,NULL,NULL,NULL,NULL),(12,'912485','91045',5,NULL,NULL,NULL,NULL,NULL,NULL),(13,'190847','230487',5,NULL,NULL,NULL,NULL,NULL,NULL),(14,'190235781','12092034',5,NULL,NULL,NULL,NULL,NULL,NULL),(15,'10924571','893465',5,NULL,NULL,NULL,NULL,NULL,NULL),(16,'1094','19847124',6,NULL,NULL,NULL,NULL,NULL,NULL),(17,'194184','184193864',6,NULL,NULL,NULL,NULL,NULL,NULL),(18,'1894756','1947563214',6,NULL,NULL,NULL,NULL,NULL,NULL),(19,'891234756','10945614095',6,NULL,NULL,NULL,NULL,NULL,NULL),(20,'8236514','1092347',7,NULL,NULL,NULL,NULL,NULL,NULL),(21,'2938074','15723123',7,NULL,NULL,NULL,NULL,NULL,NULL),(22,'1341982','137649213',7,NULL,NULL,NULL,NULL,NULL,NULL),(23,'10941321','17846519',8,NULL,NULL,NULL,NULL,NULL,NULL),(24,'127964','10293471948',8,NULL,NULL,NULL,NULL,NULL,NULL),(25,'23786419','19746342309',8,NULL,NULL,NULL,NULL,NULL,NULL),(26,'19764134','12736419',9,NULL,NULL,NULL,NULL,NULL,NULL),(27,'1928347','912478',9,NULL,NULL,NULL,NULL,NULL,NULL),(28,'1897246','1234691',9,NULL,NULL,NULL,NULL,NULL,NULL),(29,'110923478','18762349104',10,NULL,NULL,NULL,NULL,NULL,NULL),(30,'12896479','12451092',10,NULL,NULL,NULL,NULL,NULL,NULL),(31,'1286459178','127304',10,NULL,NULL,NULL,NULL,NULL,NULL),(32,'19026409','91269424',11,NULL,NULL,NULL,NULL,NULL,NULL),(33,'192074912','12784',11,NULL,NULL,NULL,NULL,NULL,NULL),(34,'196497124','62354',11,NULL,NULL,NULL,NULL,NULL,NULL),(35,'9817264','9781624',12,NULL,NULL,NULL,NULL,NULL,NULL),(36,'091874','9176293',12,NULL,NULL,NULL,NULL,NULL,NULL),(37,'126746','971264',12,NULL,NULL,NULL,NULL,NULL,NULL),(38,'617926427','812974',13,NULL,NULL,NULL,NULL,NULL,NULL),(39,'1984619','9176249',13,NULL,NULL,NULL,NULL,NULL,NULL),(40,'781624','97162',13,NULL,NULL,NULL,NULL,NULL,NULL),(41,'712947','1972634',14,NULL,NULL,NULL,NULL,NULL,NULL),(42,'1094723','7126347',14,NULL,NULL,NULL,NULL,NULL,NULL),(43,'1947912','1724',14,NULL,NULL,NULL,NULL,NULL,NULL),(44,'9162349','927613479',15,NULL,NULL,NULL,NULL,NULL,NULL),(45,'891762347','12764',15,NULL,NULL,NULL,NULL,NULL,NULL),(46,'791697467','8912734',15,NULL,NULL,NULL,NULL,NULL,NULL),(47,'178624','7962194',16,NULL,NULL,NULL,NULL,NULL,NULL),(48,'16312','7236',16,NULL,NULL,NULL,NULL,NULL,NULL),(49,'9712649','7234894',16,NULL,NULL,NULL,NULL,NULL,NULL),(50,'186242','79432',17,NULL,NULL,NULL,NULL,NULL,NULL),(51,'16914','92374',17,NULL,NULL,NULL,NULL,NULL,NULL),(52,'971649','9812374',17,NULL,NULL,NULL,NULL,NULL,NULL),(53,'916479','47823',18,NULL,NULL,NULL,NULL,NULL,NULL),(54,'167209471','178243',18,NULL,NULL,NULL,NULL,NULL,NULL),(55,'1724082','9231784',18,NULL,NULL,NULL,NULL,NULL,NULL),(56,'17293749','0124732834',19,NULL,NULL,NULL,NULL,NULL,NULL),(57,'9481724','1928347',19,NULL,NULL,NULL,NULL,NULL,NULL),(58,'9172497','48234234',19,NULL,NULL,NULL,NULL,NULL,NULL),(59,'817346','2372',20,NULL,NULL,NULL,NULL,NULL,NULL),(60,'12794','482094',20,NULL,NULL,NULL,NULL,NULL,NULL),(61,'84127','1728946',20,NULL,NULL,NULL,NULL,NULL,NULL),(62,'1280437','79236',21,NULL,NULL,NULL,NULL,NULL,NULL),(63,'34567','2197647',21,NULL,NULL,NULL,NULL,NULL,NULL),(64,'1724612','17641234',21,NULL,NULL,NULL,NULL,NULL,NULL),(65,'91762437','19472',22,NULL,NULL,NULL,NULL,NULL,NULL),(66,'1892346','18273468',22,NULL,NULL,NULL,NULL,NULL,NULL),(67,'7198234','1297634',22,NULL,NULL,NULL,NULL,NULL,NULL),(68,'182346','2719364',22,NULL,NULL,NULL,NULL,NULL,NULL),(69,'329847','238746923',2,NULL,NULL,NULL,1,NULL,'2024-07-25 15:15:14'),(70,'1426378192','09123713012',3,NULL,NULL,NULL,1,NULL,'2024-07-18 10:02:57'),(72,'2343345','45674273',2,NULL,NULL,NULL,1,NULL,'2024-07-25 15:14:24'),(73,'12143534','126358',2,NULL,NULL,NULL,1,NULL,'2024-07-26 17:19:44'),(74,'12454','324134',2,NULL,NULL,NULL,1,NULL,'2024-07-25 15:22:09'),(75,'2934234','1024309234',2,NULL,NULL,NULL,1,NULL,'2024-07-31 21:33:13'),(76,'123123123','4353466323',32,NULL,NULL,NULL,NULL,NULL,NULL),(77,'1426378192123','1231234124235',2,NULL,NULL,NULL,1,NULL,'2024-07-31 21:12:40'),(78,'a','g',3,NULL,NULL,NULL,1,NULL,'2024-07-26 21:50:09'),(79,'14263781922','091237130122',32,NULL,NULL,NULL,NULL,NULL,NULL),(80,'142637819211','11',32,NULL,NULL,NULL,NULL,NULL,NULL),(81,'23456','8980',2,NULL,NULL,NULL,1,NULL,'2024-07-31 21:11:53'),(82,'1234588','67546',32,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `detailcard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory` (
  `productID` int NOT NULL,
  `amount` int NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `createdBy` varchar(225) DEFAULT NULL,
  `updateAt` datetime DEFAULT NULL,
  `isDelete` int DEFAULT NULL,
  `deleteBy` varchar(225) DEFAULT NULL,
  `deleteAt` datetime DEFAULT NULL,
  PRIMARY KEY (`productID`),
  CONSTRAINT `FK_Inventory_Product` FOREIGN KEY (`productID`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
INSERT INTO `inventory` VALUES (2,25,NULL,NULL,NULL,NULL,NULL,NULL),(3,7,NULL,NULL,NULL,NULL,NULL,NULL),(4,10,NULL,NULL,NULL,NULL,NULL,NULL),(5,14,NULL,NULL,NULL,NULL,NULL,NULL),(6,2,NULL,NULL,NULL,NULL,NULL,NULL),(7,3,NULL,NULL,NULL,NULL,NULL,NULL),(8,4,NULL,NULL,NULL,NULL,NULL,NULL),(9,3,NULL,NULL,NULL,NULL,NULL,NULL),(10,3,NULL,NULL,NULL,NULL,NULL,NULL),(11,3,NULL,NULL,NULL,NULL,NULL,NULL),(12,10,NULL,NULL,NULL,NULL,NULL,NULL),(13,6,NULL,NULL,NULL,NULL,NULL,NULL),(14,3,NULL,NULL,NULL,NULL,NULL,NULL),(15,4,NULL,NULL,NULL,NULL,NULL,NULL),(16,3,NULL,NULL,NULL,NULL,NULL,NULL),(17,3,NULL,NULL,NULL,NULL,NULL,NULL),(18,3,NULL,NULL,NULL,NULL,NULL,NULL),(19,6,NULL,NULL,NULL,NULL,NULL,NULL),(20,3,NULL,NULL,NULL,NULL,NULL,NULL),(21,3,NULL,NULL,NULL,NULL,NULL,NULL),(22,8,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_details`
--

DROP TABLE IF EXISTS `order_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `card_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `card_id` (`card_id`),
  CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`card_id`) REFERENCES `detailcard` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_details`
--

LOCK TABLES `order_details` WRITE;
/*!40000 ALTER TABLE `order_details` DISABLE KEYS */;
INSERT INTO `order_details` VALUES (1,1,1),(2,2,2),(3,2,5),(4,3,3),(5,4,4),(6,11,16),(7,11,16),(8,12,6),(9,12,17),(10,15,18),(11,16,20),(12,17,21),(13,18,32),(14,18,56),(15,19,1),(16,20,2),(17,21,3),(18,22,4),(19,23,1),(20,23,1),(21,23,1),(22,23,1),(23,24,2),(24,25,3),(25,26,4),(26,27,2),(27,27,1),(28,28,3),(29,28,4),(30,29,11),(31,29,10),(32,29,8),(33,29,9),(34,30,6),(35,30,7),(36,31,5),(37,32,17),(38,32,18),(39,32,19),(40,32,16),(41,33,20),(42,33,21),(43,33,22),(44,34,3),(45,34,4),(46,34,1),(47,34,2),(48,34,6),(49,34,7),(50,34,5),(51,36,19),(52,37,16),(53,37,22),(54,38,18),(55,39,21),(56,40,20),(57,41,34),(58,42,32),(59,42,33),(60,43,8),(61,43,11),(62,43,9),(63,43,10),(64,44,13),(65,45,3),(66,46,1),(67,47,4),(68,48,2),(69,49,7),(70,50,5),(71,51,6),(72,52,18),(73,52,16),(74,52,19),(75,53,17),(76,54,20),(77,54,21),(78,55,22),(79,56,9),(80,57,10),(81,57,8),(82,57,11),(83,58,46),(84,59,56),(85,60,32),(86,61,1),(87,62,6),(88,62,5),(89,62,7),(90,63,4),(91,64,2),(92,65,3),(93,66,70),(94,67,72),(95,68,69),(96,69,74),(97,70,73),(98,71,78),(99,72,81),(100,73,77),(101,73,10),(102,74,75),(103,75,9);
/*!40000 ALTER TABLE `order_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `total_amount` double DEFAULT NULL,
  `order_date` datetime DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,13,20000,'2024-07-05 19:31:23','Completed'),(2,13,70000,'2024-07-05 19:34:01','Completed'),(3,13,20000,'2024-07-05 22:13:28','Completed'),(4,13,20000,'2024-07-05 22:14:06','Completed'),(5,13,20000,'2024-07-05 22:15:22','Completed'),(6,13,20000,'2024-07-05 22:15:32','Completed'),(7,13,20000,'2024-07-05 22:15:43','Completed'),(8,13,0,'2024-07-05 22:16:07','Completed'),(9,13,20000,'2024-07-05 22:16:23','Completed'),(10,13,20000,'2024-07-05 22:22:04','Completed'),(11,13,20000,'2024-07-05 22:22:32','Completed'),(12,13,60000,'2024-07-05 22:22:58','Completed'),(13,13,20000,'2024-07-05 22:27:08','Completed'),(14,13,0,'2024-07-05 22:38:29','Completed'),(15,13,20000,'2024-07-06 12:02:23','Completed'),(16,13,40000,'2024-07-06 12:23:10','Completed'),(17,13,40000,'2024-07-06 17:14:13','Completed'),(18,13,80000,'2024-07-06 17:15:26','Completed'),(19,13,40000,'2024-07-06 17:43:28','Completed'),(20,14,40000,'2024-07-06 18:09:03','Completed'),(21,14,40000,'2024-07-06 18:13:27','Completed'),(22,13,40000,'2024-07-06 18:15:40','Completed'),(23,14,80000,'2024-07-07 12:49:05','Completed'),(24,14,20000,'2024-07-07 12:51:34','Completed'),(25,14,20000,'2024-07-07 12:51:42','Completed'),(26,14,20000,'2024-07-07 12:51:49','Completed'),(27,13,40000,'2024-07-07 13:11:31','Completed'),(28,13,100000,'2024-07-07 20:32:02','Completed'),(29,13,400000,'2024-07-07 23:00:16','Completed'),(30,13,100000,'2024-07-07 23:10:55','Completed'),(31,13,100000,'2024-07-07 23:11:16','Completed'),(32,13,50000,'2024-07-08 08:14:36','Completed'),(33,13,80000,'2024-07-08 08:32:41','Completed'),(34,13,230000,'2024-07-08 08:54:35','Completed'),(35,13,10000,'2024-07-08 09:03:53','Completed'),(36,13,10000,'2024-07-08 10:40:53','Completed'),(37,13,30000,'2024-07-08 10:41:44','Completed'),(38,13,10000,'2024-07-08 10:49:36','Completed'),(39,13,20000,'2024-07-08 10:50:06','Completed'),(40,13,20000,'2024-07-08 10:50:19','Completed'),(41,13,20000,'2024-07-08 10:50:55','Completed'),(42,13,40000,'2024-07-08 11:04:33','Completed'),(43,13,400000,'2024-07-08 14:20:53','Completed'),(44,13,500000,'2024-07-08 14:37:38','Completed'),(45,13,20000,'2024-07-08 14:50:57','Completed'),(46,13,20000,'2024-07-08 14:59:07','Completed'),(47,13,20000,'2024-07-08 15:00:31','Completed'),(48,13,20000,'2024-07-08 15:22:48','Completed'),(49,13,50000,'2024-07-08 15:23:54','Completed'),(50,13,50000,'2024-07-08 16:29:24','Completed'),(51,13,50000,'2024-07-08 16:33:35','Completed'),(52,14,30000,'2024-07-08 16:54:40','Completed'),(53,14,10000,'2024-07-08 16:57:40','Completed'),(54,14,40000,'2024-07-08 17:06:31','Completed'),(55,13,20000,'2024-07-08 17:08:25','Completed'),(56,13,100000,'2024-07-08 17:10:17','Completed'),(57,13,300000,'2024-07-08 19:17:54','Completed'),(58,13,20000,'2024-07-08 21:02:59','Completed'),(59,13,20000,'2024-07-10 08:41:15','Completed'),(60,13,20000,'2024-07-10 09:20:55','Completed'),(61,13,20000,'2024-07-11 11:18:14','Completed'),(62,13,150000,'2024-07-11 11:21:43','Completed'),(63,14,20000,'2024-07-15 14:11:51','Completed'),(64,14,20000,'2024-07-15 14:12:17','Completed'),(65,13,20000,'2024-07-15 23:21:16','Completed'),(66,13,50000,'2024-07-18 10:02:57','Completed'),(67,13,20000,'2024-07-25 15:14:24','Completed'),(68,13,20000,'2024-07-25 15:15:14','Completed'),(69,13,20000,'2024-07-25 15:22:09','Completed'),(70,13,20000,'2024-07-26 17:19:44','Completed'),(71,13,50000,'2024-07-26 21:50:09','Completed'),(72,13,20000,'2024-07-31 21:11:53','Completed'),(73,13,120000,'2024-07-31 21:12:40','Completed'),(74,13,20000,'2024-07-31 21:33:13','Completed'),(75,13,100000,'2024-08-01 17:58:14','Completed');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` text,
  `image` text,
  `price` int DEFAULT NULL,
  `cateID` int DEFAULT NULL,
  `createdBy` varchar(225) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updateAt` datetime DEFAULT NULL,
  `isDelete` int DEFAULT NULL,
  `deleteBy` varchar(225) DEFAULT NULL,
  `deleteAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Product_Category` (`cateID`),
  CONSTRAINT `FK_Product_Category` FOREIGN KEY (`cateID`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (2,'Thẻ viettel 20k','https://daily.gate.vn/Skin/images/Logos/card-viettel.jpg',20000,1,'haodq','2024-05-18 14:20:05',NULL,0,NULL,NULL),(3,'Thẻ viettel 50k','https://daily.gate.vn/Skin/images/Logos/card-viettel.jpg',50000,1,'haodq','2024-05-18 14:20:05',NULL,0,NULL,NULL),(4,'Thẻ viettel 100k','https://daily.gate.vn/Skin/images/Logos/card-viettel.jpg',100000,1,'haodq','2024-05-18 14:20:05',NULL,0,NULL,NULL),(5,'Thẻ viettel 500k','https://daily.gate.vn/Skin/images/Logos/card-viettel.jpg',500000,1,'haodq','2024-05-18 14:20:05',NULL,0,NULL,NULL),(6,'Thẻ Vina 10k','https://daily.gate.vn/Skin/images/Logos/card-vinaphone.jpg',10000,2,'haodq','2024-05-18 14:20:05',NULL,0,NULL,NULL),(7,'Thẻ Vina 20k','https://daily.gate.vn/Skin/images/Logos/card-vinaphone.jpg',20000,2,'haodq','2024-05-18 14:20:05',NULL,0,NULL,NULL),(8,'Thẻ Vina 50k','https://daily.gate.vn/Skin/images/Logos/card-vinaphone.jpg',50000,2,'haodq','2024-05-18 14:20:05',NULL,0,NULL,NULL),(9,'Thẻ Vina 100k','https://daily.gate.vn/Skin/images/Logos/card-vinaphone.jpg',100000,2,'haodq','2024-05-18 14:20:05',NULL,0,NULL,NULL),(10,'Thẻ Vina 500k','https://daily.gate.vn/Skin/images/Logos/card-vinaphone.jpg',500000,2,'haodq','2024-05-18 14:20:05',NULL,0,NULL,NULL),(11,'Thẻ Mobi 20k','https://daily.gate.vn/Skin/images/Logos/card-mobifone.jpg',20000,3,'haodq','2024-05-18 14:20:05',NULL,0,NULL,NULL),(12,'Thẻ Mobi 50k','https://daily.gate.vn/Skin/images/Logos/card-mobifone.jpg',50000,3,'haodq','2024-05-18 14:20:05',NULL,0,NULL,NULL),(13,'Thẻ Mobi 100k','https://daily.gate.vn/Skin/images/Logos/card-mobifone.jpg',100000,3,'haodq','2024-05-18 14:20:05',NULL,0,NULL,NULL),(14,'Thẻ Mobi 500k','https://daily.gate.vn/Skin/images/Logos/card-mobifone.jpg',500000,3,'haodq','2024-05-18 14:20:05',NULL,0,NULL,NULL),(15,'Thẻ Vietnam 20k','https://daily.gate.vn/Skin/images/Logos/card-vietnamobile.jpg',20000,4,'haodq','2024-05-18 14:20:05',NULL,0,NULL,NULL),(16,'Thẻ Vietnam 50k','https://daily.gate.vn/Skin/images/Logos/card-vietnamobile.jpg',50000,4,'haodq','2024-05-18 14:20:05',NULL,0,NULL,NULL),(17,'Thẻ Vietnam 100k','https://daily.gate.vn/Skin/images/Logos/card-vietnamobile.jpg',100000,4,'haodq','2024-05-18 14:20:05',NULL,0,NULL,NULL),(18,'Thẻ Vietnam 500k','https://daily.gate.vn/Skin/images/Logos/card-vietnamobile.jpg',500000,4,'haodq','2024-05-18 14:20:05',NULL,0,NULL,NULL),(19,'Thẻ Garena 20k','https://daily.gate.vn/Skin/images/Logos/card-garena.jpg',20000,5,'haodq','2024-05-18 14:20:05',NULL,0,NULL,NULL),(20,'Thẻ Garena 50k','https://daily.gate.vn/Skin/images/Logos/card-garena.jpg',50000,5,'haodq','2024-05-18 14:20:05',NULL,0,NULL,NULL),(21,'Thẻ Garena 100k','https://daily.gate.vn/Skin/images/Logos/card-garena.jpg',100000,5,'haodq','2024-05-18 14:20:05',NULL,0,NULL,NULL),(22,'Thẻ Garena 200k','https://daily.gate.vn/Skin/images/Logos/card-garena.jpg',200000,5,'haodq','2024-05-18 14:20:05',NULL,0,NULL,NULL),(32,'Hao','no',1,6,NULL,NULL,NULL,0,NULL,NULL);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_history`
--

DROP TABLE IF EXISTS `transaction_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `amount` double NOT NULL,
  `type` enum('DEPOSIT','WITHDRAW') NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `transaction_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `transaction_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_history`
--

LOCK TABLES `transaction_history` WRITE;
/*!40000 ALTER TABLE `transaction_history` DISABLE KEYS */;
INSERT INTO `transaction_history` VALUES (1,13,19000,'WITHDRAW','Purchase - Order #74','2024-07-31 14:33:13'),(2,13,500000,'DEPOSIT','Deposit money via VNPay - Transaction #29916475','2024-08-01 08:11:09'),(3,13,95000,'WITHDRAW','Purchase - Order #75','2024-08-01 10:58:14');
/*!40000 ALTER TABLE `transaction_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `transaction_id` varchar(50) NOT NULL,
  `processed_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES ('10960554','2024-07-26 10:19:18'),('29916475','2024-08-01 08:11:09'),('75230840','2024-07-26 10:18:18');
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'shopcards'
--

--
-- Dumping routines for database 'shopcards'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-02 15:32:08
