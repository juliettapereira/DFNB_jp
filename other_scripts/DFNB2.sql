/*****************************************************************************************************************
NAME:    DFNB2
PURPOSE: Create the DFNB2 schema

SUPPORT: Julietta Pereira
         juliettapereirao@gmail.com

MODIFICATION LOG:
Ver       Date         Author       Description
-------   ----------   ----------   -----------------------------------------------------------------------------
1.0       6/27/2020		JPereira 	1. Built the DFNB2 schema


RUNTIME: 
2 min

NOTES: 
This is the entire structure of the DFNB2 database

SSMS > DFNB2 > Tasks > Generate Scripts > Script entire database and all objects

******************************************************************************************************************/

USE [master];
GO

/****** Object:  Database [DFNB2]    Script Date: 6/27/2020 1:16:06 PM ******/

CREATE DATABASE DFNB2 CONTAINMENT = NONE ON PRIMARY
(NAME = N'DFNB2'
, FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\DFNB2.mdf'
, SIZE = 1689600 KB
, MAXSIZE = UNLIMITED
, FILEGROWTH = 1024 KB
) LOG ON
(NAME = N'DFNB2_log'
, FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\DFNB2_log.ldf'
, SIZE = 1913920 KB
, MAXSIZE = 2048 GB
, FILEGROWTH = 10%
);
GO

ALTER DATABASE DFNB2 SET COMPATIBILITY_LEVEL = 110;
GO

IF 1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled')
    BEGIN
        EXEC DFNB2.dbo.sp_fulltext_database @action = 'enable';
END;
GO

ALTER DATABASE DFNB2 SET ANSI_NULL_DEFAULT OFF; 
GO

ALTER DATABASE DFNB2 SET ANSI_NULLS OFF; 
GO

ALTER DATABASE DFNB2 SET ANSI_PADDING OFF; 
GO

ALTER DATABASE DFNB2 SET ANSI_WARNINGS OFF; 
GO

ALTER DATABASE DFNB2 SET ARITHABORT OFF; 
GO

ALTER DATABASE DFNB2 SET AUTO_CLOSE OFF; 
GO

ALTER DATABASE DFNB2 SET AUTO_SHRINK OFF; 
GO

ALTER DATABASE DFNB2 SET AUTO_UPDATE_STATISTICS ON; 
GO

ALTER DATABASE DFNB2 SET CURSOR_CLOSE_ON_COMMIT OFF; 
GO

ALTER DATABASE DFNB2 SET CURSOR_DEFAULT GLOBAL; 
GO

ALTER DATABASE DFNB2 SET CONCAT_NULL_YIELDS_NULL OFF; 
GO

ALTER DATABASE DFNB2 SET NUMERIC_ROUNDABORT OFF; 
GO

ALTER DATABASE DFNB2 SET QUOTED_IDENTIFIER OFF; 
GO

ALTER DATABASE DFNB2 SET RECURSIVE_TRIGGERS OFF; 
GO

ALTER DATABASE DFNB2 SET DISABLE_BROKER; 
GO

ALTER DATABASE DFNB2 SET AUTO_UPDATE_STATISTICS_ASYNC OFF; 
GO

ALTER DATABASE DFNB2 SET DATE_CORRELATION_OPTIMIZATION OFF; 
GO

ALTER DATABASE DFNB2 SET TRUSTWORTHY OFF; 
GO

ALTER DATABASE DFNB2 SET ALLOW_SNAPSHOT_ISOLATION OFF; 
GO

ALTER DATABASE DFNB2 SET PARAMETERIZATION SIMPLE; 
GO

ALTER DATABASE DFNB2 SET READ_COMMITTED_SNAPSHOT OFF; 
GO

ALTER DATABASE DFNB2 SET HONOR_BROKER_PRIORITY OFF; 
GO

ALTER DATABASE DFNB2 SET RECOVERY SIMPLE; 
GO

ALTER DATABASE DFNB2 SET MULTI_USER; 
GO

ALTER DATABASE DFNB2 SET PAGE_VERIFY CHECKSUM;  
GO

ALTER DATABASE DFNB2 SET DB_CHAINING OFF; 
GO

ALTER DATABASE DFNB2 SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF); 
GO

ALTER DATABASE DFNB2 SET TARGET_RECOVERY_TIME = 0 SECONDS; 
GO

