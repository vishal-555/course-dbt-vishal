Week 2
Q: What is our user repeat rate (users who purchased 2 or more times / users who purchased)
A: 0.75 repeat rate

with cte as
(
Select
user_id,count(distinct order_id)No_of_orders
from dbt_vishal_w.orders
group by 1
)
Select
(count(distinct case when No_of_orders>=2 then user_id end)*100)/count(distinct user_id)user_repeat_rate
from cte


Q: What are good indicators of a user who will likely purchase again? 
A: User are frequently purchasing from our company grenery are more likely to purchase again.

Q: What about indicators of users who are likely NOT to purchase again?
A: Who received their deliveries post expected delivered.

Q: If you had more data, what features would you want to look into to answer this question?
A: Age, Gender, Salary_Income bucket, favourite items, etc to segment the customers into different categories
and check their purchasing patterns. Based on which one can build predictions models which will tell us whether
a customer will purchase again or not.
User feedback/ratings, more the ratings more likely to buy and lesser the rating less likely to buy from us.

Q: Explain the marts models added. Why did you organize the models in the way you did?
A: Core:

Intermediate: User info from staging user, address tables.
Dimennsion: Table with users all info at user level.

Marketing:

Intermediate: Users and their order purchase details like No of orders, Unique visits, First Delivery date, Last delivery date.
Dimension: Table with tag whether use has purchased any item, datedifference between 1st and last purchase.

Product:

Intermediate: Event table with all page view events
Fact: Page view fact table with users personal details.

Organization: In order make it reusable and efficient plus so that it can be maintained properly in the future.


Q: Include an image of your model DAGs
A:
![DAG Week 2](https://user-images.githubusercontent.com/22135998/143807178-6c5942b7-8e5b-404e-8dc7-e0a482545451.PNG)

Q: What assumptions are you making about each model? (i.e. why are you adding each test?)
A: Tests used cover uniqueness, not null,and accepted values.

Q: Did you find any “bad” data as you added and ran tests on your models?
How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
A: Yes, negative values in the first week which was handled by macros.

Q: Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through?
A: Using dbt source freshness and alerting the stakeholders when the data is not refreshed.

