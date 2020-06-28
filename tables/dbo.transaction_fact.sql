/*****************************************************************************************************************
NAME:    dbo.transaction_fact
PURPOSE: Create the Transaction Fact table

SUPPORT: Julietta Pereira
         juliettapereirao@gmail.com

MODIFICATION LOG:
Ver       Date         Author       Description
-------   ----------   ----------   -----------------------------------------------------------------------------
1.0       6/27/2020		JPereira 	1. Created the transaction_fact table


RUNTIME: 
0 sec

NOTES: 
The Transaction Fact table contains the customers' transactions.
******************************************************************************************************************/

USE [DFNB2];
GO

ALTER TABLE dbo.transaction_fact DROP CONSTRAINT FK__tbltransaction_fact_tbltransaction_type_dim;
GO

ALTER TABLE dbo.transaction_fact DROP CONSTRAINT FK__tbltransaction_fact_tblbranch_dim;
GO

/****** Object:  Table [dbo].[transaction_fact]    Script Date: 6/27/2020 10:13:45 PM ******/

IF EXISTS
(
    SELECT *
      FROM sys.objects
     WHERE object_id = OBJECT_ID(N'[dbo].[transaction_fact]')
           AND type IN(N'U')
)
    BEGIN
        DROP TABLE dbo.transaction_fact
END;
GO

/****** Object:  Table [dbo].[transaction_fact]    Script Date: 6/27/2020 10:13:45 PM ******/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE dbo.transaction_fact
(acct_id      INT NOT NULL
, tran_date    [DATE] NOT NULL
, tran_time    [TIME](7) NOT NULL
, tran_type_id SMALLINT NOT NULL
, tran_amt     INT NOT NULL
, tran_fee_amt DECIMAL(15, 3) NOT NULL
, branch_id    SMALLINT NOT NULL
, tran_id      INT IDENTITY(1, 1) NOT NULL
, CONSTRAINT PK_tbltransaction_fact PRIMARY KEY CLUSTERED(tran_id ASC)
  WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY];
GO

ALTER TABLE dbo.transaction_fact
WITH CHECK
ADD CONSTRAINT FK__tbltransaction_fact_tblbranch_dim FOREIGN KEY(branch_id) REFERENCES dbo.branch_dim(branch_id);
GO

ALTER TABLE dbo.transaction_fact CHECK CONSTRAINT FK__tbltransaction_fact_tblbranch_dim;
GO

ALTER TABLE dbo.transaction_fact
WITH CHECK
ADD CONSTRAINT FK__tbltransaction_fact_tbltransaction_type_dim FOREIGN KEY(tran_type_id) REFERENCES dbo.transaction_type_dim(tran_type_id);
GO

ALTER TABLE dbo.transaction_fact CHECK CONSTRAINT FK__tbltransaction_fact_tbltransaction_type_dim;
GO