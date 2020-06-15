/*****************************************************************************************************************
NAME:    prod_date.v
PURPOSE: Create the prod_date view

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

CREATE VIEW prod_date
AS
     SELECT prod_id
          , open_date
       FROM dbo.stg_p1 AS sp
      WHERE YEAR(sp.open_date) = 2016
            OR YEAR(sp.open_date) = 2017
            OR YEAR(sp.open_date) = 2018;