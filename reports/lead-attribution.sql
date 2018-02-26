SELECT
  quote_id,
  sent_dt closed_date,
  customer_total,
  concat(users.first_name, ' ', users.last_name) salesman_full_name,
  concat(x2_contacts.firstName, ' ', x2_contacts.lastName) customer_name
FROM quotes
  left join users on (quotes.salesman = users.id)
  left join individuals on (quotes.customer = individuals.id)
  left join x2crm.x2_contacts on (x2_contacts.id = individuals.contact_id)
WHERE lead_source LIKE '%Farm Progress 2017%';


SELECT
  firstName,
  lastName,
  concat(users.first_name, ' ', users.last_name) salesman_full_name
FROM x2crm.x2_contacts
  left join quote_tool.users on (x2_contacts.c_assignedTo = users.id)
WHERE leadSource LIKE '%Farm Progress 2017%';



