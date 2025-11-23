--### Practice Questions:

--1. Combine patient names and staff names into a single list.
select name as pat_staff_names from patients
union all
select staff_name as pat_staff_names from staff
order by 1;
--2. Create a union of high satisfaction patients (>90) and low satisfaction patients (<50).
select name as patient_name,satisfaction
from patients where satisfaction >90
union
select name as patient_name,satisfaction
from patients where satisfaction <50
order by satisfaction desc;
--3. List all unique names from both patients and staff tables.
select name as pat_staff_names from patients
union 
select staff_name as pat_staff_names from staff
order by 1;

/*### Daily Challenge:

**Question:** Create a comprehensive personnel and patient list showing: 
identifier (patient_id or staff_id), full name, type ('Patient' or 'Staff'), 
and associated service. Include only those in 'surgery' or 'emergency' services.
Order by type, then service, then name.*/
select ID,fullname,type,service
from(
select patient_id as ID,name as fullname,
'Patient' as type,service
from patients
where service in ('surgery','emergency')
union 
select staff_id as id,staff_name as fullname,
'staff' as type,service
from staff
where service in ('surgery','emergency'))t
order by 3,4,2
;