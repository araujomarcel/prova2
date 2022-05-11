-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 11-Maio-2022 às 01:50
-- Versão do servidor: 10.4.13-MariaDB
-- versão do PHP: 7.4.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `empresa2`
--

DELIMITER $$
--
-- Procedimentos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Conta_Pedidos` (OUT `qtde` INT)  BEGIN
	DECLARE qtde_pedidos INT DEFAULT 0;
	
	SELECT COUNT(*)
	FROM pedido
	INTO qtde_pedidos;
	
	SET qtde = qtde_pedidos;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eleva_ao_quadrado` (INOUT `numero` INT)  BEGIN
	SET numero = numero * numero;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `multiplicacao` (IN `n1` INT, IN `n2` INT)  BEGIN

	SELECT n1*n2;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `retorna_soma` (IN `n1` INT, IN `n2` INT, OUT `R` INT)  BEGIN

set	R=n1+n2;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `selecionar_produto` (IN `quantidade` INT)  BEGIN
	SELECT * 
	FROM produto
	LIMIT quantidade;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `soma` (IN `n1` INT, IN `n2` INT)  BEGIN
	SELECT n1+n2;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `total` ()  BEGIN
	
	
	SELECT b.idproduto,p.descricao,  SUM(b.quantidade)  AS qtdtotal
	FROM  item b, produto p
	WHERE b.idpedido=p.id
	GROUP BY 1,2;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `totalcliente` ()  begin

SELECT p.id, c.nome, sum(i.quantidade * i.precounitario ) AS qtdtotal
 FROM pedido p , cliente c , item i
 WHERE p.id=c.id AND p.id = i.idpedido
 GROUP BY 1,2;
 
 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `venda_mes_ano` (IN `mes` INT, IN `ano` INT)  BEGIN 
	
	SELECT MONTH (a.datemissao) as mes, sum(b.quantidade * b.precounitario) AS pedido
	FROM pedido a , item b
	WHERE a.id = b.idpedido AND YEAR (a.datemissao) = ano AND MONTH (a.datemissao) = mes
	GROUP BY 1;
END$$

--
-- Funções
--
CREATE DEFINER=`root`@`localhost` FUNCTION `message` (`TEXT` CHAR(70)) RETURNS CHAR(100) CHARSET latin1 BEGIN	


RETURN CONCAT ('Olá, ' , TEXT , '!');


END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `cargo`
--

