/*****************************************************************************************************************
NAME:    LoadDFNB_p3
PURPOSE: ETL process for the relational database model

SUPPORT: Julietta Pereira
         juliettapereirao@gmail.com

MODIFICATION LOG:
Ver       Date         Author       Description
-------   ----------   ----------   -----------------------------------------------------------------------------
1.0       7/18/2020		JPereira 	1. Built 1 table


RUNTIME: 
1 sec

NOTES: 
This table contains historical data as well as a forecast for next year.

******************************************************************************************************************/

USE [DFNB2];
GO

/* 1) Calculate x, slope, and intercept for linear regression equation y = mx + b into temporary table #slope_intercept */

WITH f
     AS (SELECT CASE
                    WHEN YEAR(open_date) = '2010'
                    THEN 1
                    WHEN YEAR(open_date) = '2011'
                    THEN 2
                    WHEN YEAR(open_date) = '2012'
                    THEN 3
                    WHEN YEAR(open_date) = '2013'
                    THEN 4
                    WHEN YEAR(open_date) = '2014'
                    THEN 5
                    WHEN YEAR(open_date) = '2015'
                    THEN 6
                    WHEN YEAR(open_date) = '2016'
                    THEN 7
                    WHEN YEAR(open_date) = '2017'
                    THEN 8
                    WHEN YEAR(open_date) = '2018'
                    THEN 9
                END AS x
              , AVG(CASE
                        WHEN YEAR(open_date) = '2010'
                        THEN 1
                        WHEN YEAR(open_date) = '2011'
                        THEN 2
                        WHEN YEAR(open_date) = '2012'
                        THEN 3
                        WHEN YEAR(open_date) = '2013'
                        THEN 4
                        WHEN YEAR(open_date) = '2014'
                        THEN 5
                        WHEN YEAR(open_date) = '2015'
                        THEN 6
                        WHEN YEAR(open_date) = '2016'
                        THEN 7
                        WHEN YEAR(open_date) = '2017'
                        THEN 8
                        WHEN YEAR(open_date) = '2018'
                        THEN 9
                    END) OVER() AS x_ave
              , SUM(loan_amt) AS y
              , AVG(SUM(dbo.account_dim.loan_amt)) OVER() AS y_ave
           FROM dbo.account_dim
          WHERE YEAR(dbo.account_dim.open_date) <> 2019
          GROUP BY YEAR(open_date))
     SELECT SUM((x - x_ave) * (y - y_ave)) / SUM((x - x_ave) * (x - x_ave)) AS slope
          , MAX(f.y_ave) - MAX(f.x_ave) * SUM((x - x_ave) * (y - y_ave)) / SUM((x - x_ave) * (x - x_ave)) AS intercept
     INTO #slope_intercept
       FROM f AS f;

/* 2) Create the Loan Revenue Forecast table and load using #slope_intercept */

--CREATE TABLE loan_revenue_forecast
--(year                  INT NOT NULL PRIMARY KEY
--, total_loan_amt        DECIMAL(15, 4) NOT NULL
--, calculation_indicator VARCHAR(8) NOT NULL
--);

/* dbo.loan_revenue_forecast; */

TRUNCATE TABLE dbo.loan_revenue_forecast;

INSERT INTO dbo.loan_revenue_forecast
SELECT YEAR(open_date) AS year
     , SUM(loan_amt) AS total_loan_amt
     , 'actual' AS calculation_indicator
  FROM dbo.account_dim
 WHERE YEAR(open_date) <> 2019
 GROUP BY YEAR(open_date)
UNION
SELECT DATEPART(year, '1/1/2019') AS year
     , 10 * slope + intercept AS total_loan_amt
     , 'estimate' AS calculation_indicator
  FROM #slope_intercept
 ORDER BY year DESC;