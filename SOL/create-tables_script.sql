-- articles update process tables
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[aAa_updt_log](
	[co_art] [char](30) NOT NULL,
	[art_des] [varchar](120) NOT NULL,
	[report_code] [char](30) NOT NULL,
	[rs_cos_merc] [decimal](18, 5) NOT NULL,
	[cs_cos_merc] [decimal](18, 5) NOT NULL,
	[rs_ult_cos_un] [decimal](18, 5) NOT NULL,
	[cs_ult_cos_un] [decimal](18, 5) NOT NULL,
	[rs_prec_vta3] [decimal](18, 5) NOT NULL,
	[cs_prec_vta3] [decimal](18, 5) NOT NULL,
	[fecha_reg] [smalldatetime] NOT NULL
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[aAa_updt_reports](
	[co_art] [char](30) NOT NULL,
	[art_des] [varchar](120) NOT NULL,
	[report_code] [char](30) NOT NULL,
	[rs_cos_merc] [decimal](18, 5) NOT NULL,
	[cs_cos_merc] [decimal](18, 5) NOT NULL,
	[rs_ult_cos_un] [decimal](18, 5) NOT NULL,
	[cs_ult_cos_un] [decimal](18, 5) NOT NULL,
	[fecha_reg] [smalldatetime] NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

