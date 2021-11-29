{{
  config(
    materialized='table'
  )
}}

Select 
    user_id,
    count(distinct case when status='delivered' then order_id end)No_of_orders,
    count(distinct case when status='delivered' then cast(delivered_at as date) end)Unique_visits,
    min(delivered_at)First_Delivery,
    max(delivered_at)Last_Delivery
FROM {{ ref('stg_orders') }} 
group by 1
