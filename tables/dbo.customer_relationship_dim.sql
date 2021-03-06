/*****************************************************************************************************************
NAME:    dbo.customer_relationship_dim
PURPOSE: Create the Customer Relationship Dimension table

SUPPORT: Julietta Pereira
         juliettapereirao@gmail.com

MODIFICATION LOG:
Ver       Date         Author       Description
-------   ----------   ----------   -----------------------------------------------------------------------------
1.0       6/6/2020		JPereira 	1. Created the customer_relationship_dim table


RUNTIME: 
1 sec

NOTES: 
The Customer Relationship Dimension contains the relationships between customers.
******************************************************************************************************************/

USE [DFNB2];
GO

ALTER TABLE dbo.customer_relationship_dim DROP CONSTRAINT FK_tblcustomer_relationship_dim_tblcustomer_dim;
GO

/****** Object:  Table [dbo].[customer_relationship_dim]    Script Date: 6/27/2020 12:44:41 PM ******/

IF EXISTS
(
    SELECT *
      FROM sys.objects
     WHERE object_id = OBJECT_ID(N'[dbo].[customer_relationship_dim]')
           AND type IN(N'U')
)
    BEGIN
        DROP TABLE dbo.customer_relationship_dim
END;
GO

/****** Object:  Table [dbo].[customer_relationship_dim]    Script Date: 6/27/2020 12:44:41 PM ******/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE dbo.customer_relationship_dim
(cust_rel_id SMALLINT NOT NULL
, cust_id     SMALLINT NOT NULL
, CONSTRAINT PK_tblcustomer_relationship_dim PRIMARY KEY CLUSTERED(cust_rel_id ASC, cust_id ASC)
  WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY];
GO

ALTER TABLE dbo.customer_relationship_dim
WITH CHECK
ADD CONSTRAINT FK_tblcustomer_relationship_dim_tblcustomer_dim FOREIGN KEY(cust_id) REFERENCES dbo.customer_dim(cust_id);
GO

ALTER TABLE dbo.customer_relationship_dim CHECK CONSTRAINT FK_tblcustomer_relationship_dim_tblcustomer_dim;
GO