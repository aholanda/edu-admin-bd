DROP TABLE IF EXISTS Empregado CASCADE;
CREATE TABLE Empregado(
codigoE INT PRIMARY KEY,
nome VARCHAR(64) NOT NULL,
dataNasc DATE,
especialidade VARCHAR (32)
);

DROP TABLE IF EXISTS Produto CASCADE;
CREATE TABLE Produto (
codigoP INT PRIMARY KEY,
codigoE INT REFERENCES Empregado(codigoE) ON DELETE CASCADE ON UPDATE CASCADE,
designacaoP VARCHAR (32) NOT NULL,
area REAL NOT NULL
);

DROP TABLE IF EXISTS Comprador CASCADE;
CREATE TABLE Comprador (
codigoC INT  PRIMARY KEY,
nomeC VARCHAR(64) NOT NULL,
enderecoC VARCHAR(132),
telefoneC VARCHAR(16)
);

DROP TABLE IF EXISTS Venda CASCADE;
CREATE TABLE Venda (
codigoP INT NOT NULL REFERENCES Produto(codigoP) ON DELETE CASCADE ON UPDATE CASCADE,
codigoC INT NOT NULL REFERENCES Comprador(codigoC) ON DELETE CASCADE ON UPDATE CASCADE,
dataV DATE NOT NULL,
quantidadeV REAL NOT NULL,
valorV DECIMAL(7,2) NOT NULL,
dataRecebim DATE,
PRIMARY KEY(codigoP, codigoC, dataV)
);

DROP TABLE IF EXISTS Fornecedor CASCADE;
CREATE TABLE Fornecedor(
codigoF INT PRIMARY KEY,
nomeF VARCHAR(64) NOT NULL,
enderecoF VARCHAR(132),
telefoneF VARCHAR(16)
);

-- Empregado
INSERT INTO Empregado(codigoE, nome, dataNasc, especialidade) VALUES(1, 'João Dias', '1955-01-05', 'hortelão');
INSERT INTO Empregado(codigoE, nome, dataNasc, especialidade) VALUES(2, 'Luísa Ferreira', '1945-11-25', 'jardineiro');
INSERT INTO Empregado(codigoE, nome, dataNasc, especialidade) VALUES(3, 'Mário Horta', '1960-12-05', 'motorista');
INSERT INTO Empregado(codigoE, nome, dataNasc, especialidade) VALUES(4, 'Joana Garcia', '1990-12-01', 'engenheiro agrônomo');

-- Produto
INSERT INTO Produto(codigoP, designacaoP, area, codigoE) VALUES(5, 'cenoura', 4.5, 4);
INSERT INTO Produto(codigoP, designacaoP, area, codigoE) VALUES(6, 'feijão verde', 6.5, 1);
INSERT INTO Produto(codigoP, designacaoP, area, codigoE) VALUES(7, 'batata', 2.6, 4);
INSERT INTO Produto(codigoP, designacaoP, area, codigoE) VALUES(8, 'rosa', 1, 2);

-- Comprador
INSERT INTO Comprador(codigoC, nomeC, enderecoC, telefoneC) VALUES(1, 'Manoel Silva', 'Alameda AA', '749658365');
INSERT INTO Comprador(codigoC, nomeC, enderecoC, telefoneC) VALUES(2, 'Luisa Fraga', 'Alameda BB s/n','589016587');
INSERT INTO Comprador(codigoC, nomeC, enderecoC, telefoneC) VALUES(3, 'Duarte Sousa', 'Alameda CC s/n','456123789');

-- Venda
INSERT INTO Venda(codigoP, codigoC, dataV, quantidadeV, valorV, dataRecebim) VALUES(5, 1, '1999-04-07', 50, 45000, '1999-04-07');
INSERT INTO Venda(codigoP, codigoC, dataV, quantidadeV, valorV) VALUES(5, 2, '1999-02-20', 5.6, 1000);
INSERT INTO Venda(codigoP, codigoC, dataV, quantidadeV, valorV) VALUES(6, 2, '1999-04-05', 100, 60000);
INSERT INTO Venda(codigoP, codigoC, dataV, quantidadeV, valorV) VALUES(6, 1, '1999-03-29', 450, 90000);

-- Fornecedor
INSERT INTO Fornecedor(codigoF, nomeF, enderecoF, telefoneF) VALUES(1, 'Ana Maria Sousa', 'Alameda Tapajós s/n', '213638161');
