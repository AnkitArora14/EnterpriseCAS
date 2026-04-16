use EEA_CAS_Enterprise;

-- SQL script to update TEST schema based on DEV schema --

-- Creating missing table: dbo.ActorType
CREATE TABLE [dbo].[ActorType] (
    [actorTypeId] uniqueidentifier NOT NULL CONSTRAINT [DF_ActorType_actorTypeId] DEFAULT (newid()),
    [actorTypeCode] varchar(50) NOT NULL,
    [actorTypeName] varchar(50) NOT NULL,
    [actorTypeDesc] varchar(255) NULL,
    [isDeleted] bit NULL CONSTRAINT [DF_ActorType_isDeleted] DEFAULT ((0)),
    [createdDt] datetime2 NOT NULL CONSTRAINT [DF_ActorType_createdDt] DEFAULT (sysutcdatetime()),
    [createdBy] nvarchar(255) NOT NULL,
    [lastModifiedDt] datetime2 NULL,
    [lastModifiedBy] nvarchar(255) NULL,
    CONSTRAINT [PK_ActorType] PRIMARY KEY ([actorTypeId])
);
GO

-- Creating missing table: dbo.AddressType
CREATE TABLE [dbo].[AddressType] (
    [addressTypeId] uniqueidentifier NOT NULL CONSTRAINT [DF_AddressType_addressTypeId] DEFAULT (newid()),
    [addressTypeCode] varchar(50) NOT NULL,
    [addressTypeName] varchar(50) NOT NULL,
    [addressTypeDesc] varchar(255) NULL,
    [isDeleted] bit NULL CONSTRAINT [DF_AddressType_isDeleted] DEFAULT ((0)),
    [createdDt] datetime2 NOT NULL CONSTRAINT [DF_AddressType_createdDt] DEFAULT (sysutcdatetime()),
    [createdBy] nvarchar(255) NOT NULL,
    [lastModifiedDt] datetime2 NULL,
    [lastModifiedBy] nvarchar(255) NULL,
    CONSTRAINT [PK_AddressType] PRIMARY KEY ([addressTypeId])
);
GO

-- Creating missing table: dbo.Actor
CREATE TABLE [dbo].[Actor] (
    [actorId] uniqueidentifier NOT NULL CONSTRAINT [DF_Actor_actorId] DEFAULT (newid()),
    [actorAccountNumber] varchar(50) NULL,
    [actorName] varchar(255) NOT NULL,
    [actorDesc] varchar(255) NULL,
    [typeId] uniqueidentifier NOT NULL,
    [actorTinFein] varchar(50) NULL,
    [actorVendor] varchar(255) NULL,
    [actorEndDate] date NULL,
    [actorLocationId] int NULL,
    [addressId] uniqueidentifier NULL,
    [cityId] uniqueidentifier NULL,
    [stateId] uniqueidentifier NULL,
    [countryId] uniqueidentifier NULL,
    [postalCodeId] uniqueidentifier NULL,
    [addressName] varchar(255) NULL,
    [cityName] varchar(255) NULL,
    [stateName] varchar(255) NULL,
    [countryName] varchar(255) NULL,
    [postalCodeName] varchar(255) NULL,
    [addressTypeId] uniqueidentifier NULL,
    [actorContactNames] varchar(255) NULL,
    [isDeleted] bit NULL CONSTRAINT [DF_Actor_isDeleted] DEFAULT ((0)),
    [createdDt] datetime2 NOT NULL CONSTRAINT [DF_Actor_createdDt] DEFAULT (sysutcdatetime()),
    [createdBy] nvarchar(255) NOT NULL,
    [lastModifiedDt] datetime2 NULL,
    [lastModifiedBy] nvarchar(255) NULL,
    CONSTRAINT [PK_Actor] PRIMARY KEY ([actorId]),
    CONSTRAINT [FK_Actor_ActorType] FOREIGN KEY ([typeId]) REFERENCES [dbo].[ActorType] ([actorTypeId]),
    CONSTRAINT [FK_Actor_AddressType] FOREIGN KEY ([addressTypeId]) REFERENCES [dbo].[AddressType] ([addressTypeId])
);
GO

-- Creating missing table: dbo.ActorContact
CREATE TABLE [dbo].[ActorContact] (
    [actorContactId] uniqueidentifier NOT NULL CONSTRAINT [DF_ActorContact_actorContactId] DEFAULT (newid()),
    [actorId] uniqueidentifier NOT NULL,
    [actorContactName] varchar(255) NOT NULL,
    [actorContactDesc] varchar(255) NULL,
    [actorContactPhone] varchar(50) NULL,
    [actorContactEmail] varchar(255) NULL,
    [actorContactIsActive] bit NOT NULL CONSTRAINT [DF_ActorContact_actorContactIsActive] DEFAULT ((1)),
    [isDeleted] bit NULL CONSTRAINT [DF_ActorContact_isDeleted] DEFAULT ((0)),
    [createdDt] datetime2 NOT NULL CONSTRAINT [DF_ActorContact_createdDt] DEFAULT (sysutcdatetime()),
    [createdBy] nvarchar(255) NOT NULL,
    [lastModifiedDt] datetime2 NULL,
    [lastModifiedBy] nvarchar(255) NULL,
    CONSTRAINT [PK_ActorContact] PRIMARY KEY ([actorContactId]),
    CONSTRAINT [FK_ActorContact_Actor] FOREIGN KEY ([actorId]) REFERENCES [dbo].[Actor] ([actorId])
);
GO

-- Creating missing table: dbo.Avoided
CREATE TABLE [dbo].[Avoided] (
    [avoidedId] uniqueidentifier NOT NULL CONSTRAINT [DF_Avoided_avoidedId] DEFAULT (newid()),
    [avoidedCode] nvarchar(200) NOT NULL,
    [avoidedName] nvarchar(500) NOT NULL,
    [avoidedDesc] nvarchar(MAX) NULL,
    [isDeleted] bit NOT NULL CONSTRAINT [DF_Avoided_isDeleted] DEFAULT ((0)),
    [createdDt] datetime2 NOT NULL CONSTRAINT [DF_Avoided_createdDt] DEFAULT (sysutcdatetime()),
    [createdBy] nvarchar(255) NOT NULL,
    [lastModifiedDt] datetime2 NULL,
    [lastModifiedBy] nvarchar(255) NULL,
    CONSTRAINT [PK_Avoided] PRIMARY KEY ([avoidedId])
);
GO

-- Creating missing table: dbo.CaseStatus
CREATE TABLE [dbo].[CaseStatus] (
    [caseStatusId] uniqueidentifier NOT NULL CONSTRAINT [DF_CaseStatus_caseStatusId] DEFAULT (newid()),
    [caseStatusCode] varchar(50) NOT NULL,
    [caseStatusName] varchar(50) NOT NULL,
    [caseStatusDesc] varchar(255) NULL,
    [isDeleted] bit NULL CONSTRAINT [DF_CaseStatus_isDeleted] DEFAULT ((0)),
    [createdDt] datetime2 NOT NULL CONSTRAINT [DF_CaseStatus_createdDt] DEFAULT (sysutcdatetime()),
    [createdBy] nvarchar(255) NOT NULL,
    [lastModifiedDt] datetime2 NULL,
    [lastModifiedBy] nvarchar(255) NULL,
    CONSTRAINT [PK_CaseStatus] PRIMARY KEY ([caseStatusId])
);
GO

-- Creating missing table: dbo.MitigationReason
CREATE TABLE [dbo].[MitigationReason] (
    [mitigationReasonId] uniqueidentifier NOT NULL CONSTRAINT [DF_MitigationReason_mitigationReasonId] DEFAULT (newid()),
    [mitigationReasonCode] varchar(50) NOT NULL,
    [mitigationReasonName] varchar(255) NOT NULL,
    [mitigationReasonDesc] varchar(1000) NULL,
    [isDeleted] bit NOT NULL CONSTRAINT [DF_MitigationReason_isDeleted] DEFAULT ((0)),
    [createdDt] datetime2 NOT NULL CONSTRAINT [DF_MitigationReason_createdDt] DEFAULT (sysutcdatetime()),
    [createdBy] nvarchar(255) NOT NULL,
    [lastModifiedDt] datetime2 NULL,
    [lastModifiedBy] nvarchar(255) NULL,
    CONSTRAINT [PK_MitigationReason] PRIMARY KEY ([mitigationReasonId])
);
GO

-- Creating missing table: dbo.FeeComment
CREATE TABLE [dbo].[FeeComment] (
    [feeCommentId] uniqueidentifier NOT NULL CONSTRAINT [DF_FeeComment_feeCommentId] DEFAULT (newid()),
    [feeCommentCode] varchar(100) NOT NULL,
    [feeCommentName] varchar(500) NOT NULL,
    [feeCommentDesc] varchar(500) NULL,
    [isDeleted] bit NOT NULL CONSTRAINT [DF_FeeComment_isDeleted] DEFAULT ((0)),
    [createdDt] datetime2 NOT NULL CONSTRAINT [DF_FeeComment_createdDt] DEFAULT (sysutcdatetime()),
    [createdBy] nvarchar(255) NOT NULL,
    [lastModifiedDt] datetime2 NULL,
    [lastModifiedBy] nvarchar(255) NULL,
    CONSTRAINT [PK_FeeComment] PRIMARY KEY ([feeCommentId])
);
GO

-- Creating missing table: dbo.EnforcementDocType
CREATE TABLE [dbo].[EnforcementDocType] (
    [enforcementDocTypeId] uniqueidentifier NOT NULL CONSTRAINT [DF_EnforcementDocType_enforcementDocTypeId] DEFAULT (newid()),
    [enforcementDocTypeCode] nvarchar(50) NOT NULL,
    [enforcementDocTypeName] nvarchar(50) NULL,
    [enforcementDocTypeDesc] nvarchar(255) NULL,
    [isDeleted] bit NULL CONSTRAINT [DF_EnforcementDocType_isDeleted] DEFAULT ((0)),
    [createdBy] nvarchar(100) NOT NULL,
    [createdDt] datetime2 NOT NULL CONSTRAINT [DF_EnforcementDocType_createdDt] DEFAULT (sysutcdatetime()),
    [lastModifiedBy] nvarchar(100) NULL,
    [lastModifiedDt] datetime2 NULL,
    CONSTRAINT [PK_EnforcementDocType] PRIMARY KEY ([enforcementDocTypeId])
);
GO

-- Creating missing table: dbo.Case
CREATE TABLE [dbo].[Case] (
    [caseId] uniqueidentifier NOT NULL CONSTRAINT [DF_Case_caseId] DEFAULT (newid()),
    [caseName] varchar(255) NULL,
    [caseDesc] varchar(255) NULL,
    [caseStatusId] uniqueidentifier NOT NULL,
    [casePreparationDate] date NULL,
    [agencyId] uniqueidentifier NULL,
    [programId] uniqueidentifier NULL,
    [finalCalculatedPenalty] decimal(11, 2) NULL,
    [economicBenefit] decimal(11, 2) NULL,
    [suspended] decimal(11, 2) NULL,
    [sep] decimal(11, 2) NULL,
    [ems] decimal(11, 2) NULL,
    [cashAssessed] decimal(11, 2) NULL,
    [totalAlternativePenalties] decimal(11, 2) NULL,
    [enforcementDocType] varchar(100) NULL,
    [additionalComments] varchar(4000) NULL,
    [mitigationReasonId] uniqueidentifier NULL,
    [mitigationCommentId] uniqueidentifier NULL,
    [mitigationCommentOther] varchar(512) NULL,
    [rercDate] date NULL,
    [finalDateExecuted] date NULL,
    [tura] decimal(11, 2) NULL,
    [complianceFee] decimal(11, 2) NULL,
    [otherFees1] decimal(11, 2) NULL,
    [feeComment1Id] uniqueidentifier NULL,
    [feeComment1Other] varchar(512) NULL,
    [otherFees2] decimal(11, 2) NULL,
    [feeComment2Id] uniqueidentifier NULL,
    [feeComment2Other] varchar(512) NULL,
    [totalFees] decimal(11, 2) NULL,
    [isDeleted] bit NULL CONSTRAINT [DF_Case_isDeleted] DEFAULT ((0)),
    [createdDt] datetime2 NOT NULL CONSTRAINT [DF_Case_createdDt] DEFAULT (sysutcdatetime()),
    [createdBy] nvarchar(255) NOT NULL,
    [lastModifiedDt] datetime2 NULL,
    [lastModifiedBy] nvarchar(255) NULL,
    [bureauId] uniqueidentifier NULL,
    [enforcementDocTypeId] uniqueidentifier NULL,
    [siteId] uniqueidentifier NULL,
    [organizationId] uniqueidentifier NULL,
    [personId] uniqueidentifier NULL,
    CONSTRAINT [PK_Case] PRIMARY KEY ([caseId]),
    CONSTRAINT [FK_Case_CaseStatus] FOREIGN KEY ([caseStatusId]) REFERENCES [dbo].[CaseStatus] ([caseStatusId]),
    CONSTRAINT [FK_Case_MitigationReason] FOREIGN KEY ([mitigationReasonId]) REFERENCES [dbo].[MitigationReason] ([mitigationReasonId]),
    CONSTRAINT [FK_Case_FeeComment] FOREIGN KEY ([feeComment1Id]) REFERENCES [dbo].[FeeComment] ([feeCommentId]),
    CONSTRAINT [FK_Case_Case] FOREIGN KEY ([caseId]) REFERENCES [dbo].[Case] ([caseId]),
    CONSTRAINT [FK_Case_FeeComment] FOREIGN KEY ([feeComment2Id]) REFERENCES [dbo].[FeeComment] ([feeCommentId]),
    CONSTRAINT [FK_Case_BusinessUnit] FOREIGN KEY ([agencyId]) REFERENCES [dbo].[BusinessUnit] ([businessUnitId]),
    CONSTRAINT [FK_Case_BusinessUnit] FOREIGN KEY ([programId]) REFERENCES [dbo].[BusinessUnit] ([businessUnitId]),
    CONSTRAINT [FK_Case_BusinessUnit] FOREIGN KEY ([bureauId]) REFERENCES [dbo].[BusinessUnit] ([businessUnitId]),
    CONSTRAINT [FK_Case_EnforcementDocType] FOREIGN KEY ([enforcementDocTypeId]) REFERENCES [dbo].[EnforcementDocType] ([enforcementDocTypeId])
);
GO

