-- Criação de Procedures 
use comercialdb0191

-- Procedure de insert cliente
-- drop PROCEDURE sp_cliente_inserir;
delimiter |
CREATE PROCEDURE sp_cliente_inserir(
_nome varchar(60), 
_cpf varchar(11),
_email varchar(60)
)
BEGIN
	insert into clientes (nome,cpf, email, datacad, ativo)
    values (_nome, _cpf,_email, default, default);
    select * from clientes where idcli = (select @@identity);    
END
|

 -- Procedure Atualização clientetipos
 -- drop PROCEDURE sp_cliente_alterar;
delimiter |
CREATE PROCEDURE sp_cliente_alterar(
_id int ,
_nome varchar(60), 	
_email varchar(60)
)
BEGIN
	update clientes set nome = _nome, email = _email where idcli = _id;
END
|

-- Produtos

delimiter |
CREATE PROCEDURE sp_produtos_inserir(
_descricao varchar(100), 
_unidade varchar(14),
_codbar char(13),
_valor decimal(10,2)
)
BEGIN
insert produtos (descricao, unidade, codbar, valor,desconto,descontinuado) 
values (_descricao, _unidade, _codbar, _valor, 0, default);
    select * from produtos where idprod = (select @@identity);    
END
|

-- Usuários
delimiter |
CREATE PROCEDURE sp_usuario_inserir(
_nome varchar(60), 
_email varchar(60),
_senha varchar(32),
_idnv int
)
BEGIN
insert usuarios (nome, email, senha,idnv_user,ativo) 
values (_nome, _email, md5(_senha), _idnv, default);
    select * from usuarios where iduser = (select @@identity);    
END
|
 -- Pedidos
 
 delimiter  |
 create procedure sp_pedido_inserir(
 _idcli int, _iduser int
 )
 BEGIN 
 insert pedidos (data, status_ped,desconto, idcli_ped,iduser_ped) 
 values (default, default,0,_idcli, _iduser); 
 select idped, status_ped from pedidos where idped = (select @@identity); 
 END
 |
 -- drop procedure sp_pedido_alterar
 delimiter |
 create procedure sp_pedido_alterar(
 _id int, 
 _status varchar(15), 
 _desconto decimal(10,2)
 )
 BEGIN
     update pedidos set status_ped  = _status, desconto = _desconto where idped = _id;
 END
 |
-- NIVEIS
 delimiter |
 create procedure sp_nivel_inserir(
 _nome varchar(45),
 _sigla varchar(5)
 )
 BEGIN
	insert niveis (nome,sigla) values(_nome, _sigla);
    select idnv from niveis where idnv = (select @@identity);
 END
 |
 
  delimiter |
 create procedure sp_nivel_alterar(
 _id int,
 _nome varchar(45),
 _sigla varchar(5)
 )
 BEGIN
	update niveis  set nome = _nome , sigla =  _sigla where idnv= _id;
 END
 |
 
 -- Item Pedido
 delimiter |
 create procedure sp_itempedido_inserir(
 _idped int,
 _idprd int,
 _valor decimal(10,2),
 _quantidade decimal(10,2),
 _desconto decimal(10,2)
 )
 BEGIN
    insert itempedido (idped_ip, idprod_ip, valor, quantidade, desconto)
    values (_idped, _idprod, _valor, _quantidade, _desconto);
 END
 |
 


