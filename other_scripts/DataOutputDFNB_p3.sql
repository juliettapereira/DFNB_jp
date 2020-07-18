/*****************************************************************************************************************
NAME:    DataOutputDFNB_p3
PURPOSE: Generate the output process for DFNB2 loan revenue forecast data

SUPPORT: Julietta Pereira
         juliettapereirao@gmail.com

MODIFICATION LOG:
Ver       Date         Author       Description
-------   ----------   ----------   -----------------------------------------------------------------------------
1.0       7/18/2020		JPereira 	1. Built select statements


RUNTIME: 
0 sec

NOTES: 
Data output manipulation for DFNB2 loan forecast data

******************************************************************************************************************/

/* 1) dbo.loan_revenue_forecast */

USE [DFNB2]
GO

SELECT [year]
      ,[total_loan_amt]
      ,[calculation_indicator]
  FROM [dbo].[loan_revenue_forecast]

GO
