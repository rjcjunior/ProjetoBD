CREATE  PROCEDURE `RETORNO_RECEITA`(
P_TITULO VARCHAR(100),
P_FATOR INTEGER,
OUT R_TITULO VARCHAR(100),
OUT R_PREPARO TEXT,
OUT R_INGREDIENTES TEXT
)
BEGIN
DECLARE TEMP_QUANTIDADE float;
DECLARE TEMP_MEDIDA VARCHAR(10);
DECLARE TEMP_DESCRICAO VARCHAR(60);
DECLARE TEMP_PREPARO TEXT;
DECLARE TEMP_TITULO VARCHAR(10);
DECLARE done INT DEFAULT FALSE;
DECLARE TEMP_INGREDIENTES TEXT;
DECLARE TEMP_INGREDIENTES_FRACIONADO TEXT;
DECLARE FRACIONADO BOOLEAN;
DECLARE CURSOR_RECEITA CURSOR FOR
		(SELECT RECEITA_INGREDIENTE.QUANTIDADE,
				INGREDIENTE.DESCRICAO,
                INGREDIENTE.MEDIDA,
                RECEITA.MODO_PREPARO,
                RECEITA.TITULO
		 FROM RECEITA_INGREDIENTE,
				INGREDIENTE,
				RECEITA
		 WHERE  RECEITA_INGREDIENTE.ID_INGREDIENTE = INGREDIENTE.ID_INGREDIENTE AND
				RECEITA.ID_RECEITA = RECEITA_INGREDIENTE.ID_RECEITA AND
				RECEITA.TITULO = P_TITULO);
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;   

	OPEN CURSOR_RECEITA;
    SET TEMP_INGREDIENTES = ' ';
    SET FRACIONADO = TRUE;
    LOOP_RECEITA :LOOP
		FETCH CURSOR_RECEITA INTO TEMP_QUANTIDADE,TEMP_DESCRICAO,TEMP_MEDIDA,TEMP_PREPARO,TEMP_TITULO;
        IF done THEN
			LEAVE LOOP_RECEITA;
		END IF;      
        IF TEMP_MEDIDA = 'UNIDADE' THEN
			IF MOD(TEMP_QUANTIDADE,P_FATOR) = 0 THEN
				SET TEMP_QUANTIDADE = TEMP_QUANTIDADE/P_FATOR;
                SET TEMP_INGREDIENTES = CONCAT(TEMP_INGREDIENTES,TEMP_DESCRICAO);
                SET TEMP_INGREDIENTES = CONCAT(TEMP_INGREDIENTES,TEMP_QUANTIDADE);
			ELSE
				SET FRACIONADO = FALSE;
                SET TEMP_INGREDIENTES = CONCAT(TEMP_INGREDIENTES,TEMP_DESCRICAO);
                SET TEMP_INGREDIENTES = CONCAT(TEMP_INGREDIENTES,TEMP_QUANTIDADE);
			END IF;
         else 
         IF FRACIONADO THEN
			SET TEMP_QUANTIDADE = TEMP_QUANTIDADE/P_FATOR;
			SET TEMP_INGREDIENTES = CONCAT(TEMP_INGREDIENTES,TEMP_DESCRICAO);
			SET TEMP_INGREDIENTES = CONCAT(TEMP_INGREDIENTES,TEMP_QUANTIDADE);
         else
			SET TEMP_INGREDIENTES = CONCAT(TEMP_INGREDIENTES,TEMP_DESCRICAO);
			SET TEMP_INGREDIENTES = CONCAT(TEMP_INGREDIENTES,TEMP_QUANTIDADE);
		 END IF;
        END IF; 
        
    END LOOP LOOP_RECEITA;
    SET R_PREPARO = TEMP_PREPARO;
    SET R_TITULO = TEMP_TITULO;
    SET R_INGREDIENTES = TEMP_INGREDIENTES;

END

