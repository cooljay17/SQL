--### Practice Questions:

--1. Calculate running total of patients admitted by week for each service.
select service,week,
sum(patients_admitted) over(partition by service order by week)total_patients_admitted
from services_weekly;
--2. Find the moving average of patient satisfaction over 4-week periods.
select  week,
 ROUND(AVG(patient_satisfaction) OVER (
        PARTITION BY service
        ORDER BY week
        ROWS BETWEEN 3 PRECEDING AND CURRENT ROW), 2) AS moving_avg_4week
from services_weekly
order by week;

--3. Show cumulative patient refusals by week across all services.
select service,week,
sum(patients_refused) over(partition by service order by week)total_patients_refused
from services_weekly
order by 3,2,1;

/*### Daily Challenge:

**Question:** Create a trend analysis showing for each service and week: 
week number, patients_admitted, running total of patients admitted (cumulative),
3-week moving average of patient satisfaction (current week and 2 prior weeks), 
and the difference between current week admissions and the service average. 
Filter for weeks 10-20 only.
*/
select service,week,patients_admitted,
sum(patients_admitted) over(partition by service order by week)cumultive_patients_admitted,
 ROUND(AVG(patient_satisfaction) OVER (
        PARTITION BY service
        ORDER BY week
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS moving_avg_3week,
		round((patients_admitted-avg(patients_admitted) over (partition by service)
		),2)diff_curr_admisn
		from services_weekly
		where week between 10 and 20
		order by service,week;



