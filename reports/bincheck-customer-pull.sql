
select
  quotes.quote_id,
  quotes.customer_total,
  x2_contacts.firstName,
  x2_contacts.lastName,
  concat(users.first_name, ' ', users.last_name) assignedSalesRep,
  x2_contacts.email,
  individuals.email backupEmail,
  x2_contacts.phone,
  x2_contacts.phone2,

  x2_accounts.address shippingAddress,
  x2_accounts.city shippingCity,
  x2_accounts.state shippingState,
  x2_accounts.zipcode shippingPostalCode,

  x2_accounts.billingAddress,
  x2_accounts.billingCity,
  x2_accounts.billingState,
  x2_accounts.billingPostalCode,

  individuals.shipping_street_address backupShippingAddress,
  individuals.shipping_city backupShippingCity,
  individuals.shipping_state backupShippingState,
  individuals.shipping_zip_code backupShippingPostalCode,

  individuals.street_address backupBillingAddress,
  individuals.city backupBillingCity,
  individuals.state backupBillingState,
  individuals.zip_code backupPostalCode,

  divisions.division_full_name,
  divisions.division_code,

   if(x2_accounts.c_platform_account_id IS NULL, 'LEAD', 'CUSTOMER') customerStatus

from quote_tool.quotes
  left join quote_tool.individuals on (individuals.id = quotes.customer)
  left join x2crm.x2_accounts on (x2_accounts.id = individuals.account_id)
  left join x2crm.x2_contacts on (x2_contacts.id = individuals.contact_id)
  left join quote_tool.users on (quotes.salesman = users.id)
  left join quote_tool.groups on (users.dealer_id = groups.id)
  left join quote_tool.divisions on (groups.division = divisions.id)
where
  divisions.division_code != 'KRISTOFFERSON'


  AND quotes.deleted = 'n' and sent_dt is not null
      and quote_id in (select quote_id
                       from products
                       where product_id in (select product_id
                                            from clusters
                                            where cluster_id in (select cluster_id
                                                                 from bins
                                                                 where bin_id in (select bin_id
                                                                                  from quote_tool.bin_parts
                                                                                  where part_type_id in
                                                                                        (35, 36, 52, 57, 58))
                                            )
                       )
);
