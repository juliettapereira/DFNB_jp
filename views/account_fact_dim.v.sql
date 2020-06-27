/*****************************************************************************************************************
NAME:    account_fact_dim.v
PURPOSE: Create the account_fact_dim view

SUPPORT: Julietta Pereira
         juliettapereirao@gmail.com

MODIFICATION LOG:
Ver       Date         Author       Description
-------   ----------   ----------   -----------------------------------------------------------------------------
1.0       6/6/2020		JPereira 	1. Built the view


RUNTIME: 
0 sec

NOTES: 
This view is used as the information source for the DFNB presentation 1.

******************************************************************************************************************/

USE [DFNB2];
GO

/****** Object:  View [dbo].[account_fact_dim]    Script Date: 6/27/2020 1:08:45 PM ******/

DROP VIEW dbo.account_fact_dim;
GO

/****** Object:  View [dbo].[account_fact_dim]    Script Date: 6/27/2020 1:08:45 PM ******/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE VIEW dbo.account_fact_dim
AS
     SELECT DISTINCT 
            d.acct_id
          , as_of_date
          , cur_bal
          , open_date
          , close_date
          , open_close_code
          , loan_amt
          , branch_id
          , prod_id
       FROM account_dim AS d
            LEFT JOIN
            account_fact AS af ON d.acct_id = af.acct_id;
GO