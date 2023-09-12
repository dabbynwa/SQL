select * from billing limit 10;

select feature, count(*) as cnt
from billing 
group by 1;

select feature, customer_request, count(*) as cnt, round(avg(csat),1) as csat_avg 
, round(avg(time_to_resolution)) as avg_resolve_time, round(avg(number_of_hits)) as num_hits
from billing 
group by 1,2;

/* 
-------------
Main Query 
-------------
*/
select feature, customer_request as user_request, escalated_to_tier2, count(*) as num_of_req, 
case 
when escalated_to_tier2 = 'Yes' then (count(customer_request) * 250)
Else (count(customer_request) * 50)
END as'total_cost_in_usd',
round(avg(number_of_hits)) as avg_num_of_hits, round(avg(time_to_resolution)) as avg_resolution_time,
round(avg(csat),1) as csat_avg, 
case 
when round(avg(csat),1) <= 2.5 then 'dissatisfied' 
when round(avg(csat),1) <4 then 'somewhat satisfied'
Else 'very satisfied'
END as'user_satisfaction'
from billing 
group by 1,2,3
order by 2;
