with cte as
(
    Select a.session_id,a.Has_checkout,
    b.session_id as session_id1,b.product_id
    from
(
{{ sessions_with_checkout() }}
)a
left join
(
Select 
split_part(page_url,'/',5)as product_id,
session_id
from {{ ref('stg_events') }}
where  event_type='add_to_cart'
group by 1,2
)b

on a.session_id=b.session_id
)
SELECT
product_id,
(count(distinct case when Has_checkout>=1 and session_id1 is not null then session_id end)*100.0)/
count(distinct session_id) as conversion_rate
from cte
group by 1
order by 1