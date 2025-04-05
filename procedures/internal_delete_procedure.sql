DROP PROCEDURE IF EXITS internal_delete_procedure;

DELIMITER //

CREATE PROCEDURE internal_delete_procedure (
    IN _id INT,
    IN commit_flag BOOLEAN
)
BEGIN
    DECLARE created BOOLEAN;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK TO SAVEPOINT savepoint_internal_procedure_delete;
        RESIGNAL;
    END;

    CALL ensure_transaction(created);

    SAVEPOINT savepoint_internal_procedure_delete;

    -- DELETE FROM table WHERE condition = 'something';

    SELECT ROW_COUNT() AS rows_deleted;

    CALL internal_procedure_select(_id);

    IF created = TRUE AND commit_flag = TRUE THEN
        COMMIT;
    ELSE THEN
        ROLLBACK TO SAVEPOINT savepoint_internal_procedure_delete
    END IF;

END //

DELIMITER ;