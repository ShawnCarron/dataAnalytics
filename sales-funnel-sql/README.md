# Sales Funnel SQL Analysis (Last 30 Days)

This repo contains 4 SQL queries that analyze a website sales funnel using event data:
page_view → add_to_cart → checkout_start → payment_info → purchase.

## Dataset
Table: `sales_funnel_analysis.sales`

Expected columns:
- `user_id`
- `event_type` (page_view, add_to_cart, checkout_start, payment_info, purchase)
- `event_date` (timestamp)
- `traffic_source`

## Key assumptions
- Metrics are based on distinct users per event stage
- Time window is the last 30 days from `CURRENT_DATE()`

## Queries
1. **Sales funnel overview**
   - Total distinct users at each stage
   - Stage-to-stage conversion rates
2. **Source funnel**
   - Views, carts, purchases by `traffic_source`
   - Conversion rates by source
3. **Daily funnel trend**
   - Daily counts by stage
   - View-to-purchase conversion rate by day
4. **Drop-off rates**
   - Stage conversion rates and drop-off percentages

## How to run
Run the `.sql` files in order from the `sql/` folder in a MySQL environment that supports CTEs.
Each query filters to the last 30 days using `CURRENT_DATE()` and `DATE_SUB()`.

## Example outputs
Add screenshots or a small sample table here after you run the queries.
