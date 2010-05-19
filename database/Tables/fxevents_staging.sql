IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_event_staging_setup_watch]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[fxevents_staging] DROP CONSTRAINT [DF_event_staging_setup_watch]
END

GO

/****** Object:  Table [dbo].[fxevents_staging]    Script Date: 05/16/2010 09:06:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fxevents_staging]') AND type in (N'U'))
DROP TABLE [dbo].[fxevents_staging]
GO

/****** Object:  Table [dbo].[fxevents]    Script Date: 01/10/2010 23:48:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[fxevents_staging](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[eventid] [nvarchar](10) NULL,
	[name] [nvarchar](50) NOT NULL,
	[recurring] [tinyint] NOT NULL,
	[next_date] [date] NOT NULL,
	[next_time] [time](7) NOT NULL,
	[importance] [smallint] NOT NULL,
	[previous] [numeric](19, 5) NULL,
	[watch] [tinyint] NOT NULL,
	[currency] [nchar](3) NULL,
 CONSTRAINT [PK_fxevents_staging] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[fxevents_staging] ADD  CONSTRAINT [DF_event_staging_setup_watch]  DEFAULT ((0)) FOR [watch]
GO

grant select,insert,update,delete on fxevents_staging to TRADEJOURNAL_GRP