CREATE TABLE `cargo` (
  `id` int(11) NOT NULL,
  `descricao` varchar(40) NOT NULL,
  `salario` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `cargo`
--

INSERT INTO `cargo` (`id`, `descricao`, `salario`) VALUES
(1, 'GERENTE', '12500.00'),
(2, 'ENGENHEIRO', '8000.00'),
(3, 'SUPERVISOR', '3000.00'),
(4, 'OPERARIO', '2000.00'),
(5, 'VENDEDOR', '5000.00');

-- --------------------------------------------------------

--
-- Estrutura da tabela `cliente`
--

CREATE TABLE `cliente` (
  `id` int(11) NOT NULL,
  `nome` varchar(60) NOT NULL,
  `endereco` varchar(60) NOT NULL,
  `numero` varchar(5) NOT NULL,
  `complemento` varchar(30) DEFAULT NULL,
  `bairro` varchar(40) NOT NULL,
  `municipio` varchar(40) NOT NULL,
  `cep` varchar(10) NOT NULL,
  `estado` char(2) DEFAULT NULL,
  `telefone` varchar(15) DEFAULT NULL,
  `idrepresentante` int(11) NOT NULL,
  `idregiao` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `cliente`
--

INSERT INTO `cliente` (`id`, `nome`, `endereco`, `numero`, `complemento`, `bairro`, `municipio`, `cep`, `estado`, `telefone`, `idrepresentante`, `idregiao`) VALUES
(1, 'QUALITAS IND E COMERCIO', 'RUA FELICIANO ANTUNES', '76', NULL, 'JD CHAPARRAL', 'ITAPIRA', '13843000', 'SP', '39131122', 1, 4),
(2, 'METALURGICA RL', 'AV ORESTES PRESTES', '390', NULL, 'JD LARAMO', 'ITAPIRA', '13843000', 'SP', '39134433', 1, 4),
(3, 'JF MAQUINAS E EQUIPAMENTOS', 'RUA BORBA GATO', '78', NULL, 'JD PLANALTO VERDE', 'CAMPINAS', '13843000', 'SP', '39137090', 2, 1),
(4, 'PENHA IND DE PAPELAO LTDA', 'RUA OSVALDO CRUZ', '374', NULL, 'JD PROGRESSO', 'SAO PAULO', '13843000', 'SP', '39131345', 3, 5),
(5, 'INTERNATIONAL PAPER', 'RODOVIA SP 340', '5467', NULL, '', 'MOGI GUACU', '13840000', 'SP', '38619878', 1, 4),
(6, 'MAHLE IND E COMERCIO', 'Av. Ernst MAHLE', '2000', NULL, '', 'MOGI GUACU', '13846146', 'SP', ' 38619100', 3, 5);

-- --------------------------------------------------------

--
-- Estrutura da tabela `clienteaux`
--

CREATE TABLE `clienteaux` (
  `id` int(11) NOT NULL,
  `nome` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `clienteaux`
--

INSERT INTO `clienteaux` (`id`, `nome`) VALUES
(1, 'QUALITAS IND E COMERCIO'),
(2, 'METALURGICA RL'),
(3, 'JF MAQUINAS E EQUIPAMENTOS'),
(6, 'MAHLE IND E COMERCIO');

-- --------------------------------------------------------

--
-- Estrutura da tabela `departamento`
--

CREATE TABLE `departamento` (
  `id` int(11) NOT NULL,
  `descricao` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `departamento`
--

INSERT INTO `departamento` (`id`, `descricao`) VALUES
(1, 'FINANCEIRO'),
(2, 'COMERCIAL'),
(3, 'ADMINISTRATIVO'),
(4, 'PRODUCAO');

-- --------------------------------------------------------

--
-- Estrutura da tabela `empregado`
--

CREATE TABLE `empregado` (
  `id` int(11) NOT NULL,
  `nome` varchar(60) NOT NULL,
  `endereco` varchar(60) NOT NULL,
  `numero` varchar(5) NOT NULL,
  `complemento` varchar(30) DEFAULT NULL,
  `bairro` varchar(40) NOT NULL,
  `municipio` varchar(40) NOT NULL,
  `estado` char(2) NOT NULL,
  `cep` varchar(10) NOT NULL,
  `pais` varchar(40) NOT NULL,
  `telefone` varchar(15) DEFAULT NULL,
  `escolaridade` int(11) NOT NULL,
  `cargo` varchar(40) NOT NULL,
  `salario` decimal(10,3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `empregado`
--

INSERT INTO `empregado` (`id`, `nome`, `endereco`, `numero`, `complemento`, `bairro`, `municipio`, `estado`, `cep`, `pais`, `telefone`, `escolaridade`, `cargo`, `salario`) VALUES
(1, 'ANA PAULA', 'RUA 1', '5', NULL, 'VILA MARIANA', 'ITAPIRA', 'SP', '13843000', 'BRASIL', '39134589', 3, 'ENGENHEIRO', '10000.000'),
(2, 'PEDRO HENRIQUE', 'RUA ALVAREZ TEIXEIRA', '1521', NULL, 'JD CARMEN LIDIA', 'ITAPIRA', 'SP', '13843000', 'INGLATERRA', '39138976', 3, 'ENGENHEIRO', '18000.000'),
(3, 'MARIO CAVENAZZI', 'RUA TIRADENTES', '327', NULL, 'JD PORTO VELHO', 'ITAPIRA', 'SP', '13843000', 'INGLATERRA', '39131254', 2, 'SUPERVISOR', '8000.000'),
(4, 'JURANDIR VIEIRA', 'AV MARECHAL RONDOM', '2034', NULL, 'VILA MATILDE', 'ITAPIRA', 'SP', '13843000', 'BRASIL', '39136547', 3, 'GERENTE', '12500.000'),
(5, 'AMALIA CARDOSO', 'RUA CORUMBA', '737', NULL, 'JD AUREA', 'ITAPIRA', 'SP', '13843000', 'ARGENTINA', '39132234', 1, 'OPERARIO', '2500.000');

-- --------------------------------------------------------

--
-- Estrutura da tabela `formapagto`
--

CREATE TABLE `formapagto` (
  `id` int(11) NOT NULL,
  `descricao` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `formapagto`
--

INSERT INTO `formapagto` (`id`, `descricao`) VALUES
(1, 'A VISTA'),
(2, 'A PRAZO'),
(3, 'BOLETO'),
(4, 'CHEQUE');

-- --------------------------------------------------------

--
-- Estrutura da tabela `item`
--

CREATE TABLE `item` (
  `idpedido` int(11) NOT NULL,
  `idproduto` int(11) NOT NULL,
  `quantidade` decimal(10,3) NOT NULL,
  `precounitario` decimal(10,3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `item`
--

INSERT INTO `item` (`idpedido`, `idproduto`, `quantidade`, `precounitario`) VALUES
(1, 1, '5.000', '0.250'),
(1, 2, '3.000', '0.450'),
(2, 1, '2.000', '0.250'),
(2, 3, '10.000', '0.450'),
(3, 1, '15.000', '0.250'),
(4, 2, '20.000', '0.450'),
(5, 1, '35.000', '0.250'),
(6, 1, '40.000', '0.250'),
(7, 2, '35.000', '0.450'),
(8, 4, '28.000', '0.050'),
(9, 5, '60.000', '0.050'),
(10, 2, '100.000', '0.050'),
(10, 3, '100.000', '0.450'),
(10, 4, '100.000', '0.050');

-- --------------------------------------------------------

--
-- Estrutura da tabela `pedido`
--

CREATE TABLE `pedido` (
  `id` int(11) NOT NULL,
  `idcliente` int(11) NOT NULL,
  `datemissao` date NOT NULL,
  `datentrega` date DEFAULT NULL,
  `idformapagto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `pedido`
--

INSERT INTO `pedido` (`id`, `idcliente`, `datemissao`, `datentrega`, `idformapagto`) VALUES
(1, 1, '2019-01-05', '2019-04-06', 1),
(2, 2, '2019-01-06', '2019-04-07', 2),
(3, 1, '2019-02-03', '2019-02-03', 3),
(4, 3, '2019-03-15', '2019-03-18', 1),
(5, 4, '2019-04-04', '2019-04-10', 3),
(6, 5, '2019-04-04', '2019-04-10', 3),
(7, 6, '2019-04-04', '2019-04-10', 3),
(8, 5, '2019-04-04', '2019-04-10', 3),
(9, 4, '2019-04-04', '2019-04-10', 2),
(10, 6, '2019-04-04', '2019-04-10', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `produto`
--

CREATE TABLE `produto` (
  `id` int(11) NOT NULL,
  `descricao` varchar(120) NOT NULL,
  `precodecompra` decimal(10,2) NOT NULL DEFAULT 0.00,
  `precodevenda` decimal(10,2) NOT NULL DEFAULT 0.00,
  `estoque` decimal(10,3) NOT NULL DEFAULT 0.000,
  `marca` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `produto`
--

INSERT INTO `produto` (`id`, `descricao`, `precodecompra`, `precodevenda`, `estoque`, `marca`) VALUES
(1, 'Chinelo Havaiana', '0.15', '0.25', '10000.000', 'Gerdau'),
(2, 'Perfume Zaad', '0.30', '0.45', '15000.000', 'Gerdau'),
(3, 'Perfume Malbec', '0.30', '0.45', '8000.000', 'Gerdau'),
(4, 'Perfume Omini', '0.02', '0.05', '12000.000', 'Gerdau'),
(5, 'C3PO ', '0.02', '0.05', '14000.000', 'Gerdau'),
(6, 'R2D2 ', '0.20', '0.80', '10.000', 'Gerdau');

-- --------------------------------------------------------

--
-- Estrutura da tabela `regiao`
--

CREATE TABLE `regiao` (
  `id` int(11) NOT NULL,
  `descricao` varchar(40) NOT NULL,
  `estado` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `regiao`
--

INSERT INTO `regiao` (`id`, `descricao`, `estado`) VALUES
(1, 'CAMPINAS', 'SP'),
(2, 'PIRACICABA', 'SP'),
(3, 'GRANDE SAO PAULO', 'SP'),
(4, 'BAIXA MOGIANA', 'SP'),
(5, 'SAO PAULO', 'SP');

-- --------------------------------------------------------

--
-- Estrutura da tabela `representante`
--

CREATE TABLE `representante` (
  `id` int(11) NOT NULL,
  `nome` varchar(60) NOT NULL,
  `endereco` varchar(60) NOT NULL,
  `numero` varchar(5) NOT NULL,
  `complemento` varchar(30) DEFAULT NULL,
  `bairro` varchar(40) NOT NULL,
  `municipio` varchar(40) NOT NULL,
  `estado` char(2) NOT NULL,
  `cep` varchar(10) NOT NULL,
  `telefone` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `representante`
--

INSERT INTO `representante` (`id`, `nome`, `endereco`, `numero`, `complemento`, `bairro`, `municipio`, `estado`, `cep`, `telefone`) VALUES
(1, 'ALVARO', 'RUA ORLANDO SILVA', '13', NULL, 'JD VILLAGE', 'ITAPIRA', 'SP', '13843000', '39138876'),
(2, 'PEIXOTO', 'AV DEODORA DA FONSECA', '980', NULL, 'JD CRUZEIRO', 'ITAPIRA', 'SP', '13843000', '39131423'),
(3, 'JOAQUIM', 'RUA DOS PRADOS', '26', NULL, 'JD CATAGUA', 'ITAPIRA', 'SP', '13843000', '39133390'),
(4, 'SINESIO', 'RUA ODORICO PARAGUACU', '456', NULL, 'JD FRONTEIRA', 'ITAPIRA', 'SP', '13843000', '39135527');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `cargo`
--
ALTER TABLE `cargo`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FRK_CLIENTE_REPRESENTANTE` (`idrepresentante`),
  ADD KEY `FRK_CLIENTE_REGIAO` (`idregiao`);

--
-- Índices para tabela `departamento`
--
ALTER TABLE `departamento`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `empregado`
--
ALTER TABLE `empregado`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `formapagto`
--
ALTER TABLE `formapagto`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`idpedido`,`idproduto`),
  ADD KEY `FRK_ITENS_PRODUTO` (`idproduto`);

--
-- Índices para tabela `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FRK_PEDIDO_CLIENTE` (`idcliente`),
  ADD KEY `FRK_PEDIDO_FORMAPAGTO` (`idformapagto`);

--
-- Índices para tabela `produto`
--
ALTER TABLE `produto`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `regiao`
--
ALTER TABLE `regiao`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `representante`
--
ALTER TABLE `representante`
  ADD PRIMARY KEY (`id`);

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `FRK_CLIENTE_REGIAO` FOREIGN KEY (`idregiao`) REFERENCES `regiao` (`id`),
  ADD CONSTRAINT `FRK_CLIENTE_REPRESENTANTE` FOREIGN KEY (`idrepresentante`) REFERENCES `representante` (`id`);

--
-- Limitadores para a tabela `item`
--
ALTER TABLE `item`
  ADD CONSTRAINT `FRK_ITENS_PEDIDO` FOREIGN KEY (`idpedido`) REFERENCES `pedido` (`id`),
  ADD CONSTRAINT `FRK_ITENS_PRODUTO` FOREIGN KEY (`idproduto`) REFERENCES `produto` (`id`);

--
-- Limitadores para a tabela `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `FRK_PEDIDO_CLIENTE` FOREIGN KEY (`idcliente`) REFERENCES `cliente` (`id`),
  ADD CONSTRAINT `FRK_PEDIDO_FORMAPAGTO` FOREIGN KEY (`idformapagto`) REFERENCES `formapagto` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
