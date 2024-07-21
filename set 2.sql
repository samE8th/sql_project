use ev_sales;
select * from evsalesdata;

-- 1.Annual EV Sales by Region: 
 -- Write a query to calculate the total number of EVs sold in each region for each year.
 -- Order the results by region and year.

SELECT 
    region,
    year,
    SUM(value) AS total_ev_sales
FROM 
    evsalesdata
WHERE 
    parameter = 'EV sales' AND unit = 'Vehicles'
GROUP BY 
    region, year
ORDER BY 
    region, year;

  

-- 2.EV Stock Share Trend: 
 -- Write a query to find the trend in EV stock share (percent) for each region over 
 -- the years. Display the region, year, and EV stock share.
 
 SELECT 
    region,
    year,
    value AS ev_stock_share
FROM 
    evsalesdata
WHERE 
    parameter = 'EV stock share' AND unit = 'percent'
ORDER BY 
    region, year;


-- 3.Top Regions by EV Sales: 
-- Identify the top 5 regions with the highest EV sales in the most recent year 
-- available in the dataset. Provide the region and the total number of EVs sold.


SELECT 
    region,
    SUM(value) AS total_ev_sales
FROM
    evsalesdata
WHERE 
    parameter = 'EV sales' AND unit = 'Vehicles' AND year = (SELECT MAX(year) FROM evsalesdata)
GROUP BY 
    region
ORDER BY 
    total_ev_sales DESC
LIMIT 5;



-- 4.EV Sales Growth Rate: 
-- Calculate the year-over-year growth rate of EV sales for each region. Show the region, 
-- year, and growth rate.

SELECT 
    region,
    year,
    (value - LAG(value) OVER (PARTITION BY region ORDER BY year)) / LAG(value) OVER (PARTITION BY region ORDER BY year) * 100 AS growth_rate
FROM 
    evsalesdata
WHERE 
    parameter = 'EV sales' AND unit = 'Vehicles'
ORDER BY 
    region, year;



-- 5.Powertrain Sales Analysis:
  -- Write a query to analyze the sales of different powertrains
 -- (e.g., BEV, PHEV) for the most recent year. Provide the powertrain type, total sales,
 -- and the share of each powertrain in the total sales.

SELECT 
    powertrain,
    SUM(value) AS total_sales,
    (SUM(value) / (SELECT 
            SUM(value)
        FROM
            evsalesdata
        WHERE
            parameter = 'EV sales'
                AND unit = 'Vehicles'
                AND year = (SELECT 
                    MAX(year)
                FROM
                    evsalesdata))) * 100 AS sales_share
FROM
    evsalesdata
WHERE
    parameter = 'EV sales'
        AND unit = 'Vehicles'
        AND year = (SELECT 
            MAX(year)
        FROM
            evsalesdata)
GROUP BY powertrain
ORDER BY total_sales DESC;



-- 6.Category-Wise Sales Performance: 
-- Determine the total EV sales for different categories (e.g., Cars, Trucks) for each 
-- region in the most recent year. Provide the region, category, and total sales.
SELECT 
    region,
    mode,
    SUM(value) AS total_sales
FROM 
    evsalesdata
WHERE 
    parameter = 'EV sales' AND unit = 'Vehicles' AND year = (SELECT MAX(year) FROM evsalesdata)
GROUP BY 
    region, mode
ORDER BY 
    region, mode;

