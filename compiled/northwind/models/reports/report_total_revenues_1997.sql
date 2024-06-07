-- models/reporting/report_total_revenues_1997.sql



with ord as (
    select order_id 
    from "postgres"."public"."stg_orders"
    where extract(year from order_date) = 1997
)
select 
    sum(order_details.unit_price * order_details.quantity * (1.0 - order_details.discount)) as total_revenues_1997
from 
    "postgres"."public"."stg_order_details" as order_details
inner join 
    ord on ord.order_id = order_details.order_id