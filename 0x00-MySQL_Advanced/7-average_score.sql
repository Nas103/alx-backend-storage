-- Create stored procedure ComputeAverageScoreForUser

DELIMITER //

CREATE PROCEDURE ComputeAverageScoreForUser(
  IN user_id INT
)
BEGIN
  DECLARE total_score DECIMAL(10,2) DEFAULT 0;
  DECLARE num_corrections INT DEFAULT 0;

  -- Calculate total score and number of corrections
  SELECT SUM(score), COUNT(*)
  INTO total_score, num_corrections
  FROM corrections
  WHERE user_id = user_id;

  -- Update user's average score (avoid division by zero)
  IF num_corrections > 0 THEN
    UPDATE users
    SET average_score = total_score / num_corrections
    WHERE id = user_id;
  END IF;
END //

DELIMITER ;
