-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: asp_blog
-- ------------------------------------------------------
-- Server version	8.0.19
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `asp_blog`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `asp_blog` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `asp_blog`;

--
-- Table structure for table `artigo`
--

DROP TABLE IF EXISTS `artigo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artigo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) NOT NULL,
  `conteudo` text,
  `versiculo` text,
  `preview` text NOT NULL,
  `data_criacao` datetime DEFAULT NULL,
  `data_atualizacao` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artigo`
--

LOCK TABLES `artigo` WRITE;
/*!40000 ALTER TABLE `artigo` DISABLE KEYS */;
INSERT INTO `artigo` VALUES (1,'Primeiro artigo','<div>Seja bem vindo ao meu blog! Meu nome Ã© AndrÃ© Felipe e eu sou programador em Joinville/SC.</div><div><br></div><div>Neste blog desejo colocar conteÃºdo sobre programaÃ§Ã£o, Teologia e tambÃ©m versÃ­culos da BÃ­blia.</div><div><br></div><div>AtÃ© mais!</div>','<div>O Senhor Ã© meu pastor, e nada me faltarÃ¡.</div><div>Ele me faz repousar em verdes pastos e me leva para junto de riachos tranquilos.</div><div>Renova minhas forÃ§as e me guia pelos caminhos da justiÃ§a; assim, ele honra o seu nome.</div><div><br></div><div><a href=\"https://my.bible.com/bible/1930/PSA.23.1-3\" title=\"\" target=\"_blank\">Salmo 23:1-3</a></div>','Seja bem vindo ao meu blog!','2020-02-20 22:28:57','2020-02-21 01:04:15'),(2,'Sobre','OlÃ¡! Meu nome Ã© AndrÃ© Felipe e eu sou programador em Joinville/SC.<div><br></div><div>Neste blog pretendo publicar artigos sobre programaÃ§Ã£o, Teologia e tambÃ©m versÃ­culos da BÃ­blia.</div><div><br></div><div>Sou cristÃ£o e ter conhecido a Jesus foi a melhor coisa que aconteceu na minha vida. No momento em que mais precisei, Jesus nÃ£o me abandonou.</div><div><br></div><div>Contatos:</div><div><ul><li><a href=\"https://www.linkedin.com/in/andrefelipe-frontend/\" title=\"\" target=\"_blank\">Linkedin</a></li><li><a href=\"https://www.instagram.com/newandrefelipe/\" title=\"\" target=\"_blank\">Instagram</a></li></ul></div>','<div>Porque eu, o Senhor, teu Deus, te tomo pela tua mÃ£o direita e te digo: nÃ£o temas, que eu te ajudo.</div><div><br></div><div><a href=\"https://my.bible.com/bible/212/ISA.41.13\" title=\"\" target=\"_blank\">IsaÃ­as 41:13</a></div>','OlÃ¡! Meu nome Ã© AndrÃ© Felipe e eu sou programador em Joinville/SC.','2020-02-20 22:28:57','2020-02-20 22:35:39');
/*!40000 ALTER TABLE `artigo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artigo_tag`
--

DROP TABLE IF EXISTS `artigo_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artigo_tag` (
  `id` int NOT NULL AUTO_INCREMENT,
  `artigo_id` int DEFAULT NULL,
  `tag_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artigo_tag`
--

LOCK TABLES `artigo_tag` WRITE;
/*!40000 ALTER TABLE `artigo_tag` DISABLE KEYS */;
INSERT INTO `artigo_tag` VALUES (9,2,1),(11,1,1);
/*!40000 ALTER TABLE `artigo_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tag` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
INSERT INTO `tag` VALUES (1,'Geral');
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `login_` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `nome` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `login_` (`login_`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'adm','4ad3249044bacce3753bfd66b7d0d9ce','Administrador');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'asp_blog'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-02-21 19:22:29
