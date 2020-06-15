/*****************************************************************************************************************
NAME:    account_dim.t
PURPOSE: Create the account_dim table

SUPPORT: Julietta Pereira
         juliettapereirao@gmail.com

MODIFICATION LOG:
Ver       Date         Author       Description
-------   ----------   ----------   -----------------------------------------------------------------------------
1.0       6/6/2020		JPereira 	1. Built the table


RUNTIME: 
30s

NOTES: 
This table serves as a foundation for other views

******************************************************************************************************************/

CREATE TABLE [dbo].[account_dim](
	[acct_id] [int] NOT NULL,
	[open_date] [date] NOT NULL,
	[close_date] [date] NOT NULL,
	[open_close_code] [varchar](1) NOT NULL,
	[loan_amt] [decimal](20, 4) NOT NULL,
	[branch_id] [smallint] NOT NULL,
	[prod_id] [smallint] NOT NULL,
 CONSTRAINT [PK_account_dimm] PRIMARY KEY CLUSTERED 
(
	[acct_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[account_dim]  WITH CHECK ADD  CONSTRAINT [FK__account_d__branc__6FE99F9F] FOREIGN KEY([branch_id])
REFERENCES [dbo].[branch_dim] ([branch_id])
GO

ALTER TABLE [dbo].[account_dim] CHECK CONSTRAINT [FK__account_d__branc__6FE99F9F]
GO

ALTER TABLE [dbo].[account_dim]  WITH CHECK ADD FOREIGN KEY([prod_id])
REFERENCES [dbo].[product_dim] ([prod_id])
GO

CREATE TABLE [dbo].[account_fact](
	[acct_id] [int] NOT NULL,
	[as_of_date] [date] NOT NULL,
	[cur_bal] [decimal](20, 4) NOT NULL
) ON [PRIMARY]
GO