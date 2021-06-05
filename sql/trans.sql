
/*
Transaction
{
  "idBD": 0,
  "name": "",
  "ttype": 0,
  "color": "",
  "profileId": 0,
  "description": "",
  "expenseType": 0
}


Expense
{
  "idBD": 0,
  "name": "",
  "ttype": 0,
  "color": "",
  "profileId": 0,
  "description: "",
  "expenseType": 0
}


Ingress
{
  "idBD": 0,
  "name": "",
  "ttype": 0,
  "color": "",
  "profileId": 0,
  "description: ""
}
*/

--                                                                          sql     | endpoint
-- insert                                                                   Y       | N
-- get expense and get ingress (id trans)                                   Y       | N
-- get expenses by (idProfile)                                              Y       | N
-- get ingresses by (idProfile)                                             Y       | N
-- if it is an ingress, expensetype is null                                 
-- update                                                                   Y       | N
-- delete                                                                   Y       | N

-- SET FOREIGN_KEY_CHECKS = 0;
-- DROP TABLE IF EXISTS tbExpensetype;
-- DROP TABLE IF EXISTS tbTransaction;
-- create table tbTransaction (
--     `id` integer NOT NULL AUTO_INCREMENT PRIMARY KEY,
--     `name` VARCHAR(50),
--     `description` VARCHAR(250),
--     `amount` float,
--     `ttype` integer,
--     `idexpensetype` integer,
--     `idprofile` integer NOT NULL,
--     CONSTRAINT fk_profile FOREIGN KEY (`idprofile`) REFERENCES tbProfile(`id`)
-- );
-- SET FOREIGN_KEY_CHECKS = 1;

DELIMITER //
DROP PROCEDURE IF EXISTS spInsertTbTransaction;
CREATE PROCEDURE spInsertTbTransaction(     
    IN inName VARCHAR(50),     
    IN inDescription VARCHAR(250),   
    IN inAmount float,
    IN inTtype integer,
    IN inIdexpensetype integer,
    In inIdprofile integer
) 
BEGIN    
    insert into tbTransaction (`name`,`description`,`amount`,`ttype`,`idexpensetype`,`idprofile`) values (inName,inDescription,inAmount,inTtype,inIdexpensetype,inIdprofile);
END //

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS spUpdateTbTransaction;
CREATE PROCEDURE spUpdateTbTransaction( 
    IN inId integer,
    IN inName VARCHAR(50),     
    IN inDescription VARCHAR(250),   
    IN inAmount float,
    IN inIdexpensetype integer
) 
BEGIN   
	UPDATE tbTransaction
	SET `name` = inName,
		`description` = inDescription,
		`amount` = inAmount,
		`idexpensetype` = inIdexpensetype
	WHERE `id` = inId;
END //

DELIMITER ;

DELIMITER //

DROP PROCEDURE IF EXISTS spDeleteTbTransaction;
CREATE PROCEDURE spDeleteTbTransaction(   
    IN inId integer
) 
BEGIN    
	DELETE FROM TbTransaction
	WHERE `id` = inId;
END //

DELIMITER ;

DELIMITER //

DROP PROCEDURE IF EXISTS spGetExpense;
CREATE PROCEDURE spGetExpense(
    IN inId integer
)
BEGIN    
	select * from TbTransaction where inId = `id` and `ttype` = 0;
END //

DELIMITER ;

DELIMITER //

DROP PROCEDURE IF EXISTS spGetIngress;
CREATE PROCEDURE spGetIngress(
    IN inId integer
)
BEGIN    
	select * from TbTransaction where inId = `id` and `ttype` = 1;
END //

DELIMITER ;

DELIMITER //

DROP PROCEDURE IF EXISTS spGetExpenses;
CREATE PROCEDURE spGetExpenses(IN inId integer)
BEGIN    
	select * from TbTransaction where `idprofile` = inId and `ttype` = 0;
END //

DELIMITER ;

DELIMITER //

DROP PROCEDURE IF EXISTS spGetIngresses;
CREATE PROCEDURE spGetIngresses(IN inId integer)
BEGIN    
	select * from TbTransaction where `idprofile` = inId and `ttype` = 1;
END //

DELIMITER ;