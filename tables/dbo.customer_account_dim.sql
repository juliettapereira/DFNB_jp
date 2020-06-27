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
The Customer Account Dimension table relates the Customer Dimension and Account Dimension tables together by
showing the relationship between customers and accounts.
******************************************************************************************************************/

USE [DFNB2];
GO

ALTER TABLE dbo.customer_account_dim DROP CONSTRAINT FK_tblcustomer_account_dim_tblcustomer_dim;
GO

ALTER TABLE dbo.customer_account_dim DROP CONSTRAINT FK_tblcustomer_account_dim_tblaccount_dim;
GO

/****** Object:  Table [dbo].[customer_account_dim]    Script Date: 6/27/2020 12:30:57 PM ******/

IF EXISTS
(
    SELECT *
      FROM sys.objects
     WHERE object_id = OBJECT_ID(N'[dbo].[customer_account_dim]')
           AND type IN(N'U')
)
    BEGIN
        DROP TABLE dbo.customer_account_dim;
END;
GO

/****** Object:  Table [dbo].[customer_account_dim]    Script Date: 6/27/2020 12:30:57 PM ******/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE dbo.customer_account_dim
(cust_id           SMALLINT NOT NULL
, acct_id           INT NOT NULL
, acct_cust_role_id SMALLINT NOT NULL
, CONSTRAINT PK_tblcustomer_account_dim PRIMARY KEY CLUSTERED(cust_id ASC, acct_id ASC)
  WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY];
GO

ALTER TABLE dbo.customer_account_dim
WITH CHECK
ADD CONSTRAINT FK_tblcustomer_account_dim_tblaccount_dim FOREIGN KEY(acct_id) REFERENCES dbo.account_dim(acct_id);
GO

ALTER TABLE dbo.customer_account_dim CHECK CONSTRAINT FK_tblcustomer_account_dim_tblaccount_dim;
GO

ALTER TABLE dbo.customer_account_dim
WITH CHECK
ADD CONSTRAINT FK_tblcustomer_account_dim_tblcustomer_dim FOREIGN KEY(cust_id) REFERENCES dbo.customer_dim(cust_id);
GO

ALTER TABLE dbo.customer_account_dim CHECK CONSTRAINT FK_tblcustomer_account_dim_tblcustomer_dim;
GO