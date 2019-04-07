USE [LexisExtract]
GO

/****** Object:  StoredProcedure [dbo].[InsertNewStructure]    Script Date: 4/7/2019 6:46:10 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Rebecca Ramnauth
-- Create date: 03/19/2019
-- Table:		LexisNexis Structure
-- Description:	Add new LexisNexis Structure
-- =============================================
CREATE PROCEDURE [dbo].[InsertNewStructure]
	@Subscription_Id NVARCHAR(100), 
	@File_Source NVARCHAR(250), 
	@File_Name NVARCHAR(250), 		
	@File_Id NVARCHAR(250), 
	@File_Updated DATETIME, 
	@File_Publish NVARCHAR(250), 
	@File_Content_Container NVARCHAR(250), 
	@Content_Id NVARCHAR(250),
	@Content_Updated DATETIME, 
	@Content_Action NVARCHAR(100), 
	@Reg_Citation NVARCHAR(100), 
	@Reg_Jurisdiction NVARCHAR(100), 
	@Reg_Body NVARCHAR(350), 
	@Reg_Title NVARCHAR(350), 
	@Reg_Subtitle NVARCHAR(350), 
	@Reg_Chapter NVARCHAR(350), 
	@Reg_Subchapter NVARCHAR(350), 
	@Reg_Part NVARCHAR(350), 
	@Reg_Subpart NVARCHAR(350), 
	@Reg_Section NVARCHAR(MAX), 
	@Reg_Subsection NVARCHAR(250), 
	@Reg_Content NVARCHAR(MAX), 
	@Reg_References NVARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO [Reg_Change_Structure_Test] (
		[Subscription_Id], 
		[File_Source], 
		[File_Name], 
		[File_Id], 
		[File_Updated], 
		[File_Publish], 
		[File_Content_Container], 
		[Content_Id], 
		[Content_Updated], 
		[Content_Action], 
		[Reg_Citation], 
		[Reg_Jurisdiction], 
		[Reg_Body], 
		[Reg_Title], 
		[Reg_Subtitle], 
		[Reg_Chapter], 
		[Reg_Subchapter], 
		[Reg_Part], 
		[Reg_Subpart], 
		[Reg_Section], 
		[Reg_Subsection], 
		[Reg_Content], 
		[Reg_References]
	) 
	VALUES (
		@Subscription_Id, 
		@File_Source, 
		@File_Name, 
		@File_Id, 
		@File_Updated, 
		@File_Publish, 
		@File_Content_Container, 
		@Content_Id,
		@Content_Updated, 
		@Content_Action, 
		@Reg_Citation, 
		@Reg_Jurisdiction, 
		@Reg_Body, 
		@Reg_Title, 
		@Reg_Subtitle, 
		@Reg_Chapter, 
		@Reg_Subchapter, 
		@Reg_Part, 
		@Reg_Subpart, 
		@Reg_Section, 
		@Reg_Subsection, 
		@Reg_Content, 
		@Reg_References
	);
END
GO

