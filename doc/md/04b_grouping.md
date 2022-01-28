# Grouping and Aggregates

## University DB

```postgresql
set search_path to university;
```

1. Find the number of offerings for each year
```postgresql
select year, count(oid)
from offering
group by year;
```

2. Same results because `oid` cannot be bull
```postgresql
select year, count(*)
from offering
group by year;
```

3. Similar, but different results because of null values
```postgresql
select year, count(iid)
from offering
group by year;
```

4. Find the number of course offerings for each instructor
```postgresql
select iid, count(*)
from offering
group by iid;
```

5. Get the number of students enrolled in each course offering
```postgresql
select oid, count(sid)
from enrollment
group by oid;
```

6. Get the number of students enrolled in each course offering
   - with course codes, names and sections
```postgresql
select oid, code, name, section, count(sid) as n_students
from enrollment
        natural join offering
        natural join course
group by oid, code, name, section;
```

7. What about the offerings without any enrollments?
```postgresql
select o.oid, code, name, section, count(sid) as n_students
from enrollment e
         right join offering o on e.oid = o.oid
         natural join course
group by o.oid, code, name, section
order by n_students desc;
```

8. Get the number of students enrolled in each course offering
   - with course codes, names and sections, but only for course offerings with less than 3 enrollments
```postgresql
select o.oid, code, name, section, count(sid) as n_students
from enrollment e
        right join offering o on e.oid = o.oid
        natural join course
group by o.oid, code, name, section
having count(sid) < 3;
```

9. Same, but with less than 1 enrollment
```postgresql
select o.oid, code, name, section, count(sid) as n_students
from enrollment e
         right join offering o on e.oid = o.oid
         natural join course
group by o.oid, code, name, section
having count(sid) < 1;
```

10. better
```postgresql
select o.oid, code, name, section
from enrollment e
         right join offering o on e.oid = o.oid
         natural join course
where e.oid is null;
```

## Exercises

1. Get the number of offerings for each instructor
```postgresql
select i.iid, i.name, count(oid) as count_offering
from offering o join instructor i on o.iid = i.iid
group by i.iid
order by i.iid;

```
2. Get the number of offerings for instructor with id 1, for each year
```postgresql
select o.year, count(oid)
from offering o join instructor i on o.iid = i.iid
where i.iid = 1
group by o.year
order by o.year;
```
3. Get the number of offerings for each instructor for each year
```postgresql
select i.iid, o.year, count(oid)
from offering o join instructor i on i.iid = o.iid
group by i.iid, o.year
order by i.iid;
```
    - what do we do with instructors without any offerings?
      we don't count it when iid = null
5. Get the number of offerings for each instructor for each semester and each year
```postgresql
select i.iid, o.semester,o.year, count(oid)
from offering o join instructor i on i.iid = o.iid
group by i.iid, o.semester,o.year
order by iid, year;
```
    - what do we do with semesters without any offerings?
    we don't count when semester = null 
    - what do we do with semesters without offerings for some instructors?
      we don't count when semester = null
        - for example, many instructors teach only in the fall and winter semesters, but not in the summer semesters; do
          we list these off-semesters for each instructor with a count of 0?
            no