# stored procedures
## nightly automated scripts
stored procedures to be run in nightly cronjob should be called in 
`run_nightly_procs.sql` 
### sp_update_pl_active_status()
- creates clone of player table as `z_player`
    - groups by player & team in the insert into select to eliminate duplicate player/team pairs
- updates `active` field to 0 for all rows in `z_player`
- creates temporary `z_active` table
    - this is populated with only the players who have played a game in their team's latest season
- uses `z_active` in an `update join set` statement to update active players' `active` field to a 1 in the `z_player` table (also joined by team_id -- player table primary key is player_id & team_id)  
    - using `update join` on the `z_active` table means only active players` active field is set to 1; inactive players retain the active=0 set earlier
- deletes all rows from player table
- inserts the contents of `z_player` into `player`
- drops both temporary tables