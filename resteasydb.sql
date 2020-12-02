-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: localhost    Database: resteasy
-- ------------------------------------------------------
-- Server version	8.0.22

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
-- Table structure for table `t_bill`
--

DROP TABLE IF EXISTS `t_bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_bill` (
  `bill_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `bill_amount` int NOT NULL,
  PRIMARY KEY (`bill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_bill`
--

LOCK TABLES `t_bill` WRITE;
/*!40000 ALTER TABLE `t_bill` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_customer`
--

DROP TABLE IF EXISTS `t_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_customer` (
  `customer_email` varchar(100) NOT NULL,
  `customer_name` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`customer_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_customer`
--

LOCK TABLES `t_customer` WRITE;
/*!40000 ALTER TABLE `t_customer` DISABLE KEYS */;
INSERT INTO `t_customer` VALUES ('gagan.s@gmail.com','Gagan','gagan'),('maya@gmail.com','Maya','maya'),('surendra.h@gmail.com','Surendra H','suri');
/*!40000 ALTER TABLE `t_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_dish`
--

DROP TABLE IF EXISTS `t_dish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_dish` (
  `dish_name` varchar(100) NOT NULL,
  `calories` int DEFAULT NULL,
  PRIMARY KEY (`dish_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_dish`
--

LOCK TABLES `t_dish` WRITE;
/*!40000 ALTER TABLE `t_dish` DISABLE KEYS */;
INSERT INTO `t_dish` VALUES ('Apple Juice',400),('Baby Corn Manchuri',250),('Finger Chips',500),('Fried Papad',100),('Geera Rice',300),('Ghee Rice',600),('Gobi Manchuri',300),('Orange Juice',400),('Paneer Manchuri',300),('Pineaple Juice',400),('Plain Rice',200),('Roasted Papad',50),('Veg Fried Rice',500),('Veg Salad',50);
/*!40000 ALTER TABLE `t_dish` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_order`
--

DROP TABLE IF EXISTS `t_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_order` (
  `order_id` int NOT NULL,
  `dish_name` varchar(100) NOT NULL,
  `vendor_name` varchar(100) NOT NULL,
  `quantity` int NOT NULL,
  KEY `dish_name_fk_order_idx` (`dish_name`),
  KEY `vendor_name_fk_order_idx` (`vendor_name`),
  CONSTRAINT `dish_name_fk_order` FOREIGN KEY (`dish_name`) REFERENCES `t_dish` (`dish_name`),
  CONSTRAINT `vendor_name_fk_order` FOREIGN KEY (`vendor_name`) REFERENCES `t_vendor` (`vendor_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_order`
--

LOCK TABLES `t_order` WRITE;
/*!40000 ALTER TABLE `t_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_vendor`
--

DROP TABLE IF EXISTS `t_vendor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_vendor` (
  `vendor_name` varchar(100) NOT NULL,
  `vendor_address` varchar(100) NOT NULL,
  PRIMARY KEY (`vendor_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_vendor`
--

LOCK TABLES `t_vendor` WRITE;
/*!40000 ALTER TABLE `t_vendor` DISABLE KEYS */;
INSERT INTO `t_vendor` VALUES ('Adyar Anand Bhavan - Jayanagar','Jayanagar'),('Adyar Anand Bhavan - Vijaynagar','Vijaynagar'),('Nandana Palace','Rajajinagar'),('Swathi','Rajajinagar');
/*!40000 ALTER TABLE `t_vendor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_vendordish`
--

DROP TABLE IF EXISTS `t_vendordish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_vendordish` (
  `item_id` int NOT NULL AUTO_INCREMENT,
  `vendor_name` varchar(100) NOT NULL,
  `dish_name` varchar(100) NOT NULL,
  `price` int NOT NULL,
  PRIMARY KEY (`item_id`),
  KEY `vendor_name_fk_idx` (`vendor_name`),
  KEY `dish_name_fk_idx` (`dish_name`),
  CONSTRAINT `dish_name_fk` FOREIGN KEY (`dish_name`) REFERENCES `t_dish` (`dish_name`),
  CONSTRAINT `vendor_name_fk` FOREIGN KEY (`vendor_name`) REFERENCES `t_vendor` (`vendor_name`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_vendordish`
--

LOCK TABLES `t_vendordish` WRITE;
/*!40000 ALTER TABLE `t_vendordish` DISABLE KEYS */;
INSERT INTO `t_vendordish` VALUES (1,'Adyar Anand Bhavan - Jayanagar','Apple Juice',50),(2,'Adyar Anand Bhavan - Jayanagar','Baby Corn Manchuri',80),(3,'Adyar Anand Bhavan - Jayanagar','Finger Chips',50),(4,'Adyar Anand Bhavan - Jayanagar','Fried Papad',20),(5,'Adyar Anand Bhavan - Jayanagar','Geera Rice',100),(6,'Adyar Anand Bhavan - Jayanagar','Ghee Rice',100),(7,'Adyar Anand Bhavan - Jayanagar','Gobi Manchuri',100),(8,'Adyar Anand Bhavan - Vijaynagar','Gobi Manchuri',100),(9,'Adyar Anand Bhavan - Vijaynagar','Apple Juice',50),(10,'Adyar Anand Bhavan - Vijaynagar','Finger Chips',80),(11,'Adyar Anand Bhavan - Vijaynagar','Fried Papad',20),(12,'Nandana Palace','Fried Papad',40),(13,'Nandana Palace','Apple Juice',80),(14,'Nandana Palace','Baby Corn Manchuri',150),(15,'Nandana Palace','Finger Chips',100),(16,'Nandana Palace','Fried Papad',50),(17,'Swathi','Fried Papad',40),(18,'Swathi','Veg Salad',50),(19,'Swathi','Veg Fried Rice',150),(20,'Swathi','Roasted Papad',50),(21,'Swathi','Plain Rice',50);
/*!40000 ALTER TABLE `t_vendordish` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-12-02  9:57:58
