USE [LexisExtract]
GO

/****** Object:  StoredProcedure [dbo].[GetRegulationsByFilters]    Script Date: 4/7/2019 6:45:44 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Rebecca Ramnauth
-- Create date: 03/12/2019
-- Table:       Regulations View
-- Description:	Filtering on Multiple Criteria
-- =============================================
CREATE PROCEDURE [dbo].[GetRegulationsByFilters]
      @Body_Filter VARCHAR(50),
	  @Action_Filter VARCHAR(50),
	  @Jurisdiction_Filter VARCHAR(50)
	  --@Start_Filter DATETIME,
	  --@End_Filter DATETIME
AS
BEGIN
      SET NOCOUNT ON;
      SELECT *
	  FROM [Reg_Change_Content]
	  WHERE 
		  [Content_Action] LIKE CASE 
			WHEN @Action_Filter = 'ALL' 
			THEN '%'
			ELSE @Action_Filter
		  END
		  AND 
		  [Reg_Jurisdiction] LIKE CASE 
			WHEN @Jurisdiction_Filter = 'ALL' 
			THEN '%'
			ELSE @Jurisdiction_Filter
		  END
		  AND 
		  [Reg_Body] LIKE CASE 
			WHEN @Body_Filter = 'ALL' 
			THEN '%'
			ELSE @Body_Filter
		  END
		  --AND 
		  --([Content_Updated] BETWEEN @Start_Filter AND @End_Filter)
END
GO

