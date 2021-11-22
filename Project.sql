DROP DATABASE IF EXISTS mydb;
CREATE DATABASE mydb;
USE mydb;

CREATE TABLE users(U_id INT(3) NOT NULL,username VARCHAR(20) NOT NULL, password VARCHAR(20) NOT NULL,
email VARCHAR(30),deleted TINYINT(1) NOT NULL, UNIQUE(username), PRIMARY KEY(U_id));

CREATE TABLE Destinations_Category(id INT(3) NOT NULL, name VARCHAR(20),count INT(5),PRIMARY KEY(id));

CREATE TABLE Destinations(id INT(4) NOT NULL, country VARCHAR(20) NOT NULL, town VARCHAR(20) NOT NULL,
url VARCHAR(50), username INT(3) NOT NULL,PRIMARY KEY (id),FOREIGN KEY(username) REFERENCES users(U_id));

CREATE TABLE DD_Category(destination_id INT(4) NOT NULL, category_id INT(3) NOT NULL, deleted INT(3), PRIMARY KEY(destination_id,category_id),
FOREIGN KEY (destination_id) REFERENCES Destinations(id), FOREIGN KEY (category_id) REFERENCES Destinations_Category(id),FOREIGN KEY (deleted) REFERENCES users(U_id));

INSERT INTO users VALUES (0,"admin","pass","admin@admin.com",1),(1,"alex","alex","alex@admin.com",1),(2,"billy","billy","billy@admin.com",1);

INSERT INTO Destinations_Category VALUES (100,"Χειμερινοί",0),(101,"Χριστουγεννιάτικοι",0),(102,"Καλοκαιρινοί",0);

DROP TRIGGER IF EXISTS create_dest_trig;
CREATE TRIGGER create_dest_trig
BEFORE INSERT ON DD_Category
FOR EACH ROW
UPDATE Destinations_Category SET Destinations_Category.count = Destinations_Category.count + 1 
WHERE NEW.category_id = Destinations_Category.id;

DROP TRIGGER IF EXISTS edit_dest_trig;
DELIMITER //
CREATE TRIGGER edit_dest_trig
AFTER UPDATE ON DD_Category
FOR EACH ROW
BEGIN
UPDATE Destinations_Category SET Destinations_Category.count = Destinations_Category.count - 1 
WHERE OLD.category_id = Destinations_Category.id;
UPDATE Destinations_Category SET Destinations_Category.count = Destinations_Category.count + 1 
WHERE NEW.category_id = Destinations_Category.id;
END //
DELIMITER ;

DROP TRIGGER IF EXISTS delete_dest_trig;
CREATE TRIGGER delete_dest_trig
AFTER DELETE ON DD_Category
FOR EACH ROW
UPDATE Destinations_Category SET Destinations_Category.count = Destinations_Category.count - 1 
WHERE OLD.category_id = Destinations_Category.id;

DROP FUNCTION IF EXISTS toUsername;
DELIMITER //
CREATE FUNCTION toUsername (id INT(3))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
DECLARE name VARCHAR(20);
SELECT username INTO name FROM users WHERE U_id=id;
RETURN name;
END //
DELIMITER ;