DROP PROCEDURE IF EXITS external_delete_procedure;

DELIMITER //

CREATE PROCEDURE external_delete_procedure (
    IN _id INT,
    IN commit_flag BOOLEAN
)
BEGIN
    DECLARE customer_id INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error in external_delete_procedure. Rollback' AS error_message;
    END;

    START TRANSACTION;

    CALL unique_id(_id, is_unique_id);

    IF is_unique_id = FALSE THEN SET 
        SIGNAL SQLSTATE '45000' MESSAGE_TEXT = 'Error: id is not unique, verify';
    ELSEIF is_unique_id = TRUE THEN
        -- CALL delete_internal_procedure;
    
        IF commit_flag = TRUE THEN
            COMMIT;
        ELSE
            ROLLBACK;
            SELECT 'Rollback in external_delete_procedure: commit_flag is FALSE, no changes made.' AS procedure_message;
        END IF;
    ELSE
        SIGNAL SQLSTATE '45000' MESSAGE_TEXT = 'Unexpected Error';
    END IF;

END //

DELIMITER ;