/*****************************************************************************************************************
NAME:    LoadDFNB_p2
PURPOSE: ETL process for the relational database model

SUPPORT: Julietta Pereira
         juliettapereirao@gmail.com

MODIFICATION LOG:
Ver       Date         Author       Description
-------   ----------   ----------   -----------------------------------------------------------------------------
1.0       6/27/2020		JPereira 	1. Built 2 tables


RUNTIME: 
4 sec

NOTES: 
This is the relational database model used to organize the information into related entities.

******************************************************************************************************************/

USE [DFNB2];
GO

/* 1) Drop Constraints */

IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK__tbltransaction_fact_tblbranch_dim'
           AND parent_object_id = OBJECT_ID('dbo.transaction_fact')
)

    BEGIN

        ALTER TABLE dbo.transaction_fact DROP CONSTRAINT FK__tbltransaction_fact_tblbranch_dim;

END;

IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK__tbltransaction_fact_tbltransaction_type_dim'
           AND parent_object_id = OBJECT_ID('dbo.transaction_fact')
)

    BEGIN

        ALTER TABLE dbo.transaction_fact DROP CONSTRAINT FK__tbltransaction_fact_tbltransaction_type_dim;

END;

IF EXISTS
(
    SELECT pk.*
      FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS pk
     WHERE pk.constraint_name = 'PK_tbltransaction_type_dim'
           AND table_name = 'transaction_type_dim'
)

    BEGIN

        ALTER TABLE dbo.transaction_type_dim DROP CONSTRAINT PK_tbltransaction_type_dim;

END;

IF EXISTS
(
    SELECT pk.*
      FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS pk
     WHERE pk.constraint_name = 'PK_tbltransaction_fact'
           AND table_name = 'transaction_fact'
)

    BEGIN

        ALTER TABLE dbo.transaction_fact DROP CONSTRAINT PK_tbltransaction_fact;

END;


/* 2) Create the Transaction Type Dimension table */

--SELECT DISTINCT 
--       sp2.tran_type_id
--     , sp2.tran_type_code
--     , sp2.tran_type_desc
--     , sp2.tran_fee_prct
--     , sp2.cur_cust_req_ind
--INTO dbo.transaction_type_dim
--  FROM dbo.stg_p2 AS sp2
-- ORDER BY sp2.tran_type_id;

/* dbo.transaction_type_dim; */

TRUNCATE TABLE dbo.transaction_type_dim;

INSERT INTO dbo.transaction_type_dim
SELECT DISTINCT 
       sp2.tran_type_id
     , sp2.tran_type_code
     , sp2.tran_type_desc
     , sp2.tran_fee_prct
     , sp2.cur_cust_req_ind
  FROM dbo.stg_p2 AS sp2
 ORDER BY sp2.tran_type_id;

/* 3) Create the Transaction Fact table */

--SELECT DISTINCT 
--       ISNULL(ROW_NUMBER() OVER(
--       ORDER BY tran_date DESC
--              , tran_time DESC), 0) AS tran_id
--     , sp2.acct_id
--     , sp2.tran_date
--     , sp2.tran_time
--     , sp2.tran_type_id
--     , sp2.tran_amt
--     , sp2.tran_fee_amt
--     , sp2.branch_id
--INTO dbo.transaction_fact
--  FROM dbo.stg_p2 AS sp2
-- ORDER BY 1;

/* dbo.transaction_fact; */

TRUNCATE TABLE dbo.transaction_fact;

INSERT INTO dbo.transaction_fact
SELECT ISNULL(ROW_NUMBER() OVER(
       ORDER BY tran_date DESC
              , tran_time DESC), 0) AS tran_id
     , sp2.acct_id
     , sp2.tran_date
     , sp2.tran_time
     , sp2.tran_type_id
     , sp2.tran_amt
     , sp2.tran_fee_amt
     , sp2.branch_id
  FROM dbo.stg_p2 AS sp2
 ORDER BY 1;

/* 4) Add constraints */

ALTER TABLE dbo.transaction_type_dim
ADD CONSTRAINT PK_tbltransaction_type_dim PRIMARY KEY(tran_type_id);

ALTER TABLE dbo.transaction_fact
ADD CONSTRAINT PK_tbltransaction_fact PRIMARY KEY(tran_id);

ALTER TABLE dbo.transaction_fact
ADD CONSTRAINT FK__tbltransaction_fact_tblbranch_dim FOREIGN KEY(branch_id) REFERENCES dbo.branch_dim;

ALTER TABLE dbo.transaction_fact
ADD CONSTRAINT FK__tbltransaction_fact_tbltransaction_type_dim FOREIGN KEY(tran_type_id) REFERENCES dbo.transaction_type_dim;