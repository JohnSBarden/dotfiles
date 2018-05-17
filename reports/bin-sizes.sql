use quote_tool;
SELECT
  *,
  count(*) count
FROM (
       SELECT
         bins.bin_diameter / 12                     diameter,
         bins.wall_height / 12                      height,
         if(bins.floor_slope > 0, 'Hopper', 'Flat') hopper

       FROM bins
       WHERE bins.deleted = 'n' AND bins.cluster_id IN (
         SELECT cluster_id
         FROM clusters
         WHERE clusters.deleted = 'n' AND product_id IN (
           SELECT product_id
           FROM products
           WHERE products.deleted = 'n' AND quote_id IN (
             SELECT quote_id
             FROM quotes
             WHERE sent_dt BETWEEN '2017-12-01' AND now()
           )
         )
       )
     ) binSizes
GROUP BY diameter, height, hopper

# order by diameter asc, height asc, hopper asc
ORDER BY count DESC;


;




