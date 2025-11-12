/*### Daily Challenge:

**Question:** Calculate the average length of stay (in days) for each service, 
showing only services where the average stay is more than 7 days. 
Also show the count of patients and order by average stay descending.*/
select 
service,round(avg(departure_date - arrival_date))avg_length_of_stay,
count(patient_id)total_patients 
from patients
group by service
having round(avg(departure_date - arrival_date))>7 ; 

--Practice Questions
--1. Extract the year from all patient arrival dates.
select patient_id,name, extract(year from arrival_date)patient_arrival_year
from patients
;
--2. Calculate the length of stay for each patient (departure_date - arrival_date).
select (departure_date - arrival_date)length_of_stay 
from patients;
--3. Find all patients who arrived in a specific month.
select patient_id,name, arrival_date
from patients
where extract(month from arrival_date)=8;
;