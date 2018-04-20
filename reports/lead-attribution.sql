use quote_tool;

-- amount of money and quotes closed, grouped by sources
SELECT
  count(*)            number_of_quotes,
  sum(customer_total) dollar_value,
  lead_source
FROM (
       SELECT
         quote_id,
         sent_dt                                                  closed_date,
         customer_total,
         concat(users.first_name, ' ', users.last_name)           salesman_full_name,
         concat(x2_contacts.firstName, ' ', x2_contacts.lastName) customer_name,
         quotes.lead_source
       FROM quotes
         LEFT JOIN users ON (quotes.salesman = users.id)
         LEFT JOIN individuals ON (quotes.customer = individuals.id)
         LEFT JOIN x2crm.x2_contacts ON (x2_contacts.id = individuals.contact_id)

       WHERE sent_dt BETWEEN date_sub(now(), interval 2 week) AND now()
     ) innerQuotes
GROUP BY lead_source order by number_of_quotes desc;

-- what quotes came from a source
SELECT
  quote_id,
  sent_dt                                                  closed_date,
  quotes_status.status_name                                                  quote_status,
  customer_total,
  concat(users.first_name, ' ', users.last_name)           salesman_full_name,
  concat(x2_contacts.firstName, ' ', x2_contacts.lastName) customer_name,
  quotes.lead_source
FROM quotes
  LEFT JOIN users ON (quotes.salesman = users.id)
  LEFT JOIN individuals ON (quotes.customer = individuals.id)
  LEFT JOIN quotes_status ON (quotes.status = quotes_status.id)
  LEFT JOIN x2crm.x2_contacts ON (x2_contacts.id = individuals.contact_id)
WHERE leadSource LIKE :lead_source_name or quotes.lead_source LIKE :lead_source_name
group by quote_id
;


-- what leads came from what source
SELECT
  firstName,
  lastName,
  concat(users.first_name, ' ', users.last_name) salesman_full_name
FROM x2crm.x2_contacts
  left join quote_tool.users on (x2_contacts.c_assignedTo = users.id)
WHERE leadSource LIKE '%Farm Progress 2017%';