ALTER DATABASE DFNB2 SET DELAYED_DURABILITY = DISABLED; 
GO

EXEC sys.sp_db_vardecimal_storage_format N'DFNB2'
                                       , N'ON';
GO

ALTER DATABASE DFNB2 SET QUERY_STORE = OFF;
GO

USE [DFNB2];
GO

/****** Object:  Table [dbo].[account_dim]    Script Date: 6/27/2020 1:16:06 PM ******/

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

/****** Object:  Table [dbo].[account_fact]    Script Date: 6/27/2020 1:16:06 PM ******/

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

/****** Object:  View [dbo].[account_fact_dim]    Script Date: 6/27/2020 1:16:06 PM ******/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE VIEW dbo.account_fact_dim
AS
     SELECT DISTINCT 
            d.acct_id
          , as_of_date
          , cur_bal
          , open_date
          , close_date
          , open_close_code
          , loan_amt
          , branch_id
          , prod_id
       FROM account_dim AS d
            LEFT JOIN
            account_fact AS af ON d.acct_id = af.acct_id;
GO

/****** Object:  View [dbo].[cust_rel_add]    Script Date: 6/27/2020 1:16:06 PM ******/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE VIEW dbo.cust_rel_add
AS
     SELECT DISTINCT 
            dbo.stg_p1.cust_id
          , dbo.stg_p1.cust_rel_id
          , dbo.stg_p1.cust_add_lat
          , dbo.stg_p1.cust_add_lon
       FROM dbo.stg_p1;
GO

/****** Object:  View [dbo].[prod_date]    Script Date: 6/27/2020 1:16:06 PM ******/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE VIEW dbo.prod_date
AS
     SELECT prod_id
          , open_date
       FROM dbo.stg_p1 AS sp
      WHERE YEAR(sp.open_date) = 2016
            OR YEAR(sp.open_date) = 2017
            OR YEAR(sp.open_date) = 2018;
GO

/****** Object:  Table [dbo].[branch_dim]    Script Date: 6/27/2020 1:16:06 PM ******/

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

/****** Object:  View [dbo].[account_dim_branch]    Script Date: 6/27/2020 1:16:06 PM ******/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE VIEW dbo.account_dim_branch
AS
     SELECT DISTINCT 
            d.acct_id
          , open_date
          , close_date
          , open_close_code
          , loan_amt
          , prod_id
          , d.branch_id
          , branch_code
          , branch_desc
          , region_id
          , area_id
          , branch_lat
          , branch_lon
       FROM account_dim AS d
            LEFT JOIN
            branch_dim AS bd ON d.branch_id = bd.branch_id;
GO

/****** Object:  Table [dbo].[bank_dim]    Script Date: 6/27/2020 1:16:06 PM ******/

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

/****** Object:  Table [dbo].[customer_account_dim]    Script Date: 6/27/2020 1:16:06 PM ******/

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

/****** Object:  Table [dbo].[customer_address_dim]    Script Date: 6/27/2020 1:16:06 PM ******/

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

/****** Object:  Table [dbo].[customer_dim]    Script Date: 6/27/2020 1:16:06 PM ******/

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

/****** Object:  Table [dbo].[customer_relationship_dim]    Script Date: 6/27/2020 1:16:06 PM ******/

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

/****** Object:  Table [dbo].[product_dim]    Script Date: 6/27/2020 1:16:06 PM ******/

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

ALTER TABLE dbo.branch_dim
WITH CHECK
ADD CONSTRAINT FK_tblbranch_dim_tblbank_dim FOREIGN KEY(bank_id) REFERENCES dbo.bank_dim(bank_id);
GO

ALTER TABLE dbo.branch_dim CHECK CONSTRAINT FK_tblbranch_dim_tblbank_dim;
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

ALTER TABLE dbo.customer_relationship_dim
WITH CHECK
ADD CONSTRAINT FK_tblcustomer_relationship_dim_tblcustomer_dim FOREIGN KEY(cust_id) REFERENCES dbo.customer_dim(cust_id);
GO

ALTER TABLE dbo.customer_relationship_dim CHECK CONSTRAINT FK_tblcustomer_relationship_dim_tblcustomer_dim;
GO

USE [master];
GO

ALTER DATABASE DFNB2 SET READ_WRITE; 
GO