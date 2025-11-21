--### Practice Questions:

--1. Find patients who are in services with above-average staff count.
select name as patient_name,service from patients
where service in (select service from staff
group by service
having count(staff_id)>
(select round(avg(staff_count)) from 
(select count(staff_id) as staff_count from staff group by service)));
--2. List staff who work in services that had any week with patient satisfaction below 70.
select staff_name,service
from staff where service in 
(select distinct service from services_weekly where patient_satisfaction<70);

--3. Show patients from services where total admitted patients exceed 1000.
select name as patients_name,service
from patients where service in 
(select service from services_weekly 
group by service 
having sum(patients_admitted)>1000);

/*### Daily Challenge:

**Question:** Find all patients who were admitted to services that had at least
one week where patients were refused AND the average patient satisfaction 
for that service was below the overall hospital average satisfaction. 
Show patient_id, name, service, and their personal satisfaction score.
*/

select patient_id,name as patients_name,service,satisfaction
from patients
where service in 
(select distinct service from services_weekly 
where patients_refused>0 and service in
(select distinct service from services_weekly
group by service 
having round(avg(patient_satisfaction))<
(select round(avg(patient_satisfaction)) from services_weekly)));