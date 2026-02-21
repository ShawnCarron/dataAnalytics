-- Query 2
-- source funnel
-- conversion rate analysis from campaign soure to purchase

WITH source_funnel AS (

SELECT 
	s.traffic_source,
	count(DISTINCT CASE WHEN s.event_type = 'page_view' THEN s.user_id END) AS views, 
	count(DISTINCT CASE WHEN s.event_type = 'add_to_cart' THEN s.user_id END) AS carts,
	count(DISTINCT CASE WHEN s.event_type = 'purchase' THEN s.user_id END) AS purchases
	
FROM sales_funnel_analysis.sales s
WHERE s.event_date >= timestamp(date_sub(current_date(), INTERVAL 30 DAY)) 
GROUP BY s.traffic_source

)

SELECT
	traffic_source,
	views,
	carts,
	purchases,
	round(carts * 100 / NULLIF(views, 0), 0) AS views_cart_cvr,
	round(purchases * 100 / NULLIF(carts, 0), 0) AS  cart_purchases_cvr,
	round(purchases * 100 / NULLIF(views, 0), 0) AS views_purchases_cvr
FROM source_funnel
ORDER by purchases desc;