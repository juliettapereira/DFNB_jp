/*****************************************************************************************************************
NAME:    dbo.account_dim
PURPOSE: Create the Account Dimension table

SUPPORT: Julietta Pereira
         juliettapereirao@gmail.com

MODIFICATION LOG:
Ver       Date         Author       Description
-------   ----------   ----------   -----------------------------------------------------------------------------
1.0       6/6/2020		JPereira 	1. Created the account_dim table


RUNTIME: 
1 sec

NOTES: 
The Account Dimension table contains the accounts' attributes.
******************************************************************************************************************/

USE [DFNB2];
GO

ALTER TABLE dbo.account_dim DROP CONSTRAINT FK__tblaccount_dim_tblproduct_dim;
GO

ALTER TABLE dbo.account_dim DROP CONSTRAINT FK__tblaccount_dim_tblbranch_dim;
GO

/****** Object:  Table [dbo].[account_dim]    Script Date: 6/27/2020 12:22:58 PM ******/

IF EXISTS
(
    SELECT *
      FROM sys.objects
     WHERE object_id = OBJECT_ID(N'[dbo].[account_dim]')
           AND type IN(N'U')
)
    BEGIN
        DROP TABLE dbo.account_dim
END;
GO

/****** Object:  Table [dbo].[account_dim]    Script Date: 6/27/2020 12:22:58 PM ******/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE dbo.account_dim
(acct_id         INT NOT NULL
, open_date       [DATE] NOT NULL
, close_date      [DATE] NOT NULL
, open_close_code VARCHAR(1) NOT NULL
, loan_amt        DECIMAL(20, 4) NOT NULL
, branch_id       SMALLINT NOT NULL
, prod_id         SMALLINT NOT NULL
, CONSTRAINT PK_tblaccount_dim PRIMARY KEY CLUSTERED(acct_id ASC)
  WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY];
GO

ALTER TABLE dbo.account_dim
WITH CHECK
ADD CONSTRAINT FK__tblaccount_dim_tblbranch_dim FOREIGN KEY(branch_id) REFERENCES dbo.branch_dim(branch_id);
GO

ALTER TABLE dbo.account_dim CHECK CONSTRAINT FK__tblaccount_dim_tblbranch_dim;
GO

ALTER TABLE dbo.account_dim
WITH CHECK
ADD CONSTRAINT FK__tblaccount_dim_tblproduct_dim FOREIGN KEY(prod_id) REFERENCES dbo.product_dim(prod_id);
GO

ALTER TABLE dbo.account_dim CHECK CONSTRAINT FK__tblaccount_dim_tblproduct_dim;
GO