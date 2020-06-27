/*****************************************************************************************************************
NAME:    dbo.account_fact
PURPOSE: Create the Account Fact table

SUPPORT: Julietta Pereira
         juliettapereirao@gmail.com

MODIFICATION LOG:
Ver       Date         Author       Description
-------   ----------   ----------   -----------------------------------------------------------------------------
1.0       6/6/2020		JPereira 	1. Created the account_fact table


RUNTIME: 
1 sec

NOTES: 
The Account Fact table contains snapshots of the accounts' current balance.
******************************************************************************************************************/

USE [DFNB2];
GO

ALTER TABLE dbo.account_fact DROP CONSTRAINT FK_tblaccount_fact_tblcustomer_dim;
GO

ALTER TABLE dbo.account_fact DROP CONSTRAINT FK_tblaccount_fact_tblaccount_dim;
GO

/****** Object:  Table [dbo].[account_fact]    Script Date: 6/27/2020 12:19:21 PM ******/

IF EXISTS
(
    SELECT *
      FROM sys.objects
     WHERE object_id = OBJECT_ID(N'[dbo].[account_fact]')
           AND type IN(N'U')
)
    BEGIN
        DROP TABLE dbo.account_fact;
END;
GO

/****** Object:  Table [dbo].[account_fact]    Script Date: 6/27/2020 12:19:21 PM ******/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE dbo.account_fact
(acct_id    INT NOT NULL
, cust_id    SMALLINT NOT NULL
, as_of_date [DATE] NOT NULL
, cur_bal    DECIMAL(20, 4) NOT NULL
, CONSTRAINT PK_tblaccount_fact PRIMARY KEY CLUSTERED(acct_id ASC, cust_id ASC, as_of_date ASC)
  WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY];
GO

ALTER TABLE dbo.account_fact
WITH CHECK
ADD CONSTRAINT FK_tblaccount_fact_tblaccount_dim FOREIGN KEY(acct_id) REFERENCES dbo.account_dim(acct_id);
GO

ALTER TABLE dbo.account_fact CHECK CONSTRAINT FK_tblaccount_fact_tblaccount_dim;
GO

ALTER TABLE dbo.account_fact
WITH CHECK
ADD CONSTRAINT FK_tblaccount_fact_tblcustomer_dim FOREIGN KEY(cust_id) REFERENCES dbo.customer_dim(cust_id);
GO

ALTER TABLE dbo.account_fact CHECK CONSTRAINT FK_tblaccount_fact_tblcustomer_dim;
GO