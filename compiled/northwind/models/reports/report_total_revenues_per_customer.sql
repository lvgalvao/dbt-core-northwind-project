-- models/reporting/view_total_revenues_per_customer.sql



select 
    customers.company_name, 
    sum(order_details.unit_price * order_details.quantity * (1.0 - order_details.discount)) as total
from 
    "postgres"."public"."stg_customers" as customers
inner join 
    "postgres"."public"."stg_orders" as orders on customers.customer_id = orders.customer_id
inner join 
    "postgres"."public"."stg_order_details" as order_details on order_details.order_id = orders.order_id
group by 
    customers.company_name
order by 
    total desc