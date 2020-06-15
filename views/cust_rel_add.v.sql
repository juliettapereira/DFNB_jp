/*****************************************************************************************************************
NAME:    cust_rel_add.v
PURPOSE: Create the cust_rel_add view

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

CREATE VIEW cust_rel_add
AS
     SELECT DISTINCT 
            dbo.stg_p1.cust_id
          , dbo.stg_p1.cust_rel_id
          , dbo.stg_p1.cust_add_lat
          , dbo.stg_p1.cust_add_lon
       FROM dbo.stg_p1;
