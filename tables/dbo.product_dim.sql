/*****************************************************************************************************************
NAME:    dbo.product_dim
PURPOSE: Create the Product Dimension table

SUPPORT: Julietta Pereira
         juliettapereirao@gmail.com

MODIFICATION LOG:
Ver       Date         Author       Description
-------   ----------   ----------   -----------------------------------------------------------------------------
1.0       6/6/2020		JPereira 	1. Created the product_dim table


RUNTIME: 
1 sec

NOTES: 
The Product Dimension contains the products' attributes.
******************************************************************************************************************/

USE [DFNB2];
GO

/****** Object:  Table [dbo].[product_dim]    Script Date: 6/27/2020 12:47:16 PM ******/

IF EXISTS
(
    SELECT *
      FROM sys.objects
     WHERE object_id = OBJECT_ID(N'[dbo].[product_dim]')
           AND type IN(N'U')
)
    BEGIN
        DROP TABLE dbo.product_dim
END;
GO

/****** Object:  Table [dbo].[product_dim]    Script Date: 6/27/2020 12:47:16 PM ******/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE dbo.product_dim
(prod_id SMALLINT NOT NULL
, CONSTRAINT PK_tblproduct_dim PRIMARY KEY CLUSTERED(prod_id ASC)
  WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY];
GO