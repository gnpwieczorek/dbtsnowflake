{{
    config(
        materialized="incremental"
        , tags=['hestia','mails']
    )
}}


with stg_clients_mails as (

    select
          ADRESS_EMAIL      as ADRESS_EMAIL
        , COMPANY           as COMPANY
        , NATION                  as NATION
        , TRANSFER_TIME as TRANSFER_TIME
        , current_timestamp       as added_at
        , ROWNUM_ID



    from {{ ref("raw_client") }}
    where
        COALESCE(TRIM( ADRESS_EMAIL ), '') <> ''

    {% if is_incremental() %}

        and ROWNUM_ID  > (select max(ROWNUM_ID) from {{ this }})

    {% endif %}
   
)

select * from stg_clients_mails