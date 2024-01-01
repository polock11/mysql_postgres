DELIMITER $$
CREATE PROCEDURE UPDATE_LEADERS_SCORE(
IN SchoolId INTEGER, IN LeaderScore INTEGER
)
BEGIN

    UPDATE chicago_public_schools
    SET Leaders_Score = LeaderScore
    WHERE SCHOOL_ID = SchoolId;

    IF LeaderScore >= 80 and LeaderScore <=99 THEN
        UPDATE chicago_public_schools
        SET LEADERS_ICON = 'Very Strong'
        WHERE SCHOOL_ID = SchoolId;
    ELSEIF LeaderScore >= 60 and LeaderScore <= 79 THEN
        UPDATE chicago_public_schools
        SET LEADERS_ICON = 'Strong'
        WHERE SCHOOL_ID = SchoolId;
    ELSEIF LeaderScore >= 40 and LeaderScore <= 59 THEN
        UPDATE chicago_public_schools
        SET LEADERS_ICON = 'Average'
        WHERE SCHOOL_ID = SchoolId;
    ELSEIF LeaderScore >= 20 and LeaderScore <= 39 THEN
        UPDATE chicago_public_schools
        SET LEADERS_ICON = 'Weak'
        WHERE SCHOOL_ID = SchoolId;
    ELSEIF LeaderScore >= 0 and LeaderScore <= 19 THEN
        UPDATE chicago_public_schools
        SET LEADERS_ICON = 'Very Weak'
        WHERE SCHOOL_ID = SchoolId;
     ELSE
     	ROLLBACK WORK;
        
	END IF;
    COMMIT WORK;
END$$
DELIMITER ;


--DROP PROCEDURE UPDATE_LEADERS_SCORE;