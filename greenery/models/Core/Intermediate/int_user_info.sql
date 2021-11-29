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
  u.updated_at,
  u.address_id,
  a.address,
  a.zipcode,
  a.state,
  a.country  
FROM  {{ ref('stg_users') }} u
LEFT JOIN {{ ref('stg_addresses') }} a
  ON u.address_id = a.address_id 

