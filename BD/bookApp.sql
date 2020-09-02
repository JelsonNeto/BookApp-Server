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
  `telefone1` varchar(50) DEFAULT NULL,
  `telefone2` varchar(50) DEFAULT NULL,
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

-- Dumping data for table bookapp-bd.livraria: ~6 rows (approximately)
/*!40000 ALTER TABLE `livraria` DISABLE KEYS */;
INSERT INTO `livraria` (`pkLivraria`, `nome`, `nif`, `endereco`, `email`, `telefone1`, `telefone2`, `data_criacao`, `data_modificacao`, `status_`) VALUES
	(1, 'Teste', 'teste', '121212', 'jjdjdad', '', '', '2020-08-15 14:37:59', NULL, 1),
	(4, 'Jelson Neto', '012912', 'Teste', 'jelsonneto94@gmail.com', '941926369', '', '2020-08-15 16:06:11', NULL, 1),
	(5, 'Teste-Nome', '019191', 'jksdkjsdn', 'jelsonneto93@gmail.com', '941926369', NULL, '2020-08-16 11:56:22', NULL, 1),
	(6, 'Teste-Nome', '019191', 'jksdkjsdn', 'jelsonneto93@gmail.com', '941926369', NULL, '2020-08-16 11:58:53', NULL, 1),
	(7, 'Teste-Nome', '019191', 'jksdkjsdn', 'jelsonneto93@gmail.com', '941926369', NULL, '2020-08-16 11:59:10', NULL, 1),
	(8, 'Teste-Nome', '019191', 'jksdkjsdn', 'jelsonneto93@gmail.com', '941926369', NULL, '2020-08-16 12:01:13', NULL, 1);
/*!40000 ALTER TABLE `livraria` ENABLE KEYS */;

