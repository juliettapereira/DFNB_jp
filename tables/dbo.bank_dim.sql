/*****************************************************************************************************************
NAME:    dbo.bank_dim
PURPOSE: Create the Bank Dimension table

SUPPORT: Julietta Pereira
         juliettapereirao@gmail.com

MODIFICATION LOG:
Ver       Date         Author       Description
-------   ----------   ----------   -----------------------------------------------------------------------------
1.0       6/6/2020		JPereira 	1. Created the bank_dim table


RUNTIME: 
1 sec

NOTES: 
The Bank Dimension table contains the bank attributes.
******************************************************************************************************************/

USE [DFNB2];
GO

/****** Object:  Table [dbo].[bank_dim]    Script Date: 6/27/2020 12:24:12 PM ******/

IF EXISTS
(
    SELECT *
      FROM sys.objects
     WHERE object_id = OBJECT_ID(N'[dbo].[bank_dim]')
           AND type IN(N'U')
)
    BEGIN
        DROP TABLE dbo.bank_dim;
END;
GO

/****** Object:  Table [dbo].[bank_dim]    Script Date: 6/27/2020 12:24:12 PM ******/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE dbo.bank_dim
(bank_id   VARCHAR(2) NOT NULL
, bank_name VARCHAR(50) NULL
, CONSTRAINT PK_tblbank_dim PRIMARY KEY CLUSTERED(bank_id ASC)
  WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY];
GO