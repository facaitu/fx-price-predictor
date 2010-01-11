/****** Object:  Table [dbo].[fxevent_associations]    Script Date: 01/10/2010 23:46:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[fxevent_associations](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[eventid] [nvarchar](10) NOT NULL,
	[ind_id] [nvarchar](10) NOT NULL,
	[ind_order] [int] NOT NULL,
	[ind_importance] [smallint] NOT NULL,
	[ind_positive_threshhold] [numeric](19, 5) NULL,
	[ind_positive_threshhold_weight] [smallint] NULL,
	[ind_negative_threshhold] [numeric](19, 5) NULL,
	[ind_negative_threshhold_weight] [smallint] NULL,
 CONSTRAINT [PK_event_association_setup] PRIMARY KEY CLUSTERED 
(
	[eventid] ASC,
	[ind_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


grant select,insert,update,delete on fxevent_associations to TRADEJOURNAL_GRP