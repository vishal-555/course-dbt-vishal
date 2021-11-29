{{
  config(
    materialized='table'
  )
}}

Select 
    o.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.created_at,
    a.address,
    a.zipcode,
    a.state,
    a.country,
    count(distinct o.order_id)No_of_orders
FROM  {{ ref('stg_orders') }} o
LEFT JOIN {{ ref('stg_users') }} u
ON o.user_id = u.user_id
LEFT JOIN {{ ref('stg_addresses') }} a
  ON u.address_id = a.address_id    
where o.status ='delivered'
group by 1,2,3,4,5,6,7,8,9,10