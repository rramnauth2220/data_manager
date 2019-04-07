USE [LexisExtract]
GO

/****** Object:  StoredProcedure [dbo].[GetUsersByFilters]    Script Date: 4/7/2019 6:45:58 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Rebecca Ramnauth
-- Create date: 03/20/2019
-- Table:       Users View
-- Description:	Filtering on Multiple Criteria
-- =============================================
CREATE PROCEDURE [dbo].[GetUsersByFilters]
	@Username NVARCHAR(50), 
	@InitialLogin DATETIME, 
	@RecentLogin DATETIME,
	@Role NVARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT *
	FROM [Manager_Users]
	WHERE 
		Username LIKE CASE 
		WHEN @Username = 'ALL'
		THEN '%'
		ELSE @Username
		END
		AND
		[Role] LIKE CASE 
		WHEN @Role = 'ALL'
		THEN '%'
		ELSE @Role
		END
		AND
		InitialLogin > CASE 
		WHEN @InitialLogin IS NULL 
		THEN 0
		ELSE @InitialLogin
		END
		AND 
		RecentLogin < CASE 
		WHEN @RecentLogin IS NULL 
		THEN Convert(DATE, GetDate())
		ELSE @RecentLogin
		END
END
GO

