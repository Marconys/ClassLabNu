-- Criação de Procedures 
use comercialdb0191

-- Procedure de insert cliente
-- drop PROCEDURE sp_cliente_inserir;

-- -----------------------------------------------------------------------------------------------------------------------
						-- ---------- CLIENTES -----------
-- -----------------------------------------------------------------------------------------------------------------------

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

-- -----------------------------------------------------------------------------------------------------------------------
						-- ---------- PRODUTOS -----------
-- -----------------------------------------------------------------------------------------------------------------------

delimiter |
CREATE PROCEDURE sp_produtos_inserir(
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
END
|

delimiter |

create procedure sp_produtos_alterar(
_id int,
_valor decimal (10,2),
_desconto decimal (10,2)
)

begin

update produtos set valor = _valor, desconto = _desconto where idprod = _id;

end
|
-- drop procedure sp_produtos_inserir;
-- -----------------------------------------------------------------------------------------------------------------------
						-- ---------- USUÁRIOS -----------
-- -----------------------------------------------------------------------------------------------------------------------

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

delimiter |

create procedure sp_usuarios_alterar(
_iduser int,
_nome varchar(60),
_email varchar(60),
_senha varchar(32),
_nivel varchar(15)
)

begin

update usuarios set nome = _nome, email = _email, senha = md5(_senha), nivel = _nivel where iduser = _id;

end
|
-- -----------------------------------------------------------------------------------------------------------------------
						-- ---------- PEDIDOS -----------
-- -----------------------------------------------------------------------------------------------------------------------
 
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
 -- drop procedure sp_pedido_alterar;
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
 
-- -----------------------------------------------------------------------------------------------------------------------
						-- ---------- NÍVEIS -----------
-- -----------------------------------------------------------------------------------------------------------------------

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
 
-- -----------------------------------------------------------------------------------------------------------------------
						-- ---------- ITEMPEDIDO -----------
-- -----------------------------------------------------------------------------------------------------------------------

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
 
 delimiter |

create procedure sp_itempedido_alterar(
_idped_ip int,
_idprod_ip int,
_valor decimal (10,2),
_quantidade decimal (10,2),
_desconto decimal (10,2)
)

begin

update itempedido set valor = _valor, quantidade = _quantidade, desconto = _desconto where idped = _idped and idprod = _idprod;

end
|


-- -----------------------------------------------------------------------------------------------------------------------
						-- ---------- CAIXAS -----------
-- -----------------------------------------------------------------------------------------------------------------------

delimiter |

create procedure sp_caixas_inserir(
_saldo decimal (10,2),
_status_caixa varchar (32),
_iduser_cx int
)

begin

insert into caixas (data_abertura, saldo, status_caixa, iduser_cx)
values (default, _saldo, _status_caixa, _iduser);
select * from caixas where idcx = (select @@identity);


end
|

delimiter |

create procedure sp_caixas_alterar(
_id int,
_saldo decimal (10,2),
_status_caixa varchar (32),
_iduser_cx int
)

begin

update caixas set saldo = _saldo, status_caixa = _status_caixa where idcx = _id;

end
|

-- -----------------------------------------------------------------------------------------------------------------------
						-- ---------- VENDAS -----------
-- -----------------------------------------------------------------------------------------------------------------------
delimiter |

create procedure sp_vendas_inserir(

_status_vnd varchar (15),
_desconto decimal (10,2),
_idcx_vnd int,
_idped_vnd int

)

begin

insert into vendas (data_vnd, status_vnd, desconto, idcx_vnd, idped_vnd)
values (default, _status_vnd, _desconto, _idcx, _idped);
select * from vendas where idvnd = (select @@identity);


end
|

delimiter |

create procedure sp_vendas_alterar(
_id int,
_status_vnd varchar (15),
_desconto decimal (10,2)
)

begin

update vendas set status_vnd = _status_vnd, desconto = _desconto where idvnd = _id;

end
|

-- -----------------------------------------------------------------------------------------------------------------------
						-- ---------- PAGAMENTOS -----------
-- -----------------------------------------------------------------------------------------------------------------------

delimiter |

create procedure sp_pagamentos_inserir(


_valor decimal (10,2),
_idvnd_pag int,
_idtipo int

)

begin

insert into pagamentos (valor, _idvnd_pag, idtipo_pag)
values (_valor, _idvnd, _idtipo);
select * from pagamentos where idpag = (select @@identity);


end
|

delimiter |

create procedure sp_pagamentos_alterar(
_id int,
_valor decimal (10,2)
)

begin

update pagamentos set valor = _valor where idpag = _id;

end
|

-- -----------------------------------------------------------------------------------------------------------------------
						-- ---------- TIPOS -----------
-- -----------------------------------------------------------------------------------------------------------------------

delimiter |

create procedure sp_tipos_inserir(
_nome varchar (20),
_sigla varchar (10)

)

begin

insert into tipos (nome, sigla)
values (_nome, _sigla);
select * from tipos where idtipo = (select @@identity);


end
|

delimiter |

create procedure sp_pagamentos_alterar(
_id int,
_nome varchar (20),
_sigla varchar (10)
)

begin

update tipos set nome = _nome, sigla = _sigla where idtipo = _id;

end
|