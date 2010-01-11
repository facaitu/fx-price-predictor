/****** Object:  Table [dbo].[currencies]    Script Date: 01/10/2010 23:43:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[currencies](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[currency] [nchar](3) NOT NULL,
	[name] [nchar](50) NULL,
	[lastmodified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_currencies] PRIMARY KEY CLUSTERED 
(
	[currency] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

grant select,insert,update,delete on currencies to TRADEJOURNAL_GRP