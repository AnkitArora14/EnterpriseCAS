use EEA_CAS_Enterprise;

-- Creating missing stored procedure: dbo.CreateNewApp
-- =============================================
-- Author:		Phong Lu
-- Create date: 12/02/2025
-- Description:	To create new app with tokens
-- =============================================
CREATE PROCEDURE [dbo].[CreateNewApp]
	@appName NVARCHAR(20),
	@appDataName NVARCHAR(20),
	@sharedApiName NVARCHAR(20),
	@canRead BIT = 1,
	@canWrite BIT = 1,
	@canDelete BIT = 1
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		BEGIN TRANSACTION;

		DECLARE		@appToken		NVARCHAR(36)
				,	@appDataToken	NVARCHAR(36)
				,	@appId			UNIQUEIDENTIFIER
				,	@appDataId		UNIQUEIDENTIFIER
				,	@sharedApiId	UNIQUEIDENTIFIER;

		DECLARE @InsertedIds	TABLE ([Id] UNIQUEIDENTIFIER);
		DECLARE @Result			TABLE ([Key] NVARCHAR(20), [Value] NVARCHAR(36));

		-- Check for App existence

		SELECT @appId = [appId]
		FROM [dbo].[App]
		WHERE [appName] = @appName

		IF @appId IS NOT NULL
		BEGIN
			;THROW 50001, 'Existed App', 1;
		END

		-- Check for AppData existence

		SELECT @appDataId = [appDataId]
		FROM [dbo].[AppData]
		WHERE [appDataName] = @appDataName

		IF @appDataId IS NOT NULL
		BEGIN
			;THROW 50002, 'Existed AppData', 2;
		END

		-- Check for SharedApi existence

		SELECT @sharedApiId = [sharedApiId]
		FROM [dbo].[SharedApi]
		WHERE [sharedApiName] = @sharedApiName

		IF @sharedApiId IS NULL
		BEGIN
			;THROW 50003, 'Non-existed ShareApi', 3;
		END

		-- Create new App

		SET @appToken = CONVERT(VARCHAR(36), NEWID());

		INSERT INTO [dbo].[App] ([appName], [appToken], [createdDt], [createdBy])
		OUTPUT INSERTED.[appId] INTO @InsertedIds
		VALUES (@appName, @appToken, GETUTCDATE(), 'Manual');

		SELECT @appId = [Id] FROM @InsertedIds;

		-- Create new AppData

		DELETE FROM @InsertedIds;

		SET @appDataToken = CONVERT(VARCHAR(36), NEWID());

		INSERT INTO [dbo].[AppData] ([appDataName], [appDataToken], [createdDt], [createdBy])
		OUTPUT INSERTED.[appDataId] INTO @InsertedIds
		VALUES (@appName, @appDataToken, GETUTCDATE(), 'Manual');

		SELECT @appDataId = [Id] FROM @InsertedIds;

		-- Create AppAppDataSharedApi

		INSERT INTO [dbo].[AppAppDataSharedApi] ([appId], [appDataId], [sharedApiId], [canRead], [canWrite], [canDelete], [createdDt], [createdBy])
		VALUES (@appId, @appDataId, @sharedApiId, @canRead, @canWrite, @canDelete, GETUTCDATE(), 'Manual');

		-- Return App details

		INSERT INTO @Result ([Key], [Value])
		VALUES
				('AppName', @appName)
			,	('AppDataName', @appDataName)
			,	('AppToken', @appToken)
			,	('DataToken', @appDataToken);

		SELECT * FROM @Result;

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH
END

GO

-- Creating missing stored procedure: dbo.GetApp
-- =============================================
-- Author:		Phong Lu
-- Create date: 12/02/2025
-- Description:	To get app details
-- =============================================
CREATE PROCEDURE [dbo].[GetApp]
	@appName NVARCHAR(20),
	@appDataName NVARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE		@appToken		NVARCHAR(36)
			,	@appDataToken	NVARCHAR(36)
			,	@appId			UNIQUEIDENTIFIER
			,	@appDataId		UNIQUEIDENTIFIER;

	-- Check for App existence

	SELECT @appId = [appId], @appToken = [appToken]
	FROM [dbo].[App]
	WHERE [appName] = @appName;

	IF @appId IS NULL
	BEGIN
		;THROW 50001, 'Non-existed App', 1;
	END

	-- Check for AppData existence

	SELECT @appDataId = [appDataId], @appDataToken = [appDataToken]
	FROM [dbo].[AppData]
	WHERE [appDataName] = @appDataName;

	IF @appDataId IS NULL
	BEGIN
		;THROW 50002, 'Non-existed AppData', 2;
	END

	-- Get App details

	SELECT [A].[appName], [AD].[appDataName], [A].[appToken], [AD].[appDataToken], [SA].[sharedApiName]
		, [AADSA].[canRead], [AADSA].[canWrite], [AADSA].[canDelete], [AADSA].[isDeleted], [AADSA].[createdDt], [AADSA].[createdBy], [AADSA].[lastModifiedDt], [AADSA].[lastModifiedBy]
	FROM [dbo].[AppAppDataSharedApi] AS [AADSA]
		JOIN [dbo].[App]		AS [A]	ON [AADSA].[appId]			= [A].[appId]
		JOIN [dbo].[AppData]	AS [AD]	ON [AADSA].[appDataId]		= [AD].[appDataId]
		JOIN [dbo].[SharedApi]	AS [SA]	ON [AADSA].[sharedApiId]	= [SA].[sharedApiId]
	WHERE	[AADSA].[appId]			= @appId
		AND	[AADSA].[appDataId]		= @appDataId
