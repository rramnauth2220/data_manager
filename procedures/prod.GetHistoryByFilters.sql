USE [LexisExtract]
GO

/****** Object:  StoredProcedure [dbo].[GetHistoryByFilters]    Script Date: 4/7/2019 6:44:58 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Rebecca Ramnauth
-- Create date: 03/20/2019
-- Table:       History View
-- Description:	Filtering on Multiple Criteria
-- =============================================
CREATE PROCEDURE [dbo].[GetHistoryByFilters]
	@Username NVARCHAR(50), 
	@Action NVARCHAR(10), 
	@View NVARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT *
	  FROM [dbo].[Manager_Change_Tracking]
	  WHERE 
		  [Username] LIKE CASE 
			WHEN @Username = 'ALL' 
			THEN '%'
			ELSE @Username
		  END
		  AND 
		  [Action] LIKE CASE 
			WHEN @Action = 'ALL' 
			THEN '%'
			ELSE @Action
		  END
		  AND 
		  [View] LIKE CASE 
			WHEN @View = 'ALL' 
			THEN '%'
			ELSE @View
		  END
		ORDER BY [Time] DESC
END
GO

