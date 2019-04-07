USE [LexisExtract]
GO

/****** Object:  StoredProcedure [dbo].[RecordChange]    Script Date: 4/7/2019 6:46:30 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[RecordChange]
	@Username NVARCHAR(50),
	@Action NVARCHAR(10),
	@View NVARCHAR(50),
	@Content_Id NVARCHAR(MAX),
	@Description NVARCHAR(150)
AS
BEGIN
	SET NOCOUNT ON;
    INSERT INTO 
		[dbo].[Manager_Change_Tracking](
		[Username], 
		[Time],
		[Action], 
		[View],
		[Content_Id],
		[Description])
	VALUES (
		@Username,
		CURRENT_TIMESTAMP,
		@Action, 
		@View,
		@Content_Id,
		@Description
	);
END
GO

