/*****************************************************************************************************************
NAME:    branch_dim.t
PURPOSE: Create the branch_dim table

SUPPORT: Julietta Pereira
         juliettapereirao@gmail.com

MODIFICATION LOG:
Ver       Date         Author       Description
-------   ----------   ----------   -----------------------------------------------------------------------------
1.0       6/6/2020		JPereira 	1. Built table


RUNTIME: 
30s

NOTES: 
This table serves as fondation for other views.

******************************************************************************************************************/

CREATE TABLE [dbo].[branch_dim](
	[branch_id] [smallint] NOT NULL,
	[branch_code] [varchar](5) NOT NULL,
	[branch_desc] [varchar](100) NOT NULL,
	[region_id] [varchar](2) NOT NULL,
	[area_id] [varchar](2) NULL,
	[branch_lat] [decimal](16, 12) NULL,
	[branch_lon] [decimal](16, 12) NULL,
 CONSTRAINT [PK_branch_dim] PRIMARY KEY CLUSTERED 
(
	[branch_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
