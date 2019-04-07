USE [LexisExtract]
GO

/****** Object:  StoredProcedure [dbo].[GetFilesByFilters]    Script Date: 4/7/2019 6:44:43 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Rebecca Ramnauth
-- Create date: 03/14/2019
-- Table:       Files View
-- Description:	Filtering on Multiple Criteria
-- =============================================
CREATE PROCEDURE [dbo].[GetFilesByFilters]
	@Subscription_Filter VARCHAR(100), 
	@Start_Filter DATETIME, 
	@End_Filter DATETIME
AS
BEGIN
	SET NOCOUNT ON;
    SELECT *
	FROM [Reg_Change_Extract_Tracker]
	WHERE 
		[Subscription_id] LIKE CASE 
		WHEN @Subscription_Filter = 'ALL'
		THEN '%'
		ELSE @Subscription_Filter
		END
		AND 
		[Start_Time] > CASE 
		WHEN @Start_Filter IS NULL 
		THEN 0
		ELSE @Start_Filter
		END
		AND 
		[End_Time] < CASE 
		WHEN @End_Filter IS NULL 
		THEN Convert(DATE, GetDate())
		ELSE @End_Filter
		END
END
GO

