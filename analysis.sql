-- ============================================================
-- Online Retail ETL Project
-- SQL Business Analysis
-- ============================================================


-- ============================================================
-- Query 1: Total Revenue by Country
-- Purpose: Identifies which countries generate the highest
-- total sales revenue.
-- ============================================================

SELECT
    Country,
    ROUND(SUM(TotalSales), 2) AS TotalRevenue
FROM online_retail
GROUP BY Country
ORDER BY TotalRevenue DESC;


-- ============================================================
-- Query 2: Top 10 Products by Revenue
-- Purpose: Identifies the highest-performing products based
-- on total sales revenue.
-- ============================================================

SELECT
    ProductCode,
    Description,
    ROUND(SUM(TotalSales), 2) AS ProductRevenue
FROM online_retail
GROUP BY ProductCode, Description
ORDER BY ProductRevenue DESC
LIMIT 10;


-- ============================================================
-- Query 3: Top 10 Customers by Total Spending
-- Purpose: Identifies the highest-value customers based on
-- their total purchases.
-- ============================================================

SELECT
    CustomerID,
    ROUND(SUM(TotalSales), 2) AS CustomerSpend
FROM online_retail
GROUP BY CustomerID
ORDER BY CustomerSpend DESC
LIMIT 10;


-- ============================================================
-- Query 4: Monthly Revenue Trend
-- Purpose: Analyzes total sales revenue by year and month
-- to identify sales trends over time.
-- ============================================================

SELECT
    Year,
    Month,
    ROUND(SUM(TotalSales), 2) AS MonthlyRevenue
FROM online_retail
GROUP BY Year, Month
ORDER BY Year, Month;


-- ============================================================
-- Query 5: Top 3 Products by Revenue Within Each Country
-- Purpose: Uses DENSE_RANK() to identify the three
-- highest-revenue products within each country.
-- ============================================================

WITH product_sales AS (
    SELECT
        Country,
        ProductCode,
        Description,
        SUM(TotalSales) AS ProductRevenue
    FROM online_retail
    GROUP BY Country, ProductCode, Description
),

ranked_products AS (
    SELECT
        Country,
        ProductCode,
        Description,
        ProductRevenue,
        DENSE_RANK() OVER (
            PARTITION BY Country
            ORDER BY ProductRevenue DESC
        ) AS ProductRank
    FROM product_sales
)

SELECT
    Country,
    ProductCode,
    Description,
    ProductRevenue,
    ProductRank
FROM ranked_products
WHERE ProductRank <= 3
ORDER BY Country, ProductRank;


-- ============================================================
-- Query 6: Month-over-Month Revenue Growth
-- Purpose: Uses LAG() to compare each month's revenue with
-- the previous month and calculate percentage change.
-- ============================================================

WITH monthly_sales AS (
    SELECT
        Year,
        Month,
        SUM(TotalSales) AS MonthlyRevenue
    FROM online_retail
    GROUP BY Year, Month
),

previous_month AS (
    SELECT
        Year,
        Month,
        MonthlyRevenue,
        LAG(MonthlyRevenue) OVER (
            ORDER BY Year, Month
        ) AS PreviousMonthRevenue
    FROM monthly_sales
)

SELECT
    Year,
    Month,
    ROUND(MonthlyRevenue, 2) AS MonthlyRevenue,
    ROUND(PreviousMonthRevenue, 2) AS PreviousMonthRevenue,
    ROUND(
        ((MonthlyRevenue - PreviousMonthRevenue)
        / PreviousMonthRevenue) * 100,
        2
    ) AS PercentChange
FROM previous_month
ORDER BY Year, Month;