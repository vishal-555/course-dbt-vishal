{{
    config(
        materialized = 'table'
    )
}}


with cte as
(

Select
session_id,
sum(case when event_type='page_view'  then 1 else 0 end)as has_pageview,
sum(case when event_type='account_created'  then 1 else 0 end)as has_account_created,
sum(case when event_type='add_to_cart'  then 1 else 0 end)as has_added_to_cart,
sum(case when event_type='delete_from_cart'  then 1 else 0 end)as has_deleted_from_cart,
sum(case when event_type='checkout'  then 1 else 0 end)as has_checkout,
sum(case when event_type='package_shipped'  then 1 else 0 end)as has_package_shipped
from {{ ref('stg_events') }}
group by 1

)
SELECT
count(distinct session_id)total_sessions,
count(distinct case when has_pageview>0 or has_added_to_cart>0 or has_checkout>0 then session_id end)
pageview_conversion,
count(distinct case when has_added_to_cart>0 or has_checkout>0 then session_id end)
add_to_card_conversion,
count(distinct case when  has_checkout>0 then session_id end)
checkout_conversion
from cte
