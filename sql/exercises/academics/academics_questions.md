```postgresql
set search_path to academics;
```
2. Find the family and given names of academics who are interested in the field
   number 292.
```postgresql
select famname as family_name,givename as given_name from academic 
where acnum = (select acnum from interest 
where fieldnum = 292);
```
2. Find the paper number and title of papers containing the word “database” in
   their title.
```postgresql
select panum as paper_number, title
from paper
where title like '%database%';

```
3. Find the family and given names of academics who have authored at least one
   paper with the word “database” in the paper’s title.
```postgresql
select distinct ac.acnum,famname as family_name, givename as given_name
from academic ac inner join author au on ac.acnum = au.acnum
where panum in 
(select panum 
from paper
where title like '%database%');
```
4. Find the family and given names of academics who have not authored any paper.
```postgresql
select distinct ac.acnum,famname as family_name, givename as given_name
from academic ac left join author au on ac.acnum = au.acnum
where panum is null;
```
5. Find the family and given names of academics who are working for RMIT who
   have not authored any paper.???
```postgresql
select distinct ac.acnum,famname as family_name, givename as given_name,descrip
from academic ac left join author au on ac.acnum = au.acnum
join department d on d.deptnum = ac.deptnum
where descrip like '%RMIT%' and panum is null;
```
6. Find the academic number of academics who have an interest in databases (you
   should look for the word “database” in both the Interest and Field tables).
```postgresql
select distinct a.acnum
from academic a join interest i on a.acnum = i.acnum
join field f on f.fieldnum = i.fieldnum
where descrip like '%database%' or f.title like '%database%';
```
7. Find how many academics are interested in the field number 292.
```postgresql
select count(a.acnum)
from academic a join interest i on a.acnum = i.acnum
where fieldnum = 292
group by fieldnum;
```
8. Find how many academics are interested in each field, and order the results
   by the most popular fields first. The most popular field is the field with
   the largest number of academics interested in it. There could be many fields
   equal for the first place.
```postgresql
select fieldnum, count(a.acnum)
from academic a join interest i on a.acnum = i.acnum
group by fieldnum
order by count(a.acnum) desc;
```
