/* 
TODO: stored procedure to reassign leagues for teams
 - reason: random teams from all star games and stuff like 
 	that are getting assigned the NBA league
 	
 - fix: source a team's league from whether the team has played games 
 	in a regular season (first char of season_id is 2)
 	
 * need to do this for players as well
 
*/

select a.team_id, b.team, b.team_name, b.lg
from p_box a
inner join team b on b.team_id = a.team_id
where left(a.season_id, 1) = 2
group by team_id;