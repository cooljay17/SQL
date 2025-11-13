/*Daily Challenge:Question: Create a service performance report showing service name, total patients admitted, and a performance category based on the following:
'Excellent' if avg satisfaction >= 85, 'Good' if >= 75, 'Fair' if >= 65,otherwise 'Needs Improvement'. 
Order by average satisfaction descending.*/
select service,sum(patients_admitted)total_patients_admitted,
round(avg(patient_satisfaction))avg_patient_satisfaction,
(case when round(avg(patient_satisfaction))>=85 then 'Excellant'
when round(avg(patient_satisfaction))>=75 then 'Good'
when round(avg(patient_satisfaction))>=65 then 'Fair'
else 'Needs Improvement' end)performance_category
from services_weekly
group by service
order by round(avg(patient_satisfaction)) desc;

--### Practice Questions:

--1. Categorise patients as 'High', 'Medium', or 'Low' satisfaction based on their scores.
select satisfaction,
(case when satisfaction>=80 then 'High'
	  when satisfaction>=60 and satisfaction<80 then 'Medium'
	  else 'Low' end)Score_Category
	  from patients;
--2. Label staff roles as 'Medical' or 'Support' based on role type.
select distinct role,
(case when (role='nurse' or role='doctor') then 'Medical'
	  when role='nursing_assistant' then 'Support'
	  else 'Default' end)Staff_Roles
from staff;
--3. Create age groups for patients (0-18, 19-40, 41-65, 65+).
select age,
(case when age>=65 then 'Elders'
	  when age>=41 and age<65 then 'Middle-aged'
	  when age>=19 and age<41 then 'Young'
	  else 'Children' end)Age_Groups
	  from patients;