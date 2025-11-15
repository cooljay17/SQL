/*## Daily Challenge:

**Question:** Analyze the event impact by comparing weeks with events vs weeks without events.
Show: event status ('With Event' or 'No Event'), count of weeks, average patient satisfaction,
and average staff morale. 
Order by average patient satisfaction descending.*/

select (case when (event is null or event='none') then 'No Event' else 'With Event' end)event_status,
count(week)count_weeks,round(avg(patient_satisfaction),2)avg_patient_satisfaction,
round(avg(staff_morale),2)avg_staff_morale
from services_weekly
group by (case when (event is null or event='none') then 'No Event' else 'With Event' end)
order by round(avg(patient_satisfaction),2) desc;

--## Practice Questions:
--1. Find all weeks in services_weekly where no special event occurred.
select distinct week
from services_weekly
where event='none'
order by week;
--2. Count how many records have null or empty event values.
select week,count(week)empty_event_count
from services_weekly
where event='none'
group by week
order by count(week)desc;
--3. List all services that had at least one week with a special event.
select distinct service
from services_weekly
where event<>'none';