use  ev_sales;
select * from evsalesdata;

-- What is the total number of EV sales in each region for the year 2020?
SELECT region, SUM(value) AS total_sales
FROM EVSalesData
WHERE parameter = 'EV sales' AND year = 2020
GROUP BY region;

-- Which region had the highest EV sales share in 2021?
SELECT region, value AS sales_share
FROM EVSalesData
WHERE parameter = 'EV sales share' AND year = 2021
ORDER BY value DESC
LIMIT 1;

-- What is the total EV stock for each powertrain type in the year 2019?
select parameter , sum(value) as total
from evsalesdata 
where parameter = 'EV stock' and year = 2019
group by parameter;

-- What is the average EV stock share across all regions for the year 2018?
SELECT AVG(value) AS average_stock_share
FROM EVSalesData
WHERE parameter = 'EV stock share' AND year = 2018;

-- How many Battery Electric Vehicles (BEVs) were sold in Australia in 2015?
SELECT SUM(value) AS total_bev_sales
FROM EVSalesData
WHERE region = 'Australia' AND parameter = 'EV sales' AND powertrain = 'BEV' AND year = 2015;

-- Which year had the highest total EV sales globally
SELECT year, SUM(value) AS total_sales
FROM EVSalesData
WHERE parameter = 'EV sales'
GROUP BY year
ORDER BY total_sales DESC
LIMIT 1;

