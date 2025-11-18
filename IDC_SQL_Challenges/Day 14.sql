/*### Daily Challenge:

**Question:** Create a staff utilisation report showing all staff members (staff_id, staff_name,
role, service) and the count of weeks they were present (from staff_schedule). 
Include staff members even if they have no schedule records. Order by weeks present descending.*/
select s.staff_id, s.staff_name,
s.role, s.service,
sum(sh.present)weeks_present
from staff s left join staff_schedule sh
on s.staff_id=sh.staff_id
group by s.staff_id, s.staff_name,
s.role, s.service 
order by sum(sh.present) desc ,staff_name;

--### Practice Questions:

--1. Show all staff members and their schedule information
--(including those with no schedule entries).
select s.*,sh.week,sh.present
from staff s left join staff_schedule sh
on s.staff_id=sh.staff_id;
--2. List all services from services_weekly and their corresponding staff 
--(show services even if no staff assigned).
select distinct s.staff_id,s.staff_name,sh.service
from services_weekly sh left join staff s 
on s.service=sh.service
;
--3. Display all patients and their service's weekly statistics (if available).
select  s.*,sh.*
from services_weekly sh right join patients s
on s.service=sh.service
;