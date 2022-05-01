-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema comercialdb0191
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema comercialdb0191
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `comercialdb0191` DEFAULT CHARACTER SET utf8 ;
USE `comercialdb0191` ;

-- -----------------------------------------------------
-- Table `comercialdb0191`.`niveis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comercialdb0191`.`niveis` (
  `idnv` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `sigla` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`idnv`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `comercialdb0191`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comercialdb0191`.`usuarios` (
  `iduser` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(60) NOT NULL,
  `email` VARCHAR(60) NOT NULL,
  `senha` VARCHAR(32) NOT NULL,
  `idnv_user` INT(11) NOT NULL,
  `ativo` BIT(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`iduser`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC)  ,
  INDEX `fk_usuarios_nivel1_idx` (`idnv_user` ASC)  ,
  CONSTRAINT `fk_usuarios_nivel1`
    FOREIGN KEY (`idnv_user`)
    REFERENCES `comercialdb0191`.`niveis` (`idnv`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `comercialdb0191`.`caixas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comercialdb0191`.`caixas` (
  `idcx` INT(11) NOT NULL AUTO_INCREMENT,
  `data_abertura` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `saldo` DECIMAL(10,2) NOT NULL,
  `status_caixa` VARCHAR(32) NOT NULL,
  `iduser_cx` INT(11) NOT NULL,
  PRIMARY KEY (`idcx`),
  INDEX `fk_caixas_usuarios1_idx` (`iduser_cx` ASC)  ,
  CONSTRAINT `fk_caixas_usuarios1`
    FOREIGN KEY (`iduser_cx`)
    REFERENCES `comercialdb0191`.`usuarios` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `comercialdb0191`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comercialdb0191`.`clientes` (
  `idcli` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(60) NOT NULL,
  `cpf` CHAR(11) NOT NULL,
  `email` VARCHAR(60) NOT NULL,
  `datacad` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ativo` BIT(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`idcli`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC)  ,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC)  )
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `comercialdb0191`.`enderecos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comercialdb0191`.`enderecos` (
  `idend` INT(11) NOT NULL AUTO_INCREMENT,
  `cep` CHAR(8) NOT NULL,
  `logradouro` VARCHAR(100) NOT NULL,
  `numero` VARCHAR(30) NULL DEFAULT NULL,
  `complemento` VARCHAR(100) NULL DEFAULT NULL,
  `bairro` VARCHAR(60) NOT NULL,
  `cidade` VARCHAR(100) NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  `uf` CHAR(2) NOT NULL,
  `tipo` VARCHAR(30) NOT NULL,
  `idcli_end` INT(11) NOT NULL,
  PRIMARY KEY (`idend`),
  INDEX `fk_enderecos_clientes1_idx` (`idcli_end` ASC)  ,
  CONSTRAINT `fk_enderecos_clientes1`
    FOREIGN KEY (`idcli_end`)
    REFERENCES `comercialdb0191`.`clientes` (`idcli`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `comercialdb0191`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comercialdb0191`.`pedidos` (
  `idped` INT(11) NOT NULL AUTO_INCREMENT,
  `data` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status_ped` VARCHAR(15) NOT NULL DEFAULT 'A',
  `desconto` DECIMAL(10,2) NOT NULL,
  `idcli_ped` INT(11) NOT NULL,
  `iduser_ped` INT(11) NOT NULL,
  PRIMARY KEY (`idped`),
  INDEX `fk_Pedidos_Clientes_idx` (`idcli_ped` ASC)  ,
  INDEX `fk_Pedidos_Usuarios1_idx` (`iduser_ped` ASC)  ,
  CONSTRAINT `fk_Pedidos_Clientes`
    FOREIGN KEY (`idcli_ped`)
    REFERENCES `comercialdb0191`.`clientes` (`idcli`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedidos_Usuarios1`
    FOREIGN KEY (`iduser_ped`)
    REFERENCES `comercialdb0191`.`usuarios` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `comercialdb0191`.`produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comercialdb0191`.`produtos` (
  `idprod` INT(11) NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(100) NOT NULL,
  `unidade` VARCHAR(14) NOT NULL,
  `codbar` CHAR(13) NOT NULL,
  `valor` DECIMAL(10,2) NOT NULL,
  `desconto` DECIMAL(10,2) NOT NULL,
  `descontinuado` BIT(1) NOT NULL,
  PRIMARY KEY (`idprod`),
  UNIQUE INDEX `codbar_UNIQUE` (`codbar` ASC)  )
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `comercialdb0191`.`itempedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comercialdb0191`.`itempedido` (
  `idped_ip` INT(11) NOT NULL,
  `idprod_ip` INT(11) NOT NULL,
  `valor` DECIMAL(10,2) NOT NULL,
  `quantidade` DECIMAL(10,2) NOT NULL,
  `desconto` DECIMAL(10,2) NOT NULL,
  INDEX `fk_ItemPedido_Pedidos1_idx` (`idped_ip` ASC)  ,
  INDEX `fk_ItemPedido_Produtos1_idx` (`idprod_ip` ASC)  ,
  CONSTRAINT `fk_ItemPedido_Pedidos1`
    FOREIGN KEY (`idped_ip`)
    REFERENCES `comercialdb0191`.`pedidos` (`idped`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ItemPedido_Produtos1`
    FOREIGN KEY (`idprod_ip`)
    REFERENCES `comercialdb0191`.`produtos` (`idprod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `comercialdb0191`.`tipos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comercialdb0191`.`tipos` (
  `idtipo` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(20) NOT NULL,
  `sigla` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idtipo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `comercialdb0191`.`vendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comercialdb0191`.`vendas` (
  `idvnd` INT(11) NOT NULL AUTO_INCREMENT,
  `data_vnd` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status_vnd` VARCHAR(15) NOT NULL DEFAULT 'A',
  `desconto` DECIMAL(10,2) NOT NULL,
  `idcx_vnd` INT(11) NOT NULL,
  `idped_vnd` INT(11) NOT NULL,
  PRIMARY KEY (`idvnd`),
  INDEX `fk_vendas_caixas1_idx` (`idcx_vnd` ASC)  ,
  INDEX `fk_vendas_pedidos1_idx` (`idped_vnd` ASC)  ,
  CONSTRAINT `fk_vendas_caixas1`
    FOREIGN KEY (`idcx_vnd`)
    REFERENCES `comercialdb0191`.`caixas` (`idcx`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vendas_pedidos1`
    FOREIGN KEY (`idped_vnd`)
    REFERENCES `comercialdb0191`.`pedidos` (`idped`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `comercialdb0191`.`pagamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comercialdb0191`.`pagamentos` (
  `idpag` INT(11) NOT NULL AUTO_INCREMENT,
  `valor` DECIMAL(10,2) NOT NULL,
  `idvnd_pag` INT(11) NOT NULL,
  `idtipo_pag` INT(11) NOT NULL,
  PRIMARY KEY (`idpag`),
  INDEX `fk_pagamentos_vendas1_idx` (`idvnd_pag` ASC)  ,
  INDEX `fk_pagamentos_tipos1_idx` (`idtipo_pag` ASC)  ,
  CONSTRAINT `fk_pagamentos_tipos1`
    FOREIGN KEY (`idtipo_pag`)
    REFERENCES `comercialdb0191`.`tipos` (`idtipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pagamentos_vendas1`
    FOREIGN KEY (`idvnd_pag`)
    REFERENCES `comercialdb0191`.`vendas` (`idvnd`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `comercialdb0191`.`telefones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comercialdb0191`.`telefones` (
  `idtel` INT(11) NOT NULL AUTO_INCREMENT,
  `numero` VARCHAR(20) NOT NULL,
  `tipo` VARCHAR(10) NOT NULL,
  `idcli_tel` INT(11) NOT NULL,
  PRIMARY KEY (`idtel`),
  INDEX `fk_telefones_clientes1_idx` (`idcli_tel` ASC)  ,
  CONSTRAINT `fk_telefones_clientes1`
    FOREIGN KEY (`idcli_tel`)
    REFERENCES `comercialdb0191`.`clientes` (`idcli`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

USE `comercialdb0191` ;

-- -----------------------------------------------------
-- procedure sp_caixas_alterar
-- -----------------------------------------------------

DELIMITER $$
USE `comercialdb0191`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_caixas_alterar`(
_iduser int,
_saldo decimal (10,2),
_status_caixa varchar (32),
_iduser_cx int
)
begin

update caixas set saldo = _saldo, status_caixa = _status_caixa where iduser_cx = _iduser;

end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_caixas_inserir
-- -----------------------------------------------------

DELIMITER $$
USE `comercialdb0191`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_caixas_inserir`(
_saldo decimal (10,2),
_status_caixa varchar (32),
_iduser_cx int
)
begin

insert into caixas (data_abertura, saldo, status_caixa, iduser_cx)
values (default, _saldo, _status_caixa, _iduser);
select * from caixas where idcx = (select @@identity);


end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_cliente_alterar
-- -----------------------------------------------------

DELIMITER $$
USE `comercialdb0191`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cliente_alterar`(
_id int ,
_nome varchar(60), 	
_email varchar(60)
)
BEGIN
	update clientes set nome = _nome, email = _email where idcli = _id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_cliente_inserir
-- -----------------------------------------------------

DELIMITER $$
USE `comercialdb0191`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cliente_inserir`(
_nome varchar(60), 
_cpf varchar(11),
_email varchar(60)
)
BEGIN
	insert into clientes (nome,cpf, email, datacad, ativo)
    values (_nome, _cpf,_email, default, default);
    select * from clientes where idcli = (select @@identity);    
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_itempedido_alterar
-- -----------------------------------------------------

DELIMITER $$
USE `comercialdb0191`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_itempedido_alterar`(
_idped_ip int,
_idprod_ip int,
_valor decimal (10,2),
_quantidade decimal (10,2),
_desconto decimal (10,2)
)
begin

update itempedido set valor = _valor, quantidade = _quantidade, desconto = _desconto where idped = _idped and idprod = _idprod;

end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_itempedido_inserir
-- -----------------------------------------------------

DELIMITER $$
USE `comercialdb0191`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_itempedido_inserir`(
 _idped int,
 _idprd int,
 _valor decimal(10,2),
 _quantidade decimal(10,2),
 _desconto decimal(10,2)
 )
BEGIN
    insert itempedido (idped_ip, idprod_ip, valor, quantidade, desconto)
    values (_idped, _idprod, _valor, _quantidade, _desconto);
 END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_nivel_alterar
-- -----------------------------------------------------

DELIMITER $$
USE `comercialdb0191`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_nivel_alterar`(
 _id int,
 _nome varchar(45),
 _sigla varchar(5)
 )
BEGIN
	update niveis  set nome = _nome , sigla =  _sigla where idnv= _id;
 END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_nivel_inserir
-- -----------------------------------------------------

DELIMITER $$
USE `comercialdb0191`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_nivel_inserir`(
 _nome varchar(45),
 _sigla varchar(5)
 )
BEGIN
	insert niveis (nome,sigla) values(_nome, _sigla);
    select idnv from niveis where idnv = (select @@identity);
 END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_pagamentos_alterar
-- -----------------------------------------------------

DELIMITER $$
USE `comercialdb0191`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pagamentos_alterar`(
_id int,
_valor decimal (10,2)
)
begin

update pagamentos set valor = _valor where idpag = _id;

end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_pagamentos_inserir
-- -----------------------------------------------------

DELIMITER $$
USE `comercialdb0191`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pagamentos_inserir`(


_valor decimal (10,2),
_idvnd_pag int,
_idtipo int

)
begin

insert into pagamentos (valor, _idvnd_pag, idtipo_pag)
values (_valor, _idvnd, _idtipo);
select * from pagamentos where idpag = (select @@identity);


end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_pedido_alterar
-- -----------------------------------------------------

DELIMITER $$
USE `comercialdb0191`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pedido_alterar`(
 _id int, 
 _status varchar(15), 
 _desconto decimal(10,2)
 )
BEGIN
     update pedidos set status_ped  = _status, desconto = _desconto where idped = _id;
 END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_pedido_inserir
-- -----------------------------------------------------

DELIMITER $$
USE `comercialdb0191`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pedido_inserir`(
 _idcli int, _iduser int
 )
BEGIN 
 insert pedidos (data, status_ped,desconto, idcli_ped,iduser_ped) 
 values (default, default,0,_idcli, _iduser); 
 select idped, status_ped from pedidos where idped = (select @@identity); 
 END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_produtos_alterar
-- -----------------------------------------------------

DELIMITER $$
USE `comercialdb0191`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_produtos_alterar`(
_id int,
_valor decimal (10,2),
_desconto decimal (10,2)
)
begin

update produtos set valor = _valor, desconto = _desconto where idprod = _id;

end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_produtos_inserir
-- -----------------------------------------------------

DELIMITER $$
USE `comercialdb0191`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_produtos_inserir`(
_descricao varchar(100), 
_unidade varchar(14),
_codbar char(13),
_valor decimal(10,2),
_desconto decimal(10,2),
_descontinuado bit
)
BEGIN
insert produtos (descricao, unidade, codbar, valor,desconto,descontinuado) 
values (_descricao, _unidade, _codbar, _valor, _desconto, _descontinuado);
    select * from produtos where idprod = (select @@identity);    
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_tipos_inserir
-- -----------------------------------------------------

DELIMITER $$
USE `comercialdb0191`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tipos_inserir`(
_nome varchar (20),
_sigla varchar (10)

)
begin

insert into tipos (nome, sigla)
values (_nome, _sigla);
select * from tipos where idtipo = (select @@identity);


end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_usuario_inserir
-- -----------------------------------------------------

DELIMITER $$
USE `comercialdb0191`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usuario_inserir`(
_nome varchar(60), 
_email varchar(60),
_senha varchar(32),
_idnv int
)
BEGIN
insert usuarios (nome, email, senha,idnv_user,ativo) 
values (_nome, _email, md5(_senha), _idnv, default);
    select * from usuarios where iduser = (select @@identity);    
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_usuarios_alterar
-- -----------------------------------------------------

DELIMITER $$
USE `comercialdb0191`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usuarios_alterar`(
_iduser int,
_nome varchar(60),
_email varchar(60),
_senha varchar(32),
_nivel varchar(15)
)
begin

update usuarios set nome = _nome, email = _email, senha = md5(_senha), nivel = _nivel where iduser = _id;

end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_vendas_alterar
-- -----------------------------------------------------

DELIMITER $$
USE `comercialdb0191`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_vendas_alterar`(
_id int,
_status_vnd varchar (15),
_desconto decimal (10,2)
)
begin

update vendas set status_vnd = _status_vnd, desconto = _desconto where idvnd = _id;

end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_vendas_inserir
-- -----------------------------------------------------

DELIMITER $$
USE `comercialdb0191`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_vendas_inserir`(

_status_vnd varchar (15),
_desconto decimal (10,2),
_idcx_vnd int,
_idped_vnd int

)
begin

insert into vendas (data_vnd, status_vnd, desconto, idcx_vnd, idped_vnd)
values (default, _status_vnd, _desconto, _idcx, _idped);
select * from vendas where idvnd = (select @@identity);


end$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
