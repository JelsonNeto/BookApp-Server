-- --------------------------------------------------------
-- Anfitrião:                    127.0.0.1
-- Versão do servidor:           10.1.37-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win32
-- HeidiSQL Versão:              11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for bookapp-bd
CREATE DATABASE IF NOT EXISTS `bookapp-bd` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `bookapp-bd`;

-- Dumping structure for table bookapp-bd.leitor
CREATE TABLE IF NOT EXISTS `leitor` (
  `pkLeitor` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `bi` varchar(50) NOT NULL,
  `endereco` varchar(50) DEFAULT NULL,
  `telefone` varchar(50) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `data_criacao` datetime DEFAULT NULL,
  `data_modificacao` datetime NOT NULL,
  `status_` int(11) NOT NULL,
  KEY `Index 1` (`pkLeitor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table bookapp-bd.leitor: ~0 rows (approximately)
/*!40000 ALTER TABLE `leitor` DISABLE KEYS */;
/*!40000 ALTER TABLE `leitor` ENABLE KEYS */;

-- Dumping structure for table bookapp-bd.livraria
CREATE TABLE IF NOT EXISTS `livraria` (
  `pkLivraria` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) DEFAULT NULL,
  `nif` varchar(50) DEFAULT NULL,
  `endereco` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `telefone1` varchar(50) DEFAULT NULL,
  `telefone2` varchar(50) DEFAULT NULL,
  `data_criacao` datetime DEFAULT NULL,
  `data_modificacao` datetime DEFAULT NULL,
  `status_` int(11) DEFAULT NULL,
  KEY `Index 1` (`pkLivraria`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Dumping data for table bookapp-bd.livraria: ~2 rows (approximately)
/*!40000 ALTER TABLE `livraria` DISABLE KEYS */;
INSERT INTO `livraria` (`pkLivraria`, `nome`, `nif`, `endereco`, `email`, `telefone1`, `telefone2`, `data_criacao`, `data_modificacao`, `status_`) VALUES
	(1, 'Teste', 'teste', '121212', 'jjdjdad', '', '', '2020-08-15 14:37:59', NULL, 1),
	(4, 'Jelson Neto', '012912', 'Teste', 'jelsonneto94@gmail.com', '941926369', '', '2020-08-15 16:06:11', NULL, 1),
	(5, 'Teste-Nome', '019191', 'jksdkjsdn', 'jelsonneto93@gmail.com', '941926369', NULL, '2020-08-16 11:56:22', NULL, 1),
	(6, 'Teste-Nome', '019191', 'jksdkjsdn', 'jelsonneto93@gmail.com', '941926369', NULL, '2020-08-16 11:58:53', NULL, 1),
	(7, 'Teste-Nome', '019191', 'jksdkjsdn', 'jelsonneto93@gmail.com', '941926369', NULL, '2020-08-16 11:59:10', NULL, 1),
	(8, 'Teste-Nome', '019191', 'jksdkjsdn', 'jelsonneto93@gmail.com', '941926369', NULL, '2020-08-16 12:01:13', NULL, 1);
/*!40000 ALTER TABLE `livraria` ENABLE KEYS */;

-- Dumping structure for procedure bookapp-bd.STP_Leitor_INSERT_UPDATE
DELIMITER //
CREATE PROCEDURE `STP_Leitor_INSERT_UPDATE`(IN pkLeitor INT(11),
	IN nome VARCHAR(50),
	IN bi VARCHAR(50),
	IN endereco VARCHAR(50),
	IN telefone VARCHAR(50),
	IN email VARCHAR(50),
    IN senha VARCHAR(50)
)
BEGIN
 DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 errno = MYSQL_ERRNO;
    -- SELECT errno AS MYSQL_ERROR;
    SHOW WARNINGS;
    ROLLBACK;
    END;
    START TRANSACTION;
    if(pkLeitor=0) then
    INSERT INTO leitor(nome, bi, endereco, telefone, email, data_criacao, data_modificacao, status_) 
    VALUES (nome,bi,endereco,telefone,email,now(),now(),1);
    SET @pkLeitor = LAST_INSERT_ID();
    INSERT INTO usuario (username,`email`,`password`,`idUsuario`,`tipoUsuario`,`data_criacao`,`data_modificacao`,`status_`)
				VALUES  (nome,email,senha,@pkLeitor,1,now(),now(),1);
	 
    end if;
END//
DELIMITER ;

-- Dumping structure for procedure bookapp-bd.STP_LIVRARIA_INSERT_UPDATE
DELIMITER //
CREATE PROCEDURE `STP_LIVRARIA_INSERT_UPDATE`(
	IN `pkLivraria` INT(11),
	IN `nome` VARCHAR(50),
	IN `nif` VARCHAR(50),
	IN `endereco` VARCHAR(50),
	IN `email` VARCHAR(50),
	IN `telefone1` VARCHAR(50),
	IN `telefone2` VARCHAR(50),
	IN `senha` VARCHAR(50)
)
BEGIN 

	 DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 errno = MYSQL_ERRNO;
    -- SELECT errno AS MYSQL_ERROR;
    SHOW WARNINGS;
    ROLLBACK;
    END;
    START TRANSACTION;
    
    if(pkLivraria=0) then
    
    		INSERT INTO livraria (`pkLivraria`,`nome`,`nif`,`endereco`,`email`,`telefone1`,`telefone2`,`data_criacao`,`data_modificacao`,`status_`)
				 VALUES  ( NULL       ,   nome , nif, endereco , email , telefone1 , telefone2 , NOW()      ,   NULL            ,   1 );
    
    		SET @pkLivraria = LAST_INSERT_ID();
    		
    		INSERT INTO usuario (`pkUsuario`,`username`,`email`,`password`,`idUsuario`,`tipoUsuario`,`data_criacao`,`data_modificacao`,`status_`)
							VALUES  ( NULL      ,  nome    ,  email ,  senha   , @pkLivraria , 2          ,  NOW()       ,  NULL             , 1 );
	 
	  END if;            
   	
 COMMIT WORK;  
END//
DELIMITER ;

-- Dumping structure for table bookapp-bd.usuario
CREATE TABLE IF NOT EXISTS `usuario` (
  `pkUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `tipoUsuario` int(11) NOT NULL,
  `data_criacao` datetime NOT NULL,
  `data_modificacao` datetime DEFAULT NULL,
  `status_` int(11) NOT NULL,
  KEY `Index 1` (`pkUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Dumping data for table bookapp-bd.usuario: ~0 rows (approximately)
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` (`pkUsuario`, `username`, `email`, `password`, `idUsuario`, `tipoUsuario`, `data_criacao`, `data_modificacao`, `status_`) VALUES
	(1, 'Jelson Neto', 'jelsonneto94@gmail.com', '1234', 4, 2, '2020-08-15 16:06:11', NULL, 1),
	(2, 'Teste-Nome', 'jelsonneto93@gmail.com', '1234', 5, 2, '2020-08-16 11:56:22', NULL, 1),
	(3, 'Teste-Nome', 'jelsonneto93@gmail.com', '1234', 6, 2, '2020-08-16 11:58:53', NULL, 1),
	(4, 'Teste-Nome', 'jelsonneto93@gmail.com', '1234', 7, 2, '2020-08-16 11:59:10', NULL, 1),
	(5, 'Teste-Nome', 'jelsonneto93@gmail.com', '1234', 8, 2, '2020-08-16 12:01:13', NULL, 1);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
