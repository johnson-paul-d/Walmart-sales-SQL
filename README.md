# Walmart Sales Analysis: Comprehensive Insights Using SQL

## Overview
This project focuses on analyzing Walmart sales data using SQL to uncover meaningful insights. The analysis is divided into multiple sections, including feature engineering, product performance, customer behavior, and sales trends.

## Dataset
The dataset represents Walmart sales data containing:
- Transaction details such as `Date`, `Time`, and `Branch`.
- Customer demographics like `Gender` and `Customer Type`.
- Product-related data such as `Product Line`, `Quantity`, and `Total`.
- Payment methods and ratings provided by customers.

## Objectives
- Perform feature engineering to create new columns for `VAT`, `Time of Day`, `Day Name`, and `Month Name`.
- Analyze product performance to identify the most popular product lines and revenue generators.
- Investigate customer behaviors, including the most frequent payment methods, gender distribution, and customer types.
- Examine sales trends across cities, branches, and times of the day.

## Key Insights
- The **Electronic Accessories** product line is the most sold, while **Food and Beverages** generate the highest revenue.
- **E-wallet** is the most common payment method, followed closely by cash.
- Members contribute the most to revenue and pay higher VAT amounts.
- Sales peak in January, likely due to New Year celebrations.

## Highlights of the Analysis
- **Sales Trends**: Most sales occur in the evening across weekdays.
- **Customer Ratings**: The highest ratings are given during afternoons, with **Wednesdays** receiving the best average ratings.
- **Branch Insights**: Branch A has the highest sales volume, while Branch C serves more female customers.

## SQL Features Used
- Common Table Expressions (CTEs) for modular queries.
- Window functions for calculating averages and rankings.
- Aggregation functions like `SUM`, `AVG`, and `COUNT`.
- Conditional logic using `CASE` statements.
- Date and time functions for feature engineering.

## Usage
Clone the repository and execute the SQL queries using any SQL-compatible database management system with the Walmart sales dataset.

## Acknowledgment
Thanks to Walmart for providing the sales dataset used in this project.

## License
This project is licensed under the MIT License.
