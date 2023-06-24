{{
    config(
        materialized='table'
        , tags=['hestia','mails']
    )
}}

with final_mails as
(
    select  
        NATION as notion
        ,COMPANY as COMPANY
        ,split_part(ADRESS_EMAIL,'@',2) as mail_domain
    from
        {{ ref("stg_clients_mails") }}
)
, domain_aggregation as (
    select 
        count(*) as doamin_usage
        ,mail_domain
        ,regexp_replace(notion,'[^a-zA-Z]','') as notion
        ,regexp_replace(COMPANY,'[^a-zA-Z]','') as COMPANY
    from    
        final_mails
    group by
        2,3,4

)

select * from domain_aggregation

