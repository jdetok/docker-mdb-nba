create table if not exists league (
	lg_id int,
	lg varchar(4),
	lg_desc varchar(255),
	primary key(lg_id)
);

insert into league values (101, "NBA", "National Basketball Association");
insert into league values (201, "WBA", "Women's National Basketball Association");
insert into league values (301, "GNBA", "NBA G-League");
insert into league values (901, "OTH", "Miscellaneous/Temporary League");
-- delete from league where lg_id = 901;

select * from league;
