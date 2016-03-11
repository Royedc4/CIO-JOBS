-- Coservica Refrisol Ing. Calderon
-- Articles update process tables
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

/****** Object:  Table [dbo].[aAa_updt_log]    Script Date: 11-03-2016 12:04:39 p.m. ******/
CREATE TABLE [dbo].[aAa_updt_log](
	[co_art] [char](30) NOT NULL,
	[art_des] [varchar](120) NOT NULL,
	[rs_stock_act] [decimal](18, 5) NOT NULL,
	[cs_stock_act] [decimal](18, 5) NOT NULL,
	[rs_cos_merc] [decimal](18, 5) NOT NULL,
	[cs_cos_merc] [decimal](18, 5) NOT NULL,
	[rs_ult_cos_un] [decimal](18, 5) NOT NULL,
	[cs_ult_cos_un] [decimal](18, 5) NOT NULL,
	[rs_prec_vta3] [decimal](18, 5) NOT NULL,
	[cs_prec_vta3] [decimal](18, 5) NOT NULL,
	[fecha_reg] [smalldatetime] NOT NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[aAa_updt_reports]    Script Date: 11-03-2016 12:05:03 p.m. ******/
CREATE TABLE [dbo].[aAa_updt_reports](
	[co_art] [char](30) NOT NULL,
	[art_des] [varchar](120) NOT NULL,
	[report_code] [char](30) NOT NULL,
	[rs_stock_act] [decimal](18, 5) NOT NULL,
	[cs_stock_act] [decimal](18, 5) NOT NULL,
	[rs_cos_merc] [decimal](18, 5) NOT NULL,
	[cs_cos_merc] [decimal](18, 5) NOT NULL,
	[rs_ult_cos_un] [decimal](18, 5) NOT NULL,
	[cs_ult_cos_un] [decimal](18, 5) NOT NULL,
	[fecha_reg] [smalldatetime] NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO



