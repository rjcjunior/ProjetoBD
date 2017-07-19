-- MySQL dump 10.13  Distrib 5.7.13, for linux-glibc2.5 (x86_64)
--
-- Host: localhost    Database: trabalho2
-- ------------------------------------------------------
-- Server version	5.7.16-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `CARGO`
--

DROP TABLE IF EXISTS `CARGO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CARGO` (
  `ID_CARGO` int(11) NOT NULL,
  `NOME` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`ID_CARGO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `FALTAS`
--

DROP TABLE IF EXISTS `FALTAS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FALTAS` (
  `ID_FUNCIONARIO` int(11) DEFAULT NULL,
  `DATA_FALTA` date DEFAULT NULL,
  `JUSTIFICADA` char(1) DEFAULT NULL,
  KEY `FK_FUNCIONARIO` (`ID_FUNCIONARIO`),
  CONSTRAINT `FK_FUNCIONARIO` FOREIGN KEY (`ID_FUNCIONARIO`) REFERENCES `FUNCIONARIO` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trabalho2`.`FALTAS_AFTER_INSERT` AFTER INSERT ON `FALTAS` FOR EACH ROW
BEGIN
DECLARE CONTADOR INTEGER;
	SELECT COUNT(FALTAS.JUSTIFICADA) FROM FALTAS
	WHERE FALTAS.ID_FUNCIONARIO = NEW.ID_FUNCIONARIO 
	AND FALTAS.JUSTIFICADA = 'N'
    
	INTO CONTADOR;
	
    
    IF (CONTADOR >= 5) THEN 
		UPDATE FUNCIONARIO 
        SET FUNCIONARIO.ATIVO = 'N'
        WHERE FUNCIONARIO.ID = NEW.ID_FUNCIONARIO;
    END IF;   

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `FUNCIONARIO`
--

DROP TABLE IF EXISTS `FUNCIONARIO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FUNCIONARIO` (
  `NOME` varchar(60) NOT NULL,
  `EMAIL` varchar(60) NOT NULL,
  `SEXO` varchar(10) NOT NULL,
  `DDD` int(2) DEFAULT NULL,
  `SALARIO` decimal(15,2) DEFAULT NULL,
  `TELEFONE` varchar(8) DEFAULT NULL,
  `ATIVO` varchar(1) DEFAULT NULL,
  `ENDERECO` varchar(70) NOT NULL,
  `CPF` varchar(11) NOT NULL,
  `CIDADE` varchar(20) NOT NULL,
  `ESTADO` varchar(2) NOT NULL,
  `BAIRRO` varchar(20) NOT NULL,
  `PAIS` varchar(20) NOT NULL,
  `LOGIN` varchar(12) NOT NULL,
  `SENHA` varchar(12) NOT NULL,
  `NEWS` varchar(8) DEFAULT NULL,
  `ID` int(200) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`CPF`),
  UNIQUE KEY `ID` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `F_CARGO_NIVEL`
--

DROP TABLE IF EXISTS `F_CARGO_NIVEL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `F_CARGO_NIVEL` (
  `F_CPF` varchar(11) NOT NULL,
  `F_ID_CARGO` int(11) DEFAULT NULL,
  `F_ID_NIVEL` int(11) DEFAULT NULL,
  `F_DATA` date DEFAULT NULL,
  PRIMARY KEY (`F_CPF`),
  KEY `FK_F_CARGO` (`F_ID_CARGO`),
  KEY `FK_F_NIVEL` (`F_ID_NIVEL`),
  CONSTRAINT `FK_F_CARGO` FOREIGN KEY (`F_ID_CARGO`) REFERENCES `CARGO` (`ID_CARGO`),
  CONSTRAINT `FK_F_CPF` FOREIGN KEY (`F_CPF`) REFERENCES `FUNCIONARIO` (`CPF`),
  CONSTRAINT `FK_F_NIVEL` FOREIGN KEY (`F_ID_NIVEL`) REFERENCES `NIVEL` (`ID_NIVEL`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NIVEL`
--

DROP TABLE IF EXISTS `NIVEL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NIVEL` (
  `ID_NIVEL` int(11) NOT NULL,
  `NOME` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`ID_NIVEL`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'trabalho2'
--

--
-- Dumping routines for database 'trabalho2'
--
/*!50003 DROP PROCEDURE IF EXISTS `DiminuirSalario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DiminuirSalario`(
P_CPF VARCHAR(11),
PERCENTUAL INTEGER,
OUT RESULTADO VARCHAR(60))
BEGIN
DECLARE ID_FUNCIONARIO INTEGER;

    SELECT ID FROM FUNCIONARIO 
    WHERE CPF = P_CPF
    INTO ID_FUNCIONARIO;
    
    UPDATE FUNCIONARIO AS FUNC
	SET FUNC.SALARIO = FUNC.SALARIO-SALARIO*(PERCENTUAL/100)
	WHERE FUNC.ID = ID_FUNCIONARIO;
    SET RESULTADO = 'SALARIO REDUZIDO';
    /*SELECT FUNCIONARIO.SALARIO INTO RESULTADO FROM FUNCIONARIO
    WHERE FUNCIONARIO.ID = ID_FUNCIONARIO;*/

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PromoverFuncionario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PromoverFuncionario`(
P_CPF VARCHAR(11),
P_NIVEL INTEGER)
BEGIN
DECLARE CPF_FUNCIONARIO VARCHAR(11);
DECLARE DATA_NIVEL DATE;
DECLARE NIVEL_ATUAL INTEGER;

	SELECT 
		FUNCIONARIO.CPF,
        F_CARGO_NIVEL.F_DATA,
        F_CARGO_NIVEL.F_ID_NIVEL
    FROM 
		FUNCIONARIO,
        F_CARGO_NIVEL
    WHERE
		FUNCIONARIO.CPF = F_CARGO_NIVEL.F_CPF AND
		FUNCIONARIO.CPF = P_CPF
    INTO CPF_FUNCIONARIO, DATA_NIVEL,NIVEL_ATUAL ;
    
    IF  NOW() > DATA_NIVEL + INTERVAL '3' year THEN
		IF P_NIVEL = NIVEL_ATUAL+1 THEN
           UPDATE F_CARGO_NIVEL 
           SET F_CARGO_NIVEL.F_ID_NIVEL = P_NIVEL
           WHERE F_CARGO_NIVEL.F_CPF = CPF_FUNCIONARIO;
        END IF;
    END IF ;   
	


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RegistrarFalta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistrarFalta`(
PID_FUNCIONARIO INTEGER,
PDATA_FALTA DATE,
PJUSTIFICADA CHAR(1))
BEGIN

INSERT INTO FALTAS(ID_FUNCIONARIO,DATA_FALTA,JUSTIFICADA)
VALUES(PID_FUNCIONARIO,PDATA_FALTA,PJUSTIFICADA);
 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-06-28 13:12:37
