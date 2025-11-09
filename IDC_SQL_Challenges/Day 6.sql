--Day6
/*Daily challenge
Question: For each hospital service, calculate the total number of patients admitted,
total patients refused, and the admission rate
(percentage of requests that were admitted). Order by admission rate descending.*/
select service,sum(patients_admitted)total_patients_admitted,
sum(patients_refused)total_patients_refused,
round((SUM(patients_admitted) * 100.0 / SUM(patients_request)),2) AS admission_rate
from
services_weekly
group by service order by admission_rate desc;

--Practice
--1. Count the number of patients by each service.
select service,count(patient_id)num_of_patients
from patients 
group by service;
--2. Calculate the average age of patients grouped by service.
select service,round(avg(age),2)avg_age
from patients 
group by service;
--3. Find the total number of staff members per role.
select role,count(staff_id)total_staffs
from staff
group by role;