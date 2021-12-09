{% macro sessions_with_checkout() %}

Select
session_id,
sum(case when event_type='checkout'  then 1 else 0 end)as Has_checkout
from {{ ref('stg_events') }}
group by 1
    
{% endmacro %}
