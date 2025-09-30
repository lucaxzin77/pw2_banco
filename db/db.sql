DROP DATABASE IF EXISTS banco;
CREATE DATABASE IF NOT EXISTS banco;
USE banco;
CREATE TABLE IF NOT EXISTS cliente (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    usuario VARCHAR(255) NOT NULL,
    senha VARCHAR(255) NOT NULL,
    telefone BIGINT NOT NULL,
    endereco VARCHAR(255) NOT NULL
);
CREATE TABLE IF NOT EXISTS conta (
    numero INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    tipo_conta ENUM('CC','CP'),
    saldo FLOAT,
    cliente INT UNSIGNED,
    FOREIGN KEY (cliente) REFERENCES cliente(id)
);
CREATE TABLE IF NOT EXISTS transacoes (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('Saque','Deposito','Tranferencia'),
    valor FLOAT NOT NULL,
    data DATETIME,
    descricao VARCHAR(255),
    conta_num INT UNSIGNED,
    FOREIGN KEY (conta_num) REFERENCES conta(numero)
);
CREATE TABLE IF NOT EXISTS P_fisica (
    data_nasc DATE,
    sexo ENUM('Masculino', 'Feminino', 'Outros'),
    cpf BIGINT,
    nome VARCHAR(255),
    cliente INT UNSIGNED,
    FOREIGN KEY (cliente) REFERENCES cliente(id),
    PRIMARY KEY (cliente)
);
CREATE TABLE IF NOT EXISTS P_juridica (
    razao_social VARCHAR(255),
    fundacao DATE,
    nome_fantasia VARCHAR(255),
    cnpj BIGINT,
    cliente INT UNSIGNED,
    FOREIGN KEY (cliente) REFERENCES cliente(id),
    PRIMARY KEY (cliente)
);

ALTER TABLE conta AUTO_INCREMENT = 1000;

-- PROCEDURES DE CONSULTA DE DADOS -----------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE p_ConsultarClientes ()
BEGIN
    SELECT * FROM cliente;
END;

CREATE PROCEDURE p_ConsultarClienteByID (IN clienteID INT)
BEGIN
    SELECT * FROM cliente WHERE id = clienteID;
END;

CREATE PROCEDURE p_ConsultarContas ()
BEGIN
    SELECT * FROM conta;
END;

CREATE PROCEDURE p_ConsultarContaByNum (IN contaNum INT)
BEGIN
    SELECT * FROM conta WHERE numero = contaNum;
END;

CREATE PROCEDURE p_ConsultarTransacoes ()
BEGIN
    SELECT * FROM transacoes;
END;

CREATE PROCEDURE p_ConsultarTransacaoByConta (IN contaNum INT)
BEGIN
    SELECT * FROM transacoes WHERE conta_num = contaNum;
END;

CREATE PROCEDURE p_ConsultarPFisica ()
BEGIN
    SELECT * FROM P_fisica;
END;

CREATE PROCEDURE p_ConsultarPFisicaByCPF (IN cpf BIGINT)
BEGIN
    SELECT * FROM P_fisica WHERE cpf = cpf;
END;

CREATE PROCEDURE p_ConsultarPJuridica ()
BEGIN
    SELECT * FROM P_juridica;
END;

CREATE PROCEDURE p_ConsultarPJuridicaByCNPJ (IN cpnj BIGINT)
BEGIN
    SELECT * FROM P_juridica WHERE cnpj = cnpj;
END;

-- PROCEDURES DE INSERÇÃO DE DADOS -----------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE p_CadastrarCliente (
    IN nome VARCHAR(255), 
    IN senha VARCHAR(255), 
    IN telefone BIGINT, 
    IN endereco VARCHAR(255))
    
BEGIN
    INSERT INTO cliente (usuario, senha, telefone, endereco) 
    VALUES (nome, senha, telefone, endereco);
END;

CREATE PROCEDURE p_CadastrarConta (
    IN tipo VARCHAR(255), 
    IN saldo FLOAT, 
    IN clienteID INT)
    
BEGIN
    INSERT INTO conta (tipo_conta, saldo, cliente) 
    VALUES (tipo, saldo, clienteID);
END;

