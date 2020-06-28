/*****************************************************************************************************************
NAME:    transaction_fact_branch.v
PURPOSE: Create the transaction_fact_branch view

SUPPORT: Julietta Pereira
         juliettapereirao@gmail.com

MODIFICATION LOG:
Ver       Date         Author       Description
-------   ----------   ----------   -----------------------------------------------------------------------------
1.0       6/27/2020		JPereira 	1. Built the view


RUNTIME: 
0 sec

NOTES: 
This view is used as the information source for the DFNB presentation 2.

******************************************************************************************************************/

USE [DFNB2];
GO

/****** Object:  View [dbo].[transaction_fact_branch]    Script Date: 6/27/2020 10:42:10 PM ******/

DROP VIEW dbo.transaction_fact_branch;
GO

/****** Object:  View [dbo].[transaction_fact_branch]    Script Date: 6/27/2020 10:42:10 PM ******/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE VIEW dbo.transaction_fact_branch
AS
     SELECT t.acct_id
          , t.tran_date
          , t.tran_time
          , t.tran_type_id
          , t.tran_amt
          , t.tran_fee_amt
          , t.tran_id
          , bd.branch_code
          , bd.branch_desc
          , bd.region_id
          , bd.area_id
          , bd.branch_lat
          , bd.branch_lon
          , bd.bank_id
          , bd.branch_id
       FROM transaction_fact AS t
            LEFT OUTER JOIN
            branch_dim AS bd ON t.branch_id = bd.branch_id;
GO