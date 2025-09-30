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