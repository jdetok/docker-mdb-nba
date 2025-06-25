-- SELECT PLAYER'S MAX GAME DATE AND THE TEAM THEY'RE WITH FOR THAT DATE
-- IF THE TEAM WITH THEM IN THE NEW INSERT ISN'T THE SAME
-- -- IF NEW DATE > MAX GAME DATE, UPDATE CURRENT RECORD TO ACTIVE = 0 
-- -- AND INSERT THE NEW ONE WITH ACTIVE = 1
use nba;
DELIMITER $$
CREATE OR REPLACE PROCEDURE sp_update_players()
BEGIN
	UPDATE player a
	INNER JOIN player_temp b 
		ON b.player_id = a.player_id 
	SET	a.active = 0
	WHERE a.active = 1
		AND b.team_id != a.team_id
		AND NOT EXISTS (
			SELECT 1
			FROM player c
			WHERE c.player_id = a.player_id
			AND c.team_id = a.team_id
			AND c.active = 0
			);
		
	INSERT INTO player (player_id, player, team_id, lg, active)
		SELECT a.player_id, a.player, a.team_id, a.lg, a.active
		FROM player_temp a
		WHERE NOT EXISTS (
		SELECT 1
		FROM player b
		WHERE b.player_id = a.player_id
			AND b.team_id = a.team_id
			AND  b.active = a.active
		);
	END; $$
DELIMITER ;
-- moved the delete from temp from the sp to the trigger
-- END IT BY DELETING ALL FROM THE TEMP TABLE
DELIMITER $$
CREATE TRIGGER tr_update_players 
AFTER INSERT ON player_temp 
FOR EACH ROW
BEGIN
	CALL sp_update_players();
	-- DELETE FROM player_temp;
END; $$
DELIMITER ;
