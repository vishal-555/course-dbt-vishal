{{
  config(
    materialized='table'
  )
}}

Select 
    event_id,
    session_id,
    user_id,
    page_url,
    created_at
FROM  {{ ref('stg_events') }}
where event_type='page_view'