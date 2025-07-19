-- TODO - update player active row based on max game date

/*
1. set all active = 0  
2. find the most recent team each player played for
3. set row in player with that team to active = 1
*/

/* STEP ONE: FIND ALL PLAYERS WHO ARE CURRENTLY ACTIVE
for this, need to get the current seasonid for each league
then find players whose recent game is in that season
*/ 

with

/* hello time for some changes */

maxgame (pId, maxdate) as (
	select player_id, max(game_date)
	from p_game
	group by player_id
),
activeteam (pId, tId) as (
	select a.pId, b.team_id
	from maxgame a
	inner join p_game b
		on b.player_id = a.pId
		and b.game_date = a.maxdate
	group by a.pId
)

select * from activeteam
	inner join player b on b.player_id = pId;

