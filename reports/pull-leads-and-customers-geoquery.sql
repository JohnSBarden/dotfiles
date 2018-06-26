use quote_tool;

SELECT
  *,
  (SELECT count(*)
   FROM bins
   WHERE bins.group_id = (SELECT group_id
                          FROM groups
                          WHERE account_id = c_platform_account_id)) AS numberOfBins,
  (SELECT count(*)
   FROM fdm
   WHERE fdm.group_id = (SELECT group_id
                         FROM groups
                         WHERE account_id = c_platform_account_id))  AS numberOfFdms,
  (
    3959 *
    acos(
      cos(radians(:lat)) *
      cos(radians(lat)) *
      cos(
        radians(lng) - radians(:lng)
      ) +
      sin(radians(:lat)) *
      sin(radians(lat))))                                            AS `distance`
FROM
  (SELECT
     x2_contacts.firstName,
     x2_contacts.lastName,
     concat(users.first_name, ' ', users.last_name)                    assignedSalesRep,
     x2_contacts.email,
     x2_contacts.phone,
     x2_contacts.phone2,
     x2_accounts.gpsLatitude                                           lat,
     x2_accounts.gpsLongitude                                          lng,
    x2_accounts.city,
    x2_accounts.state,
     if(x2_accounts.c_platform_account_id IS NULL, 'LEAD', 'CUSTOMER') customerStatus,
     x2_accounts.c_platform_account_id,
     IF((groups.exp_date IS NULL AND groups.sub_exp_date IS NULL AND groups.trial_exp_date IS NULL
         AND groups.mm_merchandiser_exp_date IS NULL
         AND groups.mm_producer_exp_date IS NULL
         AND groups.yf_sc_exp_date IS NULL
         AND groups.yf_producer_exp_date IS NULL), NULL, (GREATEST(
       IF(groups.exp_date IS NULL, '0', groups.exp_date),
       IF(groups.sub_exp_date IS NULL, '0', groups.sub_exp_date),
       IF(groups.trial_exp_date IS NULL, '0', groups.trial_exp_date),
       IF(groups.mm_merchandiser_exp_date IS NULL, '0', groups.mm_merchandiser_exp_date),
       IF(groups.mm_producer_exp_date IS NULL, '0', groups.mm_producer_exp_date),
       IF(groups.yf_sc_exp_date IS NULL, '0', groups.yf_sc_exp_date),
       IF(groups.yf_producer_exp_date IS NULL, '0', groups.yf_producer_exp_date)
     )))                                                               greatest_exp_date,

     if(groups.subscription_type IS NULL, 'NONE',
        if(groups.subscription_type = 1, 'PLATFORM', 'LEGACY-DATA'))   subscription_type


   FROM quote_tool.quotes
   left join individuals on (individuals.id = quotes.customer)
   left join x2crm.x2_accounts on (individuals.account_id = x2_accounts.id)
     LEFT JOIN x2crm.x2_contacts ON (x2_contacts.id = x2_accounts.primary_contact_id)
     LEFT JOIN quote_tool.users ON (users.id = x2_contacts.c_assignedTo)
     LEFT JOIN prod.groups
       ON (groups.account_id = x2_accounts.c_platform_account_id AND x2_accounts.c_platform_account_id != 0)



  ) innerQuery

HAVING distance < 200
;


