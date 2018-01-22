# Perform the above query for each salesman, 3 times
# 1) Open quotes, last 3 months
# 2) Stale quotes, last 12 months
# 3) Lost quotes, last 12 months

SELECT *
FROM (SELECT
        quotes.quote_id,
        individuals.farm_name,
        individuals.first_name,
        individuals.last_name,
        customer_total,
        quotes_status.status_name,
        quote_lost_types.type_name,
        quote_lost_details.details                               lost_extended_reason,
        quotes.created_dt                                        quote_created,
        quotes.modified_dt                                       quote_modified,
        concat(users.first_name, ' ', users.last_name)           original_quoter,
        concat(stateOwner.first_name, ' ', stateOwner.last_name) territory_owner,
        parent_territory
      FROM quote_tool.quotes
        LEFT JOIN quote_tool.users ON (quotes.salesman = users.id)
        LEFT JOIN quote_tool.individuals ON (quotes.customer = individuals.id)
        LEFT JOIN x2crm.x2_accounts ON (individuals.account_id = x2_accounts.id)
        LEFT JOIN quote_tool.states ON (states.state_id = x2_accounts.territory)
        LEFT JOIN quote_tool.users stateOwner ON (states.direct_salesman = stateOwner.id)
        LEFT JOIN quote_tool.quotes_status ON (quotes_status.id = quotes.status)
        LEFT JOIN quote_tool.quote_lost_details ON (quotes.quote_id = quote_lost_details.quote_id)
        LEFT JOIN quote_tool.quote_lost_types ON (quotes.lost_type = quote_lost_types.id)
      WHERE territory IS NOT NULL
            AND sent = 'n'
            AND quotes.created_dt >= date_sub(now(), INTERVAL 12 MONTH)
            AND users.dealer_id = 31
            AND quotes.status = 8
     ) innerQuery
WHERE original_quoter != territory_owner
;


