/*### Daily Challenge:

**Question:** Create a comprehensive report showing patient_id, patient name, 
age, service, and the total number of staff members available in their service. 
Only include patients from services that have more than 5 staff members. 
Order by number of staff descending, then by patient name.*/
select patient_id, name as patient_name, 
age, p.service, count(staff_id)Total_staff
from patients p
inner join staff s on p.service=s.service
group by patient_id, name, 
age, p.service
having count(staff_id)>5
order by count(staff_id) desc,name;

--### Practice Questions:

--1. Join patients and staff based on their common service field 
--(show patient and staff who work in same service).
select p.name as patient_name,s.staff_name,p.service same_service
from patients p
inner join staff s on p.service=s.service;

--2. Join services_weekly with staff to show weekly service data with staff information.
select w.*,s.staff_name
from services_weekly w
inner join staff s on w.service=s.service;
--3. Create a report showing patient information along with staff assigned to their service.
select p.*,s.staff_name as staff_assigned
from patients p

inner join staff s on p.service=s.service;
