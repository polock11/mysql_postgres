DELIMITER //

CREATE FUNCTION discount(
    c_id VARCHAR(3)
) RETURNS DECIMAL(10,4)
DETERMINISTIC
BEGIN
    DECLARE _value DECIMAL(10,4);
    DECLARE res DECIMAL(10,4);

    SELECT amount INTO _value
    FROM (
        SELECT ClientID, SUM(quantity * cost) AS amount
        FROM Orders
        GROUP BY ClientID
    ) AS tbl
    WHERE ClientID = c_id;

    IF _value >= 50000 THEN
        SET res = _value - (_value * 0.20);
    ELSE
        SET res = _value - (_value * 0.10);
    END IF;

    RETURN res;
END //

DELIMITER ;
