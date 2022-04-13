CREATE OR REPLACE FUNCTION DuracaoEmprestimo(idCliente INTEGER, dataFinal DATE)
       RETURNS INTEGER AS $$
DECLARE 
	duracao INTEGER; 
BEGIN
	SELECT INTO duracao SUM(dataFinal - dataEmprestimo) 
    	FROM emprestimo
    	WHERE id = idCliente;
 
 RETURN duracao;
END; $$
LANGUAGE plpgsql;