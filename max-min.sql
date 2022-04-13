CREATE OR REPLACE FUNCTION MaxMin( 
  a NUMERIC,                     
  b NUMERIC,                    
  c NUMERIC,                   
        OUT max NUMERIC,      
        OUT min NUMERIC)     
AS $$                       
BEGIN 
  max := GREATEST(a,b,c);                                                                                                                                               
  min := LEAST(a,b,c);                                                                                                                                                  
END; $$                                                                                                                                                                 
LANGUAGE plpgsql;
