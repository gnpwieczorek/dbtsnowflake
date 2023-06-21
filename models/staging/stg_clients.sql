{{
    config(
        materialized="incremental"
        , tags=['hestia']
    )
}}


with stg_client as (

    select
          ADRESS_EMAIL              as ADRESS_EMAIL
        , COMPANY           as COMPANY
        , CREDIT_CARD                 as CREDIT_CARD
        , FIRST_NAME           as FIRST_NAME
        , ID            as ID
        , LAST_NAME          as LAST_NAME
        , NATION                  as NATION
        , PASSPORT_NUMBER as PASSPORT_NUMBER
        , PESEL as PESEL
        , PHONE_NUMBER as PHONE_NUMBER
        , OP as OP
        , TRANSACTION as TRANSACTION
        , TS_MS as TS_MS
        , current_timestamp    as added_at



    from {{ source("client", "client_raw") }}

    {% if is_incremental() %}

        where added_at > (select max(added_at) from {{ this }})

    {% endif %}
    qualify row_number() over (partition by id order by ts_ms desc) = 1
)

select * from stg_client