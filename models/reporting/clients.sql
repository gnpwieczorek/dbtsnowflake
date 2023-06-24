{{
    config(
        materialized='table'
        , tags=['hestia','clients']
    )
}}


with final_client as 
(
     select
          ADRESS_EMAIL      as ADRESS_EMAIL
        , COMPANY           as COMPANY
        , CREDIT_CARD       as CREDIT_CARD
        , FIRST_NAME        as FIRST_NAME
        , ID                as ID
        , LAST_NAME         as LAST_NAME
        , NATION            as NATION
        , PASSPORT_NUMBER as PASSPORT_NUMBER
        , PESEL as PESEL
        , PHONE_NUMBER as PHONE_NUMBER
    
    from  {{ref("stg_clients")}}
    where op in ('c','u')

)

select * from final_client