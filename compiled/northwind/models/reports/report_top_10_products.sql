-- models/reporting/top_10_products.sql



select
    products.product_name, 
    sum(order_details.unit_price * order_details.quantity * (1.0 - order_details.discount)) as sales
from 
    "postgres"."public"."stg_products" as products
inner join 
    "postgres"."public"."stg_order_details" as order_details on order_details.product_id = products.product_id
group by 
    products.product_name
order by 
    sales desc
limit 10