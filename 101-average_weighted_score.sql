DELIMITER $$

DROP PROCEDURE IF EXISTS ComputeAverageWeightedScoreForUsers$$

CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE current_user_id INT;
    
    -- Cursor to iterate over all users
    DECLARE cur CURSOR FOR SELECT id FROM users;
    
    -- Declare handler for when there are no more rows to fetch
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Open the cursor to fetch all user IDs
    OPEN cur;

    -- Loop over each user
    fetch_loop: LOOP
        FETCH cur INTO current_user_id;
        IF done = 1 THEN
            LEAVE fetch_loop;
        END IF;

        -- Call the procedure to compute the average weighted score for the current user
        CALL ComputeAverageWeightedScoreForUser(current_user_id);
    END LOOP;
    
    -- Close the cursor
    CLOSE cur;
END$$

DELIMITER ;