# Online Retail ETL Pipeline

## Project Overview

This project demonstrates an end-to-end ETL (Extract, Transform, Load)
pipeline using Python, Pandas, Amazon S3, Amazon Athena, and SQL.

The project processes raw online retail transaction data, cleans and
transforms the dataset using Python, stores the processed data in Amazon S3,
and uses Amazon Athena to perform SQL-based business analysis.

## Architecture

Raw Online Retail Data
        ↓
Python / Pandas ETL
        ↓
Processed CSV
        ↓
Amazon S3
        ↓
Amazon Athena
        ↓
SQL Business Analysis

## Technologies Used

- Python
- Pandas
- SQL
- Amazon S3
- Amazon Athena
- AWS
- Git / GitHub

## ETL Process

### Extract

The raw Online Retail Excel dataset is loaded into a Pandas DataFrame.

### Transform

The Python ETL process:

- Removes records with missing customer IDs or product descriptions
- Removes transactions with invalid quantities
- Removes transactions with invalid unit prices
- Converts invoice dates to datetime values
- Calculates total sales using Quantity × UnitPrice
- Extracts year and month for time-based analysis

### Load

The transformed dataset is exported as `processed_sales.csv` and uploaded
to an Amazon S3 bucket.

Amazon Athena is configured to query the processed dataset directly from S3.

## SQL Analysis

The project includes SQL queries that analyze:

1. Total revenue by country
2. Top products by revenue
3. Top customers by spending
4. Monthly revenue trends
5. Top products within each country using DENSE_RANK()
6. Month-over-month revenue growth using LAG()

## Example Business Insight

Revenue-by-country analysis showed that the United Kingdom generated
approximately $7.3 million in revenue in the processed dataset, making it
the largest market in the analysis.

## Repository Structure

online-retail-etl-pipeline/
├── README.md
├── .gitignore
├── aws_etl_detailed_walkthrough.py
├── analytics.sql
└── images/
    └── etl_architecture.png

## Skills Demonstrated

This project demonstrates:

- Building an ETL pipeline with Python and Pandas
- Data cleaning and transformation
- Cloud data storage using Amazon S3
- Querying S3 data with Amazon Athena
- SQL aggregation and analysis
- SQL window functions including DENSE_RANK and LAG
- End-to-end data pipeline design
