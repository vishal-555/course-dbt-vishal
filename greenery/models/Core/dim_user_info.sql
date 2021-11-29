{{
  config(
    materialized='table'
  )
}}

Select 
  user_id,
  first_name,
  last_name,
  email,
  phone_number,
  address,
  zipcode,
  state,
  country,
  created_at,
  updated_at 
FROM  {{ ref('int_user_info') }}

