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
-- Table structure for table `bkusers`
--

DROP TABLE IF EXISTS `bkusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bkusers` (
  `bkid` int NOT NULL AUTO_INCREMENT,
  `bkname` varchar(45) NOT NULL,
  `bknpm` int NOT NULL,
  `bkusername` varchar(45) NOT NULL,
  `bkpasswordhash` varchar(250) NOT NULL,
  PRIMARY KEY (`bkid`),
  UNIQUE KEY `bkid_UNIQUE` (`bkid`),
  UNIQUE KEY `bkname_UNIQUE` (`bkname`),
  UNIQUE KEY `bkusername_UNIQUE` (`bkusername`),
  UNIQUE KEY `bknpm_UNIQUE` (`bknpm`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bkusers`
--

LOCK TABLES `bkusers` WRITE;
/*!40000 ALTER TABLE `bkusers` DISABLE KEYS */;
INSERT INTO `bkusers` VALUES (1,'Michelle Angelina',18320007,'michelleangelina','$2b$10$W2gZFDVSkBc1fqbSKf/.2.q9ZxESXfpSIwsPGCbl/yKW6tUq0pMT2'),(2,'William Joshua',13219007,'williamjoshua','$2b$10$7AFnKzWdItIaK5V308rwDuIAnSlpzHVGxl8FlasoGXB1PzpLtOSVS'),(3,'Victoire Louvre',10118010,'victoirelouvre','$2b$10$jqvswojVUImn0THSjelIpeSDjoFPlFEd4TCSuJCXmz3kr7mmtidS.'),(4,'Fleura Louvre',10118012,'fleuralouvre','$2b$10$PzGMrEMyvHJAJoTtfYIvhOeUxQOKMAbASyM6bn/m6tHZLkh9ODq6q'),(5,'Estoria De Lana',10117091,'esdelana','$2b$10$L3ogwPAvLscxcpSirZ2aj..BrWpBIKyyLjeof8i1ek4kONIVjJMF2'),(6,'Herald Huntsman',10116003,'hhuntsman','$2b$10$MajV6k9mFqEJqqs7berSYOjLVlEJ1xy7q9q464Jqj6jfAi4zdMCne'),(7,'Lucius Avery',10115101,'averylucius','$2b$10$HrD26rXTGkb8bs9iDMv1yunIJqTtk7Yb.wm/APlrX0eHSvkrBT9U.'),(9,'Darriel Blanc',10114056,'blancmont','$2b$10$5ARGM0DaPSpDgVamYVu9heIJnGnfIiApxpznFVSKjRzFxYOOACiba'),(18,'Daia Lestrange',11613023,'misslestrange','$2b$10$ugRj7/fqJwD1Nkwwt1QWHueVepZjCr6vKwabEIy03bGY1i/Jolaze'),(19,'Miranda Zhang',13320099,'zhangmeian','$2b$10$zeBtFyrj.ZkHR6OjMjMtH.gyrK1ryzk4Dy4tQrGZnUYc8Pmk5.Lw6'),(20,'Gabriella Starsha',12321012,'stargaby','$2b$10$AJ2eFZUOtKJJ.BILQKqvqemLL15MuO8.4pYaxPEMxkWG058YlmaAG'),(21,'Xaverius Kevin',13312012,'xkevs','$2b$10$GBybt75tGWFGuqhnlo8upuZM4MA2d3BcDKo6ZSxEuPG0KuXKsuMRO'),(22,'Harry Potter',18317003,'harrypotter','$2b$10$O/fJFwNwJdrscS/8yJqkYuW6Ki4.Bu.LFph/TyHwdiP4gd7SX0poO'),(23,'Fleur d\'Automne',18320077,'fleurdautomne','$2b$10$L2nPd0RFSsuPf4KMAkjy7uE.aWqFYiaeVsm3GTltzYMaYuhuUxuT.'),(24,'Wilhelm',18320090,'wilhelm','$2b$10$vKEPChAZ1b9x2m6I2uk1PekxSNvnWa4uH4z4eRxALkG2LPPIno7AO'),(25,'Gilbert',12221021,'gilbert','$2b$10$eNzbopPh3FAKg4e8flxf6OZz1J7dG7LQncifijm7gAd3iNCX4T2lS'),(28,'Michelle Zheng',18321030,'michellezheng','$2b$10$EcYWNwH2hrlqlxOu/YoRjegHa0WD5B2EDZUy58KPKk6BK3GbXh0Re'),(30,'Autumn Flower',13320001,'autumnflower','$2b$10$eP/XGInHmtfRO21V.nS13O5RWAV3zrSsDtISSNRgMAkadULQV0yFG'),(31,'Owen',18320000,'owen','$2b$10$I1GKUXv3LDmfvAGUlmjfNePyjB./v.Rxb5WxvgszoQ5pX7C04dvuW'),(32,'Farrel',18320008,'farrel','$2b$10$fQczMCPlYsLqQY3gbwhiw.AfkRE.P7FPQmVVZ2/4mYhudm2fPjfVC'),(33,'Sky Bahng',12304056,'skypark','$2b$10$DCXaGqIUM3nHI.QnKDm57OiBzBOZrIqY2G4WmqpsL9AX.yuq49lO.');
/*!40000 ALTER TABLE `bkusers` ENABLE KEYS */;
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
