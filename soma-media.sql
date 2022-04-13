CREATE OR REPLACE FUNCTION SomaMedia(
       VARIADIC lista NUMERIC[],
       OUT total NUMERIC, 
       OUT media NUMERIC)
AS $$
BEGIN
   SELECT INTO total SUM(lista[i])
   FROM generate_subscripts(lista, 1) g(i);
 
   SELECT INTO media AVG(lista[i])
   FROM generate_subscripts(lista, 1) g(i);
END; $$
LANGUAGE plpgsql;