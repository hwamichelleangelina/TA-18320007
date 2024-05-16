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
-- Table structure for table `reqentries`
--

DROP TABLE IF EXISTS `reqentries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reqentries` (
  `reqid` int NOT NULL AUTO_INCREMENT,
  `initial` varchar(60) NOT NULL,
  `fakultas` varchar(45) DEFAULT NULL,
  `gender` enum('P','L') DEFAULT NULL,
  `angkatan` int DEFAULT NULL,
  `kampus` enum('Ganesha','Jatinangor','Cirebon') DEFAULT NULL,
  `mediakontak` enum('Line','WA','Email') NOT NULL,
  `kontak` varchar(45) NOT NULL,
  `katakunci` enum('Akademik','Finansial','Keluarga','Percintaan','Kehidupan Kampus','Kesehatan','Karir dan Masa Depan','Lain-Lain') NOT NULL,
  `sesi` enum('Online','Offline') NOT NULL,
  `psnim` int DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `psname` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`reqid`),
  UNIQUE KEY `reqid_UNIQUE` (`reqid`),
  KEY `fk_reqentries_psnim` (`psnim`,`psname`),
  CONSTRAINT `fk_reqentries_psnim` FOREIGN KEY (`psnim`) REFERENCES `psusers` (`psnim`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Permintaan untuk melakukan pendampingan secara manual';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reqentries`
--

LOCK TABLES `reqentries` WRITE;
/*!40000 ALTER TABLE `reqentries` DISABLE KEYS */;
/*!40000 ALTER TABLE `reqentries` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-12 11:48:39
