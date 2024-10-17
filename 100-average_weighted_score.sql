DELIMITER $$

DROP PROCEDURE IF EXISTS ComputeAverageWeightedScoreForUser$$

CREATE PROCEDURE ComputeAverageWeightedScoreForUser(IN user_id INT)
BEGIN
    DECLARE weighted_sum FLOAT DEFAULT 0;
    DECLARE total_weight INT DEFAULT 0;
    DECLARE current_project_weight INT;
    DECLARE current_project_score FLOAT;

    -- Cursor to iterate over the corrections for the given user
    DECLARE cur CURSOR FOR 
        SELECT p.weight, c.score 
        FROM corrections c
        JOIN projects p ON c.project_id = p.id
        WHERE c.user_id = user_id;
    
    -- Declare handler for no data found
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET current_project_weight = NULL;
    
    -- Open the cursor
    OPEN cur;
    
    -- Loop over the cursor to calculate weighted sum and total weight
    fetch_loop: LOOP
        FETCH cur INTO current_project_weight, current_project_score;
        
        -- Exit loop if there are no more records
        IF current_project_weight IS NULL THEN
            LEAVE fetch_loop;
        END IF;
        
        -- Calculate the weighted sum
        SET weighted_sum = weighted_sum + (current_project_weight * current_project_score);
        -- Calculate the total weight
        SET total_weight = total_weight + current_project_weight;
    END LOOP;
    
    -- Close the cursor
    CLOSE cur;
    
    -- Update the average score for the user
    IF total_weight > 0 THEN
        UPDATE users
        SET average_score = weighted_sum / total_weight
        WHERE id = user_id;
    END IF;
END$$

DELIMITER ;