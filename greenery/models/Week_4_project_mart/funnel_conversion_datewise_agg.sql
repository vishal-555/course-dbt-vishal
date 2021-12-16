{{
    config(
        materialized = 'table'
    )
}}


with cte as
(

Select
cast( created_at as date)event_date,
session_id,
sum(case when event_type='page_view'  then 1 else 0 end)as has_pageview,
sum(case when event_type='account_created'  then 1 else 0 end)as has_account_created,
sum(case when event_type='add_to_cart'  then 1 else 0 end)as has_added_to_cart,
sum(case when event_type='delete_from_cart'  then 1 else 0 end)as has_deleted_from_cart,
sum(case when event_type='checkout'  then 1 else 0 end)as has_checkout,
sum(case when event_type='package_shipped'  then 1 else 0 end)as has_package_shipped
from {{ ref('stg_events') }}
group by 1,2

)
SELECT
event_date,
count(distinct session_id)total_sessions,
count(distinct case when has_pageview=1 then session_id end)page_view_sessions,
count(distinct case when has_account_created=1 then session_id end)account_created_sessions,
count(distinct case when has_added_to_cart=1 then session_id end)added_to_cart_sessions,
count(distinct case when has_deleted_from_cart=1 then session_id end)deleted_from_cart_sessions,
count(distinct case when has_checkout=1 then session_id end)checkout_sessions,
count(distinct case when has_package_shipped=1 then session_id end)package_shipped_sessions
from cte
group by 1