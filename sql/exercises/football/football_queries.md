```postgresql
SET search_path TO football;
```

1: Find the players who are the captain of a team. List the player names and IDs, and also the team name.
List only the players with a name starting with the letter T.
```postgresql
select p.name, pid, t.name
from player p join team t on p.pid = t.captain_pid
where p.name like 'T%';
```

2: Find the team names and cities of the teams that have played a match on 2014-07-01.
```postgresql
select t.name, t.city 
from team t 
where t.tid = (select home_tid
from match
where to_char(date_time,'yyyy-mm-dd') = '2014-07-01') 
or t.tid = (select away_tid
from match
where to_char(date_time,'yyyy-mm-dd') = '2014-07-01')
```

3: Find all the draws or ties (matches without a winner). List the date and times, stadium of these matches.
```postgresql
select date_time, stadium
from match
where home_goals = away_goals;
```

4: Find the names and IDs of the players who have never scored any goal.
```postgresql
select p1.name, p1.pid as player_id
from player p1 join playedin p2 on p1.pid = p2.pid
where p2.goals = 0;
```


5: For each player, find the total number of goals they scored. List the player names and IDs along with the number of goals.
```postgresql
select p1.name,p1.pid, sum(p2.goals) as total_goals
from player p1 join playedin p2 on p1.pid = p2.pid
group by p1.name, p1.pid
order by total_goals desc;
```
