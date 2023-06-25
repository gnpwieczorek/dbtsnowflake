{{ config(materialized="incremental", tags=["hestia", "clients"]) }}


with
    stg_client as (

        select
            adress_email as adress_email,
            company as company,
            credit_card as credit_card,
            first_name as first_name,
            id as id,
            last_name as last_name,
            nation as nation,
            passport_number as passport_number,
            pesel as pesel,
            phone_number as phone_number,
            op as op,
            transaction as transaction,
            ts_ms as ts_ms,
            current_timestamp as added_at

        from {{ ref("raw_client") }}

        {% if is_incremental() %}

            where added_at > (select max(added_at) from {{ this }})

        {% endif %}
        qualify row_number() over (partition by id order by ts_ms desc) = 1
    )

select *
from stg_client
