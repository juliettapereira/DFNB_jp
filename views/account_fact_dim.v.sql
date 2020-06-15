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
1 min

NOTES: 
This view is used as the information source for the DFNB presentation 1.

******************************************************************************************************************/

CREATE VIEW account_fact_dim
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
