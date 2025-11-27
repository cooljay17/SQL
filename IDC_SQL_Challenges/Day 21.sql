--### Practice Questions:

--1. Create a CTE to calculate service statistics, then query from it.
with ser_stat as(
select
service,sum(patients_admitted)total_patients_admitted,
sum(patients_refused)total_patients_refused,
round(avg(patient_satisfaction),2)avg_patient_satisfaction
from services_weekly
group by service
)
select service,total_patients_admitted,total_patients_refused,avg_patient_satisfaction
from ser_stat;

--2. Use multiple CTEs to break down a complex query into logical steps.
with avg_tot as(
select 
round(avg(overall_total_patients_admitted))overall_avg_patients_admitted
from
(
select 
sum(patients_admitted)overall_total_patients_admitted
from services_weekly
group by service)tot
)
select service,total_patients_admitted,
(total_patients_admitted-overall_avg_patients_admitted)
as Difference_in_admissions,
overall_avg_patients_admitted,
(case when total_patients_admitted>overall_avg_patients_admitted then 'Above Average'
	when total_patients_admitted=overall_avg_patients_admitted then 'Average'
	else 'Below Average'
	end)rank_indicator
from(
select service,
sum(patients_admitted) as total_patients_admitted,
max(overall_avg_patients_admitted)overall_avg_patients_admitted
from avg_tot,services_weekly
group by 1
)t
order by 2 desc;
--3. Build a CTE for staff utilization and join it with patient data.
with patient_data as
(
select patient_id,name,service
from  patients
),
staff_data as(
select staff_name,service
from staff
)
select patient_id,name as patient_name,staff_name as staff_assigned
,s.service
from patient_data p left join staff_data s on p.service=s.service
;

/*
### Daily Challenge:

**Question:** Create a comprehensive hospital performance dashboard using CTEs. 
Calculate: 1) Service-level metrics (total admissions, refusals, avg satisfaction), 2) 
Staff metrics per service (total staff, avg weeks present), 3) 
Patient demographics per service (avg age, count). 
Then combine all three CTEs to create a final report showing service name,
all calculated metrics, and an overall performance score
(weighted average of admission rate and satisfaction). 
Order by performance score descending.
*/
with serv_metrics as(
select
service,sum(patients_admitted)total_patients_admitted,
sum(patients_refused)total_patients_refused,
round(avg(patient_satisfaction),2)avg_patient_satisfaction,
ROUND(100.0 * sum(patients_admitted) /
          (sum(patients_admitted +patients_refused)), 2) AS admission_rate
from services_weekly
group by service
),
patient_data as
(
select service,count(patient_id)total_patients,
round(avg(age),2)avg_patient_age
from  patients
group by service
),
staff_data as(
select service,count(staff_id)total_staff,
round(avg(case when present=1 then week else 0 end),3)avg_staff_present
from staff_schedule
group by service
)
select sr.service,total_patients_admitted,total_patients_refused,
avg_patient_satisfaction,total_patients,avg_patient_age,
total_staff,avg_staff_present,
admission_rate,
ROUND(((0.7*avg_patient_satisfaction)+(0.3*admission_rate)),2)performance_score		  
from serv_metrics sr,staff_data s,patient_data p
where sr.service=s.service and s.service=p.service
order by 10 desc
;