/*****************************************************************************************************************
NAME:    dbo.loan_revenue_forecast
PURPOSE: Create the Loan Revenue Forecast table

SUPPORT: Julietta Pereira
         juliettapereirao@gmail.com

MODIFICATION LOG:
Ver       Date         Author       Description
-------   ----------   ----------   -----------------------------------------------------------------------------
1.0       7/18/2020		JPereira 	1. Created the loan_revenue_forecast table


RUNTIME: 
1 sec

NOTES: 
The Loan Revenue Forecast table contains total loan revenue forecast for next year.
******************************************************************************************************************/

USE [DFNB2]
GO

/****** Object:  Table [dbo].[loan_revenue_forecast]    Script Date: 7/18/2020 5:00:08 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[loan_revenue_forecast]') AND type in (N'U'))
DROP TABLE [dbo].[loan_revenue_forecast]
GO

/****** Object:  Table [dbo].[loan_revenue_forecast]    Script Date: 7/18/2020 5:00:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[loan_revenue_forecast](
	[year] [int] NOT NULL,
	[total_loan_amt] [decimal](15, 4) NOT NULL,
	[calculation_indicator] [varchar](8) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[year] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

