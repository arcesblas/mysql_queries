DROP PROCEDURE IF EXITS unique_id;

DELIMITER //

CREATE PROCEDURE unique_id (
    IN _id INT,
    OUT is_unique_id BOOLEAN
)
BEGIN
    DECLARE id_count INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;


    SELECT id, COUNT(ID) INTO id, id_count
    FROM table
    WHERE id = _id
    GROUP BY id;


    IF id_count = 1 THEN
        SET is_unique_id = TRUE;
    ELSE
        SET is_unique_id = FALSE;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: id is not unique'
    END IF;

END //

DELIMITER ;