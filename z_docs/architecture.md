# nba/wnba database architecture docs
this database architecture was designed from scratch with codd's third normal form in mind. as of today (7/20/2025) the final working architecture is very much still evolving, but the core structure is still in place
# tables
## core tables
i'm considering 'core' tables to be the "lower level" tables all higher level or viewing tables rely on for their data. these are the tables i designed in the third normal form. the data in these tables should be the main (and only) sources of basic data like player names, team names, etc. core tables listed blelow 
- league
- season
- team
- player
- game
- p_game
- t_game
### stats tables
the stats tables are also core tables in that most uses of the database rely on them, but these tables are the source of player box and shooting statistics. each row in the p_box and pshtg tables is an individual player's performance in an individual game. each in t_box and t_game is a team's performance in an individual game. 
- p_box
- p_shtg
- t_box
- t_shtg  
## viewing/API tables
all the data currently stored in this db is static on a day to day basis, with any changes being made and handled once per day overnight. i've created a few tables meant to be queried & processed by the jdeko.me/bball. these tables are fed by stored procedures that are run nighly after data is fetched externally and inserted.
## temp/utility tables