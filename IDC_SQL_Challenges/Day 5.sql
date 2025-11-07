/*### Daily Challenge:
**Question:** Calculate the total number of patients admitted, 
total patients refused, and the average patient satisfaction across all services and weeks. 
Round the average satisfaction to 2 decimal places.*/
select sum(patients_admitted)total_patients_admitted,
sum(patients_refused)total_patients_refused,
round(avg(patient_satisfaction),2)avg_patient_satisfaction
from services_weekly 
;

--Practice Questions
--1. Count the total number of patients in the hospital.
select count(patient_id) from patients;
--2. Calculate the average satisfaction score of all patients.
select avg(satisfaction) from patients;
--3. Find the minimum and maximum age of patients.
select min(age)min_age,max(age)max_age from patients;
