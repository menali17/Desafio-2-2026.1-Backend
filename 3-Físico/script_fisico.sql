CREATE DATABASE IF NOT EXISTS detran;
USE detran;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS infracao;
DROP TABLE IF EXISTS telefone_proprietario;
DROP TABLE IF EXISTS veiculo;
DROP TABLE IF EXISTS agente_transito;
DROP TABLE IF EXISTS local_infracao;
DROP TABLE IF EXISTS tipo_infracao;
DROP TABLE IF EXISTS categoria;
DROP TABLE IF EXISTS modelo;
DROP TABLE IF EXISTS proprietario;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE proprietario (
    cpf VARCHAR(11) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(150) NOT NULL,
    bairro VARCHAR(80) NOT NULL,
    cidade VARCHAR(80) NOT NULL,
    estado CHAR(2) NOT NULL,
    sexo CHAR(1) NOT NULL,
    data_nascimento DATE NOT NULL,
    idade INT NOT NULL,

    CONSTRAINT chk_proprietario_cpf 
        CHECK (cpf REGEXP '^[0-9]{11}$'),

    CONSTRAINT chk_proprietario_estado 
        CHECK (estado REGEXP '^[A-Z]{2}$'),

    CONSTRAINT chk_proprietario_sexo 
        CHECK (sexo IN ('M', 'F', 'O')),

    CONSTRAINT chk_proprietario_idade 
        CHECK (idade >= 0)
);

CREATE TABLE telefone_proprietario (
    id_telefone INT AUTO_INCREMENT PRIMARY KEY,
    cpf_proprietario VARCHAR(11) NOT NULL,
    numero VARCHAR(20) NOT NULL,

    CONSTRAINT fk_telefone_proprietario
        FOREIGN KEY (cpf_proprietario)
        REFERENCES proprietario(cpf)
        ON DELETE CASCADE
);

CREATE TABLE modelo (
    codigo_modelo CHAR(6) PRIMARY KEY,
    nome_modelo VARCHAR(80) NOT NULL,

    CONSTRAINT chk_modelo_codigo 
        CHECK (codigo_modelo REGEXP '^[0-9]{6}$')
);

CREATE TABLE categoria (
    codigo_categoria CHAR(2) PRIMARY KEY,
    nome_categoria VARCHAR(80) NOT NULL,

    CONSTRAINT chk_categoria_codigo 
        CHECK (codigo_categoria REGEXP '^[0-9]{2}$')
);

CREATE TABLE veiculo (
    placa VARCHAR(7) PRIMARY KEY,
    chassi VARCHAR(17) NOT NULL UNIQUE,
    cor_predominante VARCHAR(40) NOT NULL,
    ano_fabricacao INT NOT NULL,
    cpf_proprietario VARCHAR(11) NOT NULL,
    codigo_modelo CHAR(6) NOT NULL,
    codigo_categoria CHAR(2) NOT NULL,

    CONSTRAINT chk_veiculo_ano 
        CHECK (ano_fabricacao BETWEEN 1900 AND 2100),

    CONSTRAINT fk_veiculo_proprietario
        FOREIGN KEY (cpf_proprietario)
        REFERENCES proprietario(cpf),

    CONSTRAINT fk_veiculo_modelo
        FOREIGN KEY (codigo_modelo)
        REFERENCES modelo(codigo_modelo),

    CONSTRAINT fk_veiculo_categoria
        FOREIGN KEY (codigo_categoria)
        REFERENCES categoria(codigo_categoria)
);

CREATE TABLE tipo_infracao (
    codigo_tipo INT PRIMARY KEY,
    descricao VARCHAR(150) NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,

    CONSTRAINT chk_tipo_infracao_valor 
        CHECK (valor >= 0)
);

CREATE TABLE local_infracao (
    latitude DECIMAL(9, 6) NOT NULL,
    longitude DECIMAL(9, 6) NOT NULL,
    velocidade_permitida INT,

    CONSTRAINT pk_local_infracao 
        PRIMARY KEY (latitude, longitude),

    CONSTRAINT chk_local_latitude 
        CHECK (latitude BETWEEN -90 AND 90),

    CONSTRAINT chk_local_longitude 
        CHECK (longitude BETWEEN -180 AND 180),

    CONSTRAINT chk_local_velocidade 
        CHECK (velocidade_permitida IS NULL OR velocidade_permitida > 0)
);

CREATE TABLE agente_transito (
    matricula INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_contratacao DATE NOT NULL,
    tempo_servico_meses INT NOT NULL,

    CONSTRAINT chk_agente_tempo 
        CHECK (tempo_servico_meses >= 0)
);

CREATE TABLE infracao (
    id_infracao INT AUTO_INCREMENT PRIMARY KEY,
    placa_veiculo VARCHAR(7) NOT NULL,
    data_hora DATETIME NOT NULL,
    codigo_tipo INT NOT NULL,
    latitude DECIMAL(9, 6) NOT NULL,
    longitude DECIMAL(9, 6) NOT NULL,
    velocidade_aferida INT,
    matricula_agente INT NOT NULL,

    CONSTRAINT chk_infracao_velocidade 
        CHECK (velocidade_aferida IS NULL OR velocidade_aferida >= 0),

    CONSTRAINT fk_infracao_veiculo
        FOREIGN KEY (placa_veiculo)
        REFERENCES veiculo(placa),

    CONSTRAINT fk_infracao_tipo
        FOREIGN KEY (codigo_tipo)
        REFERENCES tipo_infracao(codigo_tipo),

    CONSTRAINT fk_infracao_local
        FOREIGN KEY (latitude, longitude)
        REFERENCES local_infracao(latitude, longitude),

    CONSTRAINT fk_infracao_agente
        FOREIGN KEY (matricula_agente)
        REFERENCES agente_transito(matricula),

    CONSTRAINT uq_infracao_evento
        UNIQUE (placa_veiculo, data_hora, codigo_tipo)
);