/****** Object:  Table [dbo].[fxerrors]    Script Date: 01/10/2010 23:44:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[fxerrors](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[err_no] [int] NOT NULL,
	[err_desc] [nvarchar](255) NULL,
 CONSTRAINT [PK_fxerrors] PRIMARY KEY CLUSTERED 
(
	[err_no] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

grant select,insert,update,delete on fxerrors to TRADEJOURNAL_GRP