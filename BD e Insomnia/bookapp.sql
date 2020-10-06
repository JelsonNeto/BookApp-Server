-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Tempo de geração: 06-Out-2020 às 10:04
-- Versão do servidor: 10.4.11-MariaDB
-- versão do PHP: 7.3.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `bookapp`
--

DELIMITER $$
--
-- Procedimentos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `STPCHANGE_AVATAR` (IN `id_usuario` INT(11), IN `tipoUsuario` INT(11), IN `avatar` VARCHAR(120))  BEGIN 

	DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING
    
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 errno = MYSQL_ERRNO;
    -- SELECT errno AS MYSQL_ERROR;
    SHOW WARNINGS;
    ROLLBACK;
    END;
    
    
    START TRANSACTION;
    
    
    UPDATE usuario SET `avatar` =  avatar WHERE usuario.`idUsuario` = id_usuario AND usuario.`tipoUsuario` = tipoUsuario;
    
    
          
    UPDATE seguidores SET `avatar_seguidor` =  avatar WHERE seguidores.`id_seguidor` = id_usuario ;
    

    
      

				
    
            
   	
 COMMIT WORK;  
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `STPLIVROS_VENDA_INSERT_UPDATE` (IN `pkLivroVenda` INT(11), IN `fkLivro` INT(11), IN `nomeLivro` VARCHAR(50), IN `fkUsuario` INT(11), IN `usuario` VARCHAR(50), IN `preco` DOUBLE)  BEGIN
  	
  	if( pkLivroVenda=0 ) then 
    
      INSERT INTO livros_venda (`pkLivroVenda`,`fkLivro`,`nomeLivro`,`fkUsuario`,`usuario`,`preco`,`data_pub_venda`,`status_`)
      				VALUES       (NULL          ,  fkLivro,nomeLivro,fkUsuario,usuario,preco, NOW() , 1);
    
    else
    	
    	  UPDATE livros_venda SET livros_venda.fkUsuario = fkUsuario, livros_venda.nomeLivro = nomeLivro,livros_venda.usuario=usuario,livros_venda.preco=preco 
    	                      WHERE livros_venda.pkLivroVenda = pkLivroVenda;
     
    END if;
     
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `STPSEGUIDOR_INSERT_UPDATE` (IN `id_seguidor` INT(11), IN `id_seguindo` INT(11), IN `avatar_seguidor` VARCHAR(120), IN `username` VARCHAR(50))  BEGIN 

	DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING
    
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 errno = MYSQL_ERRNO;
    -- SELECT errno AS MYSQL_ERROR;
    SHOW WARNINGS;
    ROLLBACK;
    END;
    
    
    START TRANSACTION;
    
    
    
        INSERT INTO seguidores(`id_seguidor`,`id_seguindo`,`avatar_seguidor`,`username`)
      	VALUES (id_seguidor,id_seguindo,avatar_seguidor,username);

				
    
            
   	
 COMMIT WORK;  
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `STP_Leitor_INSERT_UPDATE` (IN `pkLeitor` INT(11), IN `nome` VARCHAR(50), IN `bi` VARCHAR(50), IN `endereco` VARCHAR(50), IN `telefone1` VARCHAR(50), IN `telefone2` VARCHAR(50), IN `email` VARCHAR(50), IN `senha` VARCHAR(50))  BEGIN
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
    INSERT INTO leitor(`nome`, `bi`, `endereco`, `telefone1`,`telefone2`,`email`, `data_criacao`, `data_modificacao`, `status_`) 
    VALUES (nome,bi,endereco,telefone1,telefone2,email,now(),now(),1);
    SET @pkLeitor = LAST_INSERT_ID();
    INSERT INTO usuario (`username`,`email`,`password`,`telefone`,`idUsuario`,`tipoUsuario`,`data_criacao`,`data_modificacao`,`status_`)
				VALUES  (nome,email,senha, telefone1 , @pkLeitor,1,now(),now(),1);
				


	 
    end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `STP_LIVRARIA_INSERT_UPDATE` (IN `pkLivraria` INT(11), IN `nome` VARCHAR(50), IN `nif` VARCHAR(50), IN `endereco` VARCHAR(50), IN `email` VARCHAR(50), IN `telefone1` VARCHAR(50), IN `telefone2` VARCHAR(50), IN `senha` VARCHAR(50))  BEGIN 

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
    		
    		INSERT INTO usuario (`pkUsuario`,`username`,`email`,`password`, `telefone` , `idUsuario`,`tipoUsuario`,`data_criacao`,`data_modificacao`,`status_`)
							VALUES  ( NULL      ,  nome    ,  email ,  senha   ,telefone1, @pkLivraria , 2          ,  NOW()       ,  NULL             , 1 );
							
	 
	  END if;            
   	
 COMMIT WORK;  
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `STP_LIVRO_INSERT_UPDATE` (IN `pkLivro` INT(11), IN `titulo` VARCHAR(50), IN `autor` VARCHAR(50), IN `genero` VARCHAR(50), IN `paginas` INT(11), IN `preco` DOUBLE, IN `publicacao` VARCHAR(50), IN `paragrafo` INT(11), IN `descricao` TEXT, IN `imagem` VARCHAR(50), IN `fkUsuario` INT(11))  BEGIN 
    if(pkLivro=0) then    
   INSERT INTO livro(pkLivro, titulo, autor, genero, paginas, preco, publicacao, paragrafo, descricao, imagem,data_criacao,data_modificacao,fkUsuario) 
   VALUES (null,titulo,autor,genero,paginas,preco,publicacao,paragrafo,descricao,imagem, now(),null,fkUsuario);    
    			  END if;            
   	 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `STP_POST_INSERT_UPDATE` (`pkPosts` INT(11), `title` VARCHAR(120), `content` TEXT, `image` VARCHAR(120), `username` VARCHAR(120), `idUsuario` INT(11))  BEGIN 

	DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING
    
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 errno = MYSQL_ERRNO;
    -- SELECT errno AS MYSQL_ERROR;
    SHOW WARNINGS;
    ROLLBACK;
    END;
    
    
    START TRANSACTION;
    
       if(pkPosts=0) then
       
       INSERT INTO posts(`title`,`content`,`image`,`idUsuario`,`username`) VALUES (title,content,image,idUsuario,username);
       
      end if;
    
      

    
      

				
    
            
   	
 COMMIT WORK;  
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `leitor`
--

