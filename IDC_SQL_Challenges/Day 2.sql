/*### Daily Challenge:

**Question:** Find all patients admitted to 'Surgery' service with a satisfaction score below 70, showing their patient_id, name, age, and satisfaction score.
*/

select * from patients
where service='surgery' and satisfaction < 70;

/*Practice Questions*/
--1. Find all patients who are older than 60 years.
select * 
from patients 
where age>60;

--2. Retrieve all staff members who work in the 'Emergency' service.
select * from staff
where service='emergency';

--3. List all weeks where more than 100 patients requested admission in any service.
select week,month,patients_request from services_weekly
where patients_request>100;

