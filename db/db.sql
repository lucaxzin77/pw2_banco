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