/*****************************************************************************************************************
NAME:    DataOutputDFNB_p2
PURPOSE: Generate the output process for DFNB2 transaction data

SUPPORT: Julietta Pereira
         juliettapereirao@gmail.com

MODIFICATION LOG:
Ver       Date         Author       Description
-------   ----------   ----------   -----------------------------------------------------------------------------
1.0       6/27/2020		JPereira 	1. Built select statements


RUNTIME: 
0 sec

NOTES: 
Data output manipulation for DFNB2 transaction data

******************************************************************************************************************/

/* 1) dbo.transaction_fact */

USE [DFNB2]
GO

SELECT [acct_id]
      ,[tran_date]
      ,[tran_time]
      ,[tran_type_id]
      ,[tran_amt]
      ,[tran_fee_amt]
      ,[branch_id]
      ,[tran_id]
  FROM [dbo].[transaction_fact]

GO

/* 2) dbo.transaction_type_dim */

USE [DFNB2]
GO

SELECT [tran_type_id]
      ,[tran_type_code]
      ,[tran_type_desc]
      ,[tran_fee_prct]
      ,[cur_cust_req_ind]
  FROM [dbo].[transaction_type_dim]

GO

