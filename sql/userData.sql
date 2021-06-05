--
/* User data json recive and send
{
  "token": "", // this also doubles as the password value
  "firstName": "",
  "lastName": "",
  "username": "",
  "email": "",
  "imgArray": [],
  "cloudId": 0
}
*/

--                                                                      sql         | endpoint
-- get (login, email and password) user (email and token as password)   done        | done
-- insert (signup)                                                      done        | not done
-- update                                                               done        | not done

DELIMITER //

DROP PROCEDURE IF EXISTS spLogin;
CREATE PROCEDURE spLogin(
    IN inEmail VARCHAR(50),
    IN inPassword VARCHAR(50)
)
BEGIN    
	select * from tbUserdata where inEmail = `email` and inPassword = `password`;
END //

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS spInsertTbUserdata;
DROP PROCEDURE IF EXISTS spSignup;
CREATE PROCEDURE spSignup(     
    IN inFirstName VARCHAR(50),     
    IN inLastName VARCHAR(50),
    IN inUsername VARCHAR(50),     
    IN inPassword VARCHAR(50),     
    IN inEmail VARCHAR(50),  
    IN inEncodedImage MEDIUMBLOB
)
BEGIN    
    insert into tbUserdata (`firstname`,`lastname`,`username`,`password`,`email`,`token`,`encodedImage`) values (`inFirstName`, `inLastName`, `inUsername`, `inPassword`, `inEmail`, SHA2(CONCAT(`inFirstName`,`inPassword`), 224), `inEncodedImage`);
    select * from tbUserdata where `password` = inPassword and `email` = inEmail;
END //

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS spUpdateTbUserdata;
CREATE PROCEDURE spUpdateTbUserdata(    
    IN inId integer,      
    IN inToken VARCHAR(50),     
    IN inFirstName VARCHAR(50),     
    IN inLastName VARCHAR(50),
    IN inUsername VARCHAR(50),     
    IN inEmail VARCHAR(50),   
    IN inEncodedImage blob 
) 
BEGIN    
	UPDATE tbUserdata
	SET `firstname` = inFirstName,
		`lastname` = inLastName,
		`username` = inUsername,
		`email` = inEmail,
		`encodedImage` = inEncodedImage
	WHERE `id` = inId and `token` = inToken;
END //

DELIMITER ;