SELECT 
    individuals.*
FROM
    quote_tool.quotes
        LEFT JOIN
    individuals ON (individuals.id = quotes.customer)
WHERE
    sent_dt IS NULL
        AND quotes.created_dt > DATE_SUB(NOW(), INTERVAL 1 YEAR) and (shipping_state in ('Kansas', 'KS') or state in ('Kansas', 'KS'))
        group by individuals.email, individuals.phone_number
LIMIT 10000