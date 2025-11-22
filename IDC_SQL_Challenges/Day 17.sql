--### Practice Questions:

--1. Show each patient with their service's average satisfaction as an additional column.
select patient_id,name as patient_name,service,
(select round(avg(satisfaction))
from services_weekly w where w.service=p.service group by service)average_satisfaction
from patients p
group by 1,2,3;

--2. Create a derived table of service statistics and query from it.
select
sw.total_patients_admitted,
sw.total_patients_refused,
sw.average_patient_satisfaction
from
(select 
service,
sum(patients_admitted)total_patients_admitted,
sum(patients_refused)total_patients_refused,
round(avg(patient_satisfaction),2)average_patient_satisfaction
from services_weekly
group by service)sw;

--3. Display staff with their service's total patient count as a calculated field.
select staff_id,staff_name,service,
(select count(patient_id) from patients p where p.service=s.service
group by p.service)total_patients
from staff s
group by staff_id,staff_name,service; 


/*### Daily Challenge:

**Question:** Create a report showing each service with: 
service name, total patients admitted, the difference 
between their total admissions and the average admissions across all services, 
and a rank indicator ('Above Average', 'Average', 'Below Average'). 
Order by total patients admitted descending.
*/
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
from(
select 
round(avg(overall_total_patients_admitted))overall_avg_patients_admitted
from
(
select 
sum(patients_admitted)overall_total_patients_admitted
from services_weekly
group by service)tot
)avg_tot,services_weekly
group by 1
)t
order by 2 desc;
