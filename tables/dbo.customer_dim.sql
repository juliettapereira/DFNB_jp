/*****************************************************************************************************************
NAME:    dbo.customer_dim
PURPOSE: Create the Customer Dimension table

SUPPORT: Julietta Pereira
         juliettapereirao@gmail.com

MODIFICATION LOG:
Ver       Date         Author       Description
-------   ----------   ----------   -----------------------------------------------------------------------------
1.0       6/6/2020		JPereira 	1. Created the customer_dim table


RUNTIME: 
1 sec

NOTES: 
The Customer Dimension contains the customers' attributes.
******************************************************************************************************************/

USE [DFNB2];
GO

/****** Object:  Table [dbo].[customer_dim]    Script Date: 6/27/2020 12:41:53 PM ******/

IF EXISTS
(
    SELECT *
      FROM sys.objects
     WHERE object_id = OBJECT_ID(N'[dbo].[customer_dim]')
           AND type IN(N'U')
)
    BEGIN
        DROP TABLE dbo.customer_dim
END;
GO

/****** Object:  Table [dbo].[customer_dim]    Script Date: 6/27/2020 12:41:53 PM ******/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE dbo.customer_dim
(cust_id         SMALLINT NOT NULL
, last_name       VARCHAR(100) NOT NULL
, first_name      VARCHAR(100) NOT NULL
, gender          VARCHAR(1) NOT NULL
, birth_date      [DATE] NOT NULL
, cust_since_date [DATE] NOT NULL
, CONSTRAINT PK_tblcustomer_dim PRIMARY KEY CLUSTERED(cust_id ASC)
  WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY];
GO