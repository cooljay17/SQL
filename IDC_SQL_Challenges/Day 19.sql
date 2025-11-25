--### Practice Questions:

--1. Rank patients by satisfaction score within each service.
select patient_id,name as patient_name,service,satisfaction,
dense_rank() over (partition by service order by satisfaction) satisfaction_rank
from patients
;
--2. Assign row numbers to staff ordered by their name.
select staff_id,staff_name,role,
row_number() over (order by staff_name) rownum
from staff
;
--3. Rank services by total patients admitted.
select service ,Total_patients_admitted,
rank() over (order by Total_patients_admitted) rank_patient_admission
from(
select distinct service,
sum(patients_admitted) over  (partition by service)Total_patients_admitted
from services_weekly
)t;

/*### Daily Challenge:

**Question:** For each service, rank the weeks by patient satisfaction 
score (highest first). Show service, week, patient_satisfaction,
patients_admitted, and the rank. Include only the top 3 weeks per service.
*/

with pat_top_weeks as(
select week,service,Total_patients_admitted,Total_patient_satisfaction,
ROW_NUMBER() over (partition by service 
order by Total_patient_satisfaction desc,week) rank_satisfaction
from(
select week,service,
sum(patient_satisfaction)Total_patient_satisfaction,
sum(patients_admitted)Total_patients_admitted
from services_weekly
group by 1,2
order by 1,2
)t)
SELECT * FROM pat_top_weeks WHERE rank_satisfaction <= 3;


