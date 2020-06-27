/*****************************************************************************************************************
NAME:    dbo.branch_dim
PURPOSE: Create the Branch Dimension table

SUPPORT: Julietta Pereira
         juliettapereirao@gmail.com

MODIFICATION LOG:
Ver       Date         Author       Description
-------   ----------   ----------   -----------------------------------------------------------------------------
1.0       6/6/2020		JPereira 	1. Created the branch_dim table


RUNTIME: 
1 sec

NOTES: 
The Branch Dimension table contains the branches' attributes.
******************************************************************************************************************/

USE [DFNB2];
GO

ALTER TABLE dbo.branch_dim DROP CONSTRAINT FK_tblbranch_dim_tblbank_dim;
GO

/****** Object:  Table [dbo].[branch_dim]    Script Date: 6/27/2020 12:25:45 PM ******/

IF EXISTS
(
    SELECT *
      FROM sys.objects
     WHERE object_id = OBJECT_ID(N'[dbo].[branch_dim]')
           AND type IN(N'U')
)
    BEGIN
        DROP TABLE dbo.branch_dim;
END;
GO

/****** Object:  Table [dbo].[branch_dim]    Script Date: 6/27/2020 12:25:45 PM ******/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE dbo.branch_dim
(branch_id   SMALLINT NOT NULL
, branch_code VARCHAR(5) NOT NULL
, branch_desc VARCHAR(100) NOT NULL
, region_id   INT NOT NULL
, area_id     INT NOT NULL
, branch_lat  DECIMAL(16, 12) NOT NULL
, branch_lon  DECIMAL(16, 12) NOT NULL
, bank_id     VARCHAR(2) NULL
, CONSTRAINT PK_tblbranch_dim PRIMARY KEY CLUSTERED(branch_id ASC)
  WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY];
GO

ALTER TABLE dbo.branch_dim
WITH CHECK
ADD CONSTRAINT FK_tblbranch_dim_tblbank_dim FOREIGN KEY(bank_id) REFERENCES dbo.bank_dim(bank_id);
GO

ALTER TABLE dbo.branch_dim CHECK CONSTRAINT FK_tblbranch_dim_tblbank_dim;
GO