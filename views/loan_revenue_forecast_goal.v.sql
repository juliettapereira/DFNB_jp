/*****************************************************************************************************************
NAME:    loan_revenue_forecast_goal.v
PURPOSE: Create the loan_revenue_forecast_goal view

SUPPORT: Julietta Pereira
         juliettapereirao@gmail.com

MODIFICATION LOG:
Ver       Date         Author       Description
-------   ----------   ----------   -----------------------------------------------------------------------------
1.0       7/18/2020		JPereira 	1. Built the view


RUNTIME: 
0 sec

NOTES: 
This view shows the loan revenue estimate for the end of next/current year along with the actual revenue goal and current revenue.

******************************************************************************************************************/

USE [DFNB2];
GO

/****** Object:  View [dbo].[loan_revenue_forecast_goal]    Script Date: 7/18/2020 5:18:05 PM ******/

DROP VIEW dbo.loan_revenue_forecast_goal;
GO

/****** Object:  View [dbo].[loan_revenue_forecast_goal]    Script Date: 7/18/2020 5:18:05 PM ******/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE VIEW dbo.loan_revenue_forecast_goal
AS
     SELECT l.year
          , l.total_loan_amt AS total_loan_amt_estimate
          , l.total_loan_amt + l.total_loan_amt * 0.02 AS total_loan_amt_goal
          , SUM(a.loan_amt) AS current_loan_amt_revenue
          , l.total_loan_amt + l.total_loan_amt * 0.02 - SUM(a.[loan_amt]) AS difference
       FROM loan_revenue_forecast AS l
            FULL JOIN
            account_dim AS a ON l.year = YEAR(a.open_date)
      WHERE YEAR(a.open_date) = '2019'
      GROUP BY l.total_loan_amt
             , l.total_loan_amt + l.total_loan_amt * 0.02
             , l.year;
GO