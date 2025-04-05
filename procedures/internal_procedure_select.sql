DROP PROCEDURE IF EXITS internal_delete_select;

DELIMITER //

CREATE PROCEDURE internal_delete_procedure (
    IN _id INT
)
BEGIN
    DECLARE row_count INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        RESIGNAL;
    END;

    -- SELECT COUNT(*) INTO row_count FROM table WHERE condition = '';


    IF row_count = 0 THEN
        SELECT 'table no rows found' AS query_message;
    ELSE
        SELECT * FROM table FROM table WHERE condition = '';
    END IF;

END //

DELIMITER ;