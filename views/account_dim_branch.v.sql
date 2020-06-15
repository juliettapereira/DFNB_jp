/*****************************************************************************************************************
NAME:    account_dim_branch.v
PURPOSE: Create the account_dim_branch view

SUPPORT: Julietta Pereira
         juliettapereirao@gmail.com

MODIFICATION LOG:
Ver       Date         Author       Description
-------   ----------   ----------   -----------------------------------------------------------------------------
1.0       6/6/2020		JPereira 	1. Built the view


RUNTIME: 
30s
NOTES: 
This view is used as the information source for the DFNB presentation 1.

******************************************************************************************************************/

CREATE VIEW account_dim_branch
AS
     SELECT DISTINCT 
            d.acct_id
          , open_date
          , close_date
          , open_close_code
          , loan_amt
          , prod_id
          , d.branch_id
          , branch_code
          , branch_desc
          , region_id
          , area_id
          , branch_lat
          , branch_lon
       FROM account_dim AS d
            LEFT JOIN
            branch_dim AS bd ON d.branch_id = bd.branch_id;
