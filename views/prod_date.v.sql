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
0 sec

NOTES: 
This view is used as the information source for the DFNB presentation 1.

******************************************************************************************************************/

USE [DFNB2];
GO

/****** Object:  View [dbo].[prod_date]    Script Date: 6/27/2020 1:10:58 PM ******/

DROP VIEW dbo.prod_date;
GO

/****** Object:  View [dbo].[prod_date]    Script Date: 6/27/2020 1:10:58 PM ******/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE VIEW dbo.prod_date
AS
     SELECT prod_id
          , open_date
       FROM dbo.stg_p1 AS sp
      WHERE YEAR(sp.open_date) = 2016
            OR YEAR(sp.open_date) = 2017
            OR YEAR(sp.open_date) = 2018;
GO