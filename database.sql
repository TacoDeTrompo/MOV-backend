-- remember to run de file using root, password adminadmin
-- sudo mysql -u root -p MOVdb  < database.sql
--
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS tbExpensetype;
create table tbExpensetype(
    `id` integer NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `title` VARCHAR(50),
    `value` integer
);

DROP TABLE IF EXISTS tbUserdata;
create table tbUserdata(
    `id` int AUTO_INCREMENT PRIMARY KEY,
    `firstname` VARCHAR(50),
    `lastname` VARCHAR(50),
    `username` VARCHAR(50),
    `password` VARCHAR(50),
    `email` VARCHAR(50),
    `token` char(64),
    `picture` blob
);

DROP TABLE IF EXISTS tbProfile;
create table tbProfile(
    `id` integer AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50),
    `description` VARCHAR(250),
    `dayrange` integer,
    `startday` date,
    `color` VARCHAR(50),
    `iduserdata` integer NOT NULL,
    CONSTRAINT fk_userdata FOREIGN KEY (`iduserdata`) REFERENCES tbUserdata(`id`)
);

DROP TABLE IF EXISTS tbAdvice;
create table tbAdvice(
    `id` int AUTO_INCREMENT PRIMARY KEY,
    `title` VARCHAR(50),
    `description` VARCHAR(250),
    `picture` blob
);

DROP TABLE IF EXISTS tbTransaction;
create table tbTransaction (
    `id` integer NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50),
    `description` VARCHAR(250),
    `amount` float,
    `date` DATE,
    `ttype` integer,
    `idexpensetype` integer NOT NULL,
    `idprofile` integer NOT NULL,
    CONSTRAINT fk_expensetype FOREIGN KEY (`idexpensetype`) REFERENCES tbExpensetype(`id`),
    CONSTRAINT fk_profile FOREIGN KEY (`idprofile`) REFERENCES tbProfile(`id`)
);

SET FOREIGN_KEY_CHECKS = 1;
--
DROP PROCEDURE IF EXISTS spTest;

DELIMITER //
DROP PROCEDURE IF EXISTS spInsertExpensetype;
CREATE PROCEDURE spInsertExpensetype(     
    IN inTitle VARCHAR(50),     
    IN inValue integer
) 
BEGIN    
    insert into tbExpensetype (`title`, `value`) values (inTitle, inValue);
END //

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS spInsertTbProfile;
CREATE PROCEDURE spInsertTbProfile(     
    IN inName VARCHAR(50),     
    IN inDescription VARCHAR(250),
    IN inDayrange integer,      
    IN inColor VARCHAR(50),
    IN inIduserdata integer
) 
BEGIN    
    insert into tbProfile (`name`, `description`, `dayrange`, `startday`, `color`, `iduserdata`) values (inName, inDescription, inDayrange, now(), inColor, inIduserdata);
END //

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS spInsertTbUserdata;
CREATE PROCEDURE spInsertTbUserdata(     
    IN inFirstName VARCHAR(50),     
    IN inLastName VARCHAR(50),
    IN inUsername VARCHAR(50),     
    IN inPassword VARCHAR(50),     
    IN inEmail VARCHAR(50),  
    IN inPicture blob
)
BEGIN    
    insert into tbUserdata (`firstname`,`lastname`,`username`,`password`,`email`,`token`,`picture`) values (`inFirstName`, `inLastName`, `inUsername`, `inPassword`, `inEmail`, SHA2(CONCAT(`inFirstName`,`inPassword`), 224), `inPicture`);
END //

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS spInsertTbAdvice;
CREATE PROCEDURE spInsertTbAdvice(     
    IN inTitle VARCHAR(50),     
    IN inDescription VARCHAR(250),   
    IN inPicture blob
) 
BEGIN    
    insert into tbAdvice (`title`,`description`,`picture`) values (inTitle,inDescription,inPicture);
END //

DELIMITER ;

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
    insert into tbTransaction (`name`,`description`,`amount`,`date`,`ttype`,`idexpensetype`,`idprofile`) values (inName,inDescription,inAmount,now(),inTtype,inIdexpensetype,inIdprofile);
END //

DELIMITER ;

-- -- -- -- -- -- 

DELIMITER //
DROP PROCEDURE IF EXISTS spUpdateTbProfile;
CREATE PROCEDURE spUpdateTbProfile(   
    IN inId integer,
    IN inName VARCHAR(50),
    IN inDescription VARCHAR(250),
    IN inDayrange integer,
    IN inStartday date,
    IN inColor VARCHAR(50)
) 
BEGIN    
	UPDATE tbProfile
	SET `name` = inName,
		`description` = inDescription,
		`dayrange` = inDayrange,
		`startday` = inStartday,
		`color` = inColor
	WHERE `id` = inId;
END //

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS spUpdateTbUserdata;
CREATE PROCEDURE spUpdateTbUserdata(    
    IN inId integer,      
    IN inFirstName VARCHAR(50),     
    IN inLastName VARCHAR(50),
    IN inUsername VARCHAR(50),     
    IN inPassword VARCHAR(50),     
    IN inEmail VARCHAR(50),
    IN inToken VARCHAR(50),     
    IN inPicture blob 
) 
BEGIN    
	UPDATE tbUserdata
	SET `firstname` = inFirstName,
		`lastname` = inLastName,
		`username` = inUsername,
		`password` = inPassword,
		`email` = inEmail,
		`token` = inToken,
		`picture` = inPicture
	WHERE `id` = inId;
END //

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS spUpdateTbAdvice;
CREATE PROCEDURE spUpdateTbAdvice(  
    IN inId integer,
    IN inTitle VARCHAR(50),
    IN inDescription VARCHAR(250),
    IN inPicture blob
)
BEGIN    
	UPDATE tbAdvice
	SET `title` = inTitle,
		`description` = inDescription,
		`picture` = inPicture
	WHERE `id` = inId;
END //

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS spUpdateTbTransaction;
CREATE PROCEDURE spUpdateTbTransaction( 
    IN inId integer,
    IN inName VARCHAR(50),     
    IN inDescription VARCHAR(250),   
    IN inAmount float,
    IN inTtype integer,
    IN inIdexpensetype integer,
    In inIdprofile integer
) 
BEGIN   
	UPDATE tbTransaction
	SET `name` = inName,
		`description` = inDescription,
		`amount` = inAmount,
		`ttype` = inTtype,
		`idexpensetype` = inIdexpensetype,
		`idprofile` = inIdprofile 
	WHERE `id` = inId;
END //

DELIMITER ;

-- CALL spInsertExpensetype('FOOD', 0);
-- CALL spInsertExpensetype('ENTERTAINMENT', 1);
-- CALL spInsertExpensetype('SERVICES', 2);
-- CALL spInsertExpensetype('INVESTMENT', 3);

-- CALL spInsertTbUserdata ('Miguel', 'Dias', 'Jeffs', 'admin', 'admin@admin.com', 'picture');

-- CALL spInsertTbProfile('ProfileName', 'ProfileDescription', 7, '#000000', 1);

-- CALL spInsertTbTransaction ('name', 'description', 10000, 1, 1, 1);
-- CALL spInsertTbTransaction ('name2', 'description2', 5000, 0, 1, 2);

