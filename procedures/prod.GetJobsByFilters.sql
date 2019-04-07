USE [LexisExtract]
GO

/****** Object:  StoredProcedure [dbo].[GetJobsByFilters]    Script Date: 4/7/2019 6:45:12 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Rebecca Ramnauth
-- Create date: 03/14/2019
-- Table:       Jobs View
-- Description:	Filtering on Multiple Criteria
-- =============================================
CREATE PROCEDURE [dbo].[GetJobsByFilters]
	@Type_Filter VARCHAR(50), 
	@Start_Filter DATETIME, 
	@End_Filter DATETIME
AS
BEGIN

    SET NOCOUNT ON;
    SELECT *
	FROM [Reg_Change_Job_Logs]
	WHERE 
		[Job_Type] LIKE CASE 
		WHEN @Type_Filter = 'ALL'
		THEN '%'
		ELSE @Type_Filter
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

