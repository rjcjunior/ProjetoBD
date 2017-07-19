CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `produto` AS
    SELECT 
        `PRODUTO`.`P_ID` AS `P_ID`,
        `PRODUTO`.`P_NOME` AS `P_NOME`,
        `PRODUTO`.`P_VALOR` AS `P_VALOR`
    FROM
        `PRODUTO`
