with cte as
(

    {{ sessions_with_checkout() }}
)
SELECT
((count(distinct case when Has_checkout>=1 then session_id end ))*100.0)/count(distinct session_id)
as Overall_conversion
from cte