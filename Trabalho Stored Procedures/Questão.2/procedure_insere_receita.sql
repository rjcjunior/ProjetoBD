CREATE  PROCEDURE `INSERE_RECEITA`(
PID_PESSOA INTEGER,
PTITULO VARCHAR(60),
PDATA_POSTAGEM DATE,
PMODO_PREPARO TEXT,
OUT O_COMPLETA VARCHAR(30)
)
BEGIN
DECLARE done INT DEFAULT FALSE;
DECLARE COMPLETA BOOLEAN;
DECLARE TINGREDIENTE VARCHAR(30);
DECLARE TID_INGREDIENTE INTEGER;
DECLARE TQUANTIDADE INTEGER;
DECLARE TID_RECEITA INTEGER;
DECLARE TEMP_MEDIDA VARCHAR(10);
DECLARE TEMP_INGREDIENTE CURSOR FOR 
		(SELECT INGREDIENTE_RECEITA.DESCRICAO, INGREDIENTE_RECEITA.QUANTIDADE  
        FROM INGREDIENTE_RECEITA);
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
      

	OPEN TEMP_INGREDIENTE;
    SET COMPLETA = TRUE;

	INSERT INTO RECEITA(ID_PESSOA,TITULO,DATA_ENVIO,MODO_PREPARO)
    VALUES(PID_PESSOA,PTITULO,PDATA_POSTAGEM,PMODO_PREPARO);
    
    LOOP_INGREDIENTES:LOOP
        FETCH TEMP_INGREDIENTE  INTO TINGREDIENTE,TQUANTIDADE;
        IF done THEN
			LEAVE LOOP_INGREDIENTES;
		END IF; 
        
		SELECT INGREDIENTE.ID_INGREDIENTE, INGREDIENTE.MEDIDA FROM INGREDIENTE
            WHERE INGREDIENTE.DESCRICAO = TINGREDIENTE
            INTO TID_INGREDIENTE, TEMP_MEDIDA;
		IF TID_INGREDIENTE IS NOT NULL THEN
			SELECT RECEITA.ID_RECEITA FROM RECEITA
            WHERE RECEITA.TITULO = PTITULO
            INTO TID_RECEITA;
            
            IF TEMP_MEDIDA = 'UNIDADE' THEN
			
					SET TQUANTIDADE = ROUND(TQUANTIDADE);
           
           END IF;     
                
		    INSERT INTO RECEITA_INGREDIENTE(ID_RECEITA,ID_INGREDIENTE,QUANTIDADE)
            VALUES(TID_RECEITA,TID_INGREDIENTE,TQUANTIDADE);
        else
			SET COMPLETA = FALSE;
        END IF;	
    END LOOP LOOP_INGREDIENTES;   

    CLOSE TEMP_INGREDIENTE;

	IF COMPLETA THEN
		SET O_COMPLETA = 'CADASTRADA COM SUCESSO';
	ELSE
		SET O_COMPLETA = 'RECEITA INCOMPLETA';
    END IF;  
    
END
