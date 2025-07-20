/* 
TODO: stored procedure to reassign leagues for teams
 - reason: random teams from all star games and stuff like 
 	that are getting assigned the NBA league
 	
 - fix: source a team's league from whether the team has played games 
 	in a regular season (first char of season_id is 2)
 	
 * need to do this for players as well
 
* 7/20 10:18am note: created league table 
 
*/

delimiter $$
create or replace procedure sp_update_lg()
begin 
set session foreign_key_checks=0;

	-- create a temporary team table for testing 
	drop table if exists z_team;
	create table if not exists z_team like team;
	
	insert into z_team select * from team;

	-- update z_team.lg to 'OTH' for teams that have no regular season games in p_box
	update z_team a
	join (
		select a.team_id, ifnull(b.lg, 'OTH') as lg
		from z_team a
		left join (
			select z.team_id, x.lg
			from p_box z
			inner join z_team x on x.team_id = z.team_id
			where left(z.season_id, 1) = 2
			group by z.team_id	
		) b on a.team_id = b.team_id
		where b.lg is null
	) b on a.team_id = b.team_id
	set a.lg = b.lg;
	
	-- replace team data with updated z_team data
	delete from team;
	insert into team select * from z_team;
	
	drop table z_team;
set session foreign_key_checks=0;
end$$
delimiter ;

call sp_update_lg();
select * from team;



