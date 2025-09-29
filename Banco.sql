DROP DATABASE banco;
CREATE DATABASE banco;
USE banco;
CREATE TABLE cliente (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    usuario VARCHAR(255) NOT NULL,
    senha VARCHAR(255) NOT NULL,
    telefone BIGINT NOT NULL,
    endereco VARCHAR(255) NOT NULL
);
CREATE TABLE conta (
    numero INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    tipo_conta ENUM('CC','CP'),
    saldo FLOAT,
    fk_cliente_id INT UNSIGNED,
    FOREIGN KEY (fk_cliente_id) REFERENCES cliente(id)
);
CREATE TABLE trasacoes (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('Saque','Deposito','Tranferencia'),
    valor FLOAT NOT NULL,
    data DATETIME,
    descricao VARCHAR(255),
    fk_conta_numero INT UNSIGNED,
    FOREIGN KEY (fk_conta_numero) REFERENCES conta(numero)
);
CREATE TABLE P_fisica (
    data_nasc DATE,
    sexo ENUM('Masculino', 'Feminino', 'Outros'),
    cpf BIGINT,
    nome VARCHAR(255),
    cliente INT UNSIGNED,
    FOREIGN KEY (cliente) REFERENCES cliente(id),
    PRIMARY KEY (cliente)
);
CREATE TABLE P_juridica (
    razao_social VARCHAR(255),
    fundacao DATE,
    nome_fantasia VARCHAR(255),
    cnpj BIGINT,
    cliente INT UNSIGNED,
    FOREIGN KEY (cliente) REFERENCES cliente(id),
    PRIMARY KEY (cliente)
);