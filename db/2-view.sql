use nba;

create or replace view v_nba_rs_totals as
select 
	a.player, 
	b.team, 
	sum(c.pts) as pts, 
	sum(c.ast) as ast,
	sum(c.reb) as reb,
	sum(d.fgm) as fgm,
	sum(d.fg3m) as fg3m,
	sum(d.ftm) as ftm
		
	from player a
	inner join team b on b.team_id = a.team_id
	inner join p_box c on c.player_id = a.player_id
	inner join p_shtg d 
		on d.player_id = a.player_id and d.game_id = c.game_id
	inner join season e on e.season_id = c.season_id
	where a.active = 1
	and a.lg = "NBA"
	and e.season like "%RS"
	group by a.player, b.team	
	order by pts desc;

create or replace view v_nba_po_totals as
select 
	a.player, 
	b.team, 
	sum(c.pts) as pts, 
	sum(c.ast) as ast,
	sum(c.reb) as reb,
	sum(d.fgm) as fgm,
	sum(d.fg3m) as fg3m,
	sum(d.ftm) as ftm
		
	from player a
	inner join team b on b.team_id = a.team_id
	inner join p_box c on c.player_id = a.player_id
	inner join p_shtg d 
		on d.player_id = a.player_id and d.game_id = c.game_id
	inner join season e on e.season_id = c.season_id
	where a.active = 1
	and a.lg = "NBA"
	and e.season like "%PO"
	group by a.player, b.team	
	order by pts desc;

create or replace view v_wnba_rs_totals as
select 
	a.player, 
	b.team, 
	sum(c.pts) as pts, 
	sum(c.ast) as ast,
	sum(c.reb) as reb,
	sum(d.fgm) as fgm,
	sum(d.fg3m) as fg3m,
	sum(d.ftm) as ftm
		
	from player a
	inner join team b on b.team_id = a.team_id
	inner join p_box c on c.player_id = a.player_id
	inner join p_shtg d 
		on d.player_id = a.player_id and d.game_id = c.game_id
	inner join season e on e.season_id = c.season_id
	where a.active = 1
	and a.lg = "WNBA"
	and e.season like "%RS"
	group by a.player, b.team	
	order by pts desc;

create or replace view v_wnba_po_totals as
select 
	a.player, 
	b.team, 
	sum(c.pts) as pts, 
	sum(c.ast) as ast,
	sum(c.reb) as reb,
	sum(d.fgm) as fgm,
	sum(d.fg3m) as fg3m,
	sum(d.ftm) as ftm
		
	from player a
	inner join team b on b.team_id = a.team_id
	inner join p_box c on c.player_id = a.player_id
	inner join p_shtg d 
		on d.player_id = a.player_id and d.game_id = c.game_id
	inner join season e on e.season_id = c.season_id
	where a.active = 1
	and a.lg = "WNBA"
	and e.season like "%PO"
	group by a.player, b.team	
	order by pts desc;

create or replace view v_nba_rs_avgs as
	select 
	a.player,
	b.team, 
	round(avg(c.pts), 2) as pts,
	round(avg(c.ast), 2) as ast,
	round(avg(c.reb), 2) as reb,
	round(avg(d.fgm), 2) as fgm,
	round(avg(d.fg3m), 2) as fg3m,
	round(avg(d.ftm), 2) as ftm,
	round(avg(d.fg_pct), 2) as fg_pct,
	round(avg(d.fg3_pct), 2) as fg3_pct,
	round(avg(d.ft_pct), 2) as ft_pct
	
	from player a
	inner join team b on b.team_id = a.team_id
	inner join p_box c on c.player_id = a.player_id
	inner join p_shtg d on d.player_id = a.player_id and d.game_id = c.game_id
	inner join season e on e.season_id = c.season_id
	
	where a.active = 1
	and e.season like "%RS"
	and a.lg = "NBA"
	
	group by a.player, b.team	
	order by pts desc;

create or replace view v_nba_po_avgs as
	select 
	a.player,
	b.team, 
	round(avg(c.pts), 2) as pts,
	round(avg(c.ast), 2) as ast,
	round(avg(c.reb), 2) as reb,
	round(avg(d.fgm), 2) as fgm,
	round(avg(d.fg3m), 2) as fg3m,
	round(avg(d.ftm), 2) as ftm,
	round(avg(d.fg_pct), 2) as fg_pct,
	round(avg(d.fg3_pct), 2) as fg3_pct,
	round(avg(d.ft_pct), 2) as ft_pct
	
	from player a
	inner join team b on b.team_id = a.team_id
	inner join p_box c on c.player_id = a.player_id
	inner join p_shtg d on d.player_id = a.player_id and d.game_id = c.game_id
	inner join season e on e.season_id = c.season_id
	
	where a.active = 1
	and e.season like "%PO"
	and a.lg = "NBA"
	
	group by a.player, b.team	
	order by pts desc;

create or replace view v_wnba_rs_avgs as
	select 
	a.player,
	b.team, 
	round(avg(c.pts), 2) as pts,
	round(avg(c.ast), 2) as ast,
	round(avg(c.reb), 2) as reb,
	round(avg(d.fgm), 2) as fgm,
	round(avg(d.fg3m), 2) as fg3m,
	round(avg(d.ftm), 2) as ftm,
	round(avg(d.fg_pct), 2) as fg_pct,
	round(avg(d.fg3_pct), 2) as fg3_pct,
	round(avg(d.ft_pct), 2) as ft_pct
	
	from player a
	inner join team b on b.team_id = a.team_id
	inner join p_box c on c.player_id = a.player_id
	inner join p_shtg d on d.player_id = a.player_id and d.game_id = c.game_id
	inner join season e on e.season_id = c.season_id
	
	where a.active = 1
	and e.season like "%RS"
	and a.lg = "WNBA"
	
	group by a.player, b.team	
	order by pts desc;

create or replace view v_wnba_po_avgs as
	select 
	a.player,
	b.team, 
	round(avg(c.pts), 2) as pts,
	round(avg(c.ast), 2) as ast,
	round(avg(c.reb), 2) as reb,
	round(avg(d.fgm), 2) as fgm,
	round(avg(d.fg3m), 2) as fg3m,
	round(avg(d.ftm), 2) as ftm,
	round(avg(d.fg_pct), 2) as fg_pct,
	round(avg(d.fg3_pct), 2) as fg3_pct,
	round(avg(d.ft_pct), 2) as ft_pct
	
	from player a
	inner join team b on b.team_id = a.team_id
	inner join p_box c on c.player_id = a.player_id
	inner join p_shtg d on d.player_id = a.player_id and d.game_id = c.game_id
	inner join season e on e.season_id = c.season_id
	
	where a.active = 1
	and e.season like "%PO"
	and a.lg = "WNBA"
	
	group by a.player, b.team	
	order by pts desc;
