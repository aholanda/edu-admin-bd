CREATE TABLE funcionario(
   id		 INT PRIMARY KEY NOT NULL,
   nome          VARCHAR(128) NOT NULL,
   nascimento    DATE NOT NULL,
   endereco      VARCHAR(256),
   salario       REAL
);

CREATE TABLE auditoria(
    funcionarioId INT NOT NULL REFERENCES funcionario(id),
    dataEntrada   TIMESTAMP NOT NULL
);

CREATE OR REPLACE FUNCTION Auditar() RETURNS TRIGGER AS $$
    BEGIN
        INSERT INTO auditoria(funcionarioId, dataEntrada) VALUES (new.id, current_timestamp);
        RETURN NEW;
    END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER triggerFuncionario AFTER INSERT ON funcionario
       FOR EACH ROW EXECUTE PROCEDURE Auditar();

INSERT INTO funcionario VALUES (1, 'Alice Silva', '1991-10-12', 'Av. Brasil 123', 2000.00 );

SELECT * FROM funcionario;

SELECT * FROM auditoria;

-- Para listar as triggers
 SELECT * FROM pg_trigger;

-- Para listar as triggers de uma tabela em particular
SELECT tgname FROM pg_trigger, pg_class 
       WHERE tgrelid=pg_class.oid AND relname='funcionario';





 CREATE OR REPLACE FUNCTION RemoveAluno() RETURNS TRIGGER AS $func$
 BEGIN
   IF NEW.semestre > 8 THEN
     DELETE FROM aluno WHERE id = NEW.id;
   END IF;

   RETURN NEW;
 END;
 $func$ LANGUAGE plpgsql;

 CREATE TRIGGER RemoveGraduado AFTER UPDATE OF semestre ON aluno
  FOR EACH ROW EXECUTE PROCEDURE RemoveAluno();


% CREATE OR REPLACE FUNCTION AtualizaProduto() RETURNS TRIGGER AS $func$
 DECLARE nitens INTEGER;
 BEGIN
     SELECT quantidade INTO nitens FROM produto WHERE id = NEW.produto_id;

     IF NEW.quantidade <= nitens THEN
          UPDATE produto SET quantidade = quantidade - NEW.quantidade WHERE id = NEW.produto_id;
     ELSE
          RAISE NOTICE 'Restando % itens em estoque', nitens;
          DELETE FROM venda WHERE id = NEW.id;
     END IF;

     RETURN NEW;
 END;
 $func$ LANGUAGE plpgsql;
 CREATE TRIGGER Venda AFTER INSERT ON venda
 FOR EACH ROW EXECUTE PROCEDURE AtualizaProduto();
