-- Remove licenses table if it already exists
DROP TABLE IF EXISTS licenciamentos;

-- Remove people table if it already exists
DROP TABLE IF EXISTS pessoas;

-- Remove cities table if it already exists
DROP TABLE IF EXISTS cidades;

-- Create cities table
CREATE TABLE cidades (
    id_cidade INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    estado CHAR(2) NOT NULL
);

-- Create people table
CREATE TABLE pessoas (
    id_pessoa INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    id_cidade_residencia INT,

    FOREIGN KEY (id_cidade_residencia) REFERENCES cidades(id_cidade)
);

-- Create licenses table
CREATE TABLE licenciamentos (
    id_licenciamento INT PRIMARY KEY,
    id_pessoa INT NOT NULL,
    id_cidade INT NOT NULL,
    atividade VARCHAR(100) NOT NULL,
    data_emissao DATE NOT NULL,
    data_validade DATE NOT NULL,
    status VARCHAR(20) NOT NULL,

    FOREIGN KEY (id_pessoa) REFERENCES pessoas(id_pessoa),
    FOREIGN KEY (id_cidade) REFERENCES cidades(id_cidade)
);

-- Add email column to people table
ALTER TABLE pessoas ADD COLUMN email VARCHAR(150);

-- Modify email column size
ALTER TABLE pessoas MODIFY COLUMN email VARCHAR(255);

-- Remove email column
ALTER TABLE pessoas DROP COLUMN email;

-- Verify tables
SHOW TABLES;