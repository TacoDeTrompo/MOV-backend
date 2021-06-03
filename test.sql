DELIMITER //

CREATE PROCEDURE spTest(     
    IN p0 VARCHAR(50),     
    IN p1 VARCHAR(50) 
) 
BEGIN    
    SELECT * FROM todo_list;
END //

DELIMITER ;

-- 100.26.57.36

CREATE USER 'admin'@'localhost' IDENTIFIED BY 'adminadmin';

CREATE USER 'admin'@'%' IDENTIFIED BY 'adminadmin';

GRANT ALL PRIVILEGES ON *.* to admin@localhost IDENTIFIED BY 'adminadmin' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON *.* to adminadmin@'%' IDENTIFIED BY 'adminadmin' WITH GRANT OPTION;

FLUSH PRIVILEGES;

EXIT;
