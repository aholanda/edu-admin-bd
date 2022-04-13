CREATE OR REPLACE FUNCTION Fibonacci (n INTEGER) 
       RETURNS INTEGER AS $$ 
DECLARE
   contador INTEGER := 0 ; 
   i INTEGER := 0 ; 
   j INTEGER := 1 ;
BEGIN
 
 IF (n < 1) THEN
    RETURN 0 ;
    END IF; 
    
    LOOP 
    	 EXIT WHEN contador = n ; 
	      contador := contador + 1 ; 
	      	      SELECT j, i + j INTO i,	j ;
		      END LOOP ; 
		      
		      RETURN i ;
END ; 
$$ LANGUAGE plpgsql;