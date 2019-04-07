USE [LexisExtract]
GO

/****** Object:  StoredProcedure [dbo].[InsertNewSubscription]    Script Date: 4/7/2019 6:46:21 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Rebecca Ramnauth
-- Create date: 03/25/2019
-- Table:		Feed Subscription
-- Description:	Add new Subscription definition
-- =============================================
CREATE PROCEDURE [dbo].[InsertNewSubscription]
	@Source_Full_Name NVARCHAR(100),
	@Source_ShortName NVARCHAR(50),
	@Subscription_ID NVARCHAR(50),
	@Subscription_FullName NVARCHAR(50), 
	@Subscription_ShortName NVARCHAR(50),
	@Body NVARCHAR(50),
	@Active bit, 
	@Jurisdiction NVARCHAR(50),
	@Last_Epoch int, 
	@Last_Update DATETIME2(7), 
	@Schedule_Freq int, 
	@Process_Time NVARCHAR(50),
	@Scan_Error NVARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO [dbo].[Reg_Change_Sources] (
		[Source_Full_Name], 
		[Source_ShortName], 
		[Subscription_ID], 
		[Subscription_FullName],
		[Subscription_ShortName],
		[Body],
		[Active],
		[Jurisdiction],
		[Last_Epoch],
		[Last_Update],
		[Schedule_Freq],
		[Process_Time],
		[Scan_Error]
	) 
	VALUES (
		@Source_Full_Name,
		@Source_ShortName,
		@Subscription_ID,
		@Subscription_FullName, 
		@Subscription_ShortName,
		@Body,
		@Active, 
		@Jurisdiction,
		@Last_Epoch, 
		@Last_Update, 
		@Schedule_Freq, 
		@Process_Time,
		@Scan_Error
	);
END
GO

