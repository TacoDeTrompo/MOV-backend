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
-- get profile                                                          not done    | not done
-- get profiles                                                         not done    | not done
-- insert profile                                                       not done    | not done
-- update profile                                                       not done    | not done

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
	select * from tbProfile where inId = `id`;
END //

DELIMITER ;