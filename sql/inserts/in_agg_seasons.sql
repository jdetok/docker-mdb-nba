-- season inserts to handling aggregate season requests in api tables
insert into season values (99999, "rs", "Career Regular Season Statistics", 
    "all", "Career Regular Season Statistics");
insert into season values (99998, "ps", "Career Playoff Statistics", "rs", 
    "Career Playoff Statistics");
insert into season values (99997, "all", "Career Combined Reg-Season/Playoff Statistics", 
    "ps", "Career Combined Reg-Season/Playoff Statistics");
