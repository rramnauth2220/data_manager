USE [LexisExtract]
GO

/****** Object:  StoredProcedure [dbo].[RecordUser]    Script Date: 4/7/2019 6:46:48 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Rebecca Ramnauth
-- Create date: 03/20/2019
-- Table:		Users View
-- Description:	Tracking Data Manager User Logins
-- =============================================
CREATE PROCEDURE [dbo].[RecordUser]
	@Username NVARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;

	IF NOT EXISTS ( SELECT DISTINCT *
		FROM [dbo].[Manager_Users]
		WHERE [Username]=@Username)
	BEGIN
		INSERT INTO [dbo].[Manager_Users] (Username, InitialLogin, RecentLogin, NumLogins)
		VALUES (@Username, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1)
	END
	ELSE
	BEGIN 
		UPDATE [dbo].[Manager_Users]
		SET RecentLogin=CURRENT_TIMESTAMP, NumLogins = NumLogins + 1
		WHERE Username=@Username
	END
END
GO

