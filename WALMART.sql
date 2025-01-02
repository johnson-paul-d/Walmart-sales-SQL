USE walmarrt;


SELECT *
FROM sales;

-- FEATURE ENGINEERING
-- VAT column

ALTER TABLE sales ADD VAT DECIMAL(10, 2);


UPDATE sales
SET VAT = cogs * 0.05;

-- Time of the day

ALTER TABLE sales ADD Time_of_day varchar(50);


UPDATE sales
SET Time_of_day = (CASE
                       WHEN TIME BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
                       WHEN TIME BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
                       ELSE 'Evening'
                   END);

-- Day name

ALTER TABLE sales ADD Day_name varchar(50);


UPDATE sales
SET Day_name = datename(dw,date);

-- Month name

ALTER TABLE sales ADD Month_name varchar(30);


UPDATE sales
SET Month_name = DATENAME(MONTH,date);

-- QUESTIONS
-- How many unique cities does the data have?

SELECT DISTINCT(City) AS dist_city
FROM SALES;

-- In which city is each branch?

SELECT DISTINCT city,
                branch
FROM sales
ORDER BY Branch;

-- PRODUCT ANALYSIS
-- 1. How many unique product lines does the data have?

SELECT DISTINCT(Product_line) AS dist_pro_line
FROM sales
ORDER BY Product_line;

/* INFERENECES :There are 6 product lines in the data. Those are
Electronic accessories
Fashion accessories
Food and beverages
Health and beauty
Home and lifestyle
Sports and travel
*/ -- 2. What is the most common payment method?

SELECT payment,
       COUNT(*) AS COUNT
FROM sales
GROUP BY payment
ORDER BY COUNT DESC;

/* INFERENECES : The most common payment method in the given data set is E-WALLET, also the cash transaction is more or less same as E-WALLET
which signifies that the people do not tend make transactions using CREDIT CARDS
*/ -- 3. What is the most selling product line?

SELECT Product_line,
       SUM(quantity) AS Number_of_sales
FROM sales
GROUP BY Product_line
ORDER BY SUM(quantity) DESC;


SELECT gender,
       COUNT(*) AS COUNT
FROM sales
GROUP BY gender
ORDER BY COUNT DESC;

/* INFERENECES : The most selling product line is Electronic accessories which signifies the revenue produced from those is much hhigher than any other product line.
The Health and beauty product line is the lowest selling product line which makes us to think that people are less conscious about their health and beauty and
they love to invest or try new Electronic accessories
*/ --4. What is the total revenue by month?

SELECT Month_name,
       round(sum(total), 4) AS revenue
FROM sales
GROUP BY Month_name
ORDER BY revenue DESC;

/* INFERENECES : The highest total sale is in the month of JANUARY, which may be due to NEW YEAR CELEBRATION.
*/ -- 5. What month had the largest COGS?

SELECT Month_name,
       ROUND(sum(cogs), 4) AS COGS
FROM sales
GROUP BY Month_name
ORDER BY sum(cogs) DESC;

/* INFERENECES : The highest total COGS is in the month of JANUARY, which may be due to NEW YEAR CELEBRATION.
*/ -- 6. What product line had the largest revenue?

SELECT product_line,
       round(sum(total), 4) AS revenue
FROM sales
GROUP BY PRODUCT_line
ORDER BY sum(total) DESC;

/* INFERENECES : The product line "Food and beverages" had the largest revenue.
*/ -- 5. What is the city with the largest revenue?

SELECT city,
       round(sum(total), 4) AS revenue
FROM sales
GROUP BY city
ORDER BY revenue DESC;

/* INFERENECES :The city with the largest revenue is Naypyitaw.
*/ -- 6. What product line had the largest VAT?

SELECT product_line,
       round(max(TAX_5), 2)AS VAT
FROM sales
GROUP BY PRODUCT_line
ORDER BY vat DESC;

/* INFERENECES :The product line with the largest VAT is Fashion accessories.
*/ -- 7. Fetch each product line and add a column to those product line showing  "Good", "Bad". Good if its greater than average sales
WITH SalesSummary AS
  (SELECT Product_line,
          ROUND(SUM(TOTAL), 2) AS TotalSales,
          ROUND(AVG(SUM(TOTAL)) OVER (), 2) AS AvgSales
   FROM sales
   GROUP BY Product_line)
SELECT Product_line,
       TotalSales,
       AvgSales,
       CASE
           WHEN TotalSales > AvgSales THEN 'GOOD'
           WHEN TotalSales < AvgSales THEN 'BAD'
           ELSE 'NEUTRAL'
       END AS Good_Or_Bad
FROM SalesSummary;

/* INFERENECES :The product line with total sales lesser than the averge sales is Health and beauty
*/ -- 8. Which branch sold more products than average product sold?

SELECT branch,
       sum(quantity) AS Total_Quantity,
       avg(quantity) AS Average_Quantity
FROM sales
GROUP BY branch
ORDER BY Total_Quantity DESC;

-- OR

SELECT branch,
       sum(quantity) AS Total_Quantity
FROM sales
GROUP BY branch
HAVING sum(quantity) >
  (SELECT avg(quantity)
   FROM SALES)
ORDER BY Total_Quantity DESC;

/* INFERENECES :The branch A sold more products than branch B and C
*/ -- 9. What is the most common product line by gender?

SELECT product_line,
       gender,
       count(gender) AS Gender_count
FROM sales
GROUP BY product_line,
         gender
ORDER BY Gender,
         Gender_count DESC;

-- OR

