/****** Object:  Table [dbo].[fxevents]    Script Date: 01/10/2010 23:48:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[fxevents](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[eventid] [nvarchar](10) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[recurring] [tinyint] NOT NULL,
	[next_date] [date] NOT NULL,
	[next_time] [time](7) NOT NULL,
	[importance] [smallint] NOT NULL,
	[previous] [numeric](19, 5) NULL,
	[watch] [tinyint] NOT NULL,
	[currency] [nchar](3) NULL,
 CONSTRAINT [PK_fxevent_setup] PRIMARY KEY CLUSTERED 
(
	[eventid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[fxevents] ADD  CONSTRAINT [DF_event_setup_watch]  DEFAULT ((0)) FOR [watch]
GO

grant select,insert,update,delete on fxevents to TRADEJOURNAL_GRP