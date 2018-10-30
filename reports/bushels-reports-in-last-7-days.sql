select commodities.commodity_name, sum(bin_inventory) number_of_bushels
from prod.bins
  left join prod.commodities on (commodities.commodity_id = bins.bin_contents)
where file_time > date_sub(now(), interval 7 day) and bins.account_id not in (select account_id from prod.groups where is_demo_account = 1)
group by bin_contents
order by number_of_bushels desc
;