-- Creating missing table: dbo.CaseStaffAssignment
CREATE TABLE [dbo].[CaseStaffAssignment] (
    [caseStaffAssignmentId] uniqueidentifier NOT NULL CONSTRAINT [DF_CaseStaffAssignment_caseStaffAssignmentId] DEFAULT (newid()),
    [caseId] uniqueidentifier NOT NULL,
    [staffRoleId] uniqueidentifier NOT NULL,
    [staffId] uniqueidentifier NOT NULL,
    [caseStaffAssignmentDesc] varchar(255) NULL,
    [isDeleted] bit NULL CONSTRAINT [DF_CaseStaffAssignment_isDeleted] DEFAULT ((0)),
    [createdDt] datetime2 NOT NULL CONSTRAINT [DF_CaseStaffAssignment_createdDt] DEFAULT (sysutcdatetime()),
    [createdBy] nvarchar(255) NOT NULL,
    [lastModifiedDt] datetime2 NULL,
    [lastModifiedBy] nvarchar(255) NULL,
    CONSTRAINT [PK_CaseStaffAssignment] PRIMARY KEY ([caseStaffAssignmentId]),
    CONSTRAINT [FK_CaseStaffAssignment_Case] FOREIGN KEY ([caseId]) REFERENCES [dbo].[Case] ([caseId]),
    CONSTRAINT [FK_CaseStaffAssignment_StaffRole] FOREIGN KEY ([staffRoleId]) REFERENCES [dbo].[StaffRole] ([staffRoleId])
);
GO

-- Creating missing table: dbo.PotentialImpact
CREATE TABLE [dbo].[PotentialImpact] (
    [potentialImpactId] uniqueidentifier NOT NULL CONSTRAINT [DF_PotentialImpact_potentialImpactId] DEFAULT (newid()),
    [potentialImpactCode] nvarchar(100) NOT NULL,
    [potentialImpactName] nvarchar(200) NOT NULL,
    [potentialImpactDesc] nvarchar(512) NULL,
    [isDeleted] bit NOT NULL CONSTRAINT [DF_PotentialImpact_isDeleted] DEFAULT ((0)),
    [createdDt] datetime2 NOT NULL CONSTRAINT [DF_PotentialImpact_createdDt] DEFAULT (sysutcdatetime()),
    [createdBy] nvarchar(255) NOT NULL,
    [lastModifiedDt] datetime2 NULL,
    [lastModifiedBy] nvarchar(255) NULL,
    CONSTRAINT [PK_PotentialImpact] PRIMARY KEY ([potentialImpactId])
);
GO

-- Creating missing table: dbo.PotentialDamage
CREATE TABLE [dbo].[PotentialDamage] (
    [potentialDamageId] uniqueidentifier NOT NULL CONSTRAINT [DF_PotentialDamage_potentialDamageId] DEFAULT (newid()),
    [potentialDamageCode] nvarchar(100) NOT NULL,
    [potentialDamageName] nvarchar(200) NOT NULL,
    [potentialDamageDesc] nvarchar(512) NULL,
    [isDeleted] bit NOT NULL CONSTRAINT [DF_PotentialDamage_isDeleted] DEFAULT ((0)),
    [createdDt] datetime2 NOT NULL CONSTRAINT [DF_PotentialDamage_createdDt] DEFAULT (sysutcdatetime()),
    [createdBy] nvarchar(255) NOT NULL,
    [lastModifiedDt] datetime2 NULL,
    [lastModifiedBy] nvarchar(255) NULL,
    CONSTRAINT [PK_PotentialDamage] PRIMARY KEY ([potentialDamageId])
);
GO

-- Creating missing table: dbo.PreviousFailureToComply
CREATE TABLE [dbo].[PreviousFailureToComply] (
    [previousFailureToComplyId] uniqueidentifier NOT NULL CONSTRAINT [DF_PreviousFailureToComply_previousFailureToComplyId] DEFAULT (newid()),
    [previousFailureToComplyCode] nvarchar(200) NOT NULL,
    [previousFailureToComplyName] nvarchar(500) NOT NULL,
    [previousFailureToComplyDesc] nvarchar(MAX) NULL,
    [isDeleted] bit NOT NULL CONSTRAINT [DF_PreviousFailureToComply_isDeleted] DEFAULT ((0)),
    [createdDt] datetime2 NOT NULL CONSTRAINT [DF_PreviousFailureToComply_createdDt] DEFAULT (sysutcdatetime()),
    [createdBy] nvarchar(255) NOT NULL,
    [lastModifiedDt] datetime2 NULL,
    [lastModifiedBy] nvarchar(255) NULL,
    CONSTRAINT [PK_PreviousFailureToComply] PRIMARY KEY ([previousFailureToComplyId])
);
GO

-- Creating missing table: dbo.StepsToPrevent
CREATE TABLE [dbo].[StepsToPrevent] (
    [stepsToPreventId] uniqueidentifier NOT NULL CONSTRAINT [DF_StepsToPrevent_stepsToPreventId] DEFAULT (newid()),
    [stepsToPreventCode] nvarchar(200) NOT NULL,
    [stepsToPreventName] nvarchar(500) NOT NULL,
    [stepsToPreventDesc] nvarchar(MAX) NULL,
    [isDeleted] bit NOT NULL CONSTRAINT [DF_StepsToPrevent_isDeleted] DEFAULT ((0)),
    [createdDt] datetime2 NOT NULL CONSTRAINT [DF_StepsToPrevent_createdDt] DEFAULT (sysutcdatetime()),
    [createdBy] nvarchar(255) NOT NULL,
    [lastModifiedDt] datetime2 NULL,
    [lastModifiedBy] nvarchar(255) NULL,
    CONSTRAINT [PK_StepsToPrevent] PRIMARY KEY ([stepsToPreventId])
);
GO

-- Creating missing table: dbo.StepsToRTC
CREATE TABLE [dbo].[StepsToRTC] (
    [stepsToRTCId] uniqueidentifier NOT NULL CONSTRAINT [DF_StepsToRTC_stepsToRTCId] DEFAULT (newid()),
    [stepsToRTCCode] nvarchar(200) NOT NULL,
    [stepsToRTCName] nvarchar(500) NOT NULL,
    [stepsToRTCDesc] nvarchar(MAX) NULL,
    [isDeleted] bit NOT NULL CONSTRAINT [DF_StepsToRTC_isDeleted] DEFAULT ((0)),
    [createdDt] datetime2 NOT NULL CONSTRAINT [DF_StepsToRTC_createdDt] DEFAULT (sysutcdatetime()),
    [createdBy] nvarchar(255) NOT NULL,
    [lastModifiedDt] datetime2 NULL,
    [lastModifiedBy] nvarchar(255) NULL,
    CONSTRAINT [PK_StepsToRTC] PRIMARY KEY ([stepsToRTCId])
);
GO

-- Creating missing table: dbo.RemedyAndMitigate
CREATE TABLE [dbo].[RemedyAndMitigate] (
    [remedyAndMitigateId] uniqueidentifier NOT NULL CONSTRAINT [DF_RemedyAndMitigate_remedyAndMitigateId] DEFAULT (newid()),
    [remedyAndMitigateCode] nvarchar(200) NOT NULL,
    [remedyAndMitigateName] nvarchar(500) NOT NULL,
    [remedyAndMitigateDesc] nvarchar(MAX) NULL,
    [isDeleted] bit NOT NULL CONSTRAINT [DF_RemedyAndMitigate_isDeleted] DEFAULT ((0)),
    [createdDt] datetime2 NOT NULL CONSTRAINT [DF_RemedyAndMitigate_createdDt] DEFAULT (sysutcdatetime()),
    [createdBy] nvarchar(255) NOT NULL,
    [lastModifiedDt] datetime2 NULL,
    [lastModifiedBy] nvarchar(255) NULL,
    CONSTRAINT [PK_RemedyAndMitigate] PRIMARY KEY ([remedyAndMitigateId])
);
GO

-- Creating missing table: dbo.PersonAssessed
CREATE TABLE [dbo].[PersonAssessed] (
    [personAssessedId] uniqueidentifier NOT NULL CONSTRAINT [DF_PersonAssessed_personAssessedId] DEFAULT (newid()),
    [personAssessedCode] nvarchar(200) NOT NULL,
    [personAssessedName] nvarchar(500) NOT NULL,
    [personAssessedDesc] nvarchar(MAX) NULL,
    [isDeleted] bit NOT NULL CONSTRAINT [DF_PersonAssessed_isDeleted] DEFAULT ((0)),
    [createdDt] datetime2 NOT NULL CONSTRAINT [DF_PersonAssessed_createdDt] DEFAULT (sysutcdatetime()),
    [createdBy] nvarchar(255) NOT NULL,
    [lastModifiedDt] datetime2 NULL,
    [lastModifiedBy] nvarchar(255) NULL,
    CONSTRAINT [PK_PersonAssessed] PRIMARY KEY ([personAssessedId])
);
GO

-- Creating missing table: dbo.OtherPersonAssessed
CREATE TABLE [dbo].[OtherPersonAssessed] (
    [otherPersonAssessedId] uniqueidentifier NOT NULL CONSTRAINT [DF_OtherPersonAssessed_otherPersonAssessedId] DEFAULT (newid()),
    [otherPersonAssessedCode] nvarchar(200) NOT NULL,
    [otherPersonAssessedName] nvarchar(500) NOT NULL,
    [otherPersonAssessedDesc] nvarchar(MAX) NULL,
    [isDeleted] bit NOT NULL CONSTRAINT [DF_OtherPersonAssessed_isDeleted] DEFAULT ((0)),
    [createdDt] datetime2 NOT NULL CONSTRAINT [DF_OtherPersonAssessed_createdDt] DEFAULT (sysutcdatetime()),
    [createdBy] nvarchar(255) NOT NULL,
    [lastModifiedDt] datetime2 NULL,
    [lastModifiedBy] nvarchar(255) NULL,
    CONSTRAINT [PK_OtherPersonAssessed] PRIMARY KEY ([otherPersonAssessedId])
);
GO

-- Creating missing table: dbo.FinancialCondition
CREATE TABLE [dbo].[FinancialCondition] (
    [financialConditionId] uniqueidentifier NOT NULL CONSTRAINT [DF_FinancialCondition_financialConditionId] DEFAULT (newid()),
    [financialConditionCode] nvarchar(200) NOT NULL,
    [financialConditionName] nvarchar(500) NOT NULL,
    [financialConditionDesc] nvarchar(MAX) NULL,
    [isDeleted] bit NOT NULL CONSTRAINT [DF_FinancialCondition_isDeleted] DEFAULT ((0)),
    [createdDt] datetime2 NOT NULL CONSTRAINT [DF_FinancialCondition_createdDt] DEFAULT (sysutcdatetime()),
    [createdBy] nvarchar(255) NOT NULL,
    [lastModifiedDt] datetime2 NULL,
    [lastModifiedBy] nvarchar(255) NULL,
    CONSTRAINT [PK_FinancialCondition] PRIMARY KEY ([financialConditionId])
);
GO

-- Creating missing table: dbo.PublicInterest
CREATE TABLE [dbo].[PublicInterest] (
    [publicInterestId] uniqueidentifier NOT NULL CONSTRAINT [DF_PublicInterest_publicInterestId] DEFAULT (newid()),
    [publicInterestCode] nvarchar(200) NOT NULL,
    [publicInterestName] nvarchar(500) NOT NULL,
    [publicInterestDesc] nvarchar(MAX) NULL,
    [isDeleted] bit NOT NULL CONSTRAINT [DF_PublicInterest_isDeleted] DEFAULT ((0)),
    [createdDt] datetime2 NOT NULL CONSTRAINT [DF_PublicInterest_createdDt] DEFAULT (sysutcdatetime()),
    [createdBy] nvarchar(255) NOT NULL,
    [lastModifiedDt] datetime2 NULL,
    [lastModifiedBy] nvarchar(255) NULL,
    CONSTRAINT [PK_PublicInterest] PRIMARY KEY ([publicInterestId])
);
GO

-- Creating missing table: dbo.OtherFactor
CREATE TABLE [dbo].[OtherFactor] (
    [otherFactorId] uniqueidentifier NOT NULL CONSTRAINT [DF_OtherFactor_otherFactorId] DEFAULT (newid()),
    [otherFactorCode] nvarchar(200) NOT NULL,
    [otherFactorName] nvarchar(500) NOT NULL,
    [otherFactorDesc] nvarchar(MAX) NULL,
    [isDeleted] bit NOT NULL CONSTRAINT [DF_OtherFactor_isDeleted] DEFAULT ((0)),
    [createdDt] datetime2 NOT NULL CONSTRAINT [DF_OtherFactor_createdDt] DEFAULT (sysutcdatetime()),
    [createdBy] nvarchar(255) NOT NULL,
    [lastModifiedDt] datetime2 NULL,
    [lastModifiedBy] nvarchar(255) NULL,
    CONSTRAINT [PK_OtherFactor] PRIMARY KEY ([otherFactorId])
);
GO

