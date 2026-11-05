CREATE DATABASE IF NOT EXISTS sales_demo;

USE sales_demo;

CREATE TABLE sales_excel_clean (
  transaction_id VARCHAR(10), transaction_date DATE,
  customer VARCHAR(50), region VARCHAR(30), product VARCHAR(30),
  quantity INT, unit_price_ngn DECIMAL(12,2), discount_rate DECIMAL(5,2),
  payment_method VARCHAR(20), sales_rep VARCHAR(30), order_status VARCHAR(15)
);

SELECT COUNT(*) FROM sales_excel_clean;

CREATE VIEW completed_sales AS
SELECT *,
       quantity * unit_price_ngn * (1 - discount_rate) AS net_sales
FROM sales_excel_clean
WHERE order_status = 'Completed'
  AND quantity BETWEEN 1 AND 50
  AND discount_rate BETWEEN 0 AND 1;
  
SELECT region, SUM(net_sales) AS net_sales
FROM completed_sales
GROUP BY region
ORDER BY net_sales DESC;

SELECT region,
       SUM(net_sales) AS net_sales,
       ROUND(100 * SUM(net_sales) / (SELECT SUM(net_sales) FROM completed_sales), 1) AS percentage_of_total
FROM completed_sales
GROUP BY region
ORDER BY net_sales DESC;

CREATE VIEW sales_model AS
SELECT *,
       quantity * unit_price_ngn * (1 - discount_rate) AS net_sales,
       CASE WHEN quantity BETWEEN 1 AND 50
             AND discount_rate BETWEEN 0 AND 1 THEN 1 ELSE 0 END AS is_valid
FROM sales_excel_clean;sales_model