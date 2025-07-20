-- TODO - update player active row based on max game date

/*
1. set all active = 0  
2. find the most recent team each player played for
3. set row in player with that team to active = 1
*/

/* STEP ONE: FIND ALL PLAYERS WHO ARE CURRENTLY ACTIVE
for this, need to get the current seasonid for each league
then find players whose recent game is in that season

brainstorming.. probably start with game table, group by league & get 
most recent game to get season
then most recent from p_box
*/ 

/* 
 this gets player and team id of players who played in their league's recent season
 use this in an update or insert statement to update active statuses for these players
 after first setting all active to 0
 
 this gets close, but it does make players who are injured and haven't played in a season appear as inactive
*/

delimiter $$
create or replace procedure sp_update_pl_active_status()
begin
set session foreign_key_checks=0;

-- create temporary table cloning player table
	drop table if exists z_player;
	drop table if exists z_active;
	create table z_player like player;
	alter table z_player drop primary key, add primary key(player_id, team_id);
	insert into z_player 
		select * 
		from player
		group by player_id, team_id;	

	update z_player set active = 0 where active = 1;
	select * from z_player;
	
	create temporary table z_active as (
		select a.season_id, c.lg, a.team_id, a.player_id
		from p_box a
		inner join ( 
			select lg, max(season_id) as sId
			from game
			where left(season_id, 1) = 2
			group by lg
		) b on a.season_id = b.sId
		inner join team c on c.team_id = a.team_id and c.lg = b.lg
		group by a.player_id
	);

	update z_player a
	join z_active b on b.player_id = a.player_id and b.team_id = a.team_id
	set a.active=1;
	
	delete from player;
	insert into player select * from z_player; 
	select * from player; 

	drop table z_active;
	drop table z_player;
set session foreign_key_checks=1;
end$$
delimiter ;

-- call sp_update_pl_active_status();