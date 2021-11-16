/*Un trigger que impida el acceso de un inmigrante 
más de cinco veces en el mismo mes a un inmigrante. (Podría pensarse que está traficando) 
*/
CREATE OR REPLACE FUNCTION RESTRICCION() RETURNS TRIGGER
AS
$$
DECLARE
INGRESO INT:=0;
MAXIMO INT:=5;
BEGIN
	SELECT
	COUNT(EXTRACT(MONTH FROM REGISTRO_FECHA_INGRESO)) INTO INGRESO FROM REGISTRO WHERE CLIENTE_ID=NEW.CLIENTE_ID;
	IF INGRESO>=MAXIMO THEN
	RAISE EXCEPTION 'Inmigrante no permitido, sus ingresos superan al maximo establecido !ALERTA!! Sospecha de trafico';
	END IF;
	RETURN NEW;
END
$$
LANGUAGE 'plpgsql';


CREATE TRIGGER IMPEDIR_ACCESO BEFORE INSERT ON REGISTRO FOR EACH ROW EXECUTE PROCEDURE RESTRICCION();