-- Dumping structure for table bookapp-bd.livro
CREATE TABLE IF NOT EXISTS `livro` (
  `pkLivro` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(50) DEFAULT NULL,
  `autor` varchar(50) DEFAULT NULL,
  `genero` varchar(50) DEFAULT NULL,
  `paginas` varchar(50) DEFAULT NULL,
  `preco` double DEFAULT NULL,
  `publicacao` varchar(50) DEFAULT NULL,
  `paragrafo` int(11) DEFAULT NULL,
  `descricao` varchar(50) DEFAULT NULL,
  `imagem` varchar(50) DEFAULT NULL,
  `data_criacao` datetime DEFAULT NULL,
  `data_modificacao` datetime DEFAULT NULL,
  `fkUsuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`pkLivro`),
  KEY `FK_livro_usuario` (`fkUsuario`),
  CONSTRAINT `FK_livro_usuario` FOREIGN KEY (`fkUsuario`) REFERENCES `usuario` (`pkUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table bookapp-bd.livro: ~2 rows (approximately)
/*!40000 ALTER TABLE `livro` DISABLE KEYS */;
INSERT INTO `livro` (`pkLivro`, `titulo`, `autor`, `genero`, `paginas`, `preco`, `publicacao`, `paragrafo`, `descricao`, `imagem`, `data_criacao`, `data_modificacao`, `fkUsuario`) VALUES
	(1, 'Java Como Programar', 'Deitel', 'Cientifico', '1099', 45000, '10ed', 12, 'Bom', 'Teste.img', '2020-08-18 15:12:36', NULL, 1),
	(2, '1', 'C# como Programar', '1', '1999', 45000, 'Teste', 45000, '0', 'img.jgp', '2020-08-19 13:07:18', NULL, 1);
/*!40000 ALTER TABLE `livro` ENABLE KEYS */;

-- Dumping structure for table bookapp-bd.livros_venda
CREATE TABLE IF NOT EXISTS `livros_venda` (
  `pkLivroVenda` int(11) NOT NULL AUTO_INCREMENT,
  `fkLivro` int(11) DEFAULT NULL,
  `nomeLivro` varchar(50) DEFAULT NULL,
  `fkUsuario` int(11) DEFAULT NULL,
  `usuario` varchar(50) DEFAULT NULL,
  `preco` double DEFAULT NULL,
  `data_pub_venda` datetime DEFAULT NULL,
  `status_` int(11) DEFAULT NULL,
  KEY `Index 1` (`pkLivroVenda`),
  KEY `FK__livro` (`fkLivro`),
  KEY `FK__usuario` (`fkUsuario`),
  CONSTRAINT `FK__livro` FOREIGN KEY (`fkLivro`) REFERENCES `livro` (`pkLivro`),
  CONSTRAINT `FK__usuario` FOREIGN KEY (`fkUsuario`) REFERENCES `usuario` (`pkUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dumping data for table bookapp-bd.livros_venda: ~1 rows (approximately)
/*!40000 ALTER TABLE `livros_venda` DISABLE KEYS */;
INSERT INTO `livros_venda` (`pkLivroVenda`, `fkLivro`, `nomeLivro`, `fkUsuario`, `usuario`, `preco`, `data_pub_venda`, `status_`) VALUES
	(1, 1, 'Java como Programar', 1, 'Jeson Neto', 45000, '2020-08-18 15:20:05', 1);
/*!40000 ALTER TABLE `livros_venda` ENABLE KEYS */;

-- Dumping structure for procedure bookapp-bd.STPLIVROS_VENDA_INSERT_UPDATE
DELIMITER //
CREATE PROCEDURE `STPLIVROS_VENDA_INSERT_UPDATE`(
	IN `pkLivroVenda` INT(11),
	IN `fkLivro` INT(11),
	IN `nomeLivro` VARCHAR(50),
	IN `fkUsuario` INT(11),
	IN `usuario` VARCHAR(50),
	IN `preco` DOUBLE
)
BEGIN
  	
  	if( pkLivroVenda=0 ) then 
    
      INSERT INTO livros_venda (`pkLivroVenda`,`fkLivro`,`nomeLivro`,`fkUsuario`,`usuario`,`preco`,`data_pub_venda`,`status_`)
      				VALUES       (NULL          ,  fkLivro,nomeLivro,fkUsuario,usuario,preco, NOW() , 1);
    
    else
    	
    	  UPDATE livros_venda SET livros_venda.fkUsuario = fkUsuario, livros_venda.nomeLivro = nomeLivro,livros_venda.usuario=usuario,livros_venda.preco=preco 
    	                      WHERE livros_venda.pkLivroVenda = pkLivroVenda;
     
    END if;
     
END//
DELIMITER ;

-- Dumping structure for procedure bookapp-bd.STP_Leitor_INSERT_UPDATE
DELIMITER //
CREATE PROCEDURE `STP_Leitor_INSERT_UPDATE`(
	IN `pkLeitor` INT(11),
	IN `nome` VARCHAR(50),
	IN `bi` VARCHAR(50),
	IN `endereco` VARCHAR(50),
	IN `telefone` VARCHAR(50),
	IN `email` VARCHAR(50),
	IN `senha` VARCHAR(50),
    IN `foto` VARCHAR(150)
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
    INSERT INTO `leitor`(`pkLeitor`, `nome`, `bi`, `endereco`, `telefone1`, telefone2,`email`, `data_criacao`, `data_modificacao`, `status_`) VALUES (null,nome,bi,endereco,telefone1,telefone2,email,now(),now(),1);
    SET @pkLeitor = LAST_INSERT_ID();
    INSERT INTO usuario (pkUsuario, `username`,`email`,`password`,`idUsuario`,`tipoUsuario`,`data_criacao`,`data_modificacao`,`status_`,foto)
				VALUES  (null,nome,email,senha,@pkLeitor,1,now(),now(),1,foto);
select leitor.pkLeitor, leitor.nome, leitor.bi, leitor.endereco, leitor.telefone1, leitor.telefone2,leitor.email from leitor order by leitor.pkLeitor desc limit 1;
	 
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
	IN `senha` VARCHAR(50),
    IN `foto` VARCHAR(150)
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
    
    		INSERT INTO livraria (`nome`,`nif`,`endereco`,`email`,`telefone1`,`telefone2`,`data_criacao`,`data_modificacao`,`status_`)
				 VALUES  ( nome , nif, endereco , email , telefone1 , telefone2 , NOW()      ,   now()            ,   1 );
    		SET @pkLivraria = LAST_INSERT_ID();
    		INSERT INTO usuario (`username`,`email`,`password`,`idUsuario`,`tipoUsuario`,`data_criacao`,`data_modificacao`,`status_`,foto)
				VALUES  ( nome    ,  email ,  senha, @pkLivraria , 2          ,  NOW()       ,  now()           , 1,foto );
                select livraria.pkLivraria,livraria.nome,livraria.nif,livraria.endereco,livraria.email,livraria.telefone1,livraria.telefone2 from livraria order by livraria.pkLivraria desc limit 1;

	  END if;            
   	
 COMMIT WORK;  
END//
DELIMITER ;

-- Dumping structure for procedure bookapp-bd.STP_LIVRO_INSERT_UPDATE
DELIMITER //
CREATE PROCEDURE `STP_LIVRO_INSERT_UPDATE`(
	IN `pkLivro` INT(11),
	IN `titulo` VARCHAR(50),
	IN `autor` VARCHAR(50),
	IN `genero` VARCHAR(50),
	IN `paginas` INT(11),
	IN `preco` double,
	IN `publicacao` VARCHAR(50),
	IN `paragrafo` INT(11),
	IN `descricao` double,
	IN `imagem` VARCHAR(50),
	IN `fkUsuario` INT(11)
)
BEGIN 
    if(pkLivro=0) then    
   INSERT INTO livro(pkLivro, titulo, autor, genero, paginas, preco, publicacao, paragrafo, descricao, imagem,data_criacao,data_modificacao,fkUsuario) 
   VALUES (null,titulo,autor,genero,paginas,preco,publicacao,paragrafo,descricao,imagem, now(),null,fkUsuario);    
    			  END if;            
   	 
END//
DELIMITER ;

-- Dumping structure for table bookapp-bd.usuario
CREATE TABLE IF NOT EXISTS `usuario` (
  `pkUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `telefone` varchar(50) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `tipoUsuario` int(11) NOT NULL,
  `data_criacao` datetime NOT NULL,
  `data_modificacao` datetime DEFAULT NULL,
  `status_` int(11) NOT NULL,
  `foto` varchar(150) NOT NULL,
  KEY `Index 1` (`pkUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dumping data for table bookapp-bd.usuario: ~1 rows (approximately)
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` (`pkUsuario`, `username`, `email`, `password`, `telefone`, `idUsuario`, `tipoUsuario`, `data_criacao`, `data_modificacao`, `status_`) VALUES
	(1, 'Jelson Neto', 'jelsonneto94@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '941926369', 4, 2, '2020-08-15 16:06:11', NULL, 1);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
