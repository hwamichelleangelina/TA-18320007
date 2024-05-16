-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: ganecare
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
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room` (
  `idRoom` varchar(60) NOT NULL,
  `createdAtRoom` timestamp(1) NOT NULL,
  `genderConselee` varchar(60) NOT NULL,
  `genderConselor` varchar(60) NOT NULL,
  `generationConselee` varchar(45) NOT NULL,
  `generationConselor` varchar(45) NOT NULL,
  `idConselee` int NOT NULL,
  `idConselor` int NOT NULL,
  `inRoomConselee` tinyint NOT NULL,
  `inRoomConselor` tinyint NOT NULL,
  `lastMessageConselee` varchar(100) NOT NULL,
  `lastMessageConselor` varchar(100) NOT NULL,
  `majorConselee` varchar(45) NOT NULL,
  `majorConselor` varchar(45) NOT NULL,
  `nameConselee` varchar(60) NOT NULL,
  `nameConselor` varchar(60) NOT NULL,
  `photoConselee` varchar(100) NOT NULL,
  `photoConselor` varchar(100) NOT NULL,
  `roomStatus` varchar(45) NOT NULL,
  `created_date` datetime NOT NULL,
  PRIMARY KEY (`idRoom`),
  UNIQUE KEY `idRoom_UNIQUE` (`idRoom`),
  UNIQUE KEY `idConselee_UNIQUE` (`idConselee`),
  UNIQUE KEY `idConselor_UNIQUE` (`idConselor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-12 11:48:38
