-- models/staging/stg_order_details.sql

select
    order_id,
    product_id,
    unit_price,
    quantity,
    discount
from
    {{ ref('raw_order_details') }}
