--
/*
{
  "idBD": 0,
  "profileName": "",
  "description": "",
  "dayRange": "",
  "startDate": ?,
  "color": ""
}
*/
--                                                                      sql         | endpoint
-- get profile                                                          done        | not done
-- get profiles                                                         done        | not done
-- insert profile                                                       done (mike) | not done
-- update profile                                                       done        | not done

DELIMITER //

DROP PROCEDURE IF EXISTS spGetProfile;
CREATE PROCEDURE spGetProfile(
    IN inId VARCHAR(50)
)
BEGIN    
	select * from tbProfile where inId = `id`;
END //

DELIMITER ;

DELIMITER //

DROP PROCEDURE IF EXISTS spGetProfiles;
CREATE PROCEDURE spGetProfiles()
BEGIN    
	select * from tbProfile;
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
	WHERE `id` = inId and `iduserdata` = inUserId;
END //

DELIMITER ;