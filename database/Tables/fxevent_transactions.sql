/****** Object:  Table [dbo].[fxevent_transactions]    Script Date: 01/10/2010 23:47:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[fxevent_transactions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[eventid] [nvarchar](10) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[eventdate] [date] NOT NULL,
	[eventtime] [time](7) NOT NULL,
	[importance] [smallint] NOT NULL,
	[previous] [numeric](19, 5) NULL,
	[forecast] [numeric](19, 5) NULL,
	[actual] [numeric](19, 5) NULL,
	[currency] [nchar](3) NULL,
 CONSTRAINT [PK_event_transactions] PRIMARY KEY CLUSTERED 
(
	[eventid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

grant select,insert,update,delete on fxevent_transactions to TRADEJOURNAL_GRP