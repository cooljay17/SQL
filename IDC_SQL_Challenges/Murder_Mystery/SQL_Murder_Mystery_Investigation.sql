select * from employees;
select * from keycard_logs; 
select * from calls;
select * from alibis;
select * from evidence;

--1	Identify where and when the crime happened	WHERE, filtering
with crime_loc as(
select *
from keycard_logs kl
where (entry_time>='2025-10-15 20:00:00' and exit_time<='2025-10-15 21:00:00')),
--2	Analyze who accessed critical areas at the time	JOIN, BETWEEN
critical_areas as(
select kl.employee_id,name,department,role
room,
entry_time,exit_time
from keycard_logs kl
inner join employees e  on kl.employee_id=e.employee_id
where room='CEO Office'),
--3	Cross-check alibis with actual logs	JOIN, subqueries
chk_alibis as(
select a.employee_id,name,department,
role,room as key_log_location,entry_time,exit_time,claimed_location,claim_time
from alibis a
inner join employees e  on a.employee_id=e.employee_id
inner join keycard_logs kl
 on kl.employee_id=e.employee_id
where room<> claimed_location),
--4	Investigate suspicious calls made around the time	JOIN, filtering
sus_calls as(
select distinct caller_id,ec.name caller_name,receiver_id,er.name,*
from calls c inner join employees ec  on ec.employee_id=c.caller_id
inner join employees er  on er.employee_id=c.receiver_id
where call_time between '2025-10-15 20:00:00' and '2025-10-15 21:00:00'),
--5	Match evidence with movements and claims	JOIN, WHERE
chk_evidence as(
select ev.room,description,found_time,entry_time,exit_time,
e.employee_id,name,department,role
from evidence ev
inner join  keycard_logs kl on ev.room=kl.room  
inner join employees e  on kl.employee_id=e.employee_id
where ev.room='CEO Office')
--6	Combine all findings to identify the killer	INTERSECT, multiple JOINs
select Name as Killer_name
from crime_loc cl inner join critical_areas ca on cl.employee_id=ca.employee_id
intersect
select Name as Killer_name
from chk_evidence ce
intersect
select caller_name as Killer_name
from sus_calls sc 
intersect
select Name as Killer_name
from  chk_alibis cab;

select distinct employee_id,cl.name,role,department,
key_log_location,room,entry_time,exit_time,
claimed_location,claimed_time,
description as evidence,found_time,sc.name as caller_name,
from crime_loc cl inner join critical_areas ca on cl.employee_id=ca.employee_id
inner join chk_evidence ce on ca.employee_id=ce.employee_id
inner join sus_calls sc on ce.employee_id=caller_id
inner join chk_alibis cab on caller_id=cab.employee_id
 ;
