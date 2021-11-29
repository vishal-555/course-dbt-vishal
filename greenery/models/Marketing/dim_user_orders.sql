{{
  config(
    materialized='table'
  )
}}

Select 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.created_at,
    a.address,
    a.zipcode,
    a.state,
    a.country,
    o.No_of_orders,
    (case when o.No_of_orders>0 then '1' else '0' end) Is_Purchased,
    o.Unique_visits,
    EXTRACT(DAY FROM o.Last_Delivery-o.First_Delivery) AS DateDifference
FROM  {{ ref('stg_users') }} u
LEFT JOIN  {{ ref('int_user_orders') }} o
on u.user_id=o.user_id
LEFT JOIN {{ ref('stg_addresses') }} a
  ON u.address_id = a.address_id 
