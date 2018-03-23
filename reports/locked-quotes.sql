SELECT
  quote_id,
  quotes_status.status_name quote_status,
  sent_dt closed_date,
  locked_dt locked_date,
  customer_total,
  concat(users.first_name, ' ', users.last_name) salesman_full_name,
  concat(x2_contacts.firstName, ' ', x2_contacts.lastName) customer_name
FROM quotes
  left join users on (quotes.salesman = users.id)
  left join quotes_status on (quotes.status = quotes_status.id)
  left join individuals on (quotes.customer = individuals.id)
  left join x2crm.x2_contacts on (x2_contacts.id = individuals.contact_id)
WHERE locked_dt >= date_sub(now(), interval 2 week) AND (status = 2 or status = 9);
