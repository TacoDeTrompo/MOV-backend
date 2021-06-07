-- TODO:
-- get all ingress total from profile
-- get all expense total from profile
-- get total from profile ((total ingress)-(total expense))

/*

result
{
    "amount":0
}*/

DELIMITER //

DROP PROCEDURE IF EXISTS spGetAllExpenses;
CREATE PROCEDURE spGetAllExpenses(
    IN inId integer
)
BEGIN    
	select COALESCE(SUM(amount),0) `amount` from tbTransaction where `idprofile` = inId and `ttype` = 0;
END //

DELIMITER ;

DELIMITER //

DROP PROCEDURE IF EXISTS spGetAllIngress;
CREATE PROCEDURE spGetAllIngress(
    IN inId integer
)
BEGIN    
	select COALESCE(SUM(amount),0) `amount` from tbTransaction where `idprofile` = inId and `ttype` = 1;
END //

DELIMITER ;

DELIMITER //

DROP PROCEDURE IF EXISTS spGetProfileTotal;
CREATE PROCEDURE spGetProfileTotal(
    IN inId integer
)
BEGIN

    select SUM(amount) `amount`
    INTO @expenses
    from tbTransaction where `idprofile` = inId and `ttype` = 0;

    select SUM(amount) `amount`
    INTO @ingress
    from tbTransaction where `idprofile` = inId and `ttype` = 1;

	select (COALESCE(@ingress, 0) - COALESCE(@expenses, 0)) `total`;
END //

DELIMITER ;