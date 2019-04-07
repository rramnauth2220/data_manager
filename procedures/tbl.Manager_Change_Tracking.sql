USE [LexisExtract]
GO

/****** Object:  Table [dbo].[Manager_Change_Tracking]    Script Date: 4/7/2019 6:43:42 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Manager_Change_Tracking](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Time] [datetime] NOT NULL,
	[Action] [nvarchar](10) NOT NULL,
	[View] [nvarchar](50) NOT NULL,
	[Content_Id] [nvarchar](max) NULL,
	[Description] [nvarchar](150) NULL,
 CONSTRAINT [PK_Manager_Change_Tracking] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