-- Creating missing table: dbo.Delayed
CREATE TABLE [dbo].[Delayed] (
    [delayedId] uniqueidentifier NOT NULL CONSTRAINT [DF_Delayed_delayedId] DEFAULT (newid()),
    [delayedCode] nvarchar(200) NOT NULL,
    [delayedName] nvarchar(500) NOT NULL,
    [delayedDesc] nvarchar(MAX) NULL,
    [isDeleted] bit NOT NULL CONSTRAINT [DF_Delayed_isDeleted] DEFAULT ((0)),
    [createdDt] datetime2 NOT NULL CONSTRAINT [DF_Delayed_createdDt] DEFAULT (sysutcdatetime()),
    [createdBy] nvarchar(255) NOT NULL,
    [lastModifiedDt] datetime2 NULL,
    [lastModifiedBy] nvarchar(255) NULL,
    CONSTRAINT [PK_Delayed] PRIMARY KEY ([delayedId])
);
GO

-- Creating missing table: dbo.Profit
CREATE TABLE [dbo].[Profit] (
    [profitId] uniqueidentifier NOT NULL CONSTRAINT [DF_Profit_profitId] DEFAULT (newid()),
    [profitCode] nvarchar(200) NOT NULL,
    [profitName] nvarchar(500) NOT NULL,
    [profitDesc] nvarchar(MAX) NULL,
    [isDeleted] bit NOT NULL CONSTRAINT [DF_Profit_isDeleted] DEFAULT ((0)),
    [createdDt] datetime2 NOT NULL CONSTRAINT [DF_Profit_createdDt] DEFAULT (sysutcdatetime()),
    [createdBy] nvarchar(255) NOT NULL,
    [lastModifiedDt] datetime2 NULL,
    [lastModifiedBy] nvarchar(255) NULL,
    CONSTRAINT [PK_Profit] PRIMARY KEY ([profitId])
);
GO

-- Creating missing table: dbo.CaseViolation
CREATE TABLE [dbo].[CaseViolation] (
    [caseViolationId] uniqueidentifier NOT NULL,
    [caseId] uniqueidentifier NOT NULL,
    [citationId] uniqueidentifier NULL,
    [fromDate] date NULL,
    [toDate] date NULL,
    [priorNONDetails] nvarchar(MAX) NULL,
    [gravityDescription] nvarchar(MAX) NULL,
    [impactNumber] int NULL,
    [potentialImpactId] uniqueidentifier NULL,
    [potentialImpactOther] nvarchar(MAX) NULL,
    [potentialDamageId] uniqueidentifier NULL,
    [potentialDamageOther] nvarchar(MAX) NULL,
    [previousNonCompliance] decimal(11, 2) NULL,
    [lackOfGoodFaithOrGoodFaithEffort] decimal(11, 2) NULL,
    [financialConsideration] decimal(11, 2) NULL,
    [publicInterest] decimal(11, 2) NULL,
    [otherFactors] decimal(11, 2) NULL,
    [previousFailureToComplyId] uniqueidentifier NULL,
    [previousFailureToComplyOther] nvarchar(MAX) NULL,
    [stepsToPreventId] uniqueidentifier NULL,
    [stepsToPreventOther] nvarchar(MAX) NULL,
    [stepsToRTCId] uniqueidentifier NULL,
    [stepsToRTCOther] nvarchar(MAX) NULL,
    [remedyAndMitigateId] uniqueidentifier NULL,
    [remedyAndMitigateOther] nvarchar(MAX) NULL,
    [personAssessedId] uniqueidentifier NULL,
    [personAssessedOther] nvarchar(MAX) NULL,
    [otherPersonAssessedId] uniqueidentifier NULL,
    [otherPersonAssessedOther] nvarchar(MAX) NULL,
    [financialConditionId] uniqueidentifier NULL,
    [financialConditionOther] nvarchar(MAX) NULL,
    [publicInterestId] uniqueidentifier NULL,
    [publicInterestOther] nvarchar(MAX) NULL,
    [otherFactorId] uniqueidentifier NULL,
    [otherFactorOther] nvarchar(MAX) NULL,
    [totalAdditionalRegulatoryFactors] decimal(11, 2) NULL,
    [gravityTimesTotalAdditionalRegulatoryFactorsPlusGravity] decimal(11, 2) NULL,
    [maximumDailyPenaltyAllowedByStatute] decimal(11, 2) NULL,
    [totalAdjustedPenaltyOrMaxDailyPenaltyIfSmaller] decimal(11, 2) NULL,
    [numberOfDaysOfViolation] int NULL,
    [comments] nvarchar(MAX) NULL,
    [economicBenefit] decimal(11, 2) NULL,
    [delayedId] uniqueidentifier NULL,
    [delayedOther] nvarchar(MAX) NULL,
    [avoidedId] uniqueidentifier NULL,
    [avoidedOther] nvarchar(MAX) NULL,
    [profitId] uniqueidentifier NULL,
    [profitOther] nvarchar(MAX) NULL,
    [totalPenaltyPerViolation] decimal(11, 2) NULL,
    [totalCalculatedPenalty] decimal(11, 2) NULL,
    [isDeleted] bit NULL CONSTRAINT [DF_CaseViolation_isDeleted] DEFAULT ((0)),
    [createdBy] nvarchar(255) NOT NULL,
    [createdDt] datetime2 NOT NULL CONSTRAINT [DF_CaseViolation_createdDt] DEFAULT (sysutcdatetime()),
    [lastModifiedBy] nvarchar(255) NULL,
    [lastModifiedDt] datetime2 NULL,
    CONSTRAINT [PK_CaseViolation] PRIMARY KEY ([caseViolationId]),
    CONSTRAINT [FK_CaseViolation_Case] FOREIGN KEY ([caseId]) REFERENCES [dbo].[Case] ([caseId]),
    CONSTRAINT [FK_CaseViolation_Citation] FOREIGN KEY ([citationId]) REFERENCES [dbo].[Citation] ([citationId]),
    CONSTRAINT [FK_CaseViolation_PotentialImpact] FOREIGN KEY ([potentialImpactId]) REFERENCES [dbo].[PotentialImpact] ([potentialImpactId]),
    CONSTRAINT [FK_CaseViolation_PotentialDamage] FOREIGN KEY ([potentialDamageId]) REFERENCES [dbo].[PotentialDamage] ([potentialDamageId]),
    CONSTRAINT [FK_CaseViolation_PreviousFailureToComply] FOREIGN KEY ([previousFailureToComplyId]) REFERENCES [dbo].[PreviousFailureToComply] ([previousFailureToComplyId]),
    CONSTRAINT [FK_CaseViolation_StepsToPrevent] FOREIGN KEY ([stepsToPreventId]) REFERENCES [dbo].[StepsToPrevent] ([stepsToPreventId]),
    CONSTRAINT [FK_CaseViolation_StepsToRTC] FOREIGN KEY ([stepsToRTCId]) REFERENCES [dbo].[StepsToRTC] ([stepsToRTCId]),
    CONSTRAINT [FK_CaseViolation_RemedyAndMitigate] FOREIGN KEY ([remedyAndMitigateId]) REFERENCES [dbo].[RemedyAndMitigate] ([remedyAndMitigateId]),
    CONSTRAINT [FK_CaseViolation_PersonAssessed] FOREIGN KEY ([personAssessedId]) REFERENCES [dbo].[PersonAssessed] ([personAssessedId]),
    CONSTRAINT [FK_CaseViolation_OtherPersonAssessed] FOREIGN KEY ([otherPersonAssessedId]) REFERENCES [dbo].[OtherPersonAssessed] ([otherPersonAssessedId]),
    CONSTRAINT [FK_CaseViolation_FinancialCondition] FOREIGN KEY ([financialConditionId]) REFERENCES [dbo].[FinancialCondition] ([financialConditionId]),
    CONSTRAINT [FK_CaseViolation_PublicInterest] FOREIGN KEY ([publicInterestId]) REFERENCES [dbo].[PublicInterest] ([publicInterestId]),
    CONSTRAINT [FK_CaseViolation_OtherFactor] FOREIGN KEY ([otherFactorId]) REFERENCES [dbo].[OtherFactor] ([otherFactorId]),
    CONSTRAINT [FK_CaseViolation_Delayed] FOREIGN KEY ([delayedId]) REFERENCES [dbo].[Delayed] ([delayedId]),
    CONSTRAINT [FK_CaseViolation_Avoided] FOREIGN KEY ([avoidedId]) REFERENCES [dbo].[Avoided] ([avoidedId]),
    CONSTRAINT [FK_CaseViolation_Profit] FOREIGN KEY ([profitId]) REFERENCES [dbo].[Profit] ([profitId])
);
GO

-- Creating missing table: dbo.PreCondition
CREATE TABLE [dbo].[PreCondition] (
    [preConditionId] uniqueidentifier NOT NULL CONSTRAINT [DF_PreCondition_preConditionId] DEFAULT (newid()),
    [preConditionCode] varchar(50) NULL,
    [preConditionName] varchar(500) NOT NULL,
    [parentPreConditionId] uniqueidentifier NULL,
    [isDeleted] bit NOT NULL CONSTRAINT [DF_PreCondition_isDeleted] DEFAULT ((0)),
    [createdDt] datetime2 NOT NULL CONSTRAINT [DF_PreCondition_createdDt] DEFAULT (sysutcdatetime()),
    [createdBy] nvarchar(255) NOT NULL,
    [lastModifiedDt] datetime2 NULL,
    [lastModifiedBy] nvarchar(255) NULL,
    [preConditionDesc] nvarchar(500) NULL,
    CONSTRAINT [PK_PreCondition] PRIMARY KEY ([preConditionId])
);
GO

-- Creating missing table: dbo.CaseViolationPreCondition
CREATE TABLE [dbo].[CaseViolationPreCondition] (
    [caseViolationPreConditionId] uniqueidentifier NOT NULL,
    [caseViolationId] uniqueidentifier NOT NULL,
    [preConditionId] uniqueidentifier NOT NULL,
    [isDeleted] bit NULL CONSTRAINT [DF_CaseViolationPreCondition_isDeleted] DEFAULT ((0)),
    [createdBy] nvarchar(255) NOT NULL,
    [createdDt] datetime2 NOT NULL CONSTRAINT [DF_CaseViolationPreCondition_createdDt] DEFAULT (sysutcdatetime()),
    [lastModifiedBy] nvarchar(255) NULL,
    [lastModifiedDt] datetime2 NULL,
    CONSTRAINT [PK_CaseViolationPreCondition] PRIMARY KEY ([caseViolationPreConditionId]),
    CONSTRAINT [FK_CaseViolationPreCondition_CaseViolation] FOREIGN KEY ([caseViolationId]) REFERENCES [dbo].[CaseViolation] ([caseViolationId]),
    CONSTRAINT [FK_CaseViolationPreCondition_PreCondition] FOREIGN KEY ([preConditionId]) REFERENCES [dbo].[PreCondition] ([preConditionId])
);
GO

-- Creating missing table: dbo.MitigationComment
CREATE TABLE [dbo].[MitigationComment] (
    [mitigationCommentId] uniqueidentifier NOT NULL CONSTRAINT [DF_MitigationComment_mitigationCommentId] DEFAULT (newid()),
    [mitigationCommentCode] varchar(100) NOT NULL,
    [mitigationCommentName] varchar(1000) NOT NULL,
    [mitigationCommentDesc] varchar(2000) NULL,
    [isDeleted] bit NOT NULL CONSTRAINT [DF_MitigationComment_isDeleted] DEFAULT ((0)),
    [createdDt] datetime2 NOT NULL CONSTRAINT [DF_MitigationComment_createdDt] DEFAULT (sysutcdatetime()),
    [createdBy] nvarchar(255) NOT NULL,
    [lastModifiedDt] datetime2 NULL,
    [lastModifiedBy] nvarchar(255) NULL,
    CONSTRAINT [PK_MitigationComment] PRIMARY KEY ([mitigationCommentId])
);
GO

-- Creating missing table: dbo.ROType
CREATE TABLE [dbo].[ROType] (
    [roTypeId] uniqueidentifier NOT NULL CONSTRAINT [DF_ROType_roTypeId] DEFAULT (newid()),
    [roTypeCode] varchar(50) NOT NULL,
    [roTypeName] varchar(50) NOT NULL,
    [roTypeDesc] varchar(255) NULL,
    [isDeleted] bit NULL CONSTRAINT [DF_ROType_isDeleted] DEFAULT ((0)),
    [createdDt] datetime2 NOT NULL CONSTRAINT [DF_ROType_createdDt] DEFAULT (sysutcdatetime()),
    [createdBy] nvarchar(255) NOT NULL,
    [lastModifiedDt] datetime2 NULL,
    [lastModifiedBy] nvarchar(255) NULL,
    CONSTRAINT [PK_ROType] PRIMARY KEY ([roTypeId])
);
GO

-- Creating missing table: dbo.ROStatus
CREATE TABLE [dbo].[ROStatus] (
    [roStatusId] uniqueidentifier NOT NULL CONSTRAINT [DF_ROStatus_roStatusId] DEFAULT (newid()),
    [roStatusCode] varchar(50) NOT NULL,
    [roStatusName] varchar(50) NOT NULL,
    [roStatusDesc] varchar(255) NULL,
    [isDeleted] bit NULL CONSTRAINT [DF_ROStatus_isDeleted] DEFAULT ((0)),
    [createdDt] datetime2 NOT NULL CONSTRAINT [DF_ROStatus_createdDt] DEFAULT (sysutcdatetime()),
    [createdBy] nvarchar(255) NOT NULL,
    [lastModifiedDt] datetime2 NULL,
    [lastModifiedBy] nvarchar(255) NULL,
    CONSTRAINT [PK_ROStatus] PRIMARY KEY ([roStatusId])
);
GO

-- Creating missing table: dbo.RO
CREATE TABLE [dbo].[RO] (
    [roId] uniqueidentifier NOT NULL CONSTRAINT [DF_RO_roId] DEFAULT (newid()),
    [roAccountNumber] varchar(50) NOT NULL,
    [roSiteAccountNumber] varchar(20) NULL,
    [roProgramId] varchar(50) NULL,
    [roSiteName] varchar(255) NOT NULL,
    [roDesc] varchar(255) NULL,
    [roTypeId] uniqueidentifier NULL,
    [roStatusId] uniqueidentifier NULL,
    [roEndDate] date NULL,
    [addressId] uniqueidentifier NULL,
    [cityId] uniqueidentifier NULL,
    [stateId] uniqueidentifier NULL,
    [countryId] uniqueidentifier NULL,
    [postalCodeId] uniqueidentifier NULL,
    [addressName] varchar(255) NULL,
    [cityName] varchar(255) NULL,
    [stateName] varchar(255) NULL,
    [countryName] varchar(255) NULL,
    [postalCodeName] varchar(255) NULL,
    [addressTypeId] uniqueidentifier NULL,
    [isDeleted] bit NULL CONSTRAINT [DF_RO_isDeleted] DEFAULT ((0)),
    [createdDt] datetime2 NOT NULL CONSTRAINT [DF_RO_createdDt] DEFAULT (sysutcdatetime()),
    [createdBy] nvarchar(255) NOT NULL,
    [lastModifiedDt] datetime2 NULL,
    [lastModifiedBy] nvarchar(255) NULL,
    CONSTRAINT [PK_RO] PRIMARY KEY ([roId]),
    CONSTRAINT [FK_RO_ROType] FOREIGN KEY ([roTypeId]) REFERENCES [dbo].[ROType] ([roTypeId]),
    CONSTRAINT [FK_RO_ROStatus] FOREIGN KEY ([roStatusId]) REFERENCES [dbo].[ROStatus] ([roStatusId]),
    CONSTRAINT [FK_RO_AddressType] FOREIGN KEY ([addressTypeId]) REFERENCES [dbo].[AddressType] ([addressTypeId])
);
GO

-- Dropping existing default constraint for activityTypeId in dbo.ActivityType
ALTER TABLE [dbo].[ActivityType] DROP CONSTRAINT [DF__ActivityT__activ__236943A5];
GO

-- Adding/Updating default constraint for activityTypeId in dbo.ActivityType
ALTER TABLE [dbo].[ActivityType] ADD CONSTRAINT [DF_ActivityType_activityTypeId] DEFAULT (newid()) FOR [activityTypeId];
GO

-- Dropping existing default constraint for isDeleted in dbo.ActivityType
ALTER TABLE [dbo].[ActivityType] DROP CONSTRAINT [DF__ActivityT__isDel__245D67DE];
GO

-- Adding/Updating default constraint for isDeleted in dbo.ActivityType
ALTER TABLE [dbo].[ActivityType] ADD CONSTRAINT [DF_ActivityType_isDeleted] DEFAULT ((0)) FOR [isDeleted];
GO

-- Dropping existing default constraint for createdDt in dbo.ActivityType
ALTER TABLE [dbo].[ActivityType] DROP CONSTRAINT [DF__ActivityT__creat__25518C17];
GO

-- Adding/Updating default constraint for createdDt in dbo.ActivityType
ALTER TABLE [dbo].[ActivityType] ADD CONSTRAINT [DF_ActivityType_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Dropping existing default constraint for appId in dbo.App
ALTER TABLE [dbo].[App] DROP CONSTRAINT [DF_App];
GO

-- Adding/Updating default constraint for appId in dbo.App
ALTER TABLE [dbo].[App] ADD CONSTRAINT [DF_App_appId] DEFAULT (newid()) FOR [appId];
GO

-- Dropping existing default constraint for appToken in dbo.App
ALTER TABLE [dbo].[App] DROP CONSTRAINT [DF_App_appToken];
GO

-- Adding/Updating default constraint for appToken in dbo.App
ALTER TABLE [dbo].[App] ADD CONSTRAINT [DF_App_appToken] DEFAULT (newid()) FOR [appToken];
GO

-- Dropping existing default constraint for isDeleted in dbo.App
ALTER TABLE [dbo].[App] DROP CONSTRAINT [DF__App__isDeleted__282DF8C2];
GO

-- Adding/Updating default constraint for isDeleted in dbo.App
ALTER TABLE [dbo].[App] ADD CONSTRAINT [DF_App_isDeleted] DEFAULT ((0)) FOR [isDeleted];
GO

-- Adding/Updating default constraint for createdDt in dbo.App
ALTER TABLE [dbo].[App] ADD CONSTRAINT [DF_App_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Updating primary key: PK__App__C00006D58DFC335B to PK_App in dbo.App
ALTER TABLE [dbo].[App] DROP CONSTRAINT [PK__App__C00006D58DFC335B];
ALTER TABLE [dbo].[App] ADD CONSTRAINT [PK_App] PRIMARY KEY ([appId]);
GO

-- Dropping existing default constraint for appAppDataSharedApiId in dbo.AppAppDataSharedApi
ALTER TABLE [dbo].[AppAppDataSharedApi] DROP CONSTRAINT [DF_AppAppDataSharedApi];
GO

-- Adding/Updating default constraint for appAppDataSharedApiId in dbo.AppAppDataSharedApi
ALTER TABLE [dbo].[AppAppDataSharedApi] ADD CONSTRAINT [DF_AppAppDataSharedApi_appAppDataSharedApiId] DEFAULT (newid()) FOR [appAppDataSharedApiId];
GO

-- Dropping existing default constraint for canRead in dbo.AppAppDataSharedApi
ALTER TABLE [dbo].[AppAppDataSharedApi] DROP CONSTRAINT [DF__AppAppDataSharedApi__canRead];
GO

-- Adding/Updating default constraint for canRead in dbo.AppAppDataSharedApi
ALTER TABLE [dbo].[AppAppDataSharedApi] ADD CONSTRAINT [DF_AppAppDataSharedApi_canRead] DEFAULT ((0)) FOR [canRead];
GO

-- Dropping existing default constraint for canWrite in dbo.AppAppDataSharedApi
ALTER TABLE [dbo].[AppAppDataSharedApi] DROP CONSTRAINT [DF__AppAppDataSharedApi__canWrite];
GO

-- Adding/Updating default constraint for canWrite in dbo.AppAppDataSharedApi
ALTER TABLE [dbo].[AppAppDataSharedApi] ADD CONSTRAINT [DF_AppAppDataSharedApi_canWrite] DEFAULT ((0)) FOR [canWrite];
GO

-- Dropping existing default constraint for canDelete in dbo.AppAppDataSharedApi
ALTER TABLE [dbo].[AppAppDataSharedApi] DROP CONSTRAINT [DF__AppAppDataSharedApi__canDelete];
GO

-- Adding/Updating default constraint for canDelete in dbo.AppAppDataSharedApi
ALTER TABLE [dbo].[AppAppDataSharedApi] ADD CONSTRAINT [DF_AppAppDataSharedApi_canDelete] DEFAULT ((0)) FOR [canDelete];
GO

-- Dropping existing default constraint for isDeleted in dbo.AppAppDataSharedApi
ALTER TABLE [dbo].[AppAppDataSharedApi] DROP CONSTRAINT [DF__AppAppDat__isDel__2CF2ADDF];
GO

-- Adding/Updating default constraint for isDeleted in dbo.AppAppDataSharedApi
ALTER TABLE [dbo].[AppAppDataSharedApi] ADD CONSTRAINT [DF_AppAppDataSharedApi_isDeleted] DEFAULT ((0)) FOR [isDeleted];
GO

-- Adding/Updating default constraint for createdDt in dbo.AppAppDataSharedApi
ALTER TABLE [dbo].[AppAppDataSharedApi] ADD CONSTRAINT [DF_AppAppDataSharedApi_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Updating primary key: PK__AppAppDa__F79210CD85E22E6F to PK_AppAppDataSharedApi in dbo.AppAppDataSharedApi
ALTER TABLE [dbo].[AppAppDataSharedApi] DROP CONSTRAINT [PK__AppAppDa__F79210CD85E22E6F];
ALTER TABLE [dbo].[AppAppDataSharedApi] ADD CONSTRAINT [PK_AppAppDataSharedApi] PRIMARY KEY ([appAppDataSharedApiId]);
GO

-- Renaming foreign key: FK__AppAppDataSharedApi__App to FK_AppAppDataSharedApi_App in dbo.AppAppDataSharedApi
ALTER TABLE [dbo].[AppAppDataSharedApi] DROP CONSTRAINT [FK__AppAppDataSharedApi__App];
ALTER TABLE [dbo].[AppAppDataSharedApi] ADD CONSTRAINT [FK_AppAppDataSharedApi_App] FOREIGN KEY ([appId]) REFERENCES [dbo].[App] ([appId]);
GO

-- Renaming foreign key: FK__AppAppDataSharedApi__AppData to FK_AppAppDataSharedApi_AppData in dbo.AppAppDataSharedApi
ALTER TABLE [dbo].[AppAppDataSharedApi] DROP CONSTRAINT [FK__AppAppDataSharedApi__AppData];
ALTER TABLE [dbo].[AppAppDataSharedApi] ADD CONSTRAINT [FK_AppAppDataSharedApi_AppData] FOREIGN KEY ([appDataId]) REFERENCES [dbo].[AppData] ([appDataId]);
GO

-- Renaming foreign key: FK__AppAppDataSharedApi__SharedApi to FK_AppAppDataSharedApi_SharedApi in dbo.AppAppDataSharedApi
ALTER TABLE [dbo].[AppAppDataSharedApi] DROP CONSTRAINT [FK__AppAppDataSharedApi__SharedApi];
ALTER TABLE [dbo].[AppAppDataSharedApi] ADD CONSTRAINT [FK_AppAppDataSharedApi_SharedApi] FOREIGN KEY ([sharedApiId]) REFERENCES [dbo].[SharedApi] ([sharedApiId]);
GO

-- Dropping existing default constraint for appDataId in dbo.AppData
ALTER TABLE [dbo].[AppData] DROP CONSTRAINT [DF_AppData];
GO

-- Adding/Updating default constraint for appDataId in dbo.AppData
ALTER TABLE [dbo].[AppData] ADD CONSTRAINT [DF_AppData_appDataId] DEFAULT (newid()) FOR [appDataId];
GO

-- Dropping existing default constraint for appDataToken in dbo.AppData
ALTER TABLE [dbo].[AppData] DROP CONSTRAINT [DF_AppData_appDataToken];
GO

-- Adding/Updating default constraint for appDataToken in dbo.AppData
ALTER TABLE [dbo].[AppData] ADD CONSTRAINT [DF_AppData_appDataToken] DEFAULT (newid()) FOR [appDataToken];
GO

-- Dropping existing default constraint for isDeleted in dbo.AppData
ALTER TABLE [dbo].[AppData] DROP CONSTRAINT [DF__AppData__isDelet__2FCF1A8A];
GO

-- Adding/Updating default constraint for isDeleted in dbo.AppData
ALTER TABLE [dbo].[AppData] ADD CONSTRAINT [DF_AppData_isDeleted] DEFAULT ((0)) FOR [isDeleted];
GO

-- Adding/Updating default constraint for createdDt in dbo.AppData
ALTER TABLE [dbo].[AppData] ADD CONSTRAINT [DF_AppData_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Updating primary key: PK__AppData__D9893DB30D03C937 to PK_AppData in dbo.AppData
ALTER TABLE [dbo].[AppData] DROP CONSTRAINT [PK__AppData__D9893DB30D03C937];
ALTER TABLE [dbo].[AppData] ADD CONSTRAINT [PK_AppData] PRIMARY KEY ([appDataId]);
GO

-- Dropping existing default constraint for appDataBusinessUnitId in dbo.AppDataBusinessUnit
ALTER TABLE [dbo].[AppDataBusinessUnit] DROP CONSTRAINT [DF_AppBusinessUnit_appBusinessUnitId];
GO

-- Adding/Updating default constraint for appDataBusinessUnitId in dbo.AppDataBusinessUnit
ALTER TABLE [dbo].[AppDataBusinessUnit] ADD CONSTRAINT [DF_AppDataBusinessUnit_appDataBusinessUnitId] DEFAULT (newid()) FOR [appDataBusinessUnitId];
GO

-- Dropping existing default constraint for createdDt in dbo.AppDataBusinessUnit
ALTER TABLE [dbo].[AppDataBusinessUnit] DROP CONSTRAINT [DF__AppDataBu__creat__31B762FC];
GO

-- Adding/Updating default constraint for createdDt in dbo.AppDataBusinessUnit
ALTER TABLE [dbo].[AppDataBusinessUnit] ADD CONSTRAINT [DF_AppDataBusinessUnit_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Updating primary key: PK_AppBusinessUnit to PK_AppDataBusinessUnit in dbo.AppDataBusinessUnit
ALTER TABLE [dbo].[AppDataBusinessUnit] DROP CONSTRAINT [PK_AppBusinessUnit];
ALTER TABLE [dbo].[AppDataBusinessUnit] ADD CONSTRAINT [PK_AppDataBusinessUnit] PRIMARY KEY ([appDataBusinessUnitId]);
GO

-- Renaming foreign key: FK_AppBusinessUnit_BusinessUnit to FK_AppDataBusinessUnit_BusinessUnit in dbo.AppDataBusinessUnit
ALTER TABLE [dbo].[AppDataBusinessUnit] DROP CONSTRAINT [FK_AppBusinessUnit_BusinessUnit];
ALTER TABLE [dbo].[AppDataBusinessUnit] ADD CONSTRAINT [FK_AppDataBusinessUnit_BusinessUnit] FOREIGN KEY ([businessUnitId]) REFERENCES [dbo].[BusinessUnit] ([businessUnitId]);
GO

-- Dropping existing default constraint for appDataCitationId in dbo.AppDataCitation
ALTER TABLE [dbo].[AppDataCitation] DROP CONSTRAINT [DF_AppCitation_appCitationId];
GO

-- Adding/Updating default constraint for appDataCitationId in dbo.AppDataCitation
ALTER TABLE [dbo].[AppDataCitation] ADD CONSTRAINT [DF_AppDataCitation_appDataCitationId] DEFAULT (newid()) FOR [appDataCitationId];
GO

-- Dropping existing default constraint for createdDt in dbo.AppDataCitation
ALTER TABLE [dbo].[AppDataCitation] DROP CONSTRAINT [DF__AppDataCi__creat__339FAB6E];
GO

-- Adding/Updating default constraint for createdDt in dbo.AppDataCitation
ALTER TABLE [dbo].[AppDataCitation] ADD CONSTRAINT [DF_AppDataCitation_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Updating primary key: PK_AppCitation to PK_AppDataCitation in dbo.AppDataCitation
ALTER TABLE [dbo].[AppDataCitation] DROP CONSTRAINT [PK_AppCitation];
ALTER TABLE [dbo].[AppDataCitation] ADD CONSTRAINT [PK_AppDataCitation] PRIMARY KEY ([appDataCitationId]);
GO

-- Renaming foreign key: FK_AppCitation_Citation to FK_AppDataCitation_Citation in dbo.AppDataCitation
ALTER TABLE [dbo].[AppDataCitation] DROP CONSTRAINT [FK_AppCitation_Citation];
ALTER TABLE [dbo].[AppDataCitation] ADD CONSTRAINT [FK_AppDataCitation_Citation] FOREIGN KEY ([citationId]) REFERENCES [dbo].[Citation] ([citationId]);
GO

-- Dropping existing default constraint for appDataEnforcementId in dbo.AppDataEnforcement
ALTER TABLE [dbo].[AppDataEnforcement] DROP CONSTRAINT [DF_AppEnforcement_appEnforcementId];
GO

-- Adding/Updating default constraint for appDataEnforcementId in dbo.AppDataEnforcement
ALTER TABLE [dbo].[AppDataEnforcement] ADD CONSTRAINT [DF_AppDataEnforcement_appDataEnforcementId] DEFAULT (newid()) FOR [appDataEnforcementId];
GO

-- Dropping existing default constraint for createdDt in dbo.AppDataEnforcement
ALTER TABLE [dbo].[AppDataEnforcement] DROP CONSTRAINT [DF__AppDataEn__creat__3587F3E0];
GO

-- Adding/Updating default constraint for createdDt in dbo.AppDataEnforcement
ALTER TABLE [dbo].[AppDataEnforcement] ADD CONSTRAINT [DF_AppDataEnforcement_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Updating primary key: PK_AppEnforcement to PK_AppDataEnforcement in dbo.AppDataEnforcement
ALTER TABLE [dbo].[AppDataEnforcement] DROP CONSTRAINT [PK_AppEnforcement];
ALTER TABLE [dbo].[AppDataEnforcement] ADD CONSTRAINT [PK_AppDataEnforcement] PRIMARY KEY ([appDataEnforcementId]);
GO

-- Dropping existing default constraint for associatedProgramId in dbo.AssociatedProgram
ALTER TABLE [dbo].[AssociatedProgram] DROP CONSTRAINT [DF__Associate__assoc__367C1819];
GO

-- Adding/Updating default constraint for associatedProgramId in dbo.AssociatedProgram
ALTER TABLE [dbo].[AssociatedProgram] ADD CONSTRAINT [DF_AssociatedProgram_associatedProgramId] DEFAULT (newid()) FOR [associatedProgramId];
GO

-- Dropping existing default constraint for isDeleted in dbo.AssociatedProgram
ALTER TABLE [dbo].[AssociatedProgram] DROP CONSTRAINT [DF__Associate__isDel__37703C52];
GO

-- Adding/Updating default constraint for isDeleted in dbo.AssociatedProgram
ALTER TABLE [dbo].[AssociatedProgram] ADD CONSTRAINT [DF_AssociatedProgram_isDeleted] DEFAULT ((0)) FOR [isDeleted];
GO

-- Dropping existing default constraint for createdDt in dbo.AssociatedProgram
ALTER TABLE [dbo].[AssociatedProgram] DROP CONSTRAINT [DF__Associate__creat__3864608B];
GO

-- Adding/Updating default constraint for createdDt in dbo.AssociatedProgram
ALTER TABLE [dbo].[AssociatedProgram] ADD CONSTRAINT [DF_AssociatedProgram_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Dropping existing default constraint for branchId in dbo.Branch
ALTER TABLE [dbo].[Branch] DROP CONSTRAINT [DF_Branch_branchId];
GO

-- Adding/Updating default constraint for branchId in dbo.Branch
ALTER TABLE [dbo].[Branch] ADD CONSTRAINT [DF_Branch_branchId] DEFAULT (newid()) FOR [branchId];
GO

-- Dropping existing default constraint for isDeleted in dbo.Branch
ALTER TABLE [dbo].[Branch] DROP CONSTRAINT [DF_Branch_isDeleted];
GO

-- Adding/Updating default constraint for isDeleted in dbo.Branch
ALTER TABLE [dbo].[Branch] ADD CONSTRAINT [DF_Branch_isDeleted] DEFAULT ((0)) FOR [isDeleted];
GO

-- Dropping existing default constraint for createdDt in dbo.Branch
ALTER TABLE [dbo].[Branch] DROP CONSTRAINT [DF_Branch_createdDt];
GO

-- Adding/Updating default constraint for createdDt in dbo.Branch
ALTER TABLE [dbo].[Branch] ADD CONSTRAINT [DF_Branch_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Dropping existing default constraint for businessUnitId in dbo.BusinessUnit
ALTER TABLE [dbo].[BusinessUnit] DROP CONSTRAINT [DF__BusinessU__busin__3C34F16F];
GO

-- Adding/Updating default constraint for businessUnitId in dbo.BusinessUnit
ALTER TABLE [dbo].[BusinessUnit] ADD CONSTRAINT [DF_BusinessUnit_businessUnitId] DEFAULT (newid()) FOR [businessUnitId];
GO

-- Dropping existing default constraint for isDeleted in dbo.BusinessUnit
ALTER TABLE [dbo].[BusinessUnit] DROP CONSTRAINT [DF__BusinessU__isDel__3D2915A8];
GO

-- Adding/Updating default constraint for isDeleted in dbo.BusinessUnit
ALTER TABLE [dbo].[BusinessUnit] ADD CONSTRAINT [DF_BusinessUnit_isDeleted] DEFAULT ((0)) FOR [isDeleted];
GO

-- Dropping existing default constraint for createdDt in dbo.BusinessUnit
ALTER TABLE [dbo].[BusinessUnit] DROP CONSTRAINT [DF__BusinessU__creat__3E1D39E1];
GO

-- Adding/Updating default constraint for createdDt in dbo.BusinessUnit
ALTER TABLE [dbo].[BusinessUnit] ADD CONSTRAINT [DF_BusinessUnit_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Dropping existing default constraint for businessUnitAssociatedProgramId in dbo.BusinessUnitAssociatedProgram
ALTER TABLE [dbo].[BusinessUnitAssociatedProgram] DROP CONSTRAINT [DF_BusinessUnitAssociatedProgram_businessUnitAssociatedProgramId];
GO

-- Adding/Updating default constraint for businessUnitAssociatedProgramId in dbo.BusinessUnitAssociatedProgram
ALTER TABLE [dbo].[BusinessUnitAssociatedProgram] ADD CONSTRAINT [DF_BusinessUnitAssociatedProgram_businessUnitAssociatedProgramId] DEFAULT (newid()) FOR [businessUnitAssociatedProgramId];
GO

-- Dropping existing default constraint for isDeleted in dbo.BusinessUnitAssociatedProgram
ALTER TABLE [dbo].[BusinessUnitAssociatedProgram] DROP CONSTRAINT [DF__BusinessU__isDel__40058253];
GO

-- Adding/Updating default constraint for isDeleted in dbo.BusinessUnitAssociatedProgram
ALTER TABLE [dbo].[BusinessUnitAssociatedProgram] ADD CONSTRAINT [DF_BusinessUnitAssociatedProgram_isDeleted] DEFAULT ((0)) FOR [isDeleted];
GO

-- Dropping existing default constraint for createdDt in dbo.BusinessUnitAssociatedProgram
ALTER TABLE [dbo].[BusinessUnitAssociatedProgram] DROP CONSTRAINT [DF__BusinessU__creat__40F9A68C];
GO

-- Adding/Updating default constraint for createdDt in dbo.BusinessUnitAssociatedProgram
ALTER TABLE [dbo].[BusinessUnitAssociatedProgram] ADD CONSTRAINT [DF_BusinessUnitAssociatedProgram_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Updating primary key: PK_BusinessUnitAssociation to PK_BusinessUnitAssociatedProgram in dbo.BusinessUnitAssociatedProgram
ALTER TABLE [dbo].[BusinessUnitAssociatedProgram] DROP CONSTRAINT [PK_BusinessUnitAssociation];
ALTER TABLE [dbo].[BusinessUnitAssociatedProgram] ADD CONSTRAINT [PK_BusinessUnitAssociatedProgram] PRIMARY KEY ([businessUnitAssociatedProgramId]);
GO

-- Dropping existing default constraint for businessUnitCategoryId in dbo.BusinessUnitCategory
ALTER TABLE [dbo].[BusinessUnitCategory] DROP CONSTRAINT [DF_BusinessUnitCategory_businessUnitCategoryId];
GO

-- Adding/Updating default constraint for businessUnitCategoryId in dbo.BusinessUnitCategory
ALTER TABLE [dbo].[BusinessUnitCategory] ADD CONSTRAINT [DF_BusinessUnitCategory_businessUnitCategoryId] DEFAULT (newid()) FOR [businessUnitCategoryId];
GO

-- Adding/Updating default constraint for createdDt in dbo.BusinessUnitCategory
ALTER TABLE [dbo].[BusinessUnitCategory] ADD CONSTRAINT [DF_BusinessUnitCategory_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Adding/Updating default constraint for createdDt in dbo.BusinessUnitType
ALTER TABLE [dbo].[BusinessUnitType] ADD CONSTRAINT [DF_BusinessUnitType_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Updating primary key: PK__BusinessUnitType to PK_BusinessUnitType in dbo.BusinessUnitType
ALTER TABLE [dbo].[BusinessUnitType] DROP CONSTRAINT [PK__BusinessUnitType];
ALTER TABLE [dbo].[BusinessUnitType] ADD CONSTRAINT [PK_BusinessUnitType] PRIMARY KEY ([businessUnitTypeId]);
GO

-- Adding missing column: bureauId to dbo.Citation
ALTER TABLE [dbo].[Citation] ADD [bureauId] uniqueidentifier NULL;
GO

-- Dropping existing default constraint for citationId in dbo.Citation
ALTER TABLE [dbo].[Citation] DROP CONSTRAINT [DF__Citation__citati__2A164134];
GO

-- Adding/Updating default constraint for citationId in dbo.Citation
ALTER TABLE [dbo].[Citation] ADD CONSTRAINT [DF_Citation_citationId] DEFAULT (newid()) FOR [citationId];
GO

-- Dropping existing default constraint for createdDt in dbo.Citation
ALTER TABLE [dbo].[Citation] DROP CONSTRAINT [DF_Citation_createdDt];
GO

-- Adding/Updating default constraint for createdDt in dbo.Citation
ALTER TABLE [dbo].[Citation] ADD CONSTRAINT [DF_Citation_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Updating primary key: PK__Citation__EC6E99C7A84A2DDE to PK_Citation in dbo.Citation
ALTER TABLE [dbo].[Citation] DROP CONSTRAINT [PK__Citation__EC6E99C7A84A2DDE];
ALTER TABLE [dbo].[Citation] ADD CONSTRAINT [PK_Citation] PRIMARY KEY ([citationId]);
GO

-- Dropping existing default constraint for citationAssociatedProgramId in dbo.CitationAssociatedProgram
ALTER TABLE [dbo].[CitationAssociatedProgram] DROP CONSTRAINT [DF_CitationAssociatedProgram_citationAssociatedProgramId];
GO

-- Adding/Updating default constraint for citationAssociatedProgramId in dbo.CitationAssociatedProgram
ALTER TABLE [dbo].[CitationAssociatedProgram] ADD CONSTRAINT [DF_CitationAssociatedProgram_citationAssociatedProgramId] DEFAULT (newid()) FOR [citationAssociatedProgramId];
GO

-- Dropping existing default constraint for isDeleted in dbo.CitationAssociatedProgram
ALTER TABLE [dbo].[CitationAssociatedProgram] DROP CONSTRAINT [DF_citationAssociatedProgram_isDeleted];
GO

-- Adding/Updating default constraint for isDeleted in dbo.CitationAssociatedProgram
ALTER TABLE [dbo].[CitationAssociatedProgram] ADD CONSTRAINT [DF_CitationAssociatedProgram_isDeleted] DEFAULT ((0)) FOR [isDeleted];
GO

-- Dropping existing default constraint for createdDt in dbo.CitationAssociatedProgram
ALTER TABLE [dbo].[CitationAssociatedProgram] DROP CONSTRAINT [DF_citationAssociatedProgram_createdDt];
GO

-- Adding/Updating default constraint for createdDt in dbo.CitationAssociatedProgram
ALTER TABLE [dbo].[CitationAssociatedProgram] ADD CONSTRAINT [DF_CitationAssociatedProgram_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Updating primary key: PK_citationAssociatedProgram to PK_CitationAssociatedProgram in dbo.CitationAssociatedProgram
ALTER TABLE [dbo].[CitationAssociatedProgram] DROP CONSTRAINT [PK_citationAssociatedProgram];
ALTER TABLE [dbo].[CitationAssociatedProgram] ADD CONSTRAINT [PK_CitationAssociatedProgram] PRIMARY KEY ([citationAssociatedProgramId]);
GO

-- Renaming foreign key: FK_citationAssociatedProgram_Citation to FK_CitationAssociatedProgram_Citation in dbo.CitationAssociatedProgram
ALTER TABLE [dbo].[CitationAssociatedProgram] DROP CONSTRAINT [FK_citationAssociatedProgram_Citation];
ALTER TABLE [dbo].[CitationAssociatedProgram] ADD CONSTRAINT [FK_CitationAssociatedProgram_Citation] FOREIGN KEY ([citationId]) REFERENCES [dbo].[Citation] ([citationId]);
GO

-- Renaming foreign key: FK_citationAssociatedProgram_AssociatedProgram to FK_CitationAssociatedProgram_AssociatedProgram in dbo.CitationAssociatedProgram
ALTER TABLE [dbo].[CitationAssociatedProgram] DROP CONSTRAINT [FK_citationAssociatedProgram_AssociatedProgram];
ALTER TABLE [dbo].[CitationAssociatedProgram] ADD CONSTRAINT [FK_CitationAssociatedProgram_AssociatedProgram] FOREIGN KEY ([associatedProgramId]) REFERENCES [dbo].[AssociatedProgram] ([associatedProgramId]);
GO

-- Dropping existing default constraint for citationClassId in dbo.CitationClass
ALTER TABLE [dbo].[CitationClass] DROP CONSTRAINT [DF_CitationClass_citationClassId];
GO

-- Adding/Updating default constraint for citationClassId in dbo.CitationClass
ALTER TABLE [dbo].[CitationClass] ADD CONSTRAINT [DF_CitationClass_citationClassId] DEFAULT (newid()) FOR [citationClassId];
GO

-- Dropping existing default constraint for createdDt in dbo.CitationClass
ALTER TABLE [dbo].[CitationClass] DROP CONSTRAINT [DF_CitationClass_createdDt_1];
GO

-- Adding/Updating default constraint for createdDt in dbo.CitationClass
ALTER TABLE [dbo].[CitationClass] ADD CONSTRAINT [DF_CitationClass_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Updating primary key: PK__Citation__E73D8710A98051B3 to PK_CitationClass in dbo.CitationClass
ALTER TABLE [dbo].[CitationClass] DROP CONSTRAINT [PK__Citation__E73D8710A98051B3];
ALTER TABLE [dbo].[CitationClass] ADD CONSTRAINT [PK_CitationClass] PRIMARY KEY ([citationClassId]);
GO

-- Dropping existing default constraint for citationLinkId in dbo.CitationLink
ALTER TABLE [dbo].[CitationLink] DROP CONSTRAINT [DF__CitationL__citat__498EEC8D];
GO

-- Adding/Updating default constraint for citationLinkId in dbo.CitationLink
ALTER TABLE [dbo].[CitationLink] ADD CONSTRAINT [DF_CitationLink_citationLinkId] DEFAULT (newid()) FOR [citationLinkId];
GO

-- Adding/Updating default constraint for createdDt in dbo.CitationLink
ALTER TABLE [dbo].[CitationLink] ADD CONSTRAINT [DF_CitationLink_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Updating primary key: PK__Citation__4A5A4870E36C1985 to PK_CitationLink in dbo.CitationLink
ALTER TABLE [dbo].[CitationLink] DROP CONSTRAINT [PK__Citation__4A5A4870E36C1985];
ALTER TABLE [dbo].[CitationLink] ADD CONSTRAINT [PK_CitationLink] PRIMARY KEY ([citationLinkId]);
GO

-- Dropping existing default constraint for citationPenaltyId in dbo.CitationPenalty
ALTER TABLE [dbo].[CitationPenalty] DROP CONSTRAINT [DF_CitationPenalty_citationPenaltyId];
GO

-- Adding/Updating default constraint for citationPenaltyId in dbo.CitationPenalty
ALTER TABLE [dbo].[CitationPenalty] ADD CONSTRAINT [DF_CitationPenalty_citationPenaltyId] DEFAULT (newid()) FOR [citationPenaltyId];
GO

-- Adding/Updating default constraint for createdDt in dbo.CitationPenalty
ALTER TABLE [dbo].[CitationPenalty] ADD CONSTRAINT [DF_CitationPenalty_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Adding/Updating default constraint for createdDt in dbo.CitationReportType
ALTER TABLE [dbo].[CitationReportType] ADD CONSTRAINT [DF_CitationReportType_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Adding/Updating default constraint for createdDt in dbo.CitationSequence
ALTER TABLE [dbo].[CitationSequence] ADD CONSTRAINT [DF_CitationSequence_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Adding/Updating default constraint for createdDt in dbo.CitationStatus
ALTER TABLE [dbo].[CitationStatus] ADD CONSTRAINT [DF_CitationStatus_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Dropping existing default constraint for citationStatuteId in dbo.CitationStatute
ALTER TABLE [dbo].[CitationStatute] DROP CONSTRAINT [DF_CitationStatute_new_CitationStatuteId];
GO

-- Adding/Updating default constraint for citationStatuteId in dbo.CitationStatute
ALTER TABLE [dbo].[CitationStatute] ADD CONSTRAINT [DF_CitationStatute_citationStatuteId] DEFAULT (newid()) FOR [citationStatuteId];
GO

-- Dropping existing default constraint for createdDt in dbo.CitationStatute
ALTER TABLE [dbo].[CitationStatute] DROP CONSTRAINT [DF_CitationStatute_new_createdDt];
GO

-- Adding/Updating default constraint for createdDt in dbo.CitationStatute
ALTER TABLE [dbo].[CitationStatute] ADD CONSTRAINT [DF_CitationStatute_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Dropping existing default constraint for classificationId in dbo.Classification
ALTER TABLE [dbo].[Classification] DROP CONSTRAINT [DF__Classific__class__4D5F7D71];
GO

-- Adding/Updating default constraint for classificationId in dbo.Classification
ALTER TABLE [dbo].[Classification] ADD CONSTRAINT [DF_Classification_classificationId] DEFAULT (newid()) FOR [classificationId];
GO

-- Dropping existing default constraint for isDeleted in dbo.Classification
ALTER TABLE [dbo].[Classification] DROP CONSTRAINT [DF__Classific__isDel__4E53A1AA];
GO

-- Adding/Updating default constraint for isDeleted in dbo.Classification
ALTER TABLE [dbo].[Classification] ADD CONSTRAINT [DF_Classification_isDeleted] DEFAULT ((0)) FOR [isDeleted];
GO

-- Dropping existing default constraint for createdDt in dbo.Classification
ALTER TABLE [dbo].[Classification] DROP CONSTRAINT [DF__Classific__creat__4F47C5E3];
GO

-- Adding/Updating default constraint for createdDt in dbo.Classification
ALTER TABLE [dbo].[Classification] ADD CONSTRAINT [DF_Classification_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Dropping existing default constraint for correspondenceId in dbo.Correspondence
ALTER TABLE [dbo].[Correspondence] DROP CONSTRAINT [DF__Correspon__corre__503BEA1C];
GO

-- Adding/Updating default constraint for correspondenceId in dbo.Correspondence
ALTER TABLE [dbo].[Correspondence] ADD CONSTRAINT [DF_Correspondence_correspondenceId] DEFAULT (newid()) FOR [correspondenceId];
GO

-- Dropping existing default constraint for isDeleted in dbo.Correspondence
ALTER TABLE [dbo].[Correspondence] DROP CONSTRAINT [DF__Correspon__isDel__51300E55];
GO

-- Adding/Updating default constraint for isDeleted in dbo.Correspondence
ALTER TABLE [dbo].[Correspondence] ADD CONSTRAINT [DF_Correspondence_isDeleted] DEFAULT ((0)) FOR [isDeleted];
GO

-- Dropping existing default constraint for createdDt in dbo.Correspondence
ALTER TABLE [dbo].[Correspondence] DROP CONSTRAINT [DF__Correspon__creat__5224328E];
GO

-- Adding/Updating default constraint for createdDt in dbo.Correspondence
ALTER TABLE [dbo].[Correspondence] ADD CONSTRAINT [DF_Correspondence_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Adding missing column: entityTypeName to dbo.Enforcement
ALTER TABLE [dbo].[Enforcement] ADD [entityTypeName] nvarchar(255) NULL;
GO

-- Dropping existing default constraint for enforcementId in dbo.Enforcement
ALTER TABLE [dbo].[Enforcement] DROP CONSTRAINT [DF_Enforcement_enforcementId];
GO

-- Adding/Updating default constraint for enforcementId in dbo.Enforcement
ALTER TABLE [dbo].[Enforcement] ADD CONSTRAINT [DF_Enforcement_enforcementId] DEFAULT (newid()) FOR [enforcementId];
GO

-- Dropping existing default constraint for isDeleted in dbo.Enforcement
ALTER TABLE [dbo].[Enforcement] DROP CONSTRAINT [DF_Enforcement_isDeleted];
GO

-- Adding/Updating default constraint for isDeleted in dbo.Enforcement
ALTER TABLE [dbo].[Enforcement] ADD CONSTRAINT [DF_Enforcement_isDeleted] DEFAULT ((0)) FOR [isDeleted];
GO

-- Dropping existing default constraint for createdDt in dbo.Enforcement
ALTER TABLE [dbo].[Enforcement] DROP CONSTRAINT [DF_Enforcement_createdDt];
GO

-- Adding/Updating default constraint for createdDt in dbo.Enforcement
ALTER TABLE [dbo].[Enforcement] ADD CONSTRAINT [DF_Enforcement_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Renaming foreign key: FK_Enforcement_BusinessUnit_Agency to FK_Enforcement_BusinessUnit in dbo.Enforcement
ALTER TABLE [dbo].[Enforcement] DROP CONSTRAINT [FK_Enforcement_BusinessUnit_Agency];
ALTER TABLE [dbo].[Enforcement] ADD CONSTRAINT [FK_Enforcement_BusinessUnit] FOREIGN KEY ([agencyId]) REFERENCES [dbo].[BusinessUnit] ([businessUnitId]);
GO

-- Renaming foreign key: FK_Enforcement_BusinessUnit_Program to FK_Enforcement_BusinessUnit in dbo.Enforcement
ALTER TABLE [dbo].[Enforcement] DROP CONSTRAINT [FK_Enforcement_BusinessUnit_Program];
ALTER TABLE [dbo].[Enforcement] ADD CONSTRAINT [FK_Enforcement_BusinessUnit] FOREIGN KEY ([programId]) REFERENCES [dbo].[BusinessUnit] ([businessUnitId]);
GO

-- Dropping existing default constraint for enforcementCategoryId in dbo.EnforcementCategory
ALTER TABLE [dbo].[EnforcementCategory] DROP CONSTRAINT [DF_EnforcementCategory_enforcementCategoryId];
GO

-- Adding/Updating default constraint for enforcementCategoryId in dbo.EnforcementCategory
ALTER TABLE [dbo].[EnforcementCategory] ADD CONSTRAINT [DF_EnforcementCategory_enforcementCategoryId] DEFAULT (newid()) FOR [enforcementCategoryId];
GO

-- Dropping existing default constraint for isDeleted in dbo.EnforcementCategory
ALTER TABLE [dbo].[EnforcementCategory] DROP CONSTRAINT [DF_EnforcementCategory_isDeleted];
GO

-- Adding/Updating default constraint for isDeleted in dbo.EnforcementCategory
ALTER TABLE [dbo].[EnforcementCategory] ADD CONSTRAINT [DF_EnforcementCategory_isDeleted] DEFAULT ((0)) FOR [isDeleted];
GO

-- Dropping existing default constraint for createdDt in dbo.EnforcementCategory
ALTER TABLE [dbo].[EnforcementCategory] DROP CONSTRAINT [DF_EnforcementCategory_createdDt];
GO

-- Adding/Updating default constraint for createdDt in dbo.EnforcementCategory
ALTER TABLE [dbo].[EnforcementCategory] ADD CONSTRAINT [DF_EnforcementCategory_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Dropping existing default constraint for enforcementClassificationId in dbo.EnforcementClassification
ALTER TABLE [dbo].[EnforcementClassification] DROP CONSTRAINT [DF_EnforcementClassification_enforcementClassificationId];
GO

-- Adding/Updating default constraint for enforcementClassificationId in dbo.EnforcementClassification
ALTER TABLE [dbo].[EnforcementClassification] ADD CONSTRAINT [DF_EnforcementClassification_enforcementClassificationId] DEFAULT (newid()) FOR [enforcementClassificationId];
GO

-- Dropping existing default constraint for isDeleted in dbo.EnforcementClassification
ALTER TABLE [dbo].[EnforcementClassification] DROP CONSTRAINT [DF_EnforcementClassification_isDeleted];
GO

-- Adding/Updating default constraint for isDeleted in dbo.EnforcementClassification
ALTER TABLE [dbo].[EnforcementClassification] ADD CONSTRAINT [DF_EnforcementClassification_isDeleted] DEFAULT ((0)) FOR [isDeleted];
GO

-- Dropping existing default constraint for createdDt in dbo.EnforcementClassification
ALTER TABLE [dbo].[EnforcementClassification] DROP CONSTRAINT [DF_EnforcementClassification_createdDt];
GO

-- Adding/Updating default constraint for createdDt in dbo.EnforcementClassification
ALTER TABLE [dbo].[EnforcementClassification] ADD CONSTRAINT [DF_EnforcementClassification_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Dropping existing default constraint for enforcementEntityId in dbo.EnforcementEntity
ALTER TABLE [dbo].[EnforcementEntity] DROP CONSTRAINT [DF__Enforceme__enfor__5BAD9CC8];
GO

-- Adding/Updating default constraint for enforcementEntityId in dbo.EnforcementEntity
ALTER TABLE [dbo].[EnforcementEntity] ADD CONSTRAINT [DF_EnforcementEntity_enforcementEntityId] DEFAULT (newid()) FOR [enforcementEntityId];
GO

-- Dropping existing default constraint for isDeleted in dbo.EnforcementEntity
ALTER TABLE [dbo].[EnforcementEntity] DROP CONSTRAINT [DF__Enforceme__isDel__5CA1C101];
GO

-- Adding/Updating default constraint for isDeleted in dbo.EnforcementEntity
ALTER TABLE [dbo].[EnforcementEntity] ADD CONSTRAINT [DF_EnforcementEntity_isDeleted] DEFAULT ((0)) FOR [isDeleted];
GO

-- Dropping existing default constraint for createdDt in dbo.EnforcementEntity
ALTER TABLE [dbo].[EnforcementEntity] DROP CONSTRAINT [DF__Enforceme__creat__5D95E53A];
GO

-- Adding/Updating default constraint for createdDt in dbo.EnforcementEntity
ALTER TABLE [dbo].[EnforcementEntity] ADD CONSTRAINT [DF_EnforcementEntity_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Dropping existing default constraint for enforcementEntityTypeId in dbo.EnforcementEntityType
ALTER TABLE [dbo].[EnforcementEntityType] DROP CONSTRAINT [DF_EnforcementEntityType_enforcementEntityTypeId];
GO

-- Adding/Updating default constraint for enforcementEntityTypeId in dbo.EnforcementEntityType
ALTER TABLE [dbo].[EnforcementEntityType] ADD CONSTRAINT [DF_EnforcementEntityType_enforcementEntityTypeId] DEFAULT (newid()) FOR [enforcementEntityTypeId];
GO

-- Dropping existing default constraint for isDeleted in dbo.EnforcementEntityType
ALTER TABLE [dbo].[EnforcementEntityType] DROP CONSTRAINT [DF_EnforcementEntityType_isDeleted];
GO

-- Adding/Updating default constraint for isDeleted in dbo.EnforcementEntityType
ALTER TABLE [dbo].[EnforcementEntityType] ADD CONSTRAINT [DF_EnforcementEntityType_isDeleted] DEFAULT ((0)) FOR [isDeleted];
GO

-- Dropping existing default constraint for createdDt in dbo.EnforcementEntityType
ALTER TABLE [dbo].[EnforcementEntityType] DROP CONSTRAINT [DF_EnforcementEntityType_createdDt];
GO

-- Adding/Updating default constraint for createdDt in dbo.EnforcementEntityType
ALTER TABLE [dbo].[EnforcementEntityType] ADD CONSTRAINT [DF_EnforcementEntityType_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Dropping existing default constraint for enforcementHistoryId in dbo.EnforcementHistory
ALTER TABLE [dbo].[EnforcementHistory] DROP CONSTRAINT [DF_EnforcementHistory_enforcementHistoryId];
GO

-- Adding/Updating default constraint for enforcementHistoryId in dbo.EnforcementHistory
ALTER TABLE [dbo].[EnforcementHistory] ADD CONSTRAINT [DF_EnforcementHistory_enforcementHistoryId] DEFAULT (newid()) FOR [enforcementHistoryId];
GO

-- Dropping existing default constraint for isDeleted in dbo.EnforcementHistory
ALTER TABLE [dbo].[EnforcementHistory] DROP CONSTRAINT [DF_EnforcementHistory_isDeleted];
GO

-- Adding/Updating default constraint for isDeleted in dbo.EnforcementHistory
ALTER TABLE [dbo].[EnforcementHistory] ADD CONSTRAINT [DF_EnforcementHistory_isDeleted] DEFAULT ((0)) FOR [isDeleted];
GO

-- Dropping existing default constraint for createdDt in dbo.EnforcementHistory
ALTER TABLE [dbo].[EnforcementHistory] DROP CONSTRAINT [DF_EnforcementHistory_createdDt];
GO

-- Adding/Updating default constraint for createdDt in dbo.EnforcementHistory
ALTER TABLE [dbo].[EnforcementHistory] ADD CONSTRAINT [DF_EnforcementHistory_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Dropping existing default constraint for enforcementStatusId in dbo.EnforcementStatus
ALTER TABLE [dbo].[EnforcementStatus] DROP CONSTRAINT [DF_EnforcementStatus_enforcementStatusId];
GO

-- Adding/Updating default constraint for enforcementStatusId in dbo.EnforcementStatus
ALTER TABLE [dbo].[EnforcementStatus] ADD CONSTRAINT [DF_EnforcementStatus_enforcementStatusId] DEFAULT (newid()) FOR [enforcementStatusId];
GO

-- Dropping existing default constraint for isDeleted in dbo.EnforcementStatus
ALTER TABLE [dbo].[EnforcementStatus] DROP CONSTRAINT [DF_EnforcementStatus_isDeleted];
GO

-- Adding/Updating default constraint for isDeleted in dbo.EnforcementStatus
ALTER TABLE [dbo].[EnforcementStatus] ADD CONSTRAINT [DF_EnforcementStatus_isDeleted] DEFAULT ((0)) FOR [isDeleted];
GO

-- Dropping existing default constraint for createdDt in dbo.EnforcementStatus
ALTER TABLE [dbo].[EnforcementStatus] DROP CONSTRAINT [DF_EnforcementStatus_createdDt];
GO

-- Adding/Updating default constraint for createdDt in dbo.EnforcementStatus
ALTER TABLE [dbo].[EnforcementStatus] ADD CONSTRAINT [DF_EnforcementStatus_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Dropping existing default constraint for enforcementTypeId in dbo.EnforcementType
ALTER TABLE [dbo].[EnforcementType] DROP CONSTRAINT [DF_EnforcementType_enforcementTypeId];
GO

-- Adding/Updating default constraint for enforcementTypeId in dbo.EnforcementType
ALTER TABLE [dbo].[EnforcementType] ADD CONSTRAINT [DF_EnforcementType_enforcementTypeId] DEFAULT (newid()) FOR [enforcementTypeId];
GO

-- Dropping existing default constraint for isDeleted in dbo.EnforcementType
ALTER TABLE [dbo].[EnforcementType] DROP CONSTRAINT [DF_EnforcementType_isDeleted];
GO

-- Adding/Updating default constraint for isDeleted in dbo.EnforcementType
ALTER TABLE [dbo].[EnforcementType] ADD CONSTRAINT [DF_EnforcementType_isDeleted] DEFAULT ((0)) FOR [isDeleted];
GO

-- Dropping existing default constraint for createdDt in dbo.EnforcementType
ALTER TABLE [dbo].[EnforcementType] DROP CONSTRAINT [DF_EnforcementType_createdDt];
GO

-- Adding/Updating default constraint for createdDt in dbo.EnforcementType
ALTER TABLE [dbo].[EnforcementType] ADD CONSTRAINT [DF_EnforcementType_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Dropping existing default constraint for regulatedInterestId in dbo.RegulatedInterest
ALTER TABLE [dbo].[RegulatedInterest] DROP CONSTRAINT [DF__Regulated__regul__69FBBC1F];
GO

-- Adding/Updating default constraint for regulatedInterestId in dbo.RegulatedInterest
ALTER TABLE [dbo].[RegulatedInterest] ADD CONSTRAINT [DF_RegulatedInterest_regulatedInterestId] DEFAULT (newid()) FOR [regulatedInterestId];
GO

-- Dropping existing default constraint for isDeleted in dbo.RegulatedInterest
ALTER TABLE [dbo].[RegulatedInterest] DROP CONSTRAINT [DF__Regulated__isDel__6AEFE058];
GO

-- Adding/Updating default constraint for isDeleted in dbo.RegulatedInterest
ALTER TABLE [dbo].[RegulatedInterest] ADD CONSTRAINT [DF_RegulatedInterest_isDeleted] DEFAULT ((0)) FOR [isDeleted];
GO

-- Dropping existing default constraint for createdDt in dbo.RegulatedInterest
ALTER TABLE [dbo].[RegulatedInterest] DROP CONSTRAINT [DF__Regulated__creat__6BE40491];
GO

-- Adding/Updating default constraint for createdDt in dbo.RegulatedInterest
ALTER TABLE [dbo].[RegulatedInterest] ADD CONSTRAINT [DF_RegulatedInterest_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Dropping existing default constraint for regulatedInterestCorrespondenceId in dbo.RegulatedInterestCorrespondence
ALTER TABLE [dbo].[RegulatedInterestCorrespondence] DROP CONSTRAINT [DF__Regulated__regul__6CD828CA];
GO

-- Adding/Updating default constraint for regulatedInterestCorrespondenceId in dbo.RegulatedInterestCorrespondence
ALTER TABLE [dbo].[RegulatedInterestCorrespondence] ADD CONSTRAINT [DF_RegulatedInterestCorrespondence_regulatedInterestCorrespondenceId] DEFAULT (newid()) FOR [regulatedInterestCorrespondenceId];
GO

-- Dropping existing default constraint for isDeleted in dbo.RegulatedInterestCorrespondence
ALTER TABLE [dbo].[RegulatedInterestCorrespondence] DROP CONSTRAINT [DF__Regulated__isDel__6DCC4D03];
GO

-- Adding/Updating default constraint for isDeleted in dbo.RegulatedInterestCorrespondence
ALTER TABLE [dbo].[RegulatedInterestCorrespondence] ADD CONSTRAINT [DF_RegulatedInterestCorrespondence_isDeleted] DEFAULT ((0)) FOR [isDeleted];
GO

-- Dropping existing default constraint for createdDt in dbo.RegulatedInterestCorrespondence
ALTER TABLE [dbo].[RegulatedInterestCorrespondence] DROP CONSTRAINT [DF__Regulated__creat__6EC0713C];
GO

-- Adding/Updating default constraint for createdDt in dbo.RegulatedInterestCorrespondence
ALTER TABLE [dbo].[RegulatedInterestCorrespondence] ADD CONSTRAINT [DF_RegulatedInterestCorrespondence_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Dropping existing default constraint for regulatedInterestCorrespondenceTypeId in dbo.RegulatedInterestCorrespondenceType
ALTER TABLE [dbo].[RegulatedInterestCorrespondenceType] DROP CONSTRAINT [DF__Regulated__regul__6FB49575];
GO

-- Adding/Updating default constraint for regulatedInterestCorrespondenceTypeId in dbo.RegulatedInterestCorrespondenceType
ALTER TABLE [dbo].[RegulatedInterestCorrespondenceType] ADD CONSTRAINT [DF_RegulatedInterestCorrespondenceType_regulatedInterestCorrespondenceTypeId] DEFAULT (newid()) FOR [regulatedInterestCorrespondenceTypeId];
GO

-- Dropping existing default constraint for isDeleted in dbo.RegulatedInterestCorrespondenceType
ALTER TABLE [dbo].[RegulatedInterestCorrespondenceType] DROP CONSTRAINT [DF__Regulated__isDel__70A8B9AE];
GO

-- Adding/Updating default constraint for isDeleted in dbo.RegulatedInterestCorrespondenceType
ALTER TABLE [dbo].[RegulatedInterestCorrespondenceType] ADD CONSTRAINT [DF_RegulatedInterestCorrespondenceType_isDeleted] DEFAULT ((0)) FOR [isDeleted];
GO

-- Dropping existing default constraint for createdDt in dbo.RegulatedInterestCorrespondenceType
ALTER TABLE [dbo].[RegulatedInterestCorrespondenceType] DROP CONSTRAINT [DF__Regulated__creat__719CDDE7];
GO

-- Adding/Updating default constraint for createdDt in dbo.RegulatedInterestCorrespondenceType
ALTER TABLE [dbo].[RegulatedInterestCorrespondenceType] ADD CONSTRAINT [DF_RegulatedInterestCorrespondenceType_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Dropping existing default constraint for regulatedInterestInspectionId in dbo.RegulatedInterestInspection
ALTER TABLE [dbo].[RegulatedInterestInspection] DROP CONSTRAINT [DF__Regulated__regul__72910220];
GO

-- Adding/Updating default constraint for regulatedInterestInspectionId in dbo.RegulatedInterestInspection
ALTER TABLE [dbo].[RegulatedInterestInspection] ADD CONSTRAINT [DF_RegulatedInterestInspection_regulatedInterestInspectionId] DEFAULT (newid()) FOR [regulatedInterestInspectionId];
GO

-- Dropping existing default constraint for isDeleted in dbo.RegulatedInterestInspection
ALTER TABLE [dbo].[RegulatedInterestInspection] DROP CONSTRAINT [DF__Regulated__isDel__73852659];
GO

-- Adding/Updating default constraint for isDeleted in dbo.RegulatedInterestInspection
ALTER TABLE [dbo].[RegulatedInterestInspection] ADD CONSTRAINT [DF_RegulatedInterestInspection_isDeleted] DEFAULT ((0)) FOR [isDeleted];
GO

-- Dropping existing default constraint for createdDt in dbo.RegulatedInterestInspection
ALTER TABLE [dbo].[RegulatedInterestInspection] DROP CONSTRAINT [DF__Regulated__creat__74794A92];
GO

-- Adding/Updating default constraint for createdDt in dbo.RegulatedInterestInspection
ALTER TABLE [dbo].[RegulatedInterestInspection] ADD CONSTRAINT [DF_RegulatedInterestInspection_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Dropping existing default constraint for regulatedInterestInspectionTypeId in dbo.RegulatedInterestInspectionType
ALTER TABLE [dbo].[RegulatedInterestInspectionType] DROP CONSTRAINT [DF__Regulated__regul__756D6ECB];
GO

-- Adding/Updating default constraint for regulatedInterestInspectionTypeId in dbo.RegulatedInterestInspectionType
ALTER TABLE [dbo].[RegulatedInterestInspectionType] ADD CONSTRAINT [DF_RegulatedInterestInspectionType_regulatedInterestInspectionTypeId] DEFAULT (newid()) FOR [regulatedInterestInspectionTypeId];
GO

-- Dropping existing default constraint for isDeleted in dbo.RegulatedInterestInspectionType
ALTER TABLE [dbo].[RegulatedInterestInspectionType] DROP CONSTRAINT [DF__Regulated__isDel__76619304];
GO

-- Adding/Updating default constraint for isDeleted in dbo.RegulatedInterestInspectionType
ALTER TABLE [dbo].[RegulatedInterestInspectionType] ADD CONSTRAINT [DF_RegulatedInterestInspectionType_isDeleted] DEFAULT ((0)) FOR [isDeleted];
GO

-- Dropping existing default constraint for createdDt in dbo.RegulatedInterestInspectionType
ALTER TABLE [dbo].[RegulatedInterestInspectionType] DROP CONSTRAINT [DF__Regulated__creat__7755B73D];
GO

-- Adding/Updating default constraint for createdDt in dbo.RegulatedInterestInspectionType
ALTER TABLE [dbo].[RegulatedInterestInspectionType] ADD CONSTRAINT [DF_RegulatedInterestInspectionType_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Dropping existing default constraint for sectionId in dbo.Section
ALTER TABLE [dbo].[Section] DROP CONSTRAINT [DF_Section_sectionId];
GO

-- Adding/Updating default constraint for sectionId in dbo.Section
ALTER TABLE [dbo].[Section] ADD CONSTRAINT [DF_Section_sectionId] DEFAULT (newid()) FOR [sectionId];
GO

-- Dropping existing default constraint for isDeleted in dbo.Section
ALTER TABLE [dbo].[Section] DROP CONSTRAINT [DF_Section_isDeleted];
GO

-- Adding/Updating default constraint for isDeleted in dbo.Section
ALTER TABLE [dbo].[Section] ADD CONSTRAINT [DF_Section_isDeleted] DEFAULT ((0)) FOR [isDeleted];
GO

-- Dropping existing default constraint for createdDt in dbo.Section
ALTER TABLE [dbo].[Section] DROP CONSTRAINT [DF_Section_createdDt];
GO

-- Adding/Updating default constraint for createdDt in dbo.Section
ALTER TABLE [dbo].[Section] ADD CONSTRAINT [DF_Section_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Dropping existing default constraint for sharedApiId in dbo.SharedApi
ALTER TABLE [dbo].[SharedApi] DROP CONSTRAINT [DF_SharedApi_sharedApiId];
GO

-- Adding/Updating default constraint for sharedApiId in dbo.SharedApi
ALTER TABLE [dbo].[SharedApi] ADD CONSTRAINT [DF_SharedApi_sharedApiId] DEFAULT (newid()) FOR [sharedApiId];
GO

-- Dropping existing default constraint for isDeleted in dbo.SharedApi
ALTER TABLE [dbo].[SharedApi] DROP CONSTRAINT [DF__SharedApi__isDel__7C1A6C5A];
GO

-- Adding/Updating default constraint for isDeleted in dbo.SharedApi
ALTER TABLE [dbo].[SharedApi] ADD CONSTRAINT [DF_SharedApi_isDeleted] DEFAULT ((0)) FOR [isDeleted];
GO

-- Adding/Updating default constraint for createdDt in dbo.SharedApi
ALTER TABLE [dbo].[SharedApi] ADD CONSTRAINT [DF_SharedApi_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Updating primary key: PK__SharedAp__61EE6F91A4F56672 to PK_SharedApi in dbo.SharedApi
ALTER TABLE [dbo].[SharedApi] DROP CONSTRAINT [PK__SharedAp__61EE6F91A4F56672];
ALTER TABLE [dbo].[SharedApi] ADD CONSTRAINT [PK_SharedApi] PRIMARY KEY ([sharedApiId]);
GO

-- Adding/Updating default constraint for createdDt in dbo.SiteClosureReasonType
ALTER TABLE [dbo].[SiteClosureReasonType] ADD CONSTRAINT [DF_SiteClosureReasonType_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Dropping existing default constraint for siteCorrespondenceId in dbo.SiteCorrespondence
ALTER TABLE [dbo].[SiteCorrespondence] DROP CONSTRAINT [DF__SiteCorre__siteC__7D0E9093];
GO

-- Adding/Updating default constraint for siteCorrespondenceId in dbo.SiteCorrespondence
ALTER TABLE [dbo].[SiteCorrespondence] ADD CONSTRAINT [DF_SiteCorrespondence_siteCorrespondenceId] DEFAULT (newid()) FOR [siteCorrespondenceId];
GO

-- Dropping existing default constraint for isDeleted in dbo.SiteCorrespondence
ALTER TABLE [dbo].[SiteCorrespondence] DROP CONSTRAINT [DF__SiteCorre__isDel__7E02B4CC];
GO

-- Adding/Updating default constraint for isDeleted in dbo.SiteCorrespondence
ALTER TABLE [dbo].[SiteCorrespondence] ADD CONSTRAINT [DF_SiteCorrespondence_isDeleted] DEFAULT ((0)) FOR [isDeleted];
GO

-- Dropping existing default constraint for createdDt in dbo.SiteCorrespondence
ALTER TABLE [dbo].[SiteCorrespondence] DROP CONSTRAINT [DF__SiteCorre__creat__7EF6D905];
GO

-- Adding/Updating default constraint for createdDt in dbo.SiteCorrespondence
ALTER TABLE [dbo].[SiteCorrespondence] ADD CONSTRAINT [DF_SiteCorrespondence_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Dropping existing default constraint for siteCorrespondenceTypeId in dbo.SiteCorrespondenceType
ALTER TABLE [dbo].[SiteCorrespondenceType] DROP CONSTRAINT [DF__SiteCorre__siteC__7FEAFD3E];
GO

-- Adding/Updating default constraint for siteCorrespondenceTypeId in dbo.SiteCorrespondenceType
ALTER TABLE [dbo].[SiteCorrespondenceType] ADD CONSTRAINT [DF_SiteCorrespondenceType_siteCorrespondenceTypeId] DEFAULT (newid()) FOR [siteCorrespondenceTypeId];
GO

-- Dropping existing default constraint for isDeleted in dbo.SiteCorrespondenceType
ALTER TABLE [dbo].[SiteCorrespondenceType] DROP CONSTRAINT [DF__SiteCorre__isDel__00DF2177];
GO

-- Adding/Updating default constraint for isDeleted in dbo.SiteCorrespondenceType
ALTER TABLE [dbo].[SiteCorrespondenceType] ADD CONSTRAINT [DF_SiteCorrespondenceType_isDeleted] DEFAULT ((0)) FOR [isDeleted];
GO

-- Dropping existing default constraint for createdDt in dbo.SiteCorrespondenceType
ALTER TABLE [dbo].[SiteCorrespondenceType] DROP CONSTRAINT [DF__SiteCorre__creat__01D345B0];
GO

-- Adding/Updating default constraint for createdDt in dbo.SiteCorrespondenceType
ALTER TABLE [dbo].[SiteCorrespondenceType] ADD CONSTRAINT [DF_SiteCorrespondenceType_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Dropping existing default constraint for siteInspectionId in dbo.SiteInspection
ALTER TABLE [dbo].[SiteInspection] DROP CONSTRAINT [DF__SiteInspe__siteI__02C769E9];
GO

-- Adding/Updating default constraint for siteInspectionId in dbo.SiteInspection
ALTER TABLE [dbo].[SiteInspection] ADD CONSTRAINT [DF_SiteInspection_siteInspectionId] DEFAULT (newid()) FOR [siteInspectionId];
GO

-- Dropping existing default constraint for isDeleted in dbo.SiteInspection
ALTER TABLE [dbo].[SiteInspection] DROP CONSTRAINT [DF__SiteInspe__isDel__03BB8E22];
GO

-- Adding/Updating default constraint for isDeleted in dbo.SiteInspection
ALTER TABLE [dbo].[SiteInspection] ADD CONSTRAINT [DF_SiteInspection_isDeleted] DEFAULT ((0)) FOR [isDeleted];
GO

-- Dropping existing default constraint for createdDt in dbo.SiteInspection
ALTER TABLE [dbo].[SiteInspection] DROP CONSTRAINT [DF__SiteInspe__creat__04AFB25B];
GO

-- Adding/Updating default constraint for createdDt in dbo.SiteInspection
ALTER TABLE [dbo].[SiteInspection] ADD CONSTRAINT [DF_SiteInspection_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Dropping existing default constraint for siteInspectionTypeId in dbo.SiteInspectionType
ALTER TABLE [dbo].[SiteInspectionType] DROP CONSTRAINT [DF__SiteInspe__siteI__05A3D694];
GO

-- Adding/Updating default constraint for siteInspectionTypeId in dbo.SiteInspectionType
ALTER TABLE [dbo].[SiteInspectionType] ADD CONSTRAINT [DF_SiteInspectionType_siteInspectionTypeId] DEFAULT (newid()) FOR [siteInspectionTypeId];
GO

-- Dropping existing default constraint for isDeleted in dbo.SiteInspectionType
ALTER TABLE [dbo].[SiteInspectionType] DROP CONSTRAINT [DF__SiteInspe__isDel__0697FACD];
GO

-- Adding/Updating default constraint for isDeleted in dbo.SiteInspectionType
ALTER TABLE [dbo].[SiteInspectionType] ADD CONSTRAINT [DF_SiteInspectionType_isDeleted] DEFAULT ((0)) FOR [isDeleted];
GO

-- Dropping existing default constraint for createdDt in dbo.SiteInspectionType
ALTER TABLE [dbo].[SiteInspectionType] DROP CONSTRAINT [DF__SiteInspe__creat__078C1F06];
GO

-- Adding/Updating default constraint for createdDt in dbo.SiteInspectionType
ALTER TABLE [dbo].[SiteInspectionType] ADD CONSTRAINT [DF_SiteInspectionType_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Dropping existing default constraint for staffId in dbo.Staff
ALTER TABLE [dbo].[Staff] DROP CONSTRAINT [DF_Employee_employeeId];
GO

-- Adding/Updating default constraint for staffId in dbo.Staff
ALTER TABLE [dbo].[Staff] ADD CONSTRAINT [DF_Staff_staffId] DEFAULT (newid()) FOR [staffId];
GO

-- Dropping existing default constraint for isDeleted in dbo.Staff
ALTER TABLE [dbo].[Staff] DROP CONSTRAINT [DF_Employee_isDeleted];
GO

-- Adding/Updating default constraint for isDeleted in dbo.Staff
ALTER TABLE [dbo].[Staff] ADD CONSTRAINT [DF_Staff_isDeleted] DEFAULT ((0)) FOR [isDeleted];
GO

-- Dropping existing default constraint for createdDt in dbo.Staff
ALTER TABLE [dbo].[Staff] DROP CONSTRAINT [DF_Employee_createdDt];
GO

-- Adding/Updating default constraint for createdDt in dbo.Staff
ALTER TABLE [dbo].[Staff] ADD CONSTRAINT [DF_Staff_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Updating primary key: PK_Employee to PK_Staff in dbo.Staff
ALTER TABLE [dbo].[Staff] DROP CONSTRAINT [PK_Employee];
ALTER TABLE [dbo].[Staff] ADD CONSTRAINT [PK_Staff] PRIMARY KEY ([staffId]);
GO

-- Dropping existing default constraint for staffRoleId in dbo.StaffRole
ALTER TABLE [dbo].[StaffRole] DROP CONSTRAINT [DF_CaseStaffRole_caseStaffRoleId];
GO

-- Adding/Updating default constraint for staffRoleId in dbo.StaffRole
ALTER TABLE [dbo].[StaffRole] ADD CONSTRAINT [DF_StaffRole_staffRoleId] DEFAULT (newid()) FOR [staffRoleId];
GO

-- Dropping existing default constraint for isDeleted in dbo.StaffRole
ALTER TABLE [dbo].[StaffRole] DROP CONSTRAINT [DF_CaseStaffRole_isDeleted];
GO

-- Adding/Updating default constraint for isDeleted in dbo.StaffRole
ALTER TABLE [dbo].[StaffRole] ADD CONSTRAINT [DF_StaffRole_isDeleted] DEFAULT ((0)) FOR [isDeleted];
GO

-- Dropping existing default constraint for createdDt in dbo.StaffRole
ALTER TABLE [dbo].[StaffRole] DROP CONSTRAINT [DF_CaseStaffRole_createdDt];
GO

-- Adding/Updating default constraint for createdDt in dbo.StaffRole
ALTER TABLE [dbo].[StaffRole] ADD CONSTRAINT [DF_StaffRole_createdDt] DEFAULT (sysutcdatetime()) FOR [createdDt];
GO

-- Updating primary key: PK_CaseStaffRole to PK_StaffRole in dbo.StaffRole
ALTER TABLE [dbo].[StaffRole] DROP CONSTRAINT [PK_CaseStaffRole];
ALTER TABLE [dbo].[StaffRole] ADD CONSTRAINT [PK_StaffRole] PRIMARY KEY ([staffRoleId]);
GO

-- Dropping redundant table: pencalc.Actor
DROP TABLE [pencalc].[Actor];
GO

-- Dropping redundant table: pencalc.ActorContact
DROP TABLE [pencalc].[ActorContact];
GO

-- Dropping redundant table: pencalc.ActorType
DROP TABLE [pencalc].[ActorType];
GO

-- Dropping redundant table: pencalc.AddressType
DROP TABLE [pencalc].[AddressType];
GO

-- Dropping redundant table: pencalc.Case
DROP TABLE [pencalc].[Case];
GO

-- Dropping redundant table: pencalc.CaseStaffAssignment
DROP TABLE [pencalc].[CaseStaffAssignment];
GO

-- Dropping redundant table: pencalc.CaseStatus
DROP TABLE [pencalc].[CaseStatus];
GO

-- Dropping redundant table: pencalc.RO
DROP TABLE [pencalc].[RO];
GO

-- Dropping redundant table: pencalc.ROStatus
DROP TABLE [pencalc].[ROStatus];
GO

-- Dropping redundant table: pencalc.ROType
DROP TABLE [pencalc].[ROType];
GO

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

