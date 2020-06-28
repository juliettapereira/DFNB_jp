/*****************************************************************************************************************
NAME:    dbo.transaction_type_dim
PURPOSE: Create the Transaction Type Dimension table

SUPPORT: Julietta Pereira
         juliettapereirao@gmail.com

MODIFICATION LOG:
Ver       Date         Author       Description
-------   ----------   ----------   -----------------------------------------------------------------------------
1.0       6/27/2020		JPereira 	1. Created the transaction_type_dim table


RUNTIME: 
0 sec

NOTES: 
The Transaction Type Dimension table contains the transaction types' attributes.
******************************************************************************************************************/

USE [DFNB2]
GO

/****** Object:  Table [dbo].[transaction_type_dim]    Script Date: 6/27/2020 10:18:16 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[transaction_type_dim]') AND type in (N'U'))
DROP TABLE [dbo].[transaction_type_dim]
GO

/****** Object:  Table [dbo].[transaction_type_dim]    Script Date: 6/27/2020 10:18:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[transaction_type_dim](
	[tran_type_id] [smallint] NOT NULL,
	[tran_type_code] [varchar](5) NOT NULL,
	[tran_type_desc] [varchar](100) NOT NULL,
	[tran_fee_prct] [decimal](4, 3) NOT NULL,
	[cur_cust_req_ind] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbltransaction_type_dim] PRIMARY KEY CLUSTERED 
(
	[tran_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

