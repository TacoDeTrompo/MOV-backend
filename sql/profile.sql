--
/*
{
  "idBD": 0,
  "profileName": "",
  "description": "",
  "dayRange": "",
  "startDate": "",
  "color": "",
  "userId": 0
}
*/
--                                                                      sql         | endpoint
-- get profile                                                          done        | not done
-- get profiles by user                                                 done        | not done
-- insert profile                                                       done (mike) | not done
-- update profile                                                       done        | not done
-- delete profile                                                       done        | not done

-- SET FOREIGN_KEY_CHECKS = 0;

-- DROP TABLE IF EXISTS tbProfile;
-- create table tbProfile(
--     `id` integer AUTO_INCREMENT PRIMARY KEY,
--     `name` VARCHAR(50),
--     `description` VARCHAR(250),
--     `dayrange` integer,
--     `startday` VARCHAR(50),
--     `color` VARCHAR(50),
--     `iduserdata` integer NOT NULL,
--     CONSTRAINT fk_userdata FOREIGN KEY (`iduserdata`) REFERENCES tbUserdata(`id`)
-- );

-- SET FOREIGN_KEY_CHECKS = 1;

DELIMITER //

DROP PROCEDURE IF EXISTS spGetProfile;
CREATE PROCEDURE spGetProfile(
    IN inId integer
)
BEGIN    
	select * from tbProfile where inId = `id`;
END //

DELIMITER ;

DELIMITER //

DROP PROCEDURE IF EXISTS spGetProfiles;
CREATE PROCEDURE spGetProfiles(IN inId integer)
BEGIN    
	select * from tbProfile where `iduserdata` = inId;
END //

DELIMITER ;

DELIMITER //

DROP PROCEDURE IF EXISTS spUpdateTbProfile;
CREATE PROCEDURE spUpdateTbProfile(   
    IN inId integer,
    IN inUserId integer,
    IN inName VARCHAR(50),
    IN inDescription VARCHAR(250),
    IN inDayrange integer,
    IN inColor VARCHAR(50)
) 
BEGIN    
	UPDATE tbProfile
	SET `name` = inName,
		`description` = inDescription,
		`dayrange` = inDayrange,
		`color` = inColor
	WHERE `id` = inId and `iduserdata` = inUserId;
END //

DELIMITER ;

DELIMITER //

DROP PROCEDURE IF EXISTS spDeleteTbProfile;
CREATE PROCEDURE spDeleteTbProfile(   
    IN inId integer,
    IN inUserId integer
) 
BEGIN    
	DELETE FROM tbProfile
	WHERE `id` = inId;
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
    insert into tbProfile (`name`, `description`, `dayrange`, `startday`, `color`, `iduserdata`) values (inName, inDescription, inDayrange, CURDATE(), inColor, inIduserdata);
END //

DELIMITER ;
