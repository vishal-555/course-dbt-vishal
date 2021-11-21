**Question 1:** How many users do we have?
**Query:** 

select count(distinct user_id)unique_users,count(*)total_rows from dbt_vishal_w.stg_users ;


**Answer:** User count: 130

**Question 2:** On average, how many orders do we receive per hour?

**Query:**


select count(distinct order_id)/count(distinct extract(hour from created_at))  from "stg_orders";


**Answer:** Average orders per hour: 16

**Question 3:** On average, how long does an order take from being placed to being delivered?

**Query:**


Select AVG(Age(delivered_at,created_at))dif FROM "stg_orders" where status ='delivered';


**Answer:**

3 days, 22 hours, 13 minutes, 10 seconds

**Question 4:** How many users have only made one purchase? Two purchases? Three+ purchases?

**Query:**


with cte AS(Select
user_id,count(distinct order_id)orders
FROM "stg_orders"
group by 1
)
Select case when orders=1 then '1 order'
when orders=2 then '2 orders'
when orders>2 then '3 and more orders'
end No_of_orders, count(distinct user_id)Users
from cte
group by 1;


**Answer:**

1 order = 25 users, 2 order = 22users, 3 and more orders = 81 users.

**Question 5:** On average, how many unique sessions do we have per hour?

**Query:**


with cte as(SELECT
extract(hour from created_at)Hours,
count(distinct session_id) sessions
from "stg_events"
where created_at is not null
group by 1
)
Select avg(sessions) from cte;


**Answer:** 123.125 sessions