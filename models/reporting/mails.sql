{{ config(materialized="table", tags=["hestia", "mails"]) }}

with
    final_mails as (
        select
            nation as notion,
            company as company,
            split_part(adress_email, '@', 2) as mail_domain
        from {{ ref("stg_clients_mails") }}
    ),
    domain_aggregation as (
        select
            count(*) as domain_usage,
            mail_domain,
            regexp_replace(notion, '[^a-zA-Z]', '') as nation,
            regexp_replace(company, '[^a-zA-Z]', '') as company
        from final_mails
        group by 2, 3, 4

    )

select *
from domain_aggregation
