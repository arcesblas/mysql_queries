DROP PROCEDURE IF EXITS ensure_transaction;

DELIMITER //

CREATE PROCEDURE ensure_transaction (
    OUT created BOOLEAN
)
BEGIN
    -- Handling SAVEPOINT not existing error
    DECLARE EXIT HANDLER FOR 1305
    BEGIN
        START TRANSACTION;
        SET created = TRUE;
        SELECT 'Transaction created' AS status;
    END;

    -- Create and reverse SAVEPOINT
    SAVEPOINT txn_check;
    ROLLBACK TO SAVEPOINT tx_check;
    SET created = FALSE;
    SELECT 'Transaction already active' AS status;

END //

DELIMITER ;