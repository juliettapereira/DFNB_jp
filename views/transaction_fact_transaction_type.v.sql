/*****************************************************************************************************************
NAME:    transaction_fact_transaction_type.v
PURPOSE: Create the transaction_fact_transaction_type view

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

USE [DFNB2]
GO

/****** Object:  View [dbo].[transaction_fact_transaction_type]    Script Date: 6/27/2020 10:52:13 PM ******/
DROP VIEW [dbo].[transaction_fact_transaction_type]
GO

/****** Object:  View [dbo].[transaction_fact_transaction_type]    Script Date: 6/27/2020 10:52:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[transaction_fact_transaction_type]
AS
     SELECT tf.acct_id
          , tf.tran_date
          , tf.tran_time
          , tf.tran_amt
          , tf.tran_fee_amt
          , tf.tran_amt + tf.tran_fee_amt AS total_amt
          , tf.branch_id
          , tf.tran_id
          , ttd.tran_type_id
          , ttd.tran_type_code
          , ttd.tran_type_desc
          , ttd.tran_fee_prct
          , ttd.cur_cust_req_ind
       FROM transaction_fact AS tf
            LEFT OUTER JOIN
            transaction_type_dim AS ttd ON tf.tran_type_id = ttd.tran_type_id;
GO