CREATE TABLE `leitor` (
  `pkLeitor` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `bi` varchar(50) NOT NULL,
  `endereco` varchar(50) DEFAULT NULL,
  `telefone1` varchar(50) NOT NULL DEFAULT '',
  `telefone2` varchar(50) DEFAULT '',
  `email` varchar(50) DEFAULT NULL,
  `data_criacao` datetime DEFAULT NULL,
  `data_modificacao` datetime NOT NULL,
  `status_` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `leitor`
--

INSERT INTO `leitor` (`pkLeitor`, `nome`, `bi`, `endereco`, `telefone1`, `telefone2`, `email`, `data_criacao`, `data_modificacao`, `status_`) VALUES
(3, 'Edro Viegas', '000', 'Luanda', '996848399', '923422322', 'edro@gmail.com', '2020-09-05 11:09:46', '2020-09-05 11:09:46', 1),
(4, 'Edro Viegas', '000', 'Luanda', '996848399', '923422322', 'edro@gmail.com', '2020-09-05 11:11:36', '2020-09-05 11:11:36', 1),
(5, 'Edro Costa', '000', 'Luanda', '996848397', '923422323', 'edrocosta@gmail.com', '2020-09-05 11:12:53', '2020-09-05 11:12:53', 1),
(6, 'Edro Costa', '000', 'Luanda', '996848397', '923422323', 'edrocosta@gmail.com', '2020-09-05 11:14:40', '2020-09-05 11:14:40', 1),
(8, 'Edro Costa', '000', 'Luanda', '996848397', '923422323', 'edrocosta@gmail.com', '2020-09-05 11:18:02', '2020-09-05 11:18:02', 1),
(20, 'Edro Costa', '000', 'Luanda', '996848397', '923422323', 'edrocosta@gmail.com', '2020-09-05 11:50:54', '2020-09-05 11:50:54', 1),
(22, 'Edro Costa', '000', 'Luanda', '996848397', '923422323', 'edrocosta@gmail.com', '2020-09-05 12:41:20', '2020-09-05 12:41:20', 1),
(24, 'Edro Costa', '000', 'Luanda', '996848397', '923422323', 'edrocosta@gmail.com', '2020-09-05 13:04:31', '2020-09-05 13:04:31', 1),
(32, 'Edro Costa', '000', 'Luanda', '996848397', '923422323', 'edrocosta@gmail.com', '2020-09-05 13:13:38', '2020-09-05 13:13:38', 1),
(35, 'Edro Costa', '000', 'Luanda', '996848397', '923422323', 'edrocosta@gmail.com', '2020-09-05 13:15:52', '2020-09-05 13:15:52', 1),
(55, 'Edro Costa', '000', 'Luanda', '996848397', '923422323', 'edrocosta@gmail.com', '2020-09-05 16:04:06', '2020-09-05 16:04:06', 1),
(67, 'Edro Costa', '000', 'Luanda', '996848397', '923422323', 'edrocosta@gmail.com', '2020-09-05 16:52:39', '2020-09-05 16:52:39', 1),
(73, 'Edro Costa', '000', 'Luanda', '996848397', '923422323', 'edrocosta@gmail.com', '2020-09-05 18:16:49', '2020-09-05 18:16:49', 1),
(81, 'Edro Costa', '000', 'Luanda', '996848397', '923422323', 'edrocosta@gmail.com', '2020-09-05 18:20:11', '2020-09-05 18:20:11', 1),
(96, 'Edro Costa', '000', 'Luanda', '996848397', '923422323', 'edrocosta@gmail.com', '2020-09-05 19:25:46', '2020-09-05 19:25:46', 1),
(97, 'Edro Costa', '000', 'Luanda', '996848000', '923422323', 'edrocosta@gmail.com', '2020-09-05 19:25:56', '2020-09-05 19:25:56', 1),
(98, 'Edro Costa', '000', 'Luanda', '996848000', '923422323', 'edrocosta@gmail.com', '2020-09-05 19:25:57', '2020-09-05 19:25:57', 1),
(99, 'Edro Costa', '000', 'Luanda', '996848000', '923422323', 'edrocosta@gmail.com', '2020-09-05 19:25:58', '2020-09-05 19:25:58', 1),
(100, 'Edro Costa', '000', 'Luanda', '996848000', '923422323', 'edrocosta@gmail.com', '2020-09-05 19:25:59', '2020-09-05 19:25:59', 1),
(101, 'Edro Costa', '000', 'Luanda', '996848000', '923422323', 'edrocosta@gmail.com', '2020-09-05 19:26:00', '2020-09-05 19:26:00', 1),
(102, 'Edro Costa', '000', 'Luanda', '99680000', '923422323', 'edrocosta@gmail.com', '2020-09-05 19:26:09', '2020-09-05 19:26:09', 1),
(103, 'Edro Costa', '000', 'Luanda', '99680000', '923422323', 'edrocosta@gmail.com', '2020-09-05 19:26:10', '2020-09-05 19:26:10', 1),
(104, 'Edro Costa', '000', 'Luanda', '99680000', '923422323', 'edrocosta@gmail.com', '2020-09-05 19:26:11', '2020-09-05 19:26:11', 1),
(106, 'Edro Costa 2', '000', 'Luanda', '99680000', '923422323', 'edrocosta@gmail.com', '2020-09-05 19:27:51', '2020-09-05 19:27:51', 1),
(108, 'Edro Costa', '000', 'Luanda', '99680000', '923422323', 'edrocosta@gmail.com', '2020-09-05 19:28:42', '2020-09-05 19:28:42', 1),
(112, 'Edro Viegas', '000', 'Luanda', '99680000', '923422323', 'edrocosta34@gmail.com', '2020-09-05 19:32:01', '2020-09-05 19:32:01', 1),
(113, 'Edro Costa', '000', 'Luanda', '99680000', '923422323', 'edrocosta34@gmail.com', '2020-09-05 22:38:11', '2020-09-05 22:38:11', 1),
(116, 'Edro Costa', '000', 'Luanda', '996848399', '923422323', 'edrocosta348@gmail.com', '2020-09-06 19:20:50', '2020-09-06 19:20:50', 1),
(117, 'Edro Costa', '000', 'Luanda', '996848399', '923422323', 'edrocosta348@gmail.com', '2020-09-06 19:21:01', '2020-09-06 19:21:01', 1),
(119, 'Edro Costa', '000', 'Luanda', '996848399', '923422323', 'edrocosta348@gmail.com', '2020-09-06 19:22:58', '2020-09-06 19:22:58', 1),
(121, 'Edro Costa', '000', 'Luanda', '996848399', '923422323', 'edrocosta348@gmail.com', '2020-09-07 14:32:33', '2020-09-07 14:32:33', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `livraria`
--

CREATE TABLE `livraria` (
  `pkLivraria` int(11) NOT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `nif` varchar(50) DEFAULT NULL,
  `endereco` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `telefone1` varchar(50) DEFAULT NULL,
  `telefone2` varchar(50) DEFAULT NULL,
  `data_criacao` datetime DEFAULT NULL,
  `data_modificacao` datetime DEFAULT NULL,
  `status_` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `livraria`
--

INSERT INTO `livraria` (`pkLivraria`, `nome`, `nif`, `endereco`, `email`, `telefone1`, `telefone2`, `data_criacao`, `data_modificacao`, `status_`) VALUES
(57, 'Livraria Gente Culta', '6545565667', 'Luanda, 1 de Maio , Chamavo', 'genteculta1@gmail.com', '996848399', '935678965', '2020-09-08 17:41:13', NULL, 1),
(58, 'Irmas Paulinas', '203938484774', 'Luanda, Avenida Deolinda Rodrigues', 'paulinas@gmail.com', '996232402', '934567899', '2020-09-09 16:09:55', NULL, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `livro`
--

CREATE TABLE `livro` (
  `pkLivro` int(11) NOT NULL,
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
  `fkUsuario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `livro`
--

INSERT INTO `livro` (`pkLivro`, `titulo`, `autor`, `genero`, `paginas`, `preco`, `publicacao`, `paragrafo`, `descricao`, `imagem`, `data_criacao`, `data_modificacao`, `fkUsuario`) VALUES
(1, 'Java Como Programar', 'Deitel', 'Cientifico', '1099', 45000, '10ed', 12, 'Bom', 'Teste.img', '2020-08-18 15:12:36', NULL, 1),
(2, '1', 'C# como Programar', '1', '1999', 45000, 'Teste', 45000, '0', 'img.jgp', '2020-08-19 13:07:18', NULL, 1),
(4, 'Luanda', 'AG', 'lITERATURA', '12', 3456, 'Porto Editora', 0, ' hjhshsjhjskhjshks ', 'default.png', '2020-09-19 20:34:31', NULL, 58),
(5, 'Luanda', 'AG', 'lITERATURA', '12', 3456, 'Porto Editora', 0, ' hjhshsjhjskhjshks ', 'default.png', '2020-09-19 20:36:47', NULL, 58),
(6, 'Luanda', 'AG', 'lITERATURA', '12', 3456, 'Porto Editora', 0, 'hjhshsjhjskhjshks ', 'default.png', '2020-09-19 20:43:29', NULL, 58),
(7, 'Luanda', 'AG', 'lITERATURA', '12', 3456, 'Porto Editora', 0, 'hjhshsjhjskhjshks ', 'default.png', '2020-09-19 20:43:47', NULL, 58),
(8, 'Luanda', 'AG', 'lITERATURA', '12', 3456, 'Porto Editora', 0, 'hjhshsjhjskhjshks ', 'default.png', '2020-09-19 20:49:35', NULL, 58),
(9, 'Luanda', 'AG', 'lITERATURA', '12', 3456, 'Porto Editora', 0, 'hjhshsjhjskhjshks ', 'default.png', '2020-09-19 20:51:36', NULL, 58),
(10, 'Luanda', 'AG', 'lITERATURA', '12', 3456, 'Porto Editora', 0, 'hjhshsjhjskhjshks ', 'default.png', '2020-09-19 20:51:47', NULL, 58),
(11, 'Luanda', 'AG', 'lITERATURA', '12', 3456, 'Porto Editora', 0, 'hjhshsjhjskhjshks ', 'default.png', '2020-09-25 12:24:41', NULL, 58),
(12, 'Luanda', 'AG', 'lITERATURA', '12', 3456, 'Porto Editora', 0, 'hjhshsjhjskhjshks ', 'default.png', '2020-09-25 13:14:04', NULL, 58),
(13, 'Luanda', 'AG', 'lITERATURA', '12', 3456, 'Porto Editora', 0, 'hjhshsjhjskhjshks ', 'default.png', '2020-09-25 13:14:28', NULL, 58),
(14, 'Caluanda', 'Pepetela', 'Contos', '123', 3009, 'Porto Editora', 0, 'Contos sobre uma vida cheia de Esperanza...', NULL, '2020-09-25 13:20:25', NULL, 57),
(15, 'Caluanda', 'Pepetela', 'Contos', '123', 3009, 'Porto Editora', 0, 'Contos sobre uma vida cheia de Esperanza...', NULL, '2020-09-25 13:20:42', NULL, 57),
(16, 'Caluanda', 'Pepetela', 'Contos', '123', 3009, 'Porto Editora', 0, 'Contos sobre uma vida cheia de Esperanza...', NULL, '2020-09-25 13:36:12', NULL, 57),
(17, 'Caluanda', 'Pepetela', 'Contos', '123', 3009, 'Porto Editora', 0, 'Contos sobre uma vida cheia de Esperanza...', NULL, '2020-09-25 13:36:19', NULL, 57),
(18, 'Caluanda', 'Pepetela', 'Contos', '123', 3009, 'Porto Editora', 0, 'Contos sobre uma vida cheia de Esperanza...', NULL, '2020-09-25 13:36:59', NULL, 57),
(19, 'Caluanda', 'Pepetela', 'Contos', '123', 3009, 'Porto Editora', 0, 'Contos sobre uma vida cheia de Esperanza...', NULL, '2020-09-25 13:42:07', NULL, 57),
(20, 'Viagem no tempo', 'Carl Sagan', 'Ficcao', '234', 3000.89, 'Sextante', 0, NULL, NULL, '2020-09-25 15:09:57', NULL, 57),
(21, 'Quem me Dera ser Onda', 'Luandino Viera', 'Romance', '200', 3450.78, 'Acacias', 0, 'Uma livro interessante', NULL, '2020-09-25 15:32:28', NULL, 57),
(22, 'Luanda', 'AG', 'lITERATURA', '12', 3456, 'Porto Editora', 0, 'hjhshsjhjskhjshks ', 'default.png', '2020-10-06 08:58:32', NULL, 58),
(23, 'A culpa e das estrelas', 'AG', 'lITERATURA', '12', 3456, 'Porto Editora', 0, 'hjhshsjhjskhjshks ', 'default.png', '2020-10-06 08:58:58', NULL, 58);

-- --------------------------------------------------------

--
-- Estrutura da tabela `livros_venda`
--

CREATE TABLE `livros_venda` (
  `pkLivroVenda` int(11) NOT NULL,
  `fkLivro` int(11) DEFAULT NULL,
  `nomeLivro` varchar(50) DEFAULT NULL,
  `fkUsuario` int(11) DEFAULT NULL,
  `usuario` varchar(50) DEFAULT NULL,
  `preco` double DEFAULT NULL,
  `data_pub_venda` datetime DEFAULT NULL,
  `status_` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `livros_venda`
--

INSERT INTO `livros_venda` (`pkLivroVenda`, `fkLivro`, `nomeLivro`, `fkUsuario`, `usuario`, `preco`, `data_pub_venda`, `status_`) VALUES
(1, 1, 'Java como Programar', 1, 'Jeson Neto', 45000, '2020-08-18 15:20:05', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `posts`
--

CREATE TABLE `posts` (
  `pkPosts` int(11) UNSIGNED NOT NULL,
  `idUsuario` int(11) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `title` varchar(120) DEFAULT NULL,
  `image` varchar(120) NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT 1,
  `username` varchar(120) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `posts`
--

INSERT INTO `posts` (`pkPosts`, `idUsuario`, `content`, `created_at`, `title`, `image`, `status`, `username`) VALUES
(1, 58, 'Abertura de nova loja', '2020-09-12 17:50:37', 'Abertura', '', 1, ''),
(2, 58, 'Conteudo do content', '2020-09-12 18:47:03', 'Divulgacao', 'default_post_image.jpg', 1, 'Livraria Irmas Paulina'),
(3, 12, 'Abertura de nova Livraria', '2020-09-12 19:04:32', 'Abertura', 'default_post.jpg', 1, 'Livraria Gente Culta'),
(4, 12, 'Abertura de nova Livraria', '2020-09-12 21:01:18', 'Abertura', 'e1a8e0d629f5a1cfc753d3dda2c088ee.jpg', 1, 'Livraria Gente Culta');

-- --------------------------------------------------------

--
-- Estrutura da tabela `seguidores`
--

CREATE TABLE `seguidores` (
  `id_seguidor` int(11) UNSIGNED NOT NULL,
  `id_seguindo` int(11) DEFAULT NULL,
  `avatar_seguidor` varchar(120) DEFAULT NULL,
  `username` varchar(120) DEFAULT NULL,
  `data` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `seguidores`
--

INSERT INTO `seguidores` (`id_seguidor`, `id_seguindo`, `avatar_seguidor`, `username`, `data`) VALUES
(12, 58, 'f93707949c9efaa8cfe5ea23842b1e0b.jpg', 'Edro Viegas', '2020-09-10 19:39:32');

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuario`
--

CREATE TABLE `usuario` (
  `pkUsuario` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `telefone` varchar(50) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `tipoUsuario` int(11) NOT NULL,
  `data_criacao` datetime NOT NULL,
  `data_modificacao` datetime DEFAULT NULL,
  `status_` int(11) NOT NULL,
  `avatar` varchar(120) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `usuario`
--

INSERT INTO `usuario` (`pkUsuario`, `username`, `email`, `password`, `telefone`, `idUsuario`, `tipoUsuario`, `data_criacao`, `data_modificacao`, `status_`, `avatar`) VALUES
(1, 'Jelson Neto', 'jelsonneto94@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '941926369', 4, 2, '2020-08-15 16:06:11', NULL, 1, NULL),
(2, 'Edro Viegas', 'edro@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '996848399', 9, 2, '2020-09-04 14:40:52', NULL, 1, NULL),
(3, 'Gente Culta', 'edro@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '996848399', 10, 2, '2020-09-04 14:54:23', NULL, 1, NULL),
(4, 'Gente Culta', 'edro@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '996848399', 11, 2, '2020-09-04 14:54:24', NULL, 1, NULL),
(5, 'Gente Culta', 'edro@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '934533668', 12, 2, '2020-09-05 10:29:21', NULL, 1, 'f93707949c9efaa8cfe5ea23842b1e0b.jpg'),
(6, 'Edro Viegas', 'edro@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '996848399', 1, 1, '2020-09-05 10:59:47', '2020-09-05 10:59:47', 1, NULL),
(8, 'Edro Viegas', 'edro@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '996848399', 3, 1, '2020-09-05 11:09:46', '2020-09-05 11:09:46', 1, NULL),
(9, 'Edro Viegas', 'edro@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '996848399', 4, 1, '2020-09-05 11:11:36', '2020-09-05 11:11:36', 1, NULL),
(10, 'Edro Costa', 'edrocosta@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '996848397', 5, 1, '2020-09-05 11:12:53', '2020-09-05 11:12:53', 1, NULL),
(11, 'Edro Costa', 'edrocosta@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '996848397', 6, 1, '2020-09-05 11:14:40', '2020-09-05 11:14:40', 1, NULL),
(13, 'Edro Costa', 'edrocosta@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '996848397', 8, 1, '2020-09-05 11:18:02', '2020-09-05 11:18:02', 1, NULL),
(20, 'Gente Culta', 'edro@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '934533668', 13, 2, '2020-09-05 11:44:39', NULL, 1, NULL),
(26, 'Edro Costa', 'edrocosta@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '996848397', 20, 1, '2020-09-05 11:50:54', '2020-09-05 11:50:54', 1, NULL),
(28, 'Edro Costa', 'edrocosta@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '996848397', 22, 1, '2020-09-05 12:41:20', '2020-09-05 12:41:20', 1, NULL),
(30, 'Edro Costa', 'edrocosta@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '996848397', 24, 1, '2020-09-05 13:04:31', '2020-09-05 13:04:31', 1, NULL),
(38, 'Edro Costa', 'edrocosta@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '996848397', 32, 1, '2020-09-05 13:13:38', '2020-09-05 13:13:38', 1, NULL),
(41, 'Edro Costa', 'edrocosta@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '996848397', 35, 1, '2020-09-05 13:15:52', '2020-09-05 13:15:52', 1, NULL),
(61, 'Edro Costa', 'edrocosta@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '996848397', 55, 1, '2020-09-05 16:04:06', '2020-09-05 16:04:06', 1, NULL),
(62, 'Gente Culta', 'edro@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '934533668', 14, 2, '2020-09-05 16:06:00', NULL, 1, NULL),
(63, 'Gente Culta', 'edro@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '934533668', 15, 2, '2020-09-05 16:07:21', NULL, 1, NULL),
(64, 'Gente Culta', 'edro@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '934533668', 16, 2, '2020-09-05 16:12:16', NULL, 1, NULL),
(65, 'Gente Culta', 'edro@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '934533668', 17, 2, '2020-09-05 16:17:21', NULL, 1, NULL),
(66, 'Gente Culta', 'edro@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '934533668', 18, 2, '2020-09-05 16:21:17', NULL, 1, NULL),
(78, 'Gente Culta', 'edro@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '934533668', 19, 2, '2020-09-05 16:51:45', NULL, 1, NULL),
(79, 'Edro Costa', 'edrocosta@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '996848397', 67, 1, '2020-09-05 16:52:39', '2020-09-05 16:52:39', 1, NULL),
(80, 'Gente Culta', 'edro@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '934533668', 20, 2, '2020-09-05 16:52:50', NULL, 1, NULL),
(86, 'Edro Costa', 'edrocosta@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '996848397', 73, 1, '2020-09-05 18:16:49', '2020-09-05 18:16:49', 1, NULL),
(94, 'Edro Costa', 'edrocosta@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '996848397', 81, 1, '2020-09-05 18:20:11', '2020-09-05 18:20:11', 1, NULL),
(109, 'Gente Culta', 'edro@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '934533668', 21, 2, '2020-09-05 19:24:26', NULL, 1, NULL),
(110, 'Gente Culta', 'edro@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '934533600', 22, 2, '2020-09-05 19:24:40', NULL, 1, NULL),
(111, 'Gente Culta', 'edro@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '934533601', 23, 2, '2020-09-05 19:24:46', NULL, 1, NULL),
(112, 'Gente Culta', 'edro@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '934333601', 24, 2, '2020-09-05 19:25:01', NULL, 1, NULL),
(113, 'Edro Costa', 'edrocosta@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '996848397', 96, 1, '2020-09-05 19:25:46', '2020-09-05 19:25:46', 1, NULL),
(114, 'Edro Costa', 'edrocosta@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '996848000', 97, 1, '2020-09-05 19:25:56', '2020-09-05 19:25:56', 1, NULL),
(115, 'Edro Costa', 'edrocosta@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '996848000', 98, 1, '2020-09-05 19:25:57', '2020-09-05 19:25:57', 1, NULL),
(116, 'Edro Costa', 'edrocosta@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '996848000', 99, 1, '2020-09-05 19:25:58', '2020-09-05 19:25:58', 1, NULL),
(117, 'Edro Costa', 'edrocosta@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '996848000', 100, 1, '2020-09-05 19:25:59', '2020-09-05 19:25:59', 1, NULL),
(118, 'Edro Costa', 'edrocosta@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '996848000', 101, 1, '2020-09-05 19:26:00', '2020-09-05 19:26:00', 1, NULL),
(119, 'Edro Costa', 'edrocosta@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '99680000', 102, 1, '2020-09-05 19:26:09', '2020-09-05 19:26:09', 1, NULL),
(120, 'Edro Costa', 'edrocosta@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '99680000', 103, 1, '2020-09-05 19:26:10', '2020-09-05 19:26:10', 1, NULL),
(121, 'Edro Costa', 'edrocosta@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '99680000', 104, 1, '2020-09-05 19:26:11', '2020-09-05 19:26:11', 1, NULL),
(123, 'Edro Costa', 'edrocosta@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '99680000', 106, 1, '2020-09-05 19:27:51', '2020-09-05 19:27:51', 1, NULL),
(125, 'Edro Costa', 'edrocosta@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '99680000', 108, 1, '2020-09-05 19:28:42', '2020-09-05 19:28:42', 1, NULL),
(129, 'Edro Costa', 'edrocosta34@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '99680000', 112, 1, '2020-09-05 19:32:01', '2020-09-05 19:32:01', 1, NULL),
(130, 'Gente Culta', 'edro@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '934333601', 25, 2, '2020-09-05 19:32:08', NULL, 1, NULL),
(131, 'Gente Culta', 'edro@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '934333601', 26, 2, '2020-09-05 22:27:31', NULL, 1, NULL),
(132, 'Edro Costa', 'edrocosta34@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '99680000', 113, 1, '2020-09-05 22:38:11', '2020-09-05 22:38:11', 1, NULL),
(135, 'Edro Costa', 'edrocosta348@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '996848399', 116, 1, '2020-09-06 19:20:50', '2020-09-06 19:20:50', 1, NULL),
(136, 'Edro Costa', 'edrocosta348@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '996848399', 117, 1, '2020-09-06 19:21:01', '2020-09-06 19:21:01', 1, NULL),
(138, 'Edro Costa', 'edrocosta348@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '996848399', 119, 1, '2020-09-06 19:22:58', '2020-09-06 19:22:58', 1, NULL),
(139, 'Gente Culta', 'edro@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '934333601', 27, 2, '2020-09-06 19:23:07', NULL, 1, NULL),
(140, 'Pedro', 'pedro@gmail.com', '17b3c7061788dbe82de5abe9f6fe22b3', '883939939', 28, 2, '2020-09-07 14:06:13', NULL, 1, NULL),
(141, 'Gente Culta', 'aaa@gmail.com', '17b3c7061788dbe82de5abe9f6fe22b3', '877383993', 29, 2, '2020-09-07 14:21:12', NULL, 1, NULL),
(143, 'Edro Costa', 'edrocosta348@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '996848399', 121, 1, '2020-09-07 14:32:33', '2020-09-07 14:32:33', 1, NULL),
(144, 'Gente Culta', 'aaa@gmail.com', '17b3c7061788dbe82de5abe9f6fe22b3', '877383993', 30, 2, '2020-09-07 14:46:45', NULL, 1, NULL),
(145, 'Gente Culta', 'aaa@gmail.com', '17b3c7061788dbe82de5abe9f6fe22b3', '877383993', 31, 2, '2020-09-07 14:58:48', NULL, 1, NULL),
(146, 'Gente Culta', 'aaa@gmail.com', '17b3c7061788dbe82de5abe9f6fe22b3', '877383993', 32, 2, '2020-09-07 14:58:55', NULL, 1, NULL),
(147, 'Gente Culta', 'aaa@gmail.com', '17b3c7061788dbe82de5abe9f6fe22b3', '877383993', 33, 2, '2020-09-07 14:59:58', NULL, 1, NULL),
(148, 'Gente Culta', 'aaa@gmail.com', '17b3c7061788dbe82de5abe9f6fe22b3', '877383993', 34, 2, '2020-09-07 15:00:11', NULL, 1, NULL),
(149, 'Gente Culta', 'aaa@gmail.com', '17b3c7061788dbe82de5abe9f6fe22b3', '877383993', 35, 2, '2020-09-07 15:05:03', NULL, 1, NULL),
(150, 'Gente Culta', 'aaa@gmail.com', '17b3c7061788dbe82de5abe9f6fe22b3', '877383993', 36, 2, '2020-09-07 15:07:29', NULL, 1, NULL),
(151, 'Pedro', 'pedro@gmail.com', '17b3c7061788dbe82de5abe9f6fe22b3', '839938839', 37, 2, '2020-09-07 15:16:36', NULL, 1, NULL),
(152, 'Pedro', 'pedro@gmail.com', '17b3c7061788dbe82de5abe9f6fe22b3', '883873737', 38, 2, '2020-09-07 15:22:00', NULL, 1, NULL),
(153, 'Lelo', 'Lelo@gmail.com', '17b3c7061788dbe82de5abe9f6fe22b3', '849948484', 39, 2, '2020-09-07 16:28:50', NULL, 1, NULL),
(154, 'Lelo2', 'Lelo2@gmail.com', '17b3c7061788dbe82de5abe9f6fe22b3', '737637673', 40, 2, '2020-09-07 16:50:34', NULL, 1, NULL),
(157, 'Gente Culta', 'edro@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '934333601', 41, 2, '2020-09-08 00:14:23', NULL, 1, NULL),
(158, 'Gente Culta', 'edro@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '934333601', 42, 2, '2020-09-08 00:22:39', NULL, 1, NULL),
(159, 'Gente Culta', 'edro@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '934333601', 43, 2, '2020-09-08 16:15:19', NULL, 1, NULL),
(160, 'Gente Culta', 'edro@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '934333601', 46, 2, '2020-09-08 16:20:59', NULL, 1, NULL),
(161, 'Gente Culta', 'edro@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '934333601', 47, 2, '2020-09-08 16:21:19', NULL, 1, NULL),
(162, 'Livraria Gente Culta', 'genteculta@gmail.com', '17b3c7061788dbe82de5abe9f6fe22b3', '990768554', 53, 2, '2020-09-08 16:53:15', NULL, 1, NULL),
(163, 'Gente que ama ler', 'amarleitura@gmail.com', '17b3c7061788dbe82de5abe9f6fe22b3', '893833666', 54, 2, '2020-09-08 17:07:00', NULL, 1, NULL),
(164, 'Livraria Camoes', 'camoes@gmail.com', '17b3c7061788dbe82de5abe9f6fe22b3', '847788777', 55, 2, '2020-09-08 17:14:06', NULL, 1, NULL),
(165, 'Library', 'library@gmail.com', '17b3c7061788dbe82de5abe9f6fe22b3', '857758588', 56, 2, '2020-09-08 17:23:20', NULL, 1, NULL),
(166, 'Livraria Gente Culta', 'genteculta1@gmail.com', '17b3c7061788dbe82de5abe9f6fe22b3', '996848399', 57, 2, '2020-09-08 17:41:13', NULL, 1, NULL),
(167, 'Irmas Paulinas', 'paulinas@gmail.com', '17b3c7061788dbe82de5abe9f6fe22b3', '996232402', 58, 2, '2020-09-09 16:09:55', NULL, 1, 'IMAGES123.JPG');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `leitor`
--
ALTER TABLE `leitor`
  ADD KEY `Index 1` (`pkLeitor`);

--
-- Índices para tabela `livraria`
--
ALTER TABLE `livraria`
  ADD KEY `Index 1` (`pkLivraria`);

--
-- Índices para tabela `livro`
--
ALTER TABLE `livro`
  ADD PRIMARY KEY (`pkLivro`);

--
-- Índices para tabela `livros_venda`
--
ALTER TABLE `livros_venda`
  ADD KEY `Index 1` (`pkLivroVenda`),
  ADD KEY `FK__livro` (`fkLivro`),
  ADD KEY `FK__usuario` (`fkUsuario`);

--
-- Índices para tabela `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`pkPosts`);

--
-- Índices para tabela `seguidores`
--
ALTER TABLE `seguidores`
  ADD KEY `fkLivrariaSeguidores` (`id_seguindo`);

--
-- Índices para tabela `usuario`
--
ALTER TABLE `usuario`
  ADD KEY `Index 1` (`pkUsuario`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `leitor`
--
ALTER TABLE `leitor`
  MODIFY `pkLeitor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=124;

--
-- AUTO_INCREMENT de tabela `livraria`
--
ALTER TABLE `livraria`
  MODIFY `pkLivraria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT de tabela `livro`
--
ALTER TABLE `livro`
  MODIFY `pkLivro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de tabela `livros_venda`
--
ALTER TABLE `livros_venda`
  MODIFY `pkLivroVenda` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `posts`
--
ALTER TABLE `posts`
  MODIFY `pkPosts` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `usuario`
--
ALTER TABLE `usuario`
  MODIFY `pkUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=168;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `livros_venda`
--
ALTER TABLE `livros_venda`
  ADD CONSTRAINT `FK__livro` FOREIGN KEY (`fkLivro`) REFERENCES `livro` (`pkLivro`),
  ADD CONSTRAINT `FK__usuario` FOREIGN KEY (`fkUsuario`) REFERENCES `usuario` (`pkUsuario`);

--
-- Limitadores para a tabela `seguidores`
--
ALTER TABLE `seguidores`
  ADD CONSTRAINT `fkLivrariaSeguidores` FOREIGN KEY (`id_seguindo`) REFERENCES `livraria` (`pkLivraria`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
