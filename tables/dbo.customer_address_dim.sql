/*****************************************************************************************************************
NAME:    dbo.customer_account_dim
PURPOSE: Create the Customer Account Dimension table

SUPPORT: Julietta Pereira
         juliettapereirao@gmail.com

MODIFICATION LOG:
Ver       Date         Author       Description
-------   ----------   ----------   -----------------------------------------------------------------------------
1.0       6/6/2020		JPereira 	1. Created the customer_account_dim table


RUNTIME: 
1 sec

NOTES: 
The Customer Address Dimension table contains the customers' addresses and their attributes.
******************************************************************************************************************/

USE [DFNB2];
GO

ALTER TABLE dbo.customer_address_dim DROP CONSTRAINT FK_tblcustomer_address_dim_tblcustomer_dim;
GO

ALTER TABLE dbo.customer_address_dim DROP CONSTRAINT FK_tblcustomer_address_dim_tblbranch_dim;
GO

/****** Object:  Table [dbo].[customer_address_dim]    Script Date: 6/27/2020 12:34:01 PM ******/

IF EXISTS
(
    SELECT *
      FROM sys.objects
     WHERE object_id = OBJECT_ID(N'[dbo].[customer_address_dim]')
           AND type IN(N'U')
)
    BEGIN
        DROP TABLE dbo.customer_address_dim;
END;
GO

/****** Object:  Table [dbo].[customer_address_dim]    Script Date: 6/27/2020 12:34:01 PM ******/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE dbo.customer_address_dim
(cust_add_id      INT NOT NULL
, cust_id          SMALLINT NOT NULL
, branch_id        SMALLINT NOT NULL
, cust_branch_dist DECIMAL(7, 2) NOT NULL
, cust_lat         DECIMAL(16, 12) NOT NULL
, cust_lon         DECIMAL(16, 12) NOT NULL
, cust_add_type    VARCHAR(1) NOT NULL
, CONSTRAINT PK_tblcustomer_address_dim PRIMARY KEY CLUSTERED(cust_add_id ASC)
  WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY];
GO

ALTER TABLE dbo.customer_address_dim
WITH CHECK
ADD CONSTRAINT FK_tblcustomer_address_dim_tblbranch_dim FOREIGN KEY(branch_id) REFERENCES dbo.branch_dim(branch_id);
GO

ALTER TABLE dbo.customer_address_dim CHECK CONSTRAINT FK_tblcustomer_address_dim_tblbranch_dim;
GO

ALTER TABLE dbo.customer_address_dim
WITH CHECK
ADD CONSTRAINT FK_tblcustomer_address_dim_tblcustomer_dim FOREIGN KEY(cust_id) REFERENCES dbo.customer_dim(cust_id);
GO

ALTER TABLE dbo.customer_address_dim CHECK CONSTRAINT FK_tblcustomer_address_dim_tblcustomer_dim;
GO