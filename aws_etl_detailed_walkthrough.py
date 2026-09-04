#Full code at the bottom

import csv

# --------------------------------------------------
# 1. DEFINE OUR INPUT AND OUTPUT FILES
# --------------------------------------------------

# This is the raw data we want to process.
input_file = "data/sales_data.csv"

# This is where we'll save the transformed data.
output_file = "data/processed_sales.csv"


# --------------------------------------------------
# 2. READ THE RAW DATA
# --------------------------------------------------

# Open the raw CSV file in read mode.
with open(input_file, "r") as infile:

    # DictReader reads each row as a dictionary.
    # The column names become the dictionary keys.
    reader = csv.DictReader(infile)

    # Create an empty list to hold our processed rows.
    rows = []

    # Go through the raw data one row at a time.
    for row in reader:

        # Convert quantity from text to an integer.
        quantity = int(row["quantity"])

        # Convert price from text to a decimal number.
        price = float(row["price"])

        # TRANSFORMATION:
        # Calculate the total amount for each order.
        row["total_amount"] = quantity * price

        # Add the transformed row to our list.
        rows.append(row)


# --------------------------------------------------
# 3. WRITE THE TRANSFORMED DATA
# --------------------------------------------------

# Open/create the output CSV file.
with open(output_file, "w", newline="") as outfile:

    # Get the column names from the first row.
    fieldnames = rows[0].keys()

    # Create a CSV writer.
    writer = csv.DictWriter(
        outfile,
        fieldnames=fieldnames
    )

    # Write the column names.
    writer.writeheader()

    # Write all of our transformed rows.
    writer.writerows(rows)


# --------------------------------------------------
# 4. CONFIRM THE ETL JOB FINISHED
# --------------------------------------------------

print("ETL process completed successfully!")