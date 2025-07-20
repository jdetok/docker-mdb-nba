-- docker exec -i mdb mariadb nba < /mnt/web/jdeko.me/sql-final/procedures/run_nightly_procs.sql
call sp_update_lg();
call sp_update_pl_active_status();
call sp_insert_api_player_stats_avg();
call sp_insert_api_player_stats_tot();
