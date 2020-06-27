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
0 sec

NOTES: 
This view is used as the information source for the DFNB presentation 1.

******************************************************************************************************************/

USE [DFNB2];
GO

/****** Object:  View [dbo].[cust_rel_add]    Script Date: 6/27/2020 1:10:26 PM ******/

DROP VIEW dbo.cust_rel_add;
GO

/****** Object:  View [dbo].[cust_rel_add]    Script Date: 6/27/2020 1:10:26 PM ******/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE VIEW dbo.cust_rel_add
AS
     SELECT DISTINCT 
            dbo.stg_p1.cust_id
          , dbo.stg_p1.cust_rel_id
          , dbo.stg_p1.cust_add_lat
          , dbo.stg_p1.cust_add_lon
       FROM dbo.stg_p1;
GO