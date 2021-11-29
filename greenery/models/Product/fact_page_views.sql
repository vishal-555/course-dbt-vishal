{{
  config(
    materialized='table'
  )
}}

Select 
    int_e.event_id,
    int_e.session_id,
    int_e.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    a.address,
    a.zipcode,
    a.state,
    a.country,
    int_e.page_url,
    int_e.created_at
FROM  {{ ref('int_fact_page_views') }}int_e
LEFT JOIN {{ ref('stg_users') }} u
ON int_e.user_id = u.user_id
LEFT JOIN {{ ref('stg_addresses') }} a
  ON u.address_id = a.address_id   