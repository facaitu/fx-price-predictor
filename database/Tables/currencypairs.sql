/****** Object:  Table [dbo].[currencypairs]    Script Date: 01/10/2010 23:44:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[currencypairs](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[base] [nchar](3) NOT NULL,
	[quote] [nchar](3) NOT NULL,
	[boughtsold_level] [numeric](1, 1) NOT NULL,
	[inactive] [tinyint] NOT NULL,
	[lastmodified] [datetime] NOT NULL,
 CONSTRAINT [PK_currencypair_setup] PRIMARY KEY CLUSTERED 
(
	[base] ASC,
	[quote] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[currencypairs] ADD  CONSTRAINT [DF_currency_pair_setup_boughtsold_level]  DEFAULT ((0)) FOR [boughtsold_level]
GO

ALTER TABLE [dbo].[currencypairs] ADD  CONSTRAINT [DF_currency_pair_setup_inactive]  DEFAULT ((0)) FOR [inactive]
GO

grant select,insert,update,delete on currencypairs to TRADEJOURNAL_GRP