# Online Retail ETL Pipeline

## Project Overview

This project demonstrates an end-to-end ETL (Extract, Transform, Load) pipeline using **Python, Pandas, Amazon S3, Amazon Athena, and SQL**.

The pipeline takes raw online retail transaction data, cleans and transforms it with Python, stores the processed dataset in Amazon S3, and queries the cloud-based data using Amazon Athena.

The goal of the project is to demonstrate practical data engineering and analytics skills by building a pipeline that moves data from a raw source to business-ready insights.

---

## Architecture

![Online Retail ETL Architecture](etl_architecture.png)

### Pipeline Flow

**Raw Excel Data → Python/Pandas ETL → Processed CSV → Amazon S3 → Amazon Athena → SQL Business Analysis**

---

## Technologies Used

- **Python** — ETL development
- **Pandas** — data cleaning and transformation
- **Amazon S3** — cloud storage for processed data
- **Amazon Athena** — serverless SQL querying
- **SQL** — business analysis and window functions
- **Git/GitHub** — version control and project documentation

---

## Dataset

The project uses the **UCI Online Retail dataset**, which contains transactional data from an online retailer.

The dataset includes information such as:

- Invoice numbers
- Product codes and descriptions
- Quantities purchased
- Invoice dates
- Unit prices
- Customer IDs
- Countries

The raw dataset is intentionally not stored in this repository.

---

## ETL Process

### 1. Extract

The raw Online Retail Excel dataset is loaded into a Pandas DataFrame.

```python
df = pd.read_excel("Online Retail.xlsx")
```

### 2. Transform

The Python ETL pipeline performs several data-quality and transformation steps:

- Removes records with missing product descriptions
- Removes records with missing customer IDs
- Filters transactions with quantities less than or equal to zero
- Filters transactions with unit prices less than or equal to zero
- Converts invoice dates to datetime values
- Calculates total sales for each transaction
- Extracts year and month for time-based analysis

Total sales are calculated using:

```python
df["TotalSales"] = df["Quantity"] * df["UnitPrice"]
```

Year and month are extracted from the transaction date:

```python
df["Year"] = df["InvoiceDate"].dt.year
df["Month"] = df["InvoiceDate"].dt.month
```

### 3. Load

The transformed DataFrame is exported as:

```text
processed_sales.csv
```

The processed file is then uploaded to an **Amazon S3 bucket**, providing cloud-based storage for the cleaned dataset.

Amazon Athena is configured with an external table that points to the processed data stored in S3.

This allows SQL analysis to be performed directly against the S3 data without loading the dataset into a traditional database server.

---

## SQL Business Analysis

The `analysis.sql` file contains six business-analysis queries.

### Query 1 — Total Revenue by Country

Identifies which countries generate the highest total revenue.

### Query 2 — Top 10 Products by Revenue

Identifies the products responsible for the greatest amount of sales revenue.

### Query 3 — Top 10 Customers by Spending

Identifies the highest-value customers based on their total purchases.

### Query 4 — Monthly Revenue Trend

Aggregates revenue by year and month to analyze changes in sales over time.

### Query 5 — Top 3 Products Within Each Country

Uses the SQL `DENSE_RANK()` window function to identify the three highest-revenue products within each country.

### Query 6 — Month-over-Month Revenue Growth

Uses the SQL `LAG()` window function to compare monthly revenue with the previous month and calculate percentage change.

---

## Example Analysis

One of the Athena queries calculates total revenue by country:

```sql
SELECT
    Country,
    ROUND(SUM(TotalSales), 2) AS TotalRevenue
FROM retail_etl_db.online_retail
GROUP BY Country
ORDER BY TotalRevenue DESC;
```

The analysis showed that the **United Kingdom generated approximately $7.3 million in revenue** in the processed dataset, making it the largest market in the analysis.

---

## Repository Structure

```text
online-retail-etl-pipeline/
│
├── README.md
├── .gitignore
├── aws_etl_detailed_walkthrough.py
├── analysis.sql
└── etl_architecture.png
```

### File Descriptions

**`aws_etl_detailed_walkthrough.py`**  
Python ETL script responsible for extracting, cleaning, transforming, and exporting the retail dataset.

**`analysis.sql`**  
SQL queries used in Amazon Athena to perform business analysis.

**`etl_architecture.png`**  
Visual representation of the end-to-end data pipeline.

**`README.md`**  
Project documentation, architecture, technologies, and analysis overview.

---

## AWS Architecture

The cloud portion of the pipeline uses:

```text
Amazon S3
    ↓
Processed Retail Dataset
    ↓
Amazon Athena External Table
    ↓
SQL Queries
    ↓
Business Insights
```

Amazon S3 provides the storage layer while Amazon Athena provides a serverless SQL query layer over the processed dataset.

---

## Skills Demonstrated

This project demonstrates experience with:

- Building an end-to-end ETL pipeline
- Python data processing
- Pandas DataFrame transformations
- Data cleaning and validation
- Derived-column creation
- Cloud data storage with Amazon S3
- Creating and querying Athena external tables
- SQL aggregation
- Common Table Expressions (CTEs)
- SQL window functions
- `DENSE_RANK()`
- `LAG()`
- Business-oriented data analysis
- Git/GitHub version control
- Technical documentation
- Data pipeline architecture

---

## Future Improvements

Possible future enhancements include:

- Converting CSV data to Parquet for more efficient analytical queries
- Partitioning S3 data by year and month
- Automating ingestion into S3
- Adding AWS Glue for cataloging and ETL orchestration
- Adding data-quality validation
- Creating dashboards from the analyzed data
- Scheduling the pipeline for recurring execution

---

## Project Outcome

This project demonstrates how raw transactional data can be transformed into an analysis-ready cloud dataset using **Python, Pandas, Amazon S3, Amazon Athena, and SQL**.

It combines data transformation, cloud storage, SQL analytics, window functions, and technical documentation into a complete portfolio data pipeline.