END

GO

-- Creating missing stored procedure: dbo.GetApps
-- =============================================
-- Author:		Phong Lu
-- Create date: 12/02/2025
-- Description:	To get all apps
-- =============================================
CREATE PROCEDURE [dbo].[GetApps]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT [A].[appName], [AD].[appDataName], [A].[appToken], [AD].[appDataToken], [SA].[sharedApiName]
		, [AADSA].[canRead], [AADSA].[canWrite], [AADSA].[canDelete], [AADSA].[isDeleted], [AADSA].[createdDt], [AADSA].[createdBy], [AADSA].[lastModifiedDt], [AADSA].[lastModifiedBy]
	FROM [dbo].[AppAppDataSharedApi] AS [AADSA]
		JOIN [dbo].[App]		AS [A]	ON [AADSA].[appId]			= [A].[appId]
		JOIN [dbo].[AppData]	AS [AD]	ON [AADSA].[appDataId]		= [AD].[appDataId]
		JOIN [dbo].[SharedApi]	AS [SA]	ON [AADSA].[sharedApiId]	= [SA].[sharedApiId]
END

GO

-- Creating missing stored procedure: dbo.GetAvailableActivitiesBySite
CREATE PROCEDURE [dbo].[GetAvailableActivitiesBySite]
	@SiteIds NVARCHAR(100) = '',
	@TargetActivityType NVARCHAR(100) = '',
	@SortField NVARCHAR(100) = '',
	@SortDirection INT = 0,
	@DoPageResult INT = 0,
	@PageNumber INT = 1,
	@PageSize INT = 10
AS
DECLARE
	@siteIdList NVARCHAR(MAX),
	@validIds INT = 0;
