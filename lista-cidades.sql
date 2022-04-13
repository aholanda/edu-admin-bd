CREATE OR REPLACE FUNCTION ListarCidades(nomeEstado TEXT)
RETURNS VOID AS $$
DECLARE	
	reg RECORD;
	consulta TEXT;
BEGIN 
	consulta := 'SELECT C.nome AS nomeCidade FROM cidade AS C, estado AS E WHERE E.id=C.estado_id 
	AND E.nome = $1 ORDER BY C.nome';

	FOR reg IN EXECUTE consulta USING nomeEstado
		LOOP
			RAISE NOTICE '%', reg.nomeCidade;
		END LOOP;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION ListarCidades(nomeEstado TEXT, N INTEGER)
RETURNS VOID AS $$
DECLARE	
	reg RECORD;
	consulta TEXT;
BEGIN 
	consulta := 'SELECT C.nome AS nomeCidade FROM cidade AS C, estado AS E WHERE E.id=C.estado_id 
	AND E.nome = $1 ORDER BY C.nome LIMIT $2';

	FOR reg IN EXECUTE consulta USING nomeEstado, N
		LOOP
			RAISE NOTICE '%', reg.nomeCidade;
		END LOOP;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION ListarCidades(VARIADIC lista TEXT[])
RETURNS VOID AS $$
DECLARE	
	tmp TEXT;
	str TEXT; 
	consulta TEXT;
	reg RECORD;
BEGIN 
	consulta := 'SELECT C.nome AS nomeCidade FROM cidade AS C, estado AS E WHERE E.id=C.estado_id AND ';

        foreach str in array lista loop
        	execute format($f$select 'E.nome =''%s'' OR '$f$, str) into tmp;
		consulta := consulta || tmp;
	end loop;	

	consulta = consulta || '1=2'; -- somente para fechar o ultimo OR da consulta

	RAISE NOTICE '%', consulta;

	FOR reg IN EXECUTE consulta
		LOOP
			RAISE NOTICE '%', reg.nomeCidade;
		END LOOP;
END;
$$ LANGUAGE plpgsql;
