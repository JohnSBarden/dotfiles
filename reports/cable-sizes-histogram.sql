use quote_tool;



select * from (

  select floor(cable_length / 12)*1 as cable_length, count(*) cable_count from cables

  where deleted = 'n' AND bin_id in (
    select bin_id from bins where deleted = 'n' AND cluster_id in (
      select cluster_id from clusters where deleted = 'n' AND  product_id in (
        select product_id from products where deleted = 'n' AND  quote_id in (
          select quote_id from quotes where deleted = 'n' AND sent_dt >= date_sub(now(), interval 1 year)
        )
      )
    )
  )


  group by 1 order by 1

) innerQuery order by cable_count desc