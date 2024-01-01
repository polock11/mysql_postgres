--DROP trigger OrderQtCheck;

DELIMITER //

create trigger OrderQtCheck 
BEFORE INSERT ON Orders FOR EACH ROW 
BEGIN
    IF NEW.quantity < 0 THEN
    SET NEW.quantity = 0;
    END IF;
END;

DELIMITER ;