CREATE PROCEDURE p_RegistrarTransacao (
    IN tipo VARCHAR(255), 
    IN valor FLOAT, 
    IN descricao VARCHAR(255),
    IN contaNum INT)
    
BEGIN
    INSERT INTO transacoes (tipo, valor, descricao, conta_num) 
    VALUES (tipo, valor, descricao, contaNum);
END;

CREATE PROCEDURE p_CadastrarPFisica (
    IN data_nasc DATE,
    IN sexo VARCHAR(255),
    IN cpf BIGINT,
    IN nome VARCHAR(255),
    IN clienteID INT)
    
BEGIN
    INSERT INTO P_fisica (data_nasc, sexo, cpf, nome, cliente) 
    VALUES (data_nasc, sexo, cpf, nome, clienteID);
END;

CREATE PROCEDURE p_CadastrarPJuridica (
    IN razao_social VARCHAR(255),
    IN fundacao DATE,
    IN nome_fantasia VARCHAR(255),
    IN cnpj BIGINT,
    IN clienteID INT)
    
BEGIN
    INSERT INTO P_fisica (razao_social, fundacao, nome_fantasia, cnpj, cliente) 
    VALUES (razao_social, fundacao, nome_fantasia, cnpj, clienteID);
END;

-- PROCEDURES DE EDIÇÃO DE DADOS -----------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE p_EditarCliente (
    IN nome VARCHAR(255), 
    IN senha VARCHAR(255), 
    IN telefone BIGINT, 
    IN endereco VARCHAR(255),
    IN clienteID INT)

BEGIN
    UPDATE cliente
    SET usuario = nome, senha = senha, telefone = telefone, endereco = endereco
    WHERE id = clienteID;
END;

CREATE PROCEDURE p_EditarTransacao (
    IN tipo VARCHAR(255), 
    IN valor FLOAT, 
    IN descricao VARCHAR(255),
    IN contaNum INT)
    
BEGIN
    UPDATE transacoes
    SET tipo = tipo, valor = valor, descricao = descricao
    WHERE conta_num = contaNum;
END;

CREATE PROCEDURE p_EditarPFisica (
    IN data_nasc DATE,
    IN sexo VARCHAR(255),
    IN cpf BIGINT,
    IN nome VARCHAR(255),
    IN clienteID INT)
    
BEGIN
    UPDATE P_fisica
    SET data_nasc = data_nasc, sexo = sexo, cpf = cpf, nome = nome
    WHERE cliente = clienteID;
END;

CREATE PROCEDURE p_EditarPJuridica (
    IN razao_social VARCHAR(255),
    IN fundacao DATE,
    IN nome_fantasia VARCHAR(255),
    IN cnpj BIGINT,
    IN clienteID INT)
    
BEGIN
    UPDATE P_juridica
    SET razao_social = razao_social, fundacao = fundacao, nome_fantasia = nome_fantasia, cnpj = cnpj
    WHERE cliente = clienteID;
END;

-- PROCEDURES DE EXCLUSÃO DE DADOS -----------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE p_DeletarCliente (IN clienteID INT)

BEGIN
    DELETE FROM cliente WHERE id = clienteID;
END;


CREATE PROCEDURE p_DeletarConta (IN contaNum INT)

BEGIN
    DELETE FROM conta WHERE id = contaNum;
END;


CREATE PROCEDURE p_DeletarTransacao (IN transacaoID INT)

BEGIN
    DELETE FROM transacoes WHERE id = transacaoID;
END;


CREATE PROCEDURE p_DeletarPFisica (IN clienteID INT)

BEGIN
    DELETE FROM P_fisica WHERE cliente = clienteID;
END;


CREATE PROCEDURE p_DeletarPJuridica (IN clienteID INT)

BEGIN
    DELETE FROM P_juridica WHERE cliente = clienteID;
END;

-- PROCEDURES DE TRANSFERÊNCIA DE VALORES -----------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE p_Sacar (IN contaNum INT, IN valor FLOAT)
BEGIN
    UPDATE saldo SET saldo = saldo - (valor * 1.05)
    WHERE numero = contaNum;
END;

CREATE PROCEDURE p_Depositar (IN contaNum INT, IN valor FLOAT)
BEGIN
    UPDATE saldo SET saldo = saldo + valor
    WHERE numero = contaNum;
END;