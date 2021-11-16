/*Un procedimiento almacenado donde se ingrese un país 
y muestre los datos de todos los ciudadanos extranjeros 
pertenecientes a ese país*/

CREATE OR REPLACE FUNCTION PAIS(VARCHAR) RETURNS SETOF CLIENTE
AS
$$
SELECT * FROM CLIENTE
WHERE
NACIONALIDAD_ID=$1
$$
LANGUAGE SQL;

/*uso del proceso almacenado*/
select *from pais('COL');