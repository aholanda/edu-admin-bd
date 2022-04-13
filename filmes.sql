CREATE TABLE  IF NOT EXISTS filme(titulo VARCHAR(128), anoLancamento INTEGER);
INSERT INTO filme VALUES('Forrest Gump',1994);
INSERT INTO filme VALUES('O Resgate do Soldado Ryan',1998);
INSERT INTO filme VALUES('Rain Man',1988);
INSERT INTO filme VALUES('O Curioso Caso de Benjamin Button',2008);
INSERT INTO filme VALUES('A Lista de Schindler',1993);
INSERT INTO filme VALUES('Patch Adans',1998);
INSERT INTO filme VALUES('Sociedade dos Poetas Mortos',1989);

CREATE OR REPLACE FUNCTION ListarFilmes(
   tipoOrder INTEGER,
   n INTEGER
) 
RETURNS VOID AS $$
DECLARE
    reg RECORD; -- registro
    consulta TEXT;
BEGIN
		
		consulta := 'SELECT titulo, anoLancamento FROM filme ';
		IF tipoOrder = 1 THEN
		   consulta := consulta || 'ORDER BY titulo';
		ELSIF tipoOrder = 2 THEN
		     consulta := consulta || 'ORDER BY anoLancamento';
		ELSE 
		     RAISE EXCEPTION 'Tipo de ORDER incorreto %s', tipoOrder;
		END IF;
 
 consulta := consulta || ' LIMIT $1';
 
 FOR reg IN EXECUTE consulta USING n 
        LOOP
	   RAISE NOTICE '% - %', reg.anoLancamento, reg.titulo;
	END LOOP;
   
END;
$$ LANGUAGE plpgsql;