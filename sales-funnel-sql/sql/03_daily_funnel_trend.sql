-- Query 4
-- funnel drop-off rates (last 30 days)

WITH funnel_counts AS (
  SELECT
    COUNT(DISTINCT CASE WHEN s.event_type = 'page_view'      THEN s.user_id END) AS page_views,
    COUNT(DISTINCT CASE WHEN s.event_type = 'add_to_cart'    THEN s.user_id END) AS add_to_cart,
    COUNT(DISTINCT CASE WHEN s.event_type = 'checkout_start' THEN s.user_id END) AS checkout_start,
    COUNT(DISTINCT CASE WHEN s.event_type = 'payment_info'   THEN s.user_id END) AS payment_info,
    COUNT(DISTINCT CASE WHEN s.event_type = 'purchase'       THEN s.user_id END) AS purchases
  FROM sales_funnel_analysis.sales s
  WHERE s.event_date >= TIMESTAMP(DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY))
)

SELECT
  page_views,
  add_to_cart,
  checkout_start,
  payment_info,
  purchases,

  ROUND(add_to_cart    * 100.0 / NULLIF(page_views, 0), 2)      AS view_to_cart_cvr,
  ROUND(checkout_start * 100.0 / NULLIF(add_to_cart, 0), 2)    AS cart_to_checkout_cvr,
  ROUND(payment_info   * 100.0 / NULLIF(checkout_start, 0), 2) AS checkout_to_payment_cvr,
  ROUND(purchases       * 100.0 / NULLIF(payment_info, 0), 2)   AS payment_to_purchase_cvr,
  ROUND(purchases       * 100.0 / NULLIF(page_views, 0), 2)      AS view_to_purchase_cvr,

  ROUND((page_views - add_to_cart)       * 100.0 / NULLIF(page_views, 0), 2)       AS drop_after_view_pct,
  ROUND((add_to_cart - checkout_start)  * 100.0 / NULLIF(add_to_cart, 0), 2)     AS drop_after_cart_pct,
  ROUND((checkout_start - payment_info) * 100.0 / NULLIF(checkout_start, 0), 2)  AS drop_after_checkout_pct,
  ROUND((payment_info - purchases)       * 100.0 / NULLIF(payment_info, 0), 2)    AS drop_after_payment_pct
FROM funnel_counts;

