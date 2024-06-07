-- models/reporting/clients_to_marketing.sql

{{ config(
    schema='gold',
    materialized='table'
) }}

select * from {{ref('raw_customers')}}