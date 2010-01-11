/****** Object:  Table [dbo].[fxevent_currencypairs]    Script Date: 01/10/2010 23:46:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[fxevent_currencypairs](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[eventid] [nvarchar](10) NOT NULL,
	[cp_id] [int] NOT NULL,
	[base] [nchar](3) NULL,
	[quote] [nchar](3) NULL,
 CONSTRAINT [PK_fxevent_currencypairs] PRIMARY KEY CLUSTERED 
(
	[eventid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

grant select,insert,update,delete on fxevent_currencypairs to TRADEJOURNAL_GRP