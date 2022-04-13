CREATE OR REPLACE FUNCTION quadrado(
       INOUT a NUMERIC)
AS $$
BEGIN
	a := a * a;
END; $$
LANGUAGE plpgsql;