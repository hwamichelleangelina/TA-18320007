-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: peersupervision
-- ------------------------------------------------------
-- Server version	8.3.0

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
-- Table structure for table `psusers`
--

DROP TABLE IF EXISTS `psusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `psusers` (
  `psid` int NOT NULL AUTO_INCREMENT,
  `psname` varchar(60) NOT NULL,
  `psnim` int NOT NULL,
  `pspasswordhash` varchar(100) NOT NULL,
  `psisActive` tinyint NOT NULL,
  `psisAdmin` tinyint DEFAULT NULL,
  PRIMARY KEY (`psid`),
  UNIQUE KEY `psid_UNIQUE` (`psid`),
  UNIQUE KEY `psname_UNIQUE` (`psname`),
  UNIQUE KEY `psnim_UNIQUE` (`psnim`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `psusers`
--

LOCK TABLES `psusers` WRITE;
/*!40000 ALTER TABLE `psusers` DISABLE KEYS */;
INSERT INTO `psusers` VALUES (5,'Michelle Angelina',18320007,'$2b$10$NDJ/xJDBM0vbvF1iGPbdLeNQOcAjc3MfQShe/7NsKNZm5kNmFkada',1,1),(6,'William Joshua',13219007,'$2b$10$lkZd14XWaZ6u2e0poBeYqep0u0cnSgC6YdYlIlNHje/UAvdKddzXa',1,1),(7,'Axel Blaze',13218032,'$2b$10$ugBuLZOQkJaddndgHQlXI.8itv./YD9ZDufpvZNaGDwBs4Jp1iMzm',1,0),(8,'Marcus Evans',13218033,'$2b$10$qeHXh0LmS54j.olC1oukO.xFWaBU6DIGaHwcnEbkhRm/EwuOl8ebO',0,0),(9,'Jude Sharp',13218009,'$2b$10$WWa7xLXX1zSG/c22emX9beVWZLomiu7a1wL2dJR0imSbJtzxbbs.G',1,0),(10,'Sylvia Hillsman',13218022,'$2b$10$fOg4vztAGRMslx2C4FXwK.5yTp6K9TnFn7Odno67YShRKcypTak0.',1,0),(11,'Nelly Huntsman',12202231,'$2b$10$xkEbxC7POVFL.IqLGGPefeXDLmSyODMaxc0ojn1XuZJ/Sv6y926dm',1,0);
/*!40000 ALTER TABLE `psusers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-12 11:48:40