SELECT product_line,
       gender,
       count(gender) AS Gender_count
FROM sales
WHERE GENDER like 'M%'
GROUP BY product_line,
         gender
ORDER BY Gender,
         Gender_count DESC;

-- AND

SELECT product_line,
       gender,
       count(gender) AS Gender_count
FROM sales
WHERE GENDER ='Female'
GROUP BY product_line,
         gender
ORDER BY Gender,
         Gender_count DESC;

/* INFERENECES : The most common product line used by male customers is HEALTH AND BEAUTY
				 The most common product line used by female customers is FASHION ACCESSORIES
*/ -- 12. What is the average rating of each product line?

SELECT PRODUCT_LINE,
       ROUND(avg(rating), 3) AS AVERAGE_RATING
FROM SALES
GROUP BY [Product_line]
ORDER BY AVERAGE_RATING DESC;

/* INFERENECES : FOOD AND BEVERAGES have the highest average rating of 7.113
				 HOME AND LFESTYLE have the least average rating of 6.838
*/ -- CUSTOMER ANALYSIS
-- 1. How many unique customer types does the data have?

SELECT customer_type,
       count(*) AS COUNT
FROM sales
GROUP BY customer_type
ORDER BY COUNT;

-- or

SELECT count(distinct(customer_type)) AS Type_of_customer
FROM sales;

/* INFERENECES : The distinct customer types are NORMAL AND MEMBER
*/ -- 2.How many unique payment methods does the data have?

SELECT Payment,
       count(*) AS COUNT
FROM sales
GROUP BY Payment
ORDER BY COUNT;

-- or

SELECT count(distinct(Payment)) AS Payment_Type
FROM sales;

/* INFERENECES : There are three payment types CREDIT CARD, CASH,EWALLET
*/ -- 3. Which customer type buys the most?

SELECT customer_type,
       sum(Quantity) AS Number_of_goods
FROM sales
GROUP BY Customer_type
ORDER BY Number_of_goods DESC;

/* INFERENECES : The MEMBERS buys most of the products.
*/ -- 4. What is the gender of most of the customers?

SELECT Gender,
       count(gender) AS Gender_count
FROM sales
GROUP BY gender;

/* INFERENECES : The most of the customers are FEMALES
*/ -- 5. What is the gender distribution per branch?

SELECT branch,
       count(gender) AS Gender_count,
       Gender
FROM sales
GROUP BY branch,
         gender
ORDER BY branch;

/* INFERENECES : BRANCH A has more MALE
				 BRANCH B has more MALE
				 BRANCH C has more FEMALE
*/ -- 6. Which time of the day do customers give most ratings?

SELECT Time_of_day,
       round(AVG(Rating), 3) AS Average_rating
FROM sales
GROUP BY Time_of_day
ORDER BY Average_rating DESC;

/* INFERENECES : The highest average rating  is given in afternoon of the day.
*/ --7. Which time of the day do customers give most ratings per branch?

SELECT Time_of_day,
       Branch,
       round(AVG(Rating), 3) AS Average_rating
FROM sales
GROUP BY Time_of_day,
         Branch
ORDER BY branch,
         Average_rating DESC;

/* INFERENECES : BRANCH A has more Ratings in AFTERNOON
				 BRANCH B has more Ratings in MORNING
				 BRANCH C has more Ratings in EVENING
*/ -- 8. Which day for the week has the best avg ratings?

SELECT Day_name,
       round(avg(rating), 4) AS Average_rating
FROM sales
GROUP BY Day_name
ORDER BY Average_rating DESC;

/* INFERENECES : WEDNESDAY has the highest average rating
*/ -- 9. Which day of the week has the best average ratings per branch?

SELECT branch,
       Day_name,
       round(avg(rating), 4) AS Average_rating
FROM sales
GROUP BY Day_name,
         branch
ORDER BY branch,
         Average_rating DESC;

/* INFERENECES : BRANCH A has more Ratings in FRIDAY
				 BRANCH B has more Ratings in MONDAY
				 BRANCH C has more Ratings in FRIDAY
*/ -- SALES ANALYSIS
-- 1. Number of sales made in each time of the day per weekday

SELECT Time_of_day,
       Day_name,
       count(Quantity) AS Number_of_sales
FROM sales
WHERE Day_name NOT IN ('Sunday',
                       'Saturday')
GROUP BY Time_of_day,
         Day_name
ORDER BY Day_name,
         Number_of_sales DESC;

/* INFERENECES : The highest sale in MONDAY is in EVENING
				 The highest sale in TUESDAY is in EVENING
				 The highest sale in WEDNESDAY is in AFTERNOON
				 The highest sale in THURSDAY is in EVENING
			     The highest sale in FRIDAY is in AFTERNOON
*/ -- 2. Which of the customer types brings the most revenue?

SELECT CUSTOMER_TYPE,
       round(sum(Total), 4) AS Total
FROM sales
GROUP BY CUSTOMER_TYPE
ORDER BY Total DESC;

/* INFERENECES : The members brings the most revenue
*/
-- 3. Which city has the largest tax percent/ VAT (**Value Added Tax**)?

SELECT CITY,
       ROUND(AVG(VAT), 4) AS VAT_
FROM SALES
GROUP BY CITY
ORDER BY VAT_;

-- 4. Which customer type pays the most in VAT?

SELECT customer_type,
       sum(vat) AS Total_VAT
FROM sales
GROUP BY customer_type
ORDER BY AVG(vat) DESC;

/* INFERENCES : The members pay more in VAT
*/