BEGIN
	SET NOCOUNT ON;

	SET @siteIdList = REPLACE(@SiteIds, ' ', '');

	SELECT @validIds = COUNT(1)  FROM STRING_SPLIT(@siteIdList, ',') WHERE TRY_CONVERT(uniqueidentifier, value) IS NOT NULL;

	IF (@validIds <= 0)
	BEGIN
		;THROW 51000, 'At least One valid SiteId is mandatory to get the available activities list', 1;
	END

	IF (@TargetActivityType IS NULL OR @TargetActivityType = '')
	BEGIN
		;THROW 51001, 'TargetAcitityType is mandatory to get the available activities list', 1;
	END

	SELECT value INTO #SiteIDList
	FROM STRING_SPLIT(@siteIdList, ',')
	WHERE TRY_CONVERT(uniqueidentifier, value) IS NOT NULL


	IF(@SortField IS NULL OR (NULLIF(@SortField, '') IS NULL))
	BEGIN
		SET @SortField = 'category';
	END
	ELSE
	BEGIN
		SET @SortField = LOWER(RTRIM(LTRIM(@SortField)));
	END

	IF (@PageSize IS NULL OR @PageSize <= 0)
	BEGIN
		SET @PageSize = 10;
	END

	IF (@PageNumber IS NULL OR @PageNumber <= 0)
	BEGIN
		SET @PageNumber = 1;
	END

	-- Create a table expression of all the available Related Activities of different categories
	;WITH Activities (SiteId, ActivityCategory, ActivityId, ActivityTypeCode, ActivityTypeDescription, StaffId, firstName, lastName, ActivityDate)
	AS
	(
		SELECT
			SI.SiteId,
			'Inspection' AS ActivityCategory,
			SI.siteInspectionIdentifier AS ActivityId,
			ST.siteInspectionTypeCode AS ActivityTypeCode,
			ST.siteInspectionTypeDesc AS ActivityTypeDescription,
			E.staffId,
			E.firstName,
			E.lastName,
            IIF(SI.performedDate IS NOT NULL, SI.performedDate, SI.scheduledDate) AS ActivityDate
		FROM SiteInspection SI
			JOIN SiteInspectionType ST ON ST.siteInspectionTypeId = SI.siteInspectionTypeId AND ST.isDeleted <> 1 AND SI.isDeleted <> 1
			JOIN Staff E ON SI.issuingStaffId = E.StaffId AND E.isDeleted <> 1
		WHERE SI.nextVersionId IS NULL
			AND (SI.performedDate IS NOT NULL OR SI.scheduledDate IS NOT NULL)
			AND SI.siteId IN (SELECT * FROM #SiteIDList)
		UNION

		SELECT
			SEE.SiteId,
			'Enforcement' AS ActivityCategory,
			En.enforcementId AS ActivityId,
			ET.enforcementTypeCode AS ActivityTypeCode,
			ET.enforcementTypeDesc AS ActivityTypeDescription,
			E.staffId,
			E.firstName,
			E.lastName,
			En.createdDt AS ActivityDate
		FROM Enforcement En
			JOIN EnforcementType ET ON En.enforcementTypeId = ET.enforcementTypeId AND En.isDeleted <> 1
			JOIN EnforcementEntity EE ON En.enforcementId = EE.enforcementId AND ee.isDeleted <> 1
			JOIN SiteEnforcementEntity SEE ON SEE.enforcementEntityId = EE.enforcementEntityId AND SEE.isDeleted <> 1
			JOIN EnforcementEntityType EET ON EET.enforcementEntityTypeId = EE.enforcementEntityTypeId AND EET.enforcementEntityTypeCode = 'Site'
			JOIN Staff E ON En.staffId = E.StaffId AND E.isDeleted <> 1
		WHERE En.isDeleted <> 1 AND
			En.nextVersionId IS NULL
			AND CAST(SEE.siteId AS VARCHAR(100)) IN (SELECT * FROM #SiteIDList)
		UNION

		-- Correspondence
		SELECT
			SC.SiteId,
			'Correspondence' AS ActivityCategory,
			Cr.correspondenceId AS ActivityId,
			ST.siteCorrespondenceTypeCode AS ActivityTypeCode,
			ST.siteCorrespondenceTypeDesc AS ActivityTypeDescription,
			E.staffId,
			E.firstName,
			E.lastName,
			Cr.createdDt AS ActivityDate
		FROM Correspondence Cr
			JOIN SiteCorrespondence SC ON Cr.correspondenceId = SC.correspondenceId AND SC.isDeleted <> 1
			JOIN SiteCorrespondenceType ST ON SC.siteCorrespondenceTypeId = ST.siteCorrespondenceTypeId AND ST.isDeleted <> 1
			JOIN Staff E ON Cr.issuingStaffId = E.StaffId AND E.isDeleted <> 1
		WHERE Cr.isDeleted <> 1
			AND CAST(SC.siteId AS VARCHAR(100)) IN (SELECT * FROM #SiteIDList)
	)

	SELECT
		SiteId, ActivityCategory, ActivityId, ActivityTypeCode, ActivityTypeDescription, StaffId,
        CONCAT(IIF(NULLIF(lastName, '') IS NOT NULL, CONCAT(lastName, ', '), ''), firstName) AS StaffName,
		ActivityDate,
		COUNT(*) OVER()                                                                      AS FilteredCount
	FROM  Activities
	ORDER BY
			CASE WHEN @SortField = 'category' AND @SortDirection = 1 THEN ActivityCategory END,
			CASE WHEN @SortField = 'type' AND @SortDirection = 1 THEN ActivityTypeCode END,
			CASE WHEN @SortField = 'description' AND @SortDirection = 1 THEN ActivityTypeDescription END,
			CASE WHEN @SortField = 'actiondate' AND @SortDirection = 1 THEN ActivityDate END,
			CASE WHEN @SortField = 'staffname' AND @SortDirection = 1 THEN lastName END,
			--descending
			CASE WHEN @SortField = 'category' AND @SortDirection = 0 THEN ActivityCategory END DESC,
			CASE WHEN @SortField = 'type' AND @SortDirection = 0 THEN ActivityTypeCode END DESC,
			CASE WHEN @SortField = 'description' AND @SortDirection = 0 THEN ActivityTypeDescription END DESC,
			CASE WHEN @SortField = 'actiondate' AND @SortDirection = 0 THEN ActivityDate END DESC,
			CASE WHEN @SortField = 'staffname' AND @SortDirection = 0 THEN lastName END DESC
	OFFSET IIF(@DoPageResult = 1, (@PageSize * (@PageNumber - 1)), 0)
	ROWS
	FETCH NEXT
        IIF(@DoPageResult = 1, @PageSize, 0x7ffffff)
	ROWS ONLY

	DROP TABLE #SiteIDList;
END
GO

-- Creating missing stored procedure: dbo.GetAvailableActivitiesForCorrespondence
CREATE PROCEDURE [dbo].[GetAvailableActivitiesForCorrespondence]
	@SiteIds NVARCHAR(1000) = '',
	@SortField NVARCHAR(100) = '',
	@SortDirection INT = 0,
	@DoPageResult INT = 0,
	@PageNumber INT = 1,
	@PageSize INT = 10
AS
DECLARE
	@NoOfMonthsToGetHistoricRecords INT = 36,
	@Today DATE,
	@siteIdList NVARCHAR(MAX),
	@validIds INT = 0;
BEGIN
	SET NOCOUNT ON;

	SET @Today = CONVERT(DATE, GETDATE());
	SET @siteIdList = REPLACE(@SiteIds, ' ', '');

	SELECT @validIds = COUNT(1) FROM STRING_SPLIT(@siteIdList, ',')  WHERE TRY_CONVERT(uniqueidentifier, value) IS NOT NULL;

	IF (@validIds <= 0)
	BEGIN
		;THROW 51000, 'At least One valid SiteId is mandatory to get the available activities list', 1;
	END

	SELECT value INTO #SiteIDList FROM STRING_SPLIT(@siteIdList, ',')  WHERE TRY_CONVERT(uniqueidentifier, value) IS NOT NULL

	IF(@SortField IS NULL OR (NULLIF(@SortField, '') IS NULL))
	BEGIN
		SET @SortField = 'actiondate';
	END
	ELSE
	BEGIN
		SET @SortField = LOWER(RTRIM(LTRIM(@SortField)));
	END

	IF (@PageSize IS NULL OR @PageSize <= 0)
	BEGIN
		SET @PageSize = 10;
	END

	IF (@PageNumber IS NULL OR @PageNumber <= 0)
	BEGIN
		SET @PageNumber = 1;
	END

	SELECT e.relatedActivityId, LOWER(activityTypeCode) AS activityTypeCode INTO #Existing FROM
	(
		SELECT relatedActivityId, activityTypeCode FROM SiteInspection s JOIN ActivityType AT ON s.relatedActivityTypeId = at.activityTypeId WHERE s.nextVersionId IS NULL AND s.isDeleted <> 1
		UNION
		SELECT relatedActivityId, activityTypeCode FROM Enforcement e JOIN ActivityType AT ON e.relatedActivityTypeId = at.activityTypeId  WHERE e.nextVersionId IS NULL AND e.isDeleted <> 1
		UNION
		SELECT relatedActivityId, activityTypeCode FROM SiteCorrespondence sc JOIN ActivityType AT ON sc.relatedActivityTypeId = at.activityTypeId AND sc.isDeleted <> 1
			JOIN Correspondence C ON sc.correspondenceId = C.correspondenceId AND c.isDeleted <> 1
	) e

	-- Create a table expression of all the available Related Activities of different categories
	;WITH Activities (SiteId, ActivityCategory, ActivityId, ActivityTypeCode, ActivityTypeDescription, StaffId, firstName, lastName, ActivityDate)
	AS
	(
		SELECT
			SI.SiteId,
			'Inspection'                                                          AS ActivityCategory,
			SI.siteInspectionIdentifier                                           AS ActivityId,
			ST.siteInspectionTypeCode                                             AS ActivityTypeCode,
			ST.siteInspectionTypeDesc                                             AS ActivityTypeDescription,
			E.staffId,
			E.firstName,
			E.lastName,
            IIF(SI.performedDate IS NOT NULL, SI.performedDate, SI.scheduledDate) AS ActivityDate
		FROM SiteInspection SI
			JOIN SiteInspectionType ST ON ST.siteInspectionTypeId = SI.siteInspectionTypeId AND ST.isDeleted <> 1 AND SI.isDeleted <> 1
			JOIN Staff E ON SI.issuingStaffId = E.StaffId AND E.isDeleted <> 1
		WHERE SI.nextVersionId IS NULL
			AND CAST(SI.siteId AS VARCHAR(100)) IN (SELECT * FROM #SiteIDList)
			AND (SI.performedDate IS NOT NULL) -- All performed inspections
			AND DATEADD(MONTH, @NoOfMonthsToGetHistoricRecords, SI.performedDate) > @Today --Insepctions performed in last 36 months
			AND SI.siteInspectionIdentifier NOT IN (SELECT relatedActivityId FROM #Existing WHERE activityTypeCode = 'ins') --- inspection not already linked

		UNION

		SELECT
			SE.SiteId,
			'Enforcement' AS ActivityCategory,
			En.enforcementId AS ActivityId,
			ET.enforcementTypeCode AS ActivityTypeCode,
			ET.enforcementTypeDesc AS ActivityTypeDescription,
			E.staffId,
			E.firstName,
			E.lastName,
			En.createdDt AS ActivityDate
		FROM Enforcement En
			JOIN EnforcementType ET ON En.enforcementTypeId = ET.enforcementTypeId AND En.isDeleted <> 1
			JOIN EnforcementEntity EE ON En.enforcementId = EE.enforcementId AND ee.isDeleted <> 1
			JOIN SiteEnforcementEntity SE ON EE.enforcementEntityId = SE.enforcementEntityId AND SE.isDeleted <> 1
			LEFT JOIN Staff E ON En.staffId = E.StaffId AND E.isDeleted <> 1
		WHERE En.isDeleted <> 1 AND	En.nextVersionId IS NULL
			AND CAST(SE.siteId AS VARCHAR(100)) IN (SELECT * FROM #SiteIDList)
			AND DATEADD(MONTH, @NoOfMonthsToGetHistoricRecords, En.createdDt) > @Today --Enforcements performed in last 36 months
			AND En.enforcementId NOT IN (SELECT relatedActivityId FROM #Existing WHERE activityTypeCode = 'enf') --- enforcement not already linked

		UNION

		-- Correspondence
		SELECT
			SC.SiteId,
			'Correspondence' AS ActivityCategory,
			Cr.correspondenceId AS ActivityId,
			ST.siteCorrespondenceTypeCode AS ActivityTypeCode,
			ST.siteCorrespondenceTypeDesc AS ActivityTypeDescription,
			E.staffId,
			E.firstName,
			E.lastName,
			Cr.createdDt AS ActivityDate
		FROM Correspondence Cr
			JOIN SiteCorrespondence SC ON Cr.correspondenceId = SC.correspondenceId AND SC.isDeleted <> 1
			JOIN SiteCorrespondenceType ST ON SC.siteCorrespondenceTypeId = ST.siteCorrespondenceTypeId AND ST.isDeleted <> 1
			LEFT JOIN Staff E ON Cr.issuingStaffId = E.StaffId AND E.isDeleted <> 1
		WHERE Cr.isDeleted <> 1
			AND CAST(SC.siteId AS VARCHAR(100)) IN (SELECT * FROM #SiteIDList)
			AND Cr.createdDt IS NOT NULL -- Issued Site Correspondences
			AND UPPER(st.siteCorrespondenceTypeCode) NOT IN ('ADJUST','BILL','CERTIF','NOTICE','REVIEW','RTC','RTCNL','COMP','COMPNL')
			AND DATEADD(MONTH, @NoOfMonthsToGetHistoricRecords, Cr.createdDt) > @Today --Correspondences enforced in last 36 months
			AND Sc.correspondenceId NOT IN (SELECT relatedActivityId FROM #Existing WHERE activityTypeCode = 'cor') --- correspondence not already linked
	)

	SELECT
		SiteId, ActivityCategory, ActivityId, ActivityTypeCode, ActivityTypeDescription, StaffId,
        CONCAT(IIF(NULLIF(lastName, '') IS NOT NULL, CONCAT(lastName, ', '), ''), firstName) AS StaffName,
		ActivityDate,
		COUNT(*) OVER()                                                                      AS FilteredCount
	FROM  Activities
	ORDER BY
			CASE WHEN @SortField = 'category' AND @SortDirection = 1 THEN ActivityCategory END,
			CASE WHEN @SortField = 'type' AND @SortDirection = 1 THEN ActivityTypeCode END,
			CASE WHEN @SortField = 'description' AND @SortDirection = 1 THEN ActivityTypeDescription END,
			CASE WHEN @SortField = 'actiondate' AND @SortDirection = 1 THEN ActivityDate END,
			CASE WHEN @SortField = 'staffname' AND @SortDirection = 1 THEN lastName END,
			--descending
			CASE WHEN @SortField = 'category' AND @SortDirection = 0 THEN ActivityCategory END DESC,
			CASE WHEN @SortField = 'type' AND @SortDirection = 0 THEN ActivityTypeCode END DESC,
			CASE WHEN @SortField = 'description' AND @SortDirection = 0 THEN ActivityTypeDescription END DESC,
			CASE WHEN @SortField = 'actiondate' AND @SortDirection = 0 THEN ActivityDate END DESC,
			CASE WHEN @SortField = 'staffname' AND @SortDirection = 0 THEN lastName END DESC
	OFFSET IIF(@DoPageResult = 1, (@PageSize * (@PageNumber - 1)), 0)
	ROWS
	FETCH NEXT
        IIF(@DoPageResult = 1, @PageSize, 0x7ffffff)
	ROWS ONLY

	DROP TABLE #Existing;
	DROP TABLE #SiteIDList;
END
GO

-- Creating missing stored procedure: dbo.GetAvailableActivitiesForEnforcement
CREATE PROCEDURE [dbo].[GetAvailableActivitiesForEnforcement]
	@SiteIds NVARCHAR(1000) = '',
	@SortField NVARCHAR(100) = '',
	@SortDirection INT = 0,
	@DoPageResult INT = 0,
	@PageNumber INT = 1,
	@PageSize INT = 10
AS
DECLARE
	@NoOfMonthsToGetHistoricRecords INT = 36,
	@Today DATE,
	@siteIdList NVARCHAR(MAX),
	@validIds INT = 0;
BEGIN
	SET NOCOUNT ON;

	SET @Today = CONVERT(DATE, GETDATE());
	--Get comma delimited values
	SET @siteIdList = REPLACE(@SiteIds, ' ', '');

	--Convert values to uniqueidentifier and add to temp table
	SELECT @validIds = COUNT(1) FROM STRING_SPLIT(@siteIdList, ',')  WHERE TRY_CONVERT(uniqueidentifier, value) IS NOT NULL;
	--Return error if count is <= 0
	IF (@validIds <= 0)
	BEGIN
		;THROW 51000, 'At least One valid SiteId is mandatory to get the available activities list', 1;
		RETURN;
	END

	SELECT value INTO #SiteIDList FROM STRING_SPLIT(@siteIdList, ',')  WHERE TRY_CONVERT(uniqueidentifier, value) IS NOT NULL

	IF(@SortField IS NULL OR (NULLIF(@SortField, '') IS NULL))
	BEGIN
		SET @SortField = 'actiondate';
	END
	ELSE
	BEGIN
		SET @SortField = LOWER(RTRIM(LTRIM(@SortField)));
	END

	IF (@PageSize IS NULL OR @PageSize <= 0)
	BEGIN
		SET @PageSize = 10;
	END

	IF (@PageNumber IS NULL OR @PageNumber <= 0)
	BEGIN
		SET @PageNumber = 1;
	END

	SELECT e.relatedActivityId, LOWER(activityTypeCode) AS activityTypeCode INTO #Existing FROM
	(
		SELECT relatedActivityId, activityTypeCode FROM SiteInspection s JOIN ActivityType AT ON s.relatedActivityTypeId = at.activityTypeId WHERE s.nextVersionId IS NULL AND s.isDeleted <> 1
		UNION
		SELECT relatedActivityId, activityTypeCode FROM Enforcement e JOIN ActivityType AT ON e.relatedActivityTypeId = at.activityTypeId  WHERE e.nextVersionId IS NULL AND e.isDeleted <> 1
		UNION
		SELECT relatedActivityId, activityTypeCode FROM SiteCorrespondence sc JOIN ActivityType AT ON sc.relatedActivityTypeId = at.activityTypeId AND sc.isDeleted <> 1
			JOIN Correspondence C ON sc.correspondenceId = C.correspondenceId AND c.isDeleted <> 1
	) e


	-- Create a table expression of all the available Related Activities of different categories
	;WITH Activities (SiteId, ActivityCategory, ActivityId, ActivityTypeCode, ActivityTypeDescription, StaffId, firstName, lastName, ActivityDate)
	AS
	(
		SELECT
			SI.SiteId,
			'Inspection'                                                          AS ActivityCategory,
			SI.siteInspectionIdentifier                                           AS ActivityId,
			ST.siteInspectionTypeCode                                             AS ActivityTypeCode,
			ST.siteInspectionTypeDesc                                             AS ActivityTypeDescription,
			E.staffId,
			E.firstName,
			E.lastName,
            IIF(SI.performedDate IS NOT NULL, SI.performedDate, SI.scheduledDate) AS ActivityDate
		FROM SiteInspection SI
			JOIN SiteInspectionType ST ON ST.siteInspectionTypeId = SI.siteInspectionTypeId AND ST.isDeleted <> 1 AND SI.isDeleted <> 1
			JOIN Staff E ON SI.issuingStaffId = E.StaffId AND E.isDeleted <> 1
		WHERE SI.nextVersionId IS NULL
			AND CAST(SI.siteId AS VARCHAR(100)) IN (SELECT * FROM #SiteIDList)
			AND (SI.performedDate IS NOT NULL) -- All performed inspections
			AND DATEADD(MONTH, @NoOfMonthsToGetHistoricRecords, SI.performedDate) > @Today --Insepctions performed in last 36 months
			AND SI.siteInspectionIdentifier NOT IN (SELECT relatedActivityId FROM #Existing WHERE activityTypeCode = 'ins') --- inspection not already linked

		UNION

		SELECT
			EE.entityId,
			'Enforcement' AS ActivityCategory,
			En.enforcementId AS ActivityId,
			ET.enforcementTypeCode AS ActivityTypeCode,
			ET.enforcementTypeDesc AS ActivityTypeDescription,
			E.staffId,
			E.firstName,
			E.lastName,
			En.createdDt AS ActivityDate
		FROM Enforcement En
			JOIN EnforcementType ET ON En.enforcementTypeId = ET.enforcementTypeId AND En.isDeleted <> 1
			JOIN EnforcementEntity EE ON En.enforcementId = EE.enforcementId AND ee.isDeleted <> 1
			JOIN EnforcementEntityType EET ON EE.enforcementEntityTypeId = EET.enforcementEntityTypeId AND EET.isDeleted <> 1 AND EET.enforcementEntityTypeCode = 'Site'
			LEFT JOIN Staff E ON En.StaffId = E.StaffId AND E.isDeleted <> 1
		WHERE En.isDeleted <> 1
			AND	En.nextVersionId IS NULL
			AND CAST(EE.entityId AS VARCHAR(100)) IN (SELECT * FROM #SiteIDList)
			AND DATEADD(MONTH, @NoOfMonthsToGetHistoricRecords, En.createdDt) > @Today --Enforcements performed in last 36 months
			AND En.enforcementId NOT IN (SELECT relatedActivityId FROM #Existing WHERE activityTypeCode = 'enf') --- enforcement not already linked

		UNION

		-- Correspondence
		SELECT
			SC.SiteId,
			'Correspondence' AS ActivityCategory,
			Cr.correspondenceId AS ActivityId,
			ST.siteCorrespondenceTypeCode AS ActivityTypeCode,
			ST.siteCorrespondenceTypeDesc AS ActivityTypeDescription,
			E.staffId,
			E.firstName,
			E.lastName,
			Cr.createdDt AS ActivityDate
		FROM Correspondence Cr
			JOIN SiteCorrespondence SC ON Cr.correspondenceId = SC.correspondenceId AND SC.isDeleted <> 1
			JOIN SiteCorrespondenceType ST ON SC.siteCorrespondenceTypeId = ST.siteCorrespondenceTypeId AND ST.isDeleted <> 1
			LEFT JOIN Staff E ON Cr.issuingStaffId = E.StaffId AND E.isDeleted <> 1
		WHERE Cr.isDeleted <> 1
			AND CAST(SC.siteId AS VARCHAR(100)) IN (SELECT * FROM #SiteIDList)
			AND Cr.createdDt IS NOT NULL -- Issued Site Correspondences
			--AND UPPER(st.siteCorrespondenceTypeCode) IN ('NEC','RFI','INS','USTADV')
			AND st.siteCorrespondenceTypeCode NOT IN ('ADJUST', 'BILL', 'CERTIF', 'NOTICE','REVIEW')
			AND DATEADD(MONTH, @NoOfMonthsToGetHistoricRecords, Cr.createdDt) > @Today --Correspondences enforced in last 36 months
			AND Sc.correspondenceId NOT IN (SELECT relatedActivityId FROM #Existing WHERE activityTypeCode = 'cor') --- correspondence not already linked
	)

	SELECT
		SiteId, ActivityCategory, ActivityId, ActivityTypeCode, ActivityTypeDescription, StaffId,
        CONCAT(IIF(NULLIF(lastName, '') IS NOT NULL, CONCAT(lastName, ', '), ''), firstName) AS StaffName,
		ActivityDate,
		COUNT(*) OVER()                                                                      AS FilteredCount
	FROM  Activities
	ORDER BY
			CASE WHEN @SortField = 'category' AND @SortDirection = 1 THEN ActivityCategory END,
			CASE WHEN @SortField = 'type' AND @SortDirection = 1 THEN ActivityTypeCode END,
			CASE WHEN @SortField = 'description' AND @SortDirection = 1 THEN ActivityTypeDescription END,
			CASE WHEN @SortField = 'actiondate' AND @SortDirection = 1 THEN ActivityDate END,
			CASE WHEN @SortField = 'staffname' AND @SortDirection = 1 THEN lastName END,
			--descending
			CASE WHEN @SortField = 'category' AND @SortDirection = 0 THEN ActivityCategory END DESC,
			CASE WHEN @SortField = 'type' AND @SortDirection = 0 THEN ActivityTypeCode END DESC,
			CASE WHEN @SortField = 'description' AND @SortDirection = 0 THEN ActivityTypeDescription END DESC,
			CASE WHEN @SortField = 'actiondate' AND @SortDirection = 0 THEN ActivityDate END DESC,
			CASE WHEN @SortField = 'staffname' AND @SortDirection = 0 THEN lastName END DESC

	OFFSET IIF(@DoPageResult = 1, (@PageSize * (@PageNumber - 1)), 0)
	ROWS
	FETCH NEXT
        IIF(@DoPageResult = 1, @PageSize, 0x7ffffff)
	ROWS ONLY

	DROP TABLE #Existing;
	DROP TABLE #SiteIDList;

END
GO

-- Creating missing stored procedure: dbo.GetAvailableActivitiesForInspection
CREATE PROCEDURE [dbo].[GetAvailableActivitiesForInspection]
	@SiteIds NVARCHAR(1000) = '',
	@TargetTypeCode NVARCHAR(100) = '',
	@SortField NVARCHAR(100) = '',
	@SortDirection INT = 0,
	@DoPageResult INT = 0,
	@PageNumber INT = 1,
	@PageSize INT = 10
AS
DECLARE
	@NoOfMonthsToGetHistoricRecords INT = 36,
	@Today DATE,
	@siteIdList NVARCHAR(MAX),
	@validIds INT = 0;
BEGIN
	SET NOCOUNT ON;

	IF (@TargetTypeCode IS NULL OR LTRIM(RTRIM(@TargetTypeCode)) = '')
	BEGIN
		;THROW 51001, 'TargetTypeCode is mandatory to get the available activities list', 1;
	END
	ELSE
	BEGIN
		SET @TargetTypeCode = LOWER(LTRIM(RTRIM(@TargetTypeCode)));
	END

	SET @Today = CONVERT(DATE, GETDATE());
	--Get comma delimited values
	SET @siteIdList = REPLACE(@SiteIds, ' ', '');


	SELECT @validIds = COUNT(1) FROM STRING_SPLIT(@siteIdList, ',')  WHERE TRY_CONVERT(uniqueidentifier, value) IS NOT NULL;
	--Return error if count is <= 0
	IF (@validIds <= 0)
	BEGIN
		;THROW 51000, 'At least One valid SiteId is mandatory to get the available activities list', 1;
		RETURN;
	END

	--Convert values to uniqueidentifier and add to temp table
	SELECT value INTO #SiteIDList FROM STRING_SPLIT(@siteIdList, ',')  WHERE TRY_CONVERT(uniqueidentifier, value) IS NOT NULL

	IF(@SortField IS NULL OR (NULLIF(@SortField, '') IS NULL))
	BEGIN
		SET @SortField = 'actiondate';
	END
	ELSE
	BEGIN
		SET @SortField = LOWER(RTRIM(LTRIM(@SortField)));
	END

	IF (@PageSize IS NULL OR @PageSize <= 0)
	BEGIN
		SET @PageSize = 10;
	END

	IF (@PageNumber IS NULL OR @PageNumber <= 0)
	BEGIN
		SET @PageNumber = 1;
	END

	SELECT e.relatedActivityId, LOWER(activityTypeCode) AS activityTypeCode INTO #Existing FROM
	(
		SELECT relatedActivityId, activityTypeCode FROM SiteInspection s JOIN ActivityType AT ON s.relatedActivityTypeId = at.activityTypeId WHERE s.nextVersionId IS NULL AND s.isDeleted <> 1
		UNION
		SELECT relatedActivityId, activityTypeCode FROM Enforcement e JOIN ActivityType AT ON e.relatedActivityTypeId = at.activityTypeId  WHERE e.nextVersionId IS NULL AND e.isDeleted <> 1
		UNION
		SELECT relatedActivityId, activityTypeCode FROM SiteCorrespondence sc JOIN ActivityType AT ON sc.relatedActivityTypeId = at.activityTypeId AND sc.isDeleted <> 1
			JOIN Correspondence C ON sc.correspondenceId = C.correspondenceId AND c.isDeleted <> 1
	) e


	-- Create a table expression of all the available Related Activities of different categories
	;WITH Activities (SiteId, ActivityCategory, ActivityId, ActivityTypeCode, ActivityTypeDescription, StaffId, firstName, lastName, ActivityDate)
	AS
	(
		SELECT
			SI.SiteId,
			'Inspection'                                                          AS ActivityCategory,
			SI.siteInspectionIdentifier                                           AS ActivityId,
			ST.siteInspectionTypeCode                                                 AS ActivityTypeCode,
			ST.siteInspectionTypeDesc                                                 AS ActivityTypeDescription,
			E.staffId,
			E.firstName,
			E.lastName,
            IIF(SI.performedDate IS NOT NULL, SI.performedDate, SI.scheduledDate) AS ActivityDate
		FROM SiteInspection SI
			JOIN SiteInspectionType ST ON ST.siteInspectionTypeId = SI.siteInspectionTypeId AND ST.isDeleted <> 1 AND SI.isDeleted <> 1
			JOIN Staff E ON SI.issuingStaffId = E.StaffId AND E.isDeleted <> 1
		WHERE SI.nextVersionId IS NULL
			AND SI.siteId IN (SELECT * FROM #SiteIDList)
			AND (@TargetTypeCode NOT IN ('reinsp', 'repeat') OR
					-- Any other Inspection type
				(@TargetTypeCode = 'repeat' AND LOWER(ST.siteInspectionTypeCode) != 'reinsp') OR
					--IF the Inspection Type is REPEAT THEN system will provide option to link to INS with the exception of REINSP
				 (@TargetTypeCode = 'reinsp' AND LOWER(ST.siteInspectionTypeCode) = 'reinsp')
					--IF the Inspection Type is REINSP, THEN system will provide option to link to ENF or INS REINSP
				)
			AND (SI.performedDate IS NOT NULL) -- All performed inspections
			AND DATEADD(MONTH, @NoOfMonthsToGetHistoricRecords, SI.performedDate) > @Today --inspection performed in last 36 months
			AND SI.siteInspectionIdentifier NOT IN (SELECT relatedActivityId FROM #Existing WHERE activityTypeCode = 'ins') --- inspection not already linked

		UNION

		SELECT
			SE.SiteId,
			'Enforcement' AS ActivityCategory,
			En.enforcementId AS ActivityId,
			ET.enforcementTypeCode AS ActivityTypeCode,
			ET.enforcementTypeDesc AS ActivityTypeDescription,
			E.staffId,
			E.firstName,
			E.lastName,
			En.createdDt AS ActivityDate
		FROM Enforcement En
			JOIN EnforcementType ET ON En.enforcementTypeId = ET.enforcementTypeId AND En.isDeleted <> 1
			JOIN EnforcementEntity EE ON En.enforcementId = EE.enforcementId AND ee.isDeleted <> 1
			JOIN SiteEnforcementEntity SE ON EE.enforcementEntityId = SE.enforcementEntityId AND SE.isDeleted <> 1
			LEFT JOIN Staff E ON En.staffId = E.StaffId AND E.isDeleted <> 1
		WHERE En.isDeleted <> 1
			AND	En.nextVersionId IS NULL
			AND CAST(SE.siteId AS VARCHAR(100)) IN (SELECT * FROM #SiteIDList)
			AND @TargetTypeCode != 'repeat'	--- For Insepction type is repeat, only another inspection can be linked
			AND DATEADD(MONTH, @NoOfMonthsToGetHistoricRecords, En.createdDt) > @Today --Enforcements enforced in last 36 months
			AND En.enforcementId NOT IN (SELECT relatedActivityId FROM #Existing WHERE activityTypeCode = 'enf') --- enforcement not already linked

		UNION

		-- Correspondence
		SELECT
			SC.SiteId,
			'Correspondence' AS ActivityCategory,
			Cr.correspondenceId AS ActivityId,
			ST.siteCorrespondenceTypeCode AS ActivityTypeCode,
			ST.siteCorrespondenceTypeDesc AS ActivityTypeDescription,
			E.staffId,
			E.firstName,
			E.lastName,
			Cr.createdDt AS ActivityDate
		FROM Correspondence Cr
			JOIN SiteCorrespondence SC ON Cr.correspondenceId = SC.correspondenceId AND SC.isDeleted <> 1
			JOIN SiteCorrespondenceType ST ON SC.siteCorrespondenceTypeId = ST.siteCorrespondenceTypeId AND ST.isDeleted <> 1
			LEFT JOIN Staff E ON Cr.issuingStaffId = E.staffId AND E.isDeleted <> 1
		WHERE Cr.isDeleted <> 1
			AND CAST(SC.siteId AS VARCHAR(100)) IN (SELECT * FROM #SiteIDList)
			AND @TargetTypeCode NOT IN ('reinsp', 'repeat')
					--- For Insepction type is repeat, only another inspection can be linked
					--- For Insepction type is reinsp, only another inspection or enforcement can be linked
			AND Cr.createdDt IS NOT NULL -- Issued Site Correspondences
			AND DATEADD(MONTH, @NoOfMonthsToGetHistoricRecords, Cr.createdDt) > @Today --Site Correspondences issued in last 36 months
			AND Sc.correspondenceId NOT IN (SELECT relatedActivityId FROM #Existing WHERE activityTypeCode = 'cor') --- correspondence not already linked
			AND st.siteCorrespondenceTypeCode NOT IN ('ADJUST', 'BILL', 'CERTIF', 'NOTICE','REVIEW')
	)

	SELECT
		SiteId, ActivityCategory, ActivityId, ActivityTypeCode, ActivityTypeDescription, StaffId,
        CONCAT(IIF(NULLIF(lastName, '') IS NOT NULL, CONCAT(lastName, ', '), ''), firstName) AS StaffName,
		ActivityDate,
		COUNT(*) OVER()                                                                      AS FilteredCount
	FROM  Activities
	ORDER BY
			CASE WHEN @SortField = 'category' AND @SortDirection = 1 THEN ActivityCategory END,
			CASE WHEN @SortField = 'type' AND @SortDirection = 1 THEN ActivityTypeCode END,
			CASE WHEN @SortField = 'description' AND @SortDirection = 1 THEN ActivityTypeDescription END,
			CASE WHEN @SortField = 'actiondate' AND @SortDirection = 1 THEN ActivityDate END,
			CASE WHEN @SortField = 'staffname' AND @SortDirection = 1 THEN lastName END,
			--descending
			CASE WHEN @SortField = 'category' AND @SortDirection = 0 THEN ActivityCategory END DESC,
			CASE WHEN @SortField = 'type' AND @SortDirection = 0 THEN ActivityTypeCode END DESC,
			CASE WHEN @SortField = 'description' AND @SortDirection = 0 THEN ActivityTypeDescription END DESC,
			CASE WHEN @SortField = 'actiondate' AND @SortDirection = 0 THEN ActivityDate END DESC,
			CASE WHEN @SortField = 'staffname' AND @SortDirection = 0 THEN lastName END DESC

	OFFSET IIF(@DoPageResult = 1, (@PageSize * (@PageNumber - 1)), 0)
	ROWS
	FETCH NEXT
        IIF(@DoPageResult = 1, @PageSize, 0x7ffffff)
	ROWS ONLY

	DROP TABLE #Existing;
	DROP TABLE #SiteIDList;

END
GO