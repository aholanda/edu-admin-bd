-- Baseado no livro 'Sistema de banco de dados' de Elmasri/Navathe, 6a. edição, pag 60

DROP TABLE IF EXISTS Funcionario CASCADE;
CREATE TABLE Funcionario (
nome VARCHAR(16) NOT NULL,
inicial_nome_meio CHAR,
sobrenome VARCHAR(16) NOT NULL,
cpf CHAR(11),
data_nasc DATE,
endereco VARCHAR(64),
sexo CHAR,
salario DECIMAL(10,2),
cpf_supervisor CHAR(11),
id_departamento INT,
PRIMARY KEY(cpf),
FOREIGN KEY(cpf_supervisor) REFERENCES Funcionario(cpf)
ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS Departamento CASCADE;
CREATE TABLE Departamento (
id INT,
nome VARCHAR(32) NOT NULL,
cpf_gerente CHAR(11) NOT NULL DEFAULT '88665555586',
data_inicio_gerente DATE,
PRIMARY KEY(id),
UNIQUE(nome),
FOREIGN KEY(cpf_gerente) REFERENCES Funcionario(cpf)
ON UPDATE CASCADE ON DELETE RESTRICT
);

ALTER TABLE Funcionario ADD FOREIGN KEY(id_departamento) REFERENCES Departamento(id);

DROP TABLE IF EXISTS Projeto CASCADE;
CREATE TABLE Projeto (
id INT,
nome VARCHAR(64) NOT NULL,
id_departamento INT NOT NULL,
PRIMARY KEY(id),
UNIQUE(nome),
FOREIGN KEY(id_departamento) REFERENCES Departamento(id)
ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS Trabalha_em;
CREATE TABLE Trabalha_em (
cpf_funcionario CHAR(11),
id_projeto INT,
horas DECIMAL(3,1) NOT NULL,
PRIMARY KEY(cpf_funcionario, id_projeto),
FOREIGN KEY(cpf_funcionario)  REFERENCES Funcionario(cpf)
ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY(id_projeto) REFERENCES Projeto(id)
ON UPDATE CASCADE ON DELETE CASCADE,
CHECK(horas < 300)
);

DROP TABLE IF EXISTS Dependente CASCADE;
CREATE TABLE Dependente (
cpf_funcionario CHAR(11) NOT NULL,
nome VARCHAR(16) NOT NULL,
sobrenome VARCHAR(16) NOT NULL,
sexo CHAR NOT NULL,
data_nasc DATE,
endereco VARCHAR(64),
parentesco VARCHAR(8),
PRIMARY KEY(cpf_funcionario, nome),
FOREIGN KEY(cpf_funcionario) REFERENCES Funcionario(cpf)
ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Funcionario(nome,inicial_nome_meio,sobrenome,cpf,data_nasc,endereco,sexo,salario)
VALUES('Kandir', 'W', 'Ferreira', '88665555586', '22-09-1955', 'Av. D. Pedro I 493 - São Paulo, SP', 'M', 80000);

INSERT INTO Funcionario(nome,inicial_nome_meio,sobrenome,cpf,data_nasc,endereco,sexo,salario,cpf_supervisor)
VALUES('Fernando', 'T', 'Wong', '33344555587', '13-04-1972', 'Rua da Lapa 93 - São Paulo, SP', 'M', 50000, '88665555586');

INSERT INTO Departamento(id,nome, cpf_gerente) VALUES(1,'Desenvolvimento', '33344555587');

UPDATE Funcionario SET id_departamento=1 WHERE cpf='33344555587';

INSERT INTO Funcionario(nome,inicial_nome_meio,sobrenome,cpf,data_nasc,endereco,sexo,salario,cpf_supervisor)
VALUES('João', 'B', 'Silva', '12345678966', '19-01-1975', 'Rua das Flores 175 - São Paulo, SP', 'M', 50000, '33344555587');

INSERT INTO Departamento(id,nome, cpf_gerente) VALUES(2, 'Marketing', '12345678966');

UPDATE Funcionario SET id_departamento=2 WHERE cpf='12345678966';

-- filhos João
INSERT INTO Dependente(cpf_funcionario, nome, sobrenome, data_nasc, sexo, parentesco)
VALUES('12345678966', 'Paulo', 'B. Silva', '15-02-1999', 'M', 'filho');

INSERT INTO Dependente(cpf_funcionario, nome, sobrenome, data_nasc, sexo, parentesco)
VALUES('12345678966', 'Camila', 'A. Silva', '08-07-1997', 'F', 'filho');

-- Marketing

INSERT INTO Funcionario(nome,inicial_nome_meio,sobrenome,cpf,data_nasc,endereco,sexo,salario,cpf_supervisor, id_departamento)
VALUES('Maria', 'J', 'Silva', '12141678166', '11-02-1983', 'Rua das Neves 71 - São Paulo, SP', 'F', 21000, '12345678966', 2);

-- filha Maria
INSERT INTO Dependente(cpf_funcionario, nome, sobrenome, data_nasc, sexo, parentesco)
VALUES('12141678166', 'Jaqueline', 'A. Silva', '02-08-2015', 'F', 'filho');

--
INSERT INTO Funcionario(nome,inicial_nome_meio,sobrenome,cpf,data_nasc,endereco,sexo,salario,cpf_supervisor, id_departamento)
VALUES('Rudnei', 'T', 'Sacan', '12541618556', '21-12-1989', 'Rua das Flores 326 - São Paulo, SP', 'M', 21000, '12345678966', 2);

-- filho Rudnei
INSERT INTO Dependente(cpf_funcionario, nome, sobrenome, data_nasc, sexo, parentesco)
VALUES('12541618556', 'Rudnei', 'T. Sacan Filho', '18-11-2011', 'M', 'filho');

--
INSERT INTO Funcionario(nome,inicial_nome_meio,sobrenome,cpf,data_nasc,endereco,sexo,salario,cpf_supervisor, id_departamento)
VALUES('Rubneia', 'Z', 'Aparecida', '32142618456', '21-12-1987', 'Rua dos Operários 771 - São Paulo, SP', 'F', 24000, '12345678966', 2);

INSERT INTO Funcionario(nome,inicial_nome_meio,sobrenome,cpf,data_nasc,endereco,sexo,salario,cpf_supervisor, id_departamento)
VALUES('Rony', 'F', 'Tota', '31144658676', '24-11-1986', 'Rua dos Lavradores 676 - Guarulhos, SP', 'M', 16000, '12345678966', 2);

-- filho Rony
INSERT INTO Dependente(cpf_funcionario, nome, sobrenome, data_nasc, sexo, parentesco)
VALUES('31144658676', 'Ronnaldo', 'J. Tota', '03-03-2006', 'M', 'filho');

--
INSERT INTO Funcionario(nome,inicial_nome_meio,sobrenome,cpf,data_nasc,endereco,sexo,salario,cpf_supervisor, id_departamento)
VALUES('Wanda', 'S', 'Menezes', '39146668786', '14-05-1995', 'Rua dos Pastores 333 - Osasco, SP', 'F', 15000, '12345678966', 2);

-- filho Wanda
INSERT INTO Dependente(cpf_funcionario, nome, sobrenome, data_nasc, sexo, parentesco)
VALUES('39146668786', 'Wolnei', 'L. Menezes', '10-01-2004', 'M', 'filho');



INSERT INTO Projeto(id, nome, id_departamento) VALUES(1, 'Campanha de Divulgação', 2);

INSERT INTO Trabalha_em(cpf_funcionario, id_projeto, horas) VALUES('12141678166', 1, 13.0);
INSERT INTO Trabalha_em(cpf_funcionario, id_projeto, horas) VALUES('12541618556', 1, 23.0);
INSERT INTO Trabalha_em(cpf_funcionario, id_projeto, horas) VALUES('32142618456', 1, 17.0);

-- Desenvolvimento

INSERT INTO Funcionario(nome,inicial_nome_meio,sobrenome,cpf,data_nasc,endereco,sexo,salario,cpf_supervisor, id_departamento)
VALUES('Mauro', 'G', 'Moura', '12341678186', '30-03-1987', 'Rua General Carneiro  89 - São Paulo, SP', 'M', 20000, '33344555587', 1);

INSERT INTO Funcionario(nome,inicial_nome_meio,sobrenome,cpf,data_nasc,endereco,sexo,salario,cpf_supervisor, id_departamento)
VALUES('Alex', 'F', 'Albin', '16571819556', '20-12-1988', 'Rua Coronel Dulcídio 211 - São Paulo, SP', 'M', 21000, '33344555587', 1);

INSERT INTO Funcionario(nome,inicial_nome_meio,sobrenome,cpf,data_nasc,endereco,sexo,salario,cpf_supervisor, id_departamento)
VALUES('Camila', 'H', 'Machado', '32164648657', '11-12-1997', 'Rua Cabo Fontes 2512 - São Paulo, SP', 'F', 23000, '33344555587', 1);

INSERT INTO Funcionario(nome,inicial_nome_meio,sobrenome,cpf,data_nasc,endereco,sexo,salario,cpf_supervisor, id_departamento)
VALUES('Raoni', 'T', 'Sousa', '31246598456', '24-11-1996', 'Rua Maestro Tom Jobim 1118 - Guarulhos, SP', 'M', 16000, '33344555587', 1);

INSERT INTO Funcionario(nome,inicial_nome_meio,sobrenome,cpf,data_nasc,endereco,sexo,salario,cpf_supervisor, id_departamento)
VALUES('Rafael', 'C', 'Rocha', '39146124386', '04-05-1993', 'Rua Olavo Bilac 515 - Osasco, SP', 'M', 15000, '33344555587', 1);

INSERT INTO Funcionario(nome,inicial_nome_meio,sobrenome,cpf,data_nasc,endereco,sexo,salario,cpf_supervisor, id_departamento)
VALUES('Lavínia', 'J', 'Roma', '39146263486', '13-05-1991', 'Rua Manoel Bandeira 418 - Santo André, SP', 'F', 25000, '33344555587', 1);

INSERT INTO Funcionario(nome,inicial_nome_meio,sobrenome,cpf,data_nasc,endereco,sexo,salario,cpf_supervisor, id_departamento)
VALUES('Jorge', 'F', 'Medeiros', '33146568786', '04-06-1992', 'Rua Monteiro Lobato 781  - São Bernardo, SP', 'M', 15000, '33344555587', 1);

-- IS NULL

-- cpf_supervisor IS NULL
INSERT INTO Funcionario(nome,inicial_nome_meio,sobrenome,cpf,data_nasc,endereco,sexo,salario, id_departamento)
VALUES('Karlos', 'L', 'Bueno', '90446548746', '12-02-1998', 'Rua das Amoreiras 1231  - São Caetano, SP', 'M', 12700, 1);

INSERT INTO Funcionario(nome,inicial_nome_meio,sobrenome,cpf,data_nasc,endereco,sexo,salario, id_departamento)
VALUES('Gisele', 'F', 'Almeida', '90141518749', '27-07-1994', 'Rua das Goiabeiras 5432  - Metrópolis, SP', 'F', 11500, 1);


INSERT INTO Projeto(id, nome, id_departamento) VALUES(2, 'Produto A', 1);

INSERT INTO Trabalha_em(cpf_funcionario, id_projeto, horas) VALUES('12341678186', 2, 12.0);
INSERT INTO Trabalha_em(cpf_funcionario, id_projeto, horas) VALUES('16571819556', 2, 21.0);
INSERT INTO Trabalha_em(cpf_funcionario, id_projeto, horas) VALUES('32164648657', 2, 15.0);
INSERT INTO Trabalha_em(cpf_funcionario, id_projeto, horas) VALUES('33146568786', 2, 6.5);
INSERT INTO Trabalha_em(cpf_funcionario, id_projeto, horas) VALUES('39146263486', 2, 5.5);

INSERT INTO Projeto(id, nome, id_departamento) VALUES(3, 'Produto B', 1);

INSERT INTO Trabalha_em(cpf_funcionario, id_projeto, horas) VALUES('12341678186', 3, 5.3);
INSERT INTO Trabalha_em(cpf_funcionario, id_projeto, horas) VALUES('39146124386', 3, 4.8);
INSERT INTO Trabalha_em(cpf_funcionario, id_projeto, horas) VALUES('39146263486', 3, 7.2);
INSERT INTO Trabalha_em(cpf_funcionario, id_projeto, horas) VALUES('33146568786', 3, 16.0);
INSERT INTO Trabalha_em(cpf_funcionario, id_projeto, horas) VALUES('16571819556', 3, 22.0);
INSERT INTO Trabalha_em(cpf_funcionario, id_projeto, horas) VALUES('32164648657', 3, 11.0);
INSERT INTO Trabalha_em(cpf_funcionario, id_projeto, horas) VALUES('31246598456', 3, 10.5);


