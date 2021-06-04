DELIMITER //

CREATE PROCEDURE spTest(     
    IN p0 VARCHAR(50),     
    IN p1 VARCHAR(50) 
) 
BEGIN    
    SELECT * FROM todo_list;
END //

DELIMITER ;

CREATE USER 'admin'@'localhost' IDENTIFIED BY 'adminadmin';

CREATE USER 'admin'@'%' IDENTIFIED BY 'adminadmin';

GRANT ALL PRIVILEGES ON *.* to admin@localhost IDENTIFIED BY 'adminadmin' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON *.* to adminadmin@'%' IDENTIFIED BY 'adminadmin' WITH GRANT OPTION;

FLUSH PRIVILEGES;

EXIT;
--

create table tbExpensetype(
    id integer NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(50),
    value integer
);

create table tbProfile(
    id integer AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    description VARCHAR(250),
    dayrange integer,
    startday date,
    color VARCHAR(50)
);

create table tbUserdata(
    id int AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    username VARCHAR(50),
    password VARCHAR(50),
    email VARCHAR(50),
    token VARCHAR(50), -- random string xDDDDDDDDDD
    picture blob
);

create table tbAdvice(
    id int AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(50),
    description VARCHAR(250),
    picture blob
);

create table tbTransaction (
    id integer NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    description VARCHAR(250),
    amount float,
    date DATE,
    ttype integer,
    idexpensetype integer NOT NULL,
    idprofile integer NOT NULL,
    CONSTRAINT fk_expensetype FOREIGN KEY (idexpensetype) REFERENCES tbExpensetype(id),
    CONSTRAINT fk_profile FOREIGN KEY (idprofile) REFERENCES tbProfile(id)
);

--

insert into tbExpensetype (title, value) values ('title', 1);

insert into tbProfile (name, description, dayrange, startday, color) values ('name', 'description', 1, now(), '#000000');

insert into tbUserdata (firstname, lastname, username, password, email, token, picture) values ('firstname', 'lastname', 'username', 'password', 'email@email.com', 'token', 'picture');

insert into tbAdvice (title, description, picture) values ('title', 'description', 'picture');

--

select * from tbExpensetype;
select * from tbProfile;
select * from tbUserdata;
select * from tbAdvice;

-- insert into tbTransaction (name, description, amount, date, ttype, idexpensetype, idprofile) values ('name', 'description', 'amount', 'date', 'ttype', 1, 1);
--
 
select tt.name, te.title, tp.name `profilename`
from tbTransaction tt
	inner join tbExpensetype te on tt.idexpensetype = te.id
    inner join tbProfile tp on tt.idprofile = tp.id;


-- Stored Procedures
-- Example 
DELIMITER //

CREATE PROCEDURE spTest(     
    IN p0 VARCHAR(50),     
    IN p1 VARCHAR(50) 
) 
BEGIN    
    SELECT * FROM todo_list;
END //

DELIMITER ;