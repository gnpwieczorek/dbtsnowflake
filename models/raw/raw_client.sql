{{
    config(
        materialized='table'
    )
}}

select *
from {{ source('client', 'client_raw')}}