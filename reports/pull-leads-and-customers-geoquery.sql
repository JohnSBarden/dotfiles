SELECT *,
  (
    3959 *
    acos(
        cos( radians( :lat ) ) *
        cos( radians( lat ) ) *
        cos(
            radians( lng ) - radians(  :lng )
        ) +
        sin(radians(:lat)) *
        sin(radians(lat))         )     ) as `distance`
FROM
  (SELECT
     'LEAD AND MAYBE CUSTOMER' AS lead_type,
     quotes.lead_source,
     individuals.first_name       lead_first_name,
     individuals.last_name        lead_last_name,
     individuals.email            lead_email,
     individuals.phone_number     lead_phone_number,
     individuals.street_address   lead_address,
     individuals.state            lead_state,
     individuals.country          lead_country,
     individuals.zip_code         lead_postal_code,
     individuals.city             lead_city,
     users.first_name             salesman_first_name,
     users.last_name              salesman_last_name,
     groups.name                  salesman_group_name,
     x2_accounts.gpsLatitude      lat,
     x2_accounts.gpsLongitude     lng
   FROM
     quote_tool.quotes
     LEFT JOIN quote_tool.users ON (users.id = quotes.salesman)
     LEFT JOIN quote_tool.groups ON (users.dealer_id = groups.id)
     LEFT JOIN quote_tool.individuals ON (individuals.id = quotes.customer)
     LEFT JOIN x2crm.x2_accounts ON (individuals.account_id = x2_accounts.id)
   UNION SELECT
           'CUSTOMER' AS       lead_type,
           'UNKNOWN'  AS       lead_source,
           pu.first_name       lead_first_name,
           pu.last_name        lead_last_name,
           pu.email            lead_email,
           pu.phone_number     lead_phone_number,
           pg.address_shipping lead_address,
           pg.state_shipping   lead_state,
           pg.zip_shipping     lead_postal_code,
           pg.city_shipping    lead_city,
           pg.country_shipping lead_country,
           ppg.first_name      salesman_first_name,
           ppg.last_name       salesman_last_name,
           ppg.account_name    salesman_group_name,
           pg.lat              lat,
           pg.lng              lng

         FROM
           prod.users pu
           INNER JOIN prod.groups pg ON (pu.group_id = pg.group_id)
           INNER JOIN prod.groups ppg ON (pg.parent_id = ppg.group_id)) a

where lat is not null
having distance < 100
;

