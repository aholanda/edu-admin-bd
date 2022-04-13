CREATE TABLE  IF NOT EXISTS emprestimo(id INTEGER, dataEmprestimo DATE);
INSERT INTO emprestimo VALUES(123, '2015-10-05');
CREATE OR REPLACE FUNCTION DuracaoEmprestimo(idCliente INTEGER)
       RETURNS INTEGER AS $$
DECLARE 
	duracao INTEGER; 
	current_date INTEGER;
BEGIN
	SELECT INTO duracao SUM(current_date - dataEmprestimo) 
    	FROM emprestimo
    	WHERE id = idCliente;
 
 RETURN duracao;
END; $$
LANGUAGE plpgsql;