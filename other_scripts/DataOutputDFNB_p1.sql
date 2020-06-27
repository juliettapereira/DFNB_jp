/*****************************************************************************************************************
NAME:    DataOutputDFNB_p1
PURPOSE: Generate the output process for DFNB2 data

SUPPORT: Julietta Pereira
         juliettapereirao@gmail.com

MODIFICATION LOG:
Ver       Date         Author       Description
-------   ----------   ----------   -----------------------------------------------------------------------------
1.0       6/6/2020		JPereira 	1. Built select statements


RUNTIME: 
1 min

NOTES: 
Data output manipulation for DFNB2 data

******************************************************************************************************************/

/* 1) dbo.account_dim */

USE [DFNB2];
GO

SELECT acct_id
     , open_date
     , close_date
     , open_close_code
     , loan_amt
     , branch_id
     , prod_id
  FROM dbo.account_dim;

GO

/* 2) dbo.account_fact */

USE [DFNB2];
GO

SELECT acct_id
     , cust_id
     , as_of_date
     , cur_bal
  FROM dbo.account_fact;

GO

/* 3) dbo.bank_dim */

USE [DFNB2];
GO

SELECT bank_id
     , bank_name
  FROM dbo.bank_dim;

GO

/* 4) dbo.branch_dim */

USE [DFNB2];
GO

SELECT branch_id
     , branch_code
     , branch_desc
     , region_id
     , area_id
     , branch_lat
     , branch_lon
     , bank_id
  FROM dbo.branch_dim;

GO

/* 5) dbo.customer_account_dim */

USE [DFNB2];
GO

SELECT cust_id
     , acct_id
     , acct_cust_role_id
  FROM dbo.customer_account_dim;

GO

/* 6) dbo.customer_address_dim */

USE [DFNB2];
GO

SELECT cust_add_id
     , cust_id
     , branch_id
     , cust_branch_dist
     , cust_lat
     , cust_lon
     , cust_add_type
  FROM dbo.customer_address_dim;

GO

/* 7) dbo.customer_dim */

USE [DFNB2];
GO

SELECT cust_id
     , last_name
     , first_name
     , gender
     , birth_date
     , cust_since_date
  FROM dbo.customer_dim;

GO

/* 8) dbo.customer_relationship_dim */

USE [DFNB2];
GO

SELECT cust_rel_id
     , cust_id
  FROM dbo.customer_relationship_dim;

GO

/* 9) dbo.product_dim */

USE [DFNB2];
GO

SELECT prod_id
  FROM dbo.product_dim;

GO