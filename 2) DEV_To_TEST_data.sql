use EEA_CAS_Enterprise;

-- Lookup Data Insert Script generated from DEV for TEST on 4/15/2026 11:41:19 AM

-- Table [dbo].[ActivityType] is already in sync with DEV.

-- Table [dbo].[AssociatedProgram] is already in sync with DEV.

-- Table [dbo].[Avoided] does not exist on destination. Assuming it will be created.
-- Data for Avoided
IF NOT EXISTS (SELECT 1 FROM [dbo].[Avoided] WHERE [avoidedCode] = 'OTHER')
    INSERT INTO [dbo].[Avoided] ([avoidedCode], [avoidedName], [avoidedDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('OTHER', 'OTHER', 'Other avoided economic benefit factor', 0, '2026-03-23 14:55:42.526', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Avoided] WHERE [avoidedCode] = 'POTENTIAL_PUBLIC_HEALTH_IMPACT_IDENTIFIED')
    INSERT INTO [dbo].[Avoided] ([avoidedCode], [avoidedName], [avoidedDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('POTENTIAL_PUBLIC_HEALTH_IMPACT_IDENTIFIED', 'POTENTIAL PUBLIC HEALTH IMPACT IDENTIFIED', 'Potential public health impact identified', 0, '2026-03-23 14:55:42.526', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Avoided] WHERE [avoidedCode] = 'POTENTIAL_PUBLIC_SAFETY_AND_WELFARE_IMPACT_IDENTIFIED')
    INSERT INTO [dbo].[Avoided] ([avoidedCode], [avoidedName], [avoidedDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('POTENTIAL_PUBLIC_SAFETY_AND_WELFARE_IMPACT_IDENTIFIED', 'POTENTIAL PUBLIC SAFETY AND WELFARE IMPACT IDENTIFIED', 'Potential public safety and welfare impact identified', 0, '2026-03-23 14:55:42.526', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Avoided] WHERE [avoidedCode] = 'POTENTIAL_ENVIRONMENTAL_IMPACT_IDENTIFIED')
    INSERT INTO [dbo].[Avoided] ([avoidedCode], [avoidedName], [avoidedDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('POTENTIAL_ENVIRONMENTAL_IMPACT_IDENTIFIED', 'POTENTIAL ENVIRONMENTAL IMPACT IDENTIFIED', 'Potential environmental impact identified', 0, '2026-03-23 14:55:42.526', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Avoided] WHERE [avoidedCode] = 'ACTUAL_PUBLIC_HEALTH_IMPACT_IDENTIFIED')
    INSERT INTO [dbo].[Avoided] ([avoidedCode], [avoidedName], [avoidedDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('ACTUAL_PUBLIC_HEALTH_IMPACT_IDENTIFIED', 'ACTUAL PUBLIC HEALTH IMPACT IDENTIFIED', 'Actual public health impact identified', 0, '2026-03-23 14:55:42.526', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Avoided] WHERE [avoidedCode] = 'ACTUAL_PUBLIC_SAFETY_AND_WELFARE_IMPACT_IDENTIFIED')
    INSERT INTO [dbo].[Avoided] ([avoidedCode], [avoidedName], [avoidedDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('ACTUAL_PUBLIC_SAFETY_AND_WELFARE_IMPACT_IDENTIFIED', 'ACTUAL PUBLIC SAFETY AND WELFARE IMPACT IDENTIFIED', 'Actual public safety and welfare impact identified', 0, '2026-03-23 14:55:42.526', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Avoided] WHERE [avoidedCode] = 'ACTUAL_ENVIRONMENTAL_IMPACT_IDENTIFIED')
    INSERT INTO [dbo].[Avoided] ([avoidedCode], [avoidedName], [avoidedDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('ACTUAL_ENVIRONMENTAL_IMPACT_IDENTIFIED', 'ACTUAL ENVIRONMENTAL IMPACT IDENTIFIED', 'Actual environmental impact identified', 0, '2026-03-23 14:55:42.526', 'SYSTEM', NULL, NULL);
GO

-- Table [dbo].[Branch] is already in sync with DEV.

-- Data for BusinessUnitAssociatedProgram
IF NOT EXISTS (SELECT 1 FROM BusinessUnitAssociatedProgram buap JOIN BusinessUnit bu ON buap.BusinessUnitId = bu.BusinessUnitId JOIN AssociatedProgram ap ON buap.AssociatedProgramId = ap.AssociatedProgramId WHERE bu.BusinessUnitCode = 'WET' AND ap.AssociatedProgramCode = 'WET-Inland')
BEGIN
    INSERT INTO [dbo].[BusinessUnitAssociatedProgram] ([BusinessUnitId], [AssociatedProgramId], [CreatedBy], [CreatedDt])
    SELECT bu.BusinessUnitId, ap.AssociatedProgramId, 'System', '2025-12-12 09:00:00.000'
    FROM BusinessUnit bu, AssociatedProgram ap WHERE bu.BusinessUnitCode = 'WET' AND ap.AssociatedProgramCode = 'WET-Inland';
END
IF NOT EXISTS (SELECT 1 FROM BusinessUnitAssociatedProgram buap JOIN BusinessUnit bu ON buap.BusinessUnitId = bu.BusinessUnitId JOIN AssociatedProgram ap ON buap.AssociatedProgramId = ap.AssociatedProgramId WHERE bu.BusinessUnitCode = 'WET' AND ap.AssociatedProgramCode = 'WET-Coastal')
BEGIN
    INSERT INTO [dbo].[BusinessUnitAssociatedProgram] ([BusinessUnitId], [AssociatedProgramId], [CreatedBy], [CreatedDt])
    SELECT bu.BusinessUnitId, ap.AssociatedProgramId, 'System', '2025-12-12 09:00:00.000'
    FROM BusinessUnit bu, AssociatedProgram ap WHERE bu.BusinessUnitCode = 'WET' AND ap.AssociatedProgramCode = 'WET-Coastal';
END
IF NOT EXISTS (SELECT 1 FROM BusinessUnitAssociatedProgram buap JOIN BusinessUnit bu ON buap.BusinessUnitId = bu.BusinessUnitId JOIN AssociatedProgram ap ON buap.AssociatedProgramId = ap.AssociatedProgramId WHERE bu.BusinessUnitCode = 'WET' AND ap.AssociatedProgramCode = 'WET-Wetlands Act')
BEGIN
    INSERT INTO [dbo].[BusinessUnitAssociatedProgram] ([BusinessUnitId], [AssociatedProgramId], [CreatedBy], [CreatedDt])
    SELECT bu.BusinessUnitId, ap.AssociatedProgramId, 'System', '2025-12-12 09:00:00.000'
    FROM BusinessUnit bu, AssociatedProgram ap WHERE bu.BusinessUnitCode = 'WET' AND ap.AssociatedProgramCode = 'WET-Wetlands Act';
END
IF NOT EXISTS (SELECT 1 FROM BusinessUnitAssociatedProgram buap JOIN BusinessUnit bu ON buap.BusinessUnitId = bu.BusinessUnitId JOIN AssociatedProgram ap ON buap.AssociatedProgramId = ap.AssociatedProgramId WHERE bu.BusinessUnitCode = 'WET' AND ap.AssociatedProgramCode = 'WET-Procedural')
BEGIN
    INSERT INTO [dbo].[BusinessUnitAssociatedProgram] ([BusinessUnitId], [AssociatedProgramId], [CreatedBy], [CreatedDt])
    SELECT bu.BusinessUnitId, ap.AssociatedProgramId, 'System', '2025-12-12 09:00:00.000'
    FROM BusinessUnit bu, AssociatedProgram ap WHERE bu.BusinessUnitCode = 'WET' AND ap.AssociatedProgramCode = 'WET-Procedural';
END
-- Removing records not in DEV
DELETE buap FROM [dbo].[BusinessUnitAssociatedProgram] buap JOIN BusinessUnit bu ON buap.BusinessUnitId = bu.BusinessUnitId JOIN AssociatedProgram ap ON buap.AssociatedProgramId = ap.AssociatedProgramId WHERE bu.BusinessUnitCode = 'WPC' AND ap.AssociatedProgramCode = 'WPC-CSO/SSO';
DELETE buap FROM [dbo].[BusinessUnitAssociatedProgram] buap JOIN BusinessUnit bu ON buap.BusinessUnitId = bu.BusinessUnitId JOIN AssociatedProgram ap ON buap.AssociatedProgramId = ap.AssociatedProgramId WHERE bu.BusinessUnitCode = 'WPC' AND ap.AssociatedProgramCode = 'ERP-Sewer Connections';
DELETE buap FROM [dbo].[BusinessUnitAssociatedProgram] buap JOIN BusinessUnit bu ON buap.BusinessUnitId = bu.BusinessUnitId JOIN AssociatedProgram ap ON buap.AssociatedProgramId = ap.AssociatedProgramId WHERE bu.BusinessUnitCode = 'WPC' AND ap.AssociatedProgramCode = 'WPC-IWW';
DELETE buap FROM [dbo].[BusinessUnitAssociatedProgram] buap JOIN BusinessUnit bu ON buap.BusinessUnitId = bu.BusinessUnitId JOIN AssociatedProgram ap ON buap.AssociatedProgramId = ap.AssociatedProgramId WHERE bu.BusinessUnitCode = 'WPC' AND ap.AssociatedProgramCode = 'WPC-NPDES';
DELETE buap FROM [dbo].[BusinessUnitAssociatedProgram] buap JOIN BusinessUnit bu ON buap.BusinessUnitId = bu.BusinessUnitId JOIN AssociatedProgram ap ON buap.AssociatedProgramId = ap.AssociatedProgramId WHERE bu.BusinessUnitCode = 'BWSC' AND ap.AssociatedProgramCode = 'WET-Wetlands Act';
DELETE buap FROM [dbo].[BusinessUnitAssociatedProgram] buap JOIN BusinessUnit bu ON buap.BusinessUnitId = bu.BusinessUnitId JOIN AssociatedProgram ap ON buap.AssociatedProgramId = ap.AssociatedProgramId WHERE bu.BusinessUnitCode = 'IWW' AND ap.AssociatedProgramCode = 'ERP-PP';
DELETE buap FROM [dbo].[BusinessUnitAssociatedProgram] buap JOIN BusinessUnit bu ON buap.BusinessUnitId = bu.BusinessUnitId JOIN AssociatedProgram ap ON buap.AssociatedProgramId = ap.AssociatedProgramId WHERE bu.BusinessUnitCode = 'WPC' AND ap.AssociatedProgramCode = 'WPC-T5';
DELETE buap FROM [dbo].[BusinessUnitAssociatedProgram] buap JOIN BusinessUnit bu ON buap.BusinessUnitId = bu.BusinessUnitId JOIN AssociatedProgram ap ON buap.AssociatedProgramId = ap.AssociatedProgramId WHERE bu.BusinessUnitCode = 'ERP' AND ap.AssociatedProgramCode = 'ERP-Sewer Connections';
DELETE buap FROM [dbo].[BusinessUnitAssociatedProgram] buap JOIN BusinessUnit bu ON buap.BusinessUnitId = bu.BusinessUnitId JOIN AssociatedProgram ap ON buap.AssociatedProgramId = ap.AssociatedProgramId WHERE bu.BusinessUnitCode = 'WPC' AND ap.AssociatedProgramCode = 'WPC-401 WQC';
DELETE buap FROM [dbo].[BusinessUnitAssociatedProgram] buap JOIN BusinessUnit bu ON buap.BusinessUnitId = bu.BusinessUnitId JOIN AssociatedProgram ap ON buap.AssociatedProgramId = ap.AssociatedProgramId WHERE bu.BusinessUnitCode = 'WS' AND ap.AssociatedProgramCode = 'DW';
DELETE buap FROM [dbo].[BusinessUnitAssociatedProgram] buap JOIN BusinessUnit bu ON buap.BusinessUnitId = bu.BusinessUnitId JOIN AssociatedProgram ap ON buap.AssociatedProgramId = ap.AssociatedProgramId WHERE bu.BusinessUnitCode = 'WPC' AND ap.AssociatedProgramCode = 'WPC-RW';
DELETE buap FROM [dbo].[BusinessUnitAssociatedProgram] buap JOIN BusinessUnit bu ON buap.BusinessUnitId = bu.BusinessUnitId JOIN AssociatedProgram ap ON buap.AssociatedProgramId = ap.AssociatedProgramId WHERE bu.BusinessUnitCode = 'BWSC' AND ap.AssociatedProgramCode = 'WET-Procedural';
DELETE buap FROM [dbo].[BusinessUnitAssociatedProgram] buap JOIN BusinessUnit bu ON buap.BusinessUnitId = bu.BusinessUnitId JOIN AssociatedProgram ap ON buap.AssociatedProgramId = ap.AssociatedProgramId WHERE bu.BusinessUnitCode = 'WPC' AND ap.AssociatedProgramCode = 'WPC-Holding Tanks';
DELETE buap FROM [dbo].[BusinessUnitAssociatedProgram] buap JOIN BusinessUnit bu ON buap.BusinessUnitId = bu.BusinessUnitId JOIN AssociatedProgram ap ON buap.AssociatedProgramId = ap.AssociatedProgramId WHERE bu.BusinessUnitCode = 'BWSC' AND ap.AssociatedProgramCode = 'WET-Coastal';
DELETE buap FROM [dbo].[BusinessUnitAssociatedProgram] buap JOIN BusinessUnit bu ON buap.BusinessUnitId = bu.BusinessUnitId JOIN AssociatedProgram ap ON buap.AssociatedProgramId = ap.AssociatedProgramId WHERE bu.BusinessUnitCode = 'WPC' AND ap.AssociatedProgramCode = 'WPC-GW';
DELETE buap FROM [dbo].[BusinessUnitAssociatedProgram] buap JOIN BusinessUnit bu ON buap.BusinessUnitId = bu.BusinessUnitId JOIN AssociatedProgram ap ON buap.AssociatedProgramId = ap.AssociatedProgramId WHERE bu.BusinessUnitCode = 'ERP' AND ap.AssociatedProgramCode = 'ERP-PP';
DELETE buap FROM [dbo].[BusinessUnitAssociatedProgram] buap JOIN BusinessUnit bu ON buap.BusinessUnitId = bu.BusinessUnitId JOIN AssociatedProgram ap ON buap.AssociatedProgramId = ap.AssociatedProgramId WHERE bu.BusinessUnitCode = 'WPC' AND ap.AssociatedProgramCode = 'WPC-DR';
DELETE buap FROM [dbo].[BusinessUnitAssociatedProgram] buap JOIN BusinessUnit bu ON buap.BusinessUnitId = bu.BusinessUnitId JOIN AssociatedProgram ap ON buap.AssociatedProgramId = ap.AssociatedProgramId WHERE bu.BusinessUnitCode = 'WPC' AND ap.AssociatedProgramCode = 'WPC-SW';
DELETE buap FROM [dbo].[BusinessUnitAssociatedProgram] buap JOIN BusinessUnit bu ON buap.BusinessUnitId = bu.BusinessUnitId JOIN AssociatedProgram ap ON buap.AssociatedProgramId = ap.AssociatedProgramId WHERE bu.BusinessUnitCode = 'BWSC' AND ap.AssociatedProgramCode = 'WET-Inland';
GO

-- Table [dbo].[BusinessUnitType] is already in sync with DEV.

-- Table [dbo].[CaseStatus] does not exist on destination. Assuming it will be created.
-- Data for CaseStatus
IF NOT EXISTS (SELECT 1 FROM [dbo].[CaseStatus] WHERE [caseStatusCode] = 'FINAL')
    INSERT INTO [dbo].[CaseStatus] ([caseStatusCode], [caseStatusName], [caseStatusDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('FINAL', 'THE FINAL STATE OF A PENALTY CALCULATION', 'THE FINAL STATE OF A PENALTY CALCULATION', 0, '2026-01-13 17:16:40.913', 'seed', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[CaseStatus] WHERE [caseStatusCode] = 'DRAFT')
    INSERT INTO [dbo].[CaseStatus] ([caseStatusCode], [caseStatusName], [caseStatusDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('DRAFT', 'THE INITIAL STATE OF A PENALTY CALCULATION', 'THE INITIAL STATE OF A PENALTY CALCULATION', 0, '2026-01-13 17:16:40.913', 'seed', NULL, NULL);
GO

-- Table [dbo].[CitationClass] is already in sync with DEV.

-- Table [dbo].[CitationSequence] is already in sync with DEV.

-- Table [dbo].[CitationStatus] is already in sync with DEV.

-- Table [dbo].[CitationStatute] is already in sync with DEV.

-- Table [dbo].[Delayed] does not exist on destination. Assuming it will be created.
-- Data for Delayed
IF NOT EXISTS (SELECT 1 FROM [dbo].[Delayed] WHERE [delayedCode] = 'POTENTIAL_PUBLIC_HEALTH_IMPACT_IDENTIFIED')
    INSERT INTO [dbo].[Delayed] ([delayedCode], [delayedName], [delayedDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('POTENTIAL_PUBLIC_HEALTH_IMPACT_IDENTIFIED', 'POTENTIAL PUBLIC HEALTH IMPACT IDENTIFIED', 'Potential public health impact identified', 0, '2026-03-23 14:55:00.224', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Delayed] WHERE [delayedCode] = 'POTENTIAL_ENVIRONMENTAL_IMPACT_IDENTIFIED')
    INSERT INTO [dbo].[Delayed] ([delayedCode], [delayedName], [delayedDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('POTENTIAL_ENVIRONMENTAL_IMPACT_IDENTIFIED', 'POTENTIAL ENVIRONMENTAL IMPACT IDENTIFIED', 'Potential environmental impact identified', 0, '2026-03-23 14:55:00.224', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Delayed] WHERE [delayedCode] = 'OTHER')
    INSERT INTO [dbo].[Delayed] ([delayedCode], [delayedName], [delayedDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('OTHER', 'OTHER', 'Other delayed economic benefit factor', 0, '2026-03-23 14:55:00.224', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Delayed] WHERE [delayedCode] = 'POTENTIAL_PUBLIC_SAFETY_AND_WELFARE_IMPACT_IDENTIFIED')
    INSERT INTO [dbo].[Delayed] ([delayedCode], [delayedName], [delayedDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('POTENTIAL_PUBLIC_SAFETY_AND_WELFARE_IMPACT_IDENTIFIED', 'POTENTIAL PUBLIC SAFETY AND WELFARE IMPACT IDENTIFIED', 'Potential public safety and welfare impact identified', 0, '2026-03-23 14:55:00.224', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Delayed] WHERE [delayedCode] = 'ACTUAL_PUBLIC_SAFETY_AND_WELFARE_IMPACT_IDENTIFIED')
    INSERT INTO [dbo].[Delayed] ([delayedCode], [delayedName], [delayedDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('ACTUAL_PUBLIC_SAFETY_AND_WELFARE_IMPACT_IDENTIFIED', 'ACTUAL PUBLIC SAFETY AND WELFARE IMPACT IDENTIFIED', 'Actual public safety and welfare impact identified', 0, '2026-03-23 14:55:00.224', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Delayed] WHERE [delayedCode] = 'ACTUAL_PUBLIC_HEALTH_IMPACT_IDENTIFIED')
    INSERT INTO [dbo].[Delayed] ([delayedCode], [delayedName], [delayedDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('ACTUAL_PUBLIC_HEALTH_IMPACT_IDENTIFIED', 'ACTUAL PUBLIC HEALTH IMPACT IDENTIFIED', 'Actual public health impact identified', 0, '2026-03-23 14:55:00.224', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Delayed] WHERE [delayedCode] = 'ACTUAL_ENVIRONMENTAL_IMPACT_IDENTIFIED')
    INSERT INTO [dbo].[Delayed] ([delayedCode], [delayedName], [delayedDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('ACTUAL_ENVIRONMENTAL_IMPACT_IDENTIFIED', 'ACTUAL ENVIRONMENTAL IMPACT IDENTIFIED', 'Actual environmental impact identified', 0, '2026-03-23 14:55:00.224', 'SYSTEM', NULL, NULL);
GO

-- Table [dbo].[EnforcementDocType] does not exist on destination. Assuming it will be created.
-- Data for EnforcementDocType
IF NOT EXISTS (SELECT 1 FROM [dbo].[EnforcementDocType] WHERE [enforcementDocTypeCode] = 'EXPEDITED_PENALTY_ASSESSMENT_NOTICE')
    INSERT INTO [dbo].[EnforcementDocType] ([enforcementDocTypeCode], [enforcementDocTypeName], [enforcementDocTypeDesc], [isDeleted], [createdBy], [createdDt], [lastModifiedBy], [lastModifiedDt]) VALUES ('EXPEDITED_PENALTY_ASSESSMENT_NOTICE', 'Expedited Penalty Assessment Notice', NULL, 0, 'SYSTEM', '2026-03-18 13:48:29.482', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[EnforcementDocType] WHERE [enforcementDocTypeCode] = 'UNILATERAL_ADMINISTRATIVE_ORDER')
    INSERT INTO [dbo].[EnforcementDocType] ([enforcementDocTypeCode], [enforcementDocTypeName], [enforcementDocTypeDesc], [isDeleted], [createdBy], [createdDt], [lastModifiedBy], [lastModifiedDt]) VALUES ('UNILATERAL_ADMINISTRATIVE_ORDER', 'Unilateral Administrative Order', NULL, 0, 'SYSTEM', '2026-03-18 13:48:29.482', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[EnforcementDocType] WHERE [enforcementDocTypeCode] = 'DEMAND_ACTION')
    INSERT INTO [dbo].[EnforcementDocType] ([enforcementDocTypeCode], [enforcementDocTypeName], [enforcementDocTypeDesc], [isDeleted], [createdBy], [createdDt], [lastModifiedBy], [lastModifiedDt]) VALUES ('DEMAND_ACTION', 'Demand Action', NULL, 0, 'SYSTEM', '2026-03-18 13:48:29.482', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[EnforcementDocType] WHERE [enforcementDocTypeCode] = 'STANDARDIZED_PENALTY_ASSESSMENT_NOTICE')
    INSERT INTO [dbo].[EnforcementDocType] ([enforcementDocTypeCode], [enforcementDocTypeName], [enforcementDocTypeDesc], [isDeleted], [createdBy], [createdDt], [lastModifiedBy], [lastModifiedDt]) VALUES ('STANDARDIZED_PENALTY_ASSESSMENT_NOTICE', 'Standardized Penalty Assessment Notice', NULL, 0, 'SYSTEM', '2026-03-18 13:48:29.482', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[EnforcementDocType] WHERE [enforcementDocTypeCode] = 'REPORTING_PENALTY_ASSESSMENT_NOTICE')
    INSERT INTO [dbo].[EnforcementDocType] ([enforcementDocTypeCode], [enforcementDocTypeName], [enforcementDocTypeDesc], [isDeleted], [createdBy], [createdDt], [lastModifiedBy], [lastModifiedDt]) VALUES ('REPORTING_PENALTY_ASSESSMENT_NOTICE', 'Reporting Penalty Assessment Notice', NULL, 0, 'SYSTEM', '2026-03-18 13:48:29.482', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[EnforcementDocType] WHERE [enforcementDocTypeCode] = 'NOTICE_OF_ENFORCEMENT_CONFERENCE')
    INSERT INTO [dbo].[EnforcementDocType] ([enforcementDocTypeCode], [enforcementDocTypeName], [enforcementDocTypeDesc], [isDeleted], [createdBy], [createdDt], [lastModifiedBy], [lastModifiedDt]) VALUES ('NOTICE_OF_ENFORCEMENT_CONFERENCE', 'Notice Of Enforcement Conference', NULL, 0, 'SYSTEM', '2026-03-18 13:48:29.482', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[EnforcementDocType] WHERE [enforcementDocTypeCode] = 'PENALTY_ASSESSMENT_NOTICE')
    INSERT INTO [dbo].[EnforcementDocType] ([enforcementDocTypeCode], [enforcementDocTypeName], [enforcementDocTypeDesc], [isDeleted], [createdBy], [createdDt], [lastModifiedBy], [lastModifiedDt]) VALUES ('PENALTY_ASSESSMENT_NOTICE', 'Penalty Assessment Notice', NULL, 0, 'SYSTEM', '2026-03-18 13:48:29.482', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[EnforcementDocType] WHERE [enforcementDocTypeCode] = 'E0350_CLEAN_STATE_WARNING_LETTER')
    INSERT INTO [dbo].[EnforcementDocType] ([enforcementDocTypeCode], [enforcementDocTypeName], [enforcementDocTypeDesc], [isDeleted], [createdBy], [createdDt], [lastModifiedBy], [lastModifiedDt]) VALUES ('E0350_CLEAN_STATE_WARNING_LETTER', 'E0350 Clean State - Warning Letter', NULL, 0, 'SYSTEM', '2026-03-18 13:48:29.482', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[EnforcementDocType] WHERE [enforcementDocTypeCode] = 'REFERRAL_TO_OTHER_AGENCY')
    INSERT INTO [dbo].[EnforcementDocType] ([enforcementDocTypeCode], [enforcementDocTypeName], [enforcementDocTypeDesc], [isDeleted], [createdBy], [createdDt], [lastModifiedBy], [lastModifiedDt]) VALUES ('REFERRAL_TO_OTHER_AGENCY', 'Referral To Other Agency', NULL, 0, 'SYSTEM', '2026-03-18 13:48:29.482', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[EnforcementDocType] WHERE [enforcementDocTypeCode] = 'PRINTERS_PROJECT_ONLY_NON_NON_WARNING_LETTER')
    INSERT INTO [dbo].[EnforcementDocType] ([enforcementDocTypeCode], [enforcementDocTypeName], [enforcementDocTypeDesc], [isDeleted], [createdBy], [createdDt], [lastModifiedBy], [lastModifiedDt]) VALUES ('PRINTERS_PROJECT_ONLY_NON_NON_WARNING_LETTER', 'Printers Project Only-Non.Non Warning Letter', NULL, 0, 'SYSTEM', '2026-03-18 13:48:29.482', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[EnforcementDocType] WHERE [enforcementDocTypeCode] = 'ADMIN_HEARING_APPEAL')
    INSERT INTO [dbo].[EnforcementDocType] ([enforcementDocTypeCode], [enforcementDocTypeName], [enforcementDocTypeDesc], [isDeleted], [createdBy], [createdDt], [lastModifiedBy], [lastModifiedDt]) VALUES ('ADMIN_HEARING_APPEAL', 'Administrative Hearing Appeal', NULL, 0, 'SYSTEM', '2026-03-18 13:48:29.482', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[EnforcementDocType] WHERE [enforcementDocTypeCode] = 'NOTICE_OF_NON_COMPLIANCE')
    INSERT INTO [dbo].[EnforcementDocType] ([enforcementDocTypeCode], [enforcementDocTypeName], [enforcementDocTypeDesc], [isDeleted], [createdBy], [createdDt], [lastModifiedBy], [lastModifiedDt]) VALUES ('NOTICE_OF_NON_COMPLIANCE', 'Notice Of Non-Compliance', NULL, 0, 'SYSTEM', '2026-03-18 13:48:29.482', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[EnforcementDocType] WHERE [enforcementDocTypeCode] = 'FIELD_NOTICE_OF_NON_COMPLIANCE')
    INSERT INTO [dbo].[EnforcementDocType] ([enforcementDocTypeCode], [enforcementDocTypeName], [enforcementDocTypeDesc], [isDeleted], [createdBy], [createdDt], [lastModifiedBy], [lastModifiedDt]) VALUES ('FIELD_NOTICE_OF_NON_COMPLIANCE', 'Field Notice Of Non Compliance', NULL, 0, 'SYSTEM', '2026-03-18 13:48:29.482', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[EnforcementDocType] WHERE [enforcementDocTypeCode] = 'ADMIN_CONSENT_ORDER_NO_PENALTY')
    INSERT INTO [dbo].[EnforcementDocType] ([enforcementDocTypeCode], [enforcementDocTypeName], [enforcementDocTypeDesc], [isDeleted], [createdBy], [createdDt], [lastModifiedBy], [lastModifiedDt]) VALUES ('ADMIN_CONSENT_ORDER_NO_PENALTY', 'Administrative Consent Order, No Penalty', NULL, 0, 'SYSTEM', '2026-03-18 13:48:29.482', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[EnforcementDocType] WHERE [enforcementDocTypeCode] = 'ATTORNEY_GENERAL_ENFORCEMENT_FOR_DEP')
    INSERT INTO [dbo].[EnforcementDocType] ([enforcementDocTypeCode], [enforcementDocTypeName], [enforcementDocTypeDesc], [isDeleted], [createdBy], [createdDt], [lastModifiedBy], [lastModifiedDt]) VALUES ('ATTORNEY_GENERAL_ENFORCEMENT_FOR_DEP', 'Attorney General Enforcement For Dep', NULL, 0, 'SYSTEM', '2026-03-18 13:48:29.482', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[EnforcementDocType] WHERE [enforcementDocTypeCode] = 'ADMIN_CONSENT_ORDER_WITH_PENALTY')
    INSERT INTO [dbo].[EnforcementDocType] ([enforcementDocTypeCode], [enforcementDocTypeName], [enforcementDocTypeDesc], [isDeleted], [createdBy], [createdDt], [lastModifiedBy], [lastModifiedDt]) VALUES ('ADMIN_CONSENT_ORDER_WITH_PENALTY', 'Administrative Consent Order, With Penalty', NULL, 0, 'SYSTEM', '2026-03-18 13:48:29.482', NULL, NULL);
GO

-- Table [dbo].[EnforcementEntityType] is already in sync with DEV.

-- Table [dbo].[EnforcementStatus] is already in sync with DEV.

-- Table [dbo].[EnforcementType] is already in sync with DEV.

-- Table [dbo].[FeeComment] does not exist on destination. Assuming it will be created.
-- Data for FeeComment
IF NOT EXISTS (SELECT 1 FROM [dbo].[FeeComment] WHERE [feeCommentCode] = 'DOUBLE_PERMIT_FEES_IMPOSED')
    INSERT INTO [dbo].[FeeComment] ([feeCommentCode], [feeCommentName], [feeCommentDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('DOUBLE_PERMIT_FEES_IMPOSED', 'DOUBLE PERMIT FEES IMPOSED', NULL, 0, '2026-03-18 15:35:37.170', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[FeeComment] WHERE [feeCommentCode] = 'UNPAID_PREVIOUSLY_UNBILLED_ANNUAL_COMPLIANCE_FEES')
    INSERT INTO [dbo].[FeeComment] ([feeCommentCode], [feeCommentName], [feeCommentDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('UNPAID_PREVIOUSLY_UNBILLED_ANNUAL_COMPLIANCE_FEES', 'AMOUNT REFLECTS "UNPAID, PREVIOUSLY UNBILLED ANNUAL COMPLIANCE FEES"', NULL, 0, '2026-03-18 15:35:37.170', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[FeeComment] WHERE [feeCommentCode] = 'UNPAID_TURA_FEES')
    INSERT INTO [dbo].[FeeComment] ([feeCommentCode], [feeCommentName], [feeCommentDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('UNPAID_TURA_FEES', 'UNPAID TURA FEES', NULL, 0, '2026-03-18 15:35:37.170', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[FeeComment] WHERE [feeCommentCode] = 'OTHER')
    INSERT INTO [dbo].[FeeComment] ([feeCommentCode], [feeCommentName], [feeCommentDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('OTHER', 'OTHER', NULL, 0, '2026-03-18 15:35:37.170', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[FeeComment] WHERE [feeCommentCode] = 'TURA_LATE_FEES')
    INSERT INTO [dbo].[FeeComment] ([feeCommentCode], [feeCommentName], [feeCommentDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('TURA_LATE_FEES', 'TURA LATE FEES', NULL, 0, '2026-03-18 15:35:37.170', 'SYSTEM', NULL, NULL);
GO

-- Table [dbo].[FinancialCondition] does not exist on destination. Assuming it will be created.
-- Data for FinancialCondition
IF NOT EXISTS (SELECT 1 FROM [dbo].[FinancialCondition] WHERE [financialConditionCode] = 'ADJUSTMENT_INTENDED_TO_PROMOTE_A_QUICKER_RETURN_TO_COMPLIANCE_POSITIVE')
    INSERT INTO [dbo].[FinancialCondition] ([financialConditionCode], [financialConditionName], [financialConditionDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('ADJUSTMENT_INTENDED_TO_PROMOTE_A_QUICKER_RETURN_TO_COMPLIANCE_POSITIVE', 'ADJUSTMENT INTENDED TO PROMOTE A QUICKER RETURN TO COMPLIANCE (+)', 'Adjustment is intended to speed up return to compliance', 0, '2026-03-23 14:41:34.072', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[FinancialCondition] WHERE [financialConditionCode] = 'OTHER')
    INSERT INTO [dbo].[FinancialCondition] ([financialConditionCode], [financialConditionName], [financialConditionDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('OTHER', 'OTHER', 'Other financial condition factor', 0, '2026-03-23 14:41:34.072', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[FinancialCondition] WHERE [financialConditionCode] = 'VIOLATOR_PROVIDED_SUFFICIENT_INFORMATION_TO_SUBSTANTIATE_AN_INABILITY_TO_PAY')
    INSERT INTO [dbo].[FinancialCondition] ([financialConditionCode], [financialConditionName], [financialConditionDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('VIOLATOR_PROVIDED_SUFFICIENT_INFORMATION_TO_SUBSTANTIATE_AN_INABILITY_TO_PAY', 'VIOLATOR PROVIDED SUFFICIENT INFORMATION TO SUBSTANTIATE AN "INABILITY TO PAY"', 'Violator provided sufficient information to support an inability to pay claim', 0, '2026-03-23 14:41:34.072', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[FinancialCondition] WHERE [financialConditionCode] = 'PAYMENT_OF_A_PENALTY_WOULD_IMPEDE_THE_ABILITY_TO_CONDUCT_REMEDIAL_MEASURES_NEGATIVE')
    INSERT INTO [dbo].[FinancialCondition] ([financialConditionCode], [financialConditionName], [financialConditionDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('PAYMENT_OF_A_PENALTY_WOULD_IMPEDE_THE_ABILITY_TO_CONDUCT_REMEDIAL_MEASURES_NEGATIVE', 'PAYMENT OF A PENALTY WOULD IMPEDE THE ABILITY TO CONDUCT REMEDIAL MEASURES (-)', 'Penalty payment would interfere with remedial measures', 0, '2026-03-23 14:41:34.072', 'SYSTEM', NULL, NULL);
GO

-- Table [dbo].[MitigationComment] does not exist on destination. Assuming it will be created.
-- Data for MitigationComment
IF NOT EXISTS (SELECT 1 FROM [dbo].[MitigationComment] WHERE [mitigationCommentCode] = 'FINANCIAL_INFORMATION')
    INSERT INTO [dbo].[MitigationComment] ([mitigationCommentCode], [mitigationCommentName], [mitigationCommentDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('FINANCIAL_INFORMATION', 'PENALTY WAS DETERMINED AFTER CONSIDERING VIOLATOR''S FINANCIAL INFORMATION', NULL, 0, '2026-03-18 14:15:25.076', 'system', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[MitigationComment] WHERE [mitigationCommentCode] = 'HOMEOWNER_POLICY_DEFINITION')
    INSERT INTO [dbo].[MitigationComment] ([mitigationCommentCode], [mitigationCommentName], [mitigationCommentDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('HOMEOWNER_POLICY_DEFINITION', 'VIOLATOR QUALIFIES AS A "HOMEOWNER" BY POLICY DEFINITION', NULL, 0, '2026-03-18 14:15:25.076', 'system', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[MitigationComment] WHERE [mitigationCommentCode] = 'OTHER')
    INSERT INTO [dbo].[MitigationComment] ([mitigationCommentCode], [mitigationCommentName], [mitigationCommentDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('OTHER', 'OTHER', NULL, 0, '2026-03-18 14:15:25.076', 'system', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[MitigationComment] WHERE [mitigationCommentCode] = 'SMALL_BUSINESS_POLICY_DEFINITION')
    INSERT INTO [dbo].[MitigationComment] ([mitigationCommentCode], [mitigationCommentName], [mitigationCommentDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('SMALL_BUSINESS_POLICY_DEFINITION', 'VIOLATOR QUALIFIES AS A "SMALL BUSINESS" BY POLICY DEFINITION', NULL, 0, '2026-03-18 14:15:25.076', 'system', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[MitigationComment] WHERE [mitigationCommentCode] = 'SEP_ADEQUATE_NEXUS')
    INSERT INTO [dbo].[MitigationComment] ([mitigationCommentCode], [mitigationCommentName], [mitigationCommentDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('SEP_ADEQUATE_NEXUS', 'VIOLATOR PROPOSED A SEP REFLECTING ADEQUATE NEXUS', NULL, 0, '2026-03-18 14:15:25.076', 'system', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[MitigationComment] WHERE [mitigationCommentCode] = 'STATE_AGENCY')
    INSERT INTO [dbo].[MitigationComment] ([mitigationCommentCode], [mitigationCommentName], [mitigationCommentDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('STATE_AGENCY', 'VIOLATOR IS A "STATE AGENCY"', NULL, 0, '2026-03-18 14:15:25.076', 'system', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[MitigationComment] WHERE [mitigationCommentCode] = 'VIOLATOR_SELF_DISCLOSED_CITED_VIOLATIONS')
    INSERT INTO [dbo].[MitigationComment] ([mitigationCommentCode], [mitigationCommentName], [mitigationCommentDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('VIOLATOR_SELF_DISCLOSED_CITED_VIOLATIONS', 'VIOLATOR SELF-DISCLOSED THE CITED VIOLATIONS', NULL, 0, '2026-03-18 14:15:25.076', 'system', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[MitigationComment] WHERE [mitigationCommentCode] = 'MUNICIPALITY_POLICY_DEFINITION')
    INSERT INTO [dbo].[MitigationComment] ([mitigationCommentCode], [mitigationCommentName], [mitigationCommentDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('MUNICIPALITY_POLICY_DEFINITION', 'VIOLATOR QUALIFIES AS A "MUNICIPALITY" UNDER POLICY DEFINITION', NULL, 0, '2026-03-18 14:15:25.076', 'system', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[MitigationComment] WHERE [mitigationCommentCode] = 'EARLY_SETTLEMENT_GUIDANCE')
    INSERT INTO [dbo].[MitigationComment] ([mitigationCommentCode], [mitigationCommentName], [mitigationCommentDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('EARLY_SETTLEMENT_GUIDANCE', 'PENALTY WAS DETERMINED AFTER CONSIDERING MASSDEP''S GUIDANCE FOR EARLY SETTLEMENT', NULL, 0, '2026-03-18 14:15:25.076', 'system', NULL, NULL);
GO

-- Table [dbo].[MitigationReason] does not exist on destination. Assuming it will be created.
-- Data for MitigationReason
IF NOT EXISTS (SELECT 1 FROM [dbo].[MitigationReason] WHERE [mitigationReasonCode] = 'MUNICIPAL')
    INSERT INTO [dbo].[MitigationReason] ([mitigationReasonCode], [mitigationReasonName], [mitigationReasonDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('MUNICIPAL', 'MUNICIPAL', NULL, 0, '2026-03-18 14:15:25.037', 'system', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[MitigationReason] WHERE [mitigationReasonCode] = 'AUDIT_SELF_REPORTING')
    INSERT INTO [dbo].[MitigationReason] ([mitigationReasonCode], [mitigationReasonName], [mitigationReasonDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('AUDIT_SELF_REPORTING', 'AUDIT - SELF REPORTING', NULL, 0, '2026-03-18 14:15:25.037', 'system', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[MitigationReason] WHERE [mitigationReasonCode] = 'SEP')
    INSERT INTO [dbo].[MitigationReason] ([mitigationReasonCode], [mitigationReasonName], [mitigationReasonDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('SEP', 'SEP', NULL, 0, '2026-03-18 14:15:25.037', 'system', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[MitigationReason] WHERE [mitigationReasonCode] = 'STATE_AGENCY')
    INSERT INTO [dbo].[MitigationReason] ([mitigationReasonCode], [mitigationReasonName], [mitigationReasonDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('STATE_AGENCY', 'STATE AGENCY', NULL, 0, '2026-03-18 14:15:25.037', 'system', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[MitigationReason] WHERE [mitigationReasonCode] = 'HOMEOWNER_POLICY')
    INSERT INTO [dbo].[MitigationReason] ([mitigationReasonCode], [mitigationReasonName], [mitigationReasonDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('HOMEOWNER_POLICY', 'HOMEOWNER POLICY', NULL, 0, '2026-03-18 14:15:25.037', 'system', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[MitigationReason] WHERE [mitigationReasonCode] = 'FINANCIAL')
    INSERT INTO [dbo].[MitigationReason] ([mitigationReasonCode], [mitigationReasonName], [mitigationReasonDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('FINANCIAL', 'FINANCIAL', NULL, 0, '2026-03-18 14:15:25.037', 'system', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[MitigationReason] WHERE [mitigationReasonCode] = 'EARLY_SETTLEMENT')
    INSERT INTO [dbo].[MitigationReason] ([mitigationReasonCode], [mitigationReasonName], [mitigationReasonDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('EARLY_SETTLEMENT', 'EARLY SETTLEMENT', NULL, 0, '2026-03-18 14:15:25.037', 'system', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[MitigationReason] WHERE [mitigationReasonCode] = 'SMALL_BUSINESS')
    INSERT INTO [dbo].[MitigationReason] ([mitigationReasonCode], [mitigationReasonName], [mitigationReasonDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('SMALL_BUSINESS', 'SMALL BUSINESS', NULL, 0, '2026-03-18 14:15:25.037', 'system', NULL, NULL);
GO

-- Table [dbo].[OtherFactor] does not exist on destination. Assuming it will be created.
-- Data for OtherFactor
IF NOT EXISTS (SELECT 1 FROM [dbo].[OtherFactor] WHERE [otherFactorCode] = 'ACTUAL_ENVIRONMENTAL_IMPACT_IDENTIFIED')
    INSERT INTO [dbo].[OtherFactor] ([otherFactorCode], [otherFactorName], [otherFactorDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('ACTUAL_ENVIRONMENTAL_IMPACT_IDENTIFIED', 'ACTUAL ENVIRONMENTAL IMPACT IDENTIFIED', 'Actual environmental impact identified', 0, '2026-03-23 14:40:51.338', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[OtherFactor] WHERE [otherFactorCode] = 'ACTUAL_PUBLIC_SAFETY_AND_WELFARE_IMPACT_IDENTIFIED')
    INSERT INTO [dbo].[OtherFactor] ([otherFactorCode], [otherFactorName], [otherFactorDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('ACTUAL_PUBLIC_SAFETY_AND_WELFARE_IMPACT_IDENTIFIED', 'ACTUAL PUBLIC SAFETY AND WELFARE IMPACT IDENTIFIED', 'Actual public safety and welfare impact identified', 0, '2026-03-23 14:40:51.338', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[OtherFactor] WHERE [otherFactorCode] = 'POTENTIAL_PUBLIC_SAFETY_AND_WELFARE_IMPACT_IDENTIFIED')
    INSERT INTO [dbo].[OtherFactor] ([otherFactorCode], [otherFactorName], [otherFactorDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('POTENTIAL_PUBLIC_SAFETY_AND_WELFARE_IMPACT_IDENTIFIED', 'POTENTIAL PUBLIC SAFETY AND WELFARE IMPACT IDENTIFIED', 'Potential public safety and welfare impact identified', 0, '2026-03-23 14:40:51.338', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[OtherFactor] WHERE [otherFactorCode] = 'POTENTIAL_PUBLIC_HEALTH_IMPACT_IDENTIFIED')
    INSERT INTO [dbo].[OtherFactor] ([otherFactorCode], [otherFactorName], [otherFactorDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('POTENTIAL_PUBLIC_HEALTH_IMPACT_IDENTIFIED', 'POTENTIAL PUBLIC HEALTH IMPACT IDENTIFIED', 'Potential public health impact identified', 0, '2026-03-23 14:40:51.338', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[OtherFactor] WHERE [otherFactorCode] = 'ACTUAL_PUBLIC_HEALTH_IMPACT_IDENTIFIED')
    INSERT INTO [dbo].[OtherFactor] ([otherFactorCode], [otherFactorName], [otherFactorDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('ACTUAL_PUBLIC_HEALTH_IMPACT_IDENTIFIED', 'ACTUAL PUBLIC HEALTH IMPACT IDENTIFIED', 'Actual public health impact identified', 0, '2026-03-23 14:40:51.338', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[OtherFactor] WHERE [otherFactorCode] = 'POTENTIAL_ENVIRONMENTAL_IMPACT_IDENTIFIED')
    INSERT INTO [dbo].[OtherFactor] ([otherFactorCode], [otherFactorName], [otherFactorDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('POTENTIAL_ENVIRONMENTAL_IMPACT_IDENTIFIED', 'POTENTIAL ENVIRONMENTAL IMPACT IDENTIFIED', 'Potential environmental impact identified', 0, '2026-03-23 14:40:51.338', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[OtherFactor] WHERE [otherFactorCode] = 'OTHER')
    INSERT INTO [dbo].[OtherFactor] ([otherFactorCode], [otherFactorName], [otherFactorDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('OTHER', 'OTHER', 'Other factor', 0, '2026-03-23 14:40:51.338', 'SYSTEM', NULL, NULL);
GO

-- Table [dbo].[OtherPersonAssessed] does not exist on destination. Assuming it will be created.
-- Data for OtherPersonAssessed
IF NOT EXISTS (SELECT 1 FROM [dbo].[OtherPersonAssessed] WHERE [otherPersonAssessedCode] = 'OTHER')
    INSERT INTO [dbo].[OtherPersonAssessed] ([otherPersonAssessedCode], [otherPersonAssessedName], [otherPersonAssessedDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('OTHER', 'OTHER', 'Other assessment factor for other persons', 0, '2026-03-23 14:44:15.461', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[OtherPersonAssessed] WHERE [otherPersonAssessedCode] = 'DETER_FUTURE_VIOLATIONS_BY_OTHERS_IN_SIMILAR_INDUSTRY')
    INSERT INTO [dbo].[OtherPersonAssessed] ([otherPersonAssessedCode], [otherPersonAssessedName], [otherPersonAssessedDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('DETER_FUTURE_VIOLATIONS_BY_OTHERS_IN_SIMILAR_INDUSTRY', 'DETER FUTURE VIOLATIONS BY OTHERS IN SIMILAR INDUSTRY', 'Deterrence of future violations by others in similar industry', 0, '2026-03-23 14:44:15.461', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[OtherPersonAssessed] WHERE [otherPersonAssessedCode] = 'DETER_FUTURE_VIOLATIONS_BY_OTHERS')
    INSERT INTO [dbo].[OtherPersonAssessed] ([otherPersonAssessedCode], [otherPersonAssessedName], [otherPersonAssessedDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('DETER_FUTURE_VIOLATIONS_BY_OTHERS', 'DETER FUTURE VIOLATIONS BY OTHERS', 'Deterrence of future violations by others', 0, '2026-03-23 14:44:15.461', 'SYSTEM', NULL, NULL);
GO

-- Table [dbo].[PersonAssessed] does not exist on destination. Assuming it will be created.
-- Data for PersonAssessed
IF NOT EXISTS (SELECT 1 FROM [dbo].[PersonAssessed] WHERE [personAssessedCode] = 'OTHER')
    INSERT INTO [dbo].[PersonAssessed] ([personAssessedCode], [personAssessedName], [personAssessedDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('OTHER', 'OTHER', 'Other assessment factor', 0, '2026-03-23 14:17:25.283', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[PersonAssessed] WHERE [personAssessedCode] = 'DETER_FUTURE_VIOLATIONS_AT_THIS_OR_OTHER_FACILITIES_POSITIVE')
    INSERT INTO [dbo].[PersonAssessed] ([personAssessedCode], [personAssessedName], [personAssessedDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('DETER_FUTURE_VIOLATIONS_AT_THIS_OR_OTHER_FACILITIES_POSITIVE', 'DETER FUTURE VIOLATIONS AT THIS OR OTHER FACILITIES (+)', 'Deterrence of future violations', 0, '2026-03-23 14:17:25.283', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[PersonAssessed] WHERE [personAssessedCode] = 'MAKE_COMPLIANCE_LESS_COSTLY_THAN_NON_COMPLIANCE_POSITIVE')
    INSERT INTO [dbo].[PersonAssessed] ([personAssessedCode], [personAssessedName], [personAssessedDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('MAKE_COMPLIANCE_LESS_COSTLY_THAN_NON_COMPLIANCE_POSITIVE', 'MAKE COMPLIANCE LESS COSTLY THAN NON-COMPLIANCE (+)', 'Encourage compliance by making it less costly than non-compliance', 0, '2026-03-23 14:17:25.283', 'SYSTEM', NULL, NULL);
GO

-- Table [dbo].[PotentialDamage] does not exist on destination. Assuming it will be created.
-- Data for PotentialDamage
IF NOT EXISTS (SELECT 1 FROM [dbo].[PotentialDamage] WHERE [potentialDamageCode] = 'POTENTIAL_COSTS_DAMAGES_INCURRED_BY_THE_COMMONWEALTH')
    INSERT INTO [dbo].[PotentialDamage] ([potentialDamageCode], [potentialDamageName], [potentialDamageDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('POTENTIAL_COSTS_DAMAGES_INCURRED_BY_THE_COMMONWEALTH', 'POTENTIAL COSTS/DAMAGES INCURRED BY THE COMMONWEALTH', NULL, 0, '2026-03-23 13:41:57.886', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[PotentialDamage] WHERE [potentialDamageCode] = 'POTENTIAL_COSTS_DAMAGES_INCURRED_BY_OTHERS')
    INSERT INTO [dbo].[PotentialDamage] ([potentialDamageCode], [potentialDamageName], [potentialDamageDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('POTENTIAL_COSTS_DAMAGES_INCURRED_BY_OTHERS', 'POTENTIAL COSTS/DAMAGES INCURRED BY OTHERS', NULL, 0, '2026-03-23 13:41:57.886', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[PotentialDamage] WHERE [potentialDamageCode] = 'ACTUAL_COSTS_DAMAGES_INCURRED_BY_THE_COMMONWEALTH')
    INSERT INTO [dbo].[PotentialDamage] ([potentialDamageCode], [potentialDamageName], [potentialDamageDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('ACTUAL_COSTS_DAMAGES_INCURRED_BY_THE_COMMONWEALTH', 'ACTUAL COSTS/DAMAGES INCURRED BY THE COMMONWEALTH', NULL, 0, '2026-03-23 13:41:57.886', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[PotentialDamage] WHERE [potentialDamageCode] = 'OTHER')
    INSERT INTO [dbo].[PotentialDamage] ([potentialDamageCode], [potentialDamageName], [potentialDamageDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('OTHER', 'OTHER', NULL, 0, '2026-03-23 13:41:57.886', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[PotentialDamage] WHERE [potentialDamageCode] = 'ACTUAL_COSTS_DAMAGES_INCURRED_BY_OTHERS')
    INSERT INTO [dbo].[PotentialDamage] ([potentialDamageCode], [potentialDamageName], [potentialDamageDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('ACTUAL_COSTS_DAMAGES_INCURRED_BY_OTHERS', 'ACTUAL COSTS/DAMAGES INCURRED BY OTHERS', NULL, 0, '2026-03-23 13:41:57.886', 'SYSTEM', NULL, NULL);
GO

-- Table [dbo].[PotentialImpact] does not exist on destination. Assuming it will be created.
-- Data for PotentialImpact
IF NOT EXISTS (SELECT 1 FROM [dbo].[PotentialImpact] WHERE [potentialImpactCode] = 'OTHER')
    INSERT INTO [dbo].[PotentialImpact] ([potentialImpactCode], [potentialImpactName], [potentialImpactDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('OTHER', 'OTHER', NULL, 0, '2026-03-23 13:42:35.825', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[PotentialImpact] WHERE [potentialImpactCode] = 'ACTUAL_ENVIRONMENTAL_IMPACT_IDENTIFIED')
    INSERT INTO [dbo].[PotentialImpact] ([potentialImpactCode], [potentialImpactName], [potentialImpactDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('ACTUAL_ENVIRONMENTAL_IMPACT_IDENTIFIED', 'ACTUAL ENVIRONMENTAL IMPACT IDENTIFIED', NULL, 0, '2026-03-23 13:42:35.825', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[PotentialImpact] WHERE [potentialImpactCode] = 'ACTUAL_PUBLIC_HEALTH_IMPACT_IDENTIFIED')
    INSERT INTO [dbo].[PotentialImpact] ([potentialImpactCode], [potentialImpactName], [potentialImpactDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('ACTUAL_PUBLIC_HEALTH_IMPACT_IDENTIFIED', 'ACTUAL PUBLIC HEALTH IMPACT IDENTIFIED', NULL, 0, '2026-03-23 13:42:35.825', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[PotentialImpact] WHERE [potentialImpactCode] = 'ACTUAL_PUBLIC_SAFETY_AND_WELFARE_IMPACT_IDENTIFIED')
    INSERT INTO [dbo].[PotentialImpact] ([potentialImpactCode], [potentialImpactName], [potentialImpactDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('ACTUAL_PUBLIC_SAFETY_AND_WELFARE_IMPACT_IDENTIFIED', 'ACTUAL PUBLIC SAFETY AND WELFARE IMPACT IDENTIFIED', NULL, 0, '2026-03-23 13:42:35.825', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[PotentialImpact] WHERE [potentialImpactCode] = 'POTENTIAL_PUBLIC_HEALTH_IMPACT_IDENTIFIED')
    INSERT INTO [dbo].[PotentialImpact] ([potentialImpactCode], [potentialImpactName], [potentialImpactDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('POTENTIAL_PUBLIC_HEALTH_IMPACT_IDENTIFIED', 'POTENTIAL PUBLIC HEALTH IMPACT IDENTIFIED', NULL, 0, '2026-03-23 13:42:35.825', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[PotentialImpact] WHERE [potentialImpactCode] = 'POTENTIAL_ENVIRONMENTAL_IMPACT_IDENTIFIED')
    INSERT INTO [dbo].[PotentialImpact] ([potentialImpactCode], [potentialImpactName], [potentialImpactDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('POTENTIAL_ENVIRONMENTAL_IMPACT_IDENTIFIED', 'POTENTIAL ENVIRONMENTAL IMPACT IDENTIFIED', NULL, 0, '2026-03-23 13:42:35.825', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[PotentialImpact] WHERE [potentialImpactCode] = 'POTENTIAL_PUBLIC_SAFETY_AND_WELFARE_IMPACT_IDENTIFIED')
    INSERT INTO [dbo].[PotentialImpact] ([potentialImpactCode], [potentialImpactName], [potentialImpactDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('POTENTIAL_PUBLIC_SAFETY_AND_WELFARE_IMPACT_IDENTIFIED', 'POTENTIAL PUBLIC SAFETY AND WELFARE IMPACT IDENTIFIED', NULL, 0, '2026-03-23 13:42:35.825', 'SYSTEM', NULL, NULL);
GO

-- Table [dbo].[PreviousFailureToComply] does not exist on destination. Assuming it will be created.
-- Data for PreviousFailureToComply
IF NOT EXISTS (SELECT 1 FROM [dbo].[PreviousFailureToComply] WHERE [previousFailureToComplyCode] = 'MORE_THAN_ONE_VIOLATION_AT_THE_SAME_OR_OTHER_FACILITIES')
    INSERT INTO [dbo].[PreviousFailureToComply] ([previousFailureToComplyCode], [previousFailureToComplyName], [previousFailureToComplyDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('MORE_THAN_ONE_VIOLATION_AT_THE_SAME_OR_OTHER_FACILITIES', 'MORE THAN ONE VIOLATION AT THE SAME OR OTHER FACILITIES', 'Multiple violations across facilities', 0, '2026-03-23 14:08:33.295', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[PreviousFailureToComply] WHERE [previousFailureToComplyCode] = 'HIGHER_LEVEL_ENFORCEMENT_PENDING_OTHER_PROGRAMS_POSITIVE_ONLY')
    INSERT INTO [dbo].[PreviousFailureToComply] ([previousFailureToComplyCode], [previousFailureToComplyName], [previousFailureToComplyDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('HIGHER_LEVEL_ENFORCEMENT_PENDING_OTHER_PROGRAMS_POSITIVE_ONLY', 'HIGHER-LEVEL ENFORCEMENT PENDING (OTHER PROGRAM(S)) (+ ONLY)', 'Pending higher-level enforcement actions', 0, '2026-03-23 14:08:33.295', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[PreviousFailureToComply] WHERE [previousFailureToComplyCode] = 'LOWER_LEVEL_ENFORCEMENT_PENDING_OTHER_PROGRAMS_POSITIVE_ONLY')
    INSERT INTO [dbo].[PreviousFailureToComply] ([previousFailureToComplyCode], [previousFailureToComplyName], [previousFailureToComplyDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('LOWER_LEVEL_ENFORCEMENT_PENDING_OTHER_PROGRAMS_POSITIVE_ONLY', 'LOWER-LEVEL ENFORCEMENT PENDING (OTHER PROGRAM(S)) (+ ONLY)', 'Pending lower-level enforcement actions', 0, '2026-03-23 14:08:33.295', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[PreviousFailureToComply] WHERE [previousFailureToComplyCode] = 'LOWER_LEVEL_ENFORCEMENT_PREVIOUSLY_ISSUED_POSITIVE_ONLY')
    INSERT INTO [dbo].[PreviousFailureToComply] ([previousFailureToComplyCode], [previousFailureToComplyName], [previousFailureToComplyDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('LOWER_LEVEL_ENFORCEMENT_PREVIOUSLY_ISSUED_POSITIVE_ONLY', 'LOWER-LEVEL ENFORCEMENT PREVIOUSLY ISSUED (+ ONLY)', 'Previously issued lower-level enforcement', 0, '2026-03-23 14:08:33.295', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[PreviousFailureToComply] WHERE [previousFailureToComplyCode] = 'OTHER')
    INSERT INTO [dbo].[PreviousFailureToComply] ([previousFailureToComplyCode], [previousFailureToComplyName], [previousFailureToComplyDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('OTHER', 'OTHER', 'Other type of failure to comply', 0, '2026-03-23 14:08:33.295', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[PreviousFailureToComply] WHERE [previousFailureToComplyCode] = 'SIMILAR_RECENT_VIOLATIONS_AT_THE_SAME_OR_OTHER_FACILITIES')
    INSERT INTO [dbo].[PreviousFailureToComply] ([previousFailureToComplyCode], [previousFailureToComplyName], [previousFailureToComplyDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('SIMILAR_RECENT_VIOLATIONS_AT_THE_SAME_OR_OTHER_FACILITIES', 'SIMILAR/RECENT VIOLATIONS AT THE SAME OR OTHER FACILITIES', 'History of similar or recent violations', 0, '2026-03-23 14:08:33.295', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[PreviousFailureToComply] WHERE [previousFailureToComplyCode] = 'HIGHER_LEVEL_ENFORCEMENT_PREVIOUSLY_ISSUED_POSITIVE_ONLY')
    INSERT INTO [dbo].[PreviousFailureToComply] ([previousFailureToComplyCode], [previousFailureToComplyName], [previousFailureToComplyDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('HIGHER_LEVEL_ENFORCEMENT_PREVIOUSLY_ISSUED_POSITIVE_ONLY', 'HIGHER-LEVEL ENFORCEMENT PREVIOUSLY ISSUED (+ ONLY)', 'Previously issued higher-level enforcement', 0, '2026-03-23 14:08:33.295', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[PreviousFailureToComply] WHERE [previousFailureToComplyCode] = 'OTHER_ENFORCEMENT_PENDING_AG_DA_EPA_LOCAL_COMMUNITY_ETC_POSITIVE_ONLY')
    INSERT INTO [dbo].[PreviousFailureToComply] ([previousFailureToComplyCode], [previousFailureToComplyName], [previousFailureToComplyDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('OTHER_ENFORCEMENT_PENDING_AG_DA_EPA_LOCAL_COMMUNITY_ETC_POSITIVE_ONLY', 'OTHER ENFORCEMENT PENDING (AG, DA, EPA, LOCAL COMMUNITY, ETC.) (+ ONLY)', 'Other pending enforcement from agencies', 0, '2026-03-23 14:08:33.295', 'SYSTEM', NULL, NULL);
GO

-- Table [dbo].[Profit] does not exist on destination. Assuming it will be created.
-- Data for Profit
IF NOT EXISTS (SELECT 1 FROM [dbo].[Profit] WHERE [profitCode] = 'ACTUAL_ENVIRONMENTAL_IMPACT_IDENTIFIED')
    INSERT INTO [dbo].[Profit] ([profitCode], [profitName], [profitDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('ACTUAL_ENVIRONMENTAL_IMPACT_IDENTIFIED', 'ACTUAL ENVIRONMENTAL IMPACT IDENTIFIED', 'Actual environmental impact identified', 0, '2026-03-23 14:57:57.448', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Profit] WHERE [profitCode] = 'POTENTIAL_ENVIRONMENTAL_IMPACT_IDENTIFIED')
    INSERT INTO [dbo].[Profit] ([profitCode], [profitName], [profitDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('POTENTIAL_ENVIRONMENTAL_IMPACT_IDENTIFIED', 'POTENTIAL ENVIRONMENTAL IMPACT IDENTIFIED', 'Potential environmental impact identified', 0, '2026-03-23 14:57:57.448', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Profit] WHERE [profitCode] = 'OTHER')
    INSERT INTO [dbo].[Profit] ([profitCode], [profitName], [profitDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('OTHER', 'OTHER', 'Other profit economic benefit factor', 0, '2026-03-23 14:57:57.448', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Profit] WHERE [profitCode] = 'ACTUAL_PUBLIC_HEALTH_IMPACT_IDENTIFIED')
    INSERT INTO [dbo].[Profit] ([profitCode], [profitName], [profitDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('ACTUAL_PUBLIC_HEALTH_IMPACT_IDENTIFIED', 'ACTUAL PUBLIC HEALTH IMPACT IDENTIFIED', 'Actual public health impact identified', 0, '2026-03-23 14:57:57.448', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Profit] WHERE [profitCode] = 'POTENTIAL_PUBLIC_HEALTH_IMPACT_IDENTIFIED')
    INSERT INTO [dbo].[Profit] ([profitCode], [profitName], [profitDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('POTENTIAL_PUBLIC_HEALTH_IMPACT_IDENTIFIED', 'POTENTIAL PUBLIC HEALTH IMPACT IDENTIFIED', 'Potential public health impact identified', 0, '2026-03-23 14:57:57.448', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Profit] WHERE [profitCode] = 'POTENTIAL_PUBLIC_SAFETY_AND_WELFARE_IMPACT_IDENTIFIED')
    INSERT INTO [dbo].[Profit] ([profitCode], [profitName], [profitDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('POTENTIAL_PUBLIC_SAFETY_AND_WELFARE_IMPACT_IDENTIFIED', 'POTENTIAL PUBLIC SAFETY AND WELFARE IMPACT IDENTIFIED', 'Potential public safety and welfare impact identified', 0, '2026-03-23 14:57:57.448', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Profit] WHERE [profitCode] = 'ACTUAL_PUBLIC_SAFETY_AND_WELFARE_IMPACT_IDENTIFIED')
    INSERT INTO [dbo].[Profit] ([profitCode], [profitName], [profitDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('ACTUAL_PUBLIC_SAFETY_AND_WELFARE_IMPACT_IDENTIFIED', 'ACTUAL PUBLIC SAFETY AND WELFARE IMPACT IDENTIFIED', 'Actual public safety and welfare impact identified', 0, '2026-03-23 14:57:57.448', 'SYSTEM', NULL, NULL);
GO

-- Table [dbo].[PublicInterest] does not exist on destination. Assuming it will be created.
-- Data for PublicInterest
IF NOT EXISTS (SELECT 1 FROM [dbo].[PublicInterest] WHERE [publicInterestCode] = 'VIOLATION_AFFECTS_A_MASSGIS_MAPPED_ENVIRONMENTAL_JUSTICE_EJ_POPULATION_POSITIVE')
    INSERT INTO [dbo].[PublicInterest] ([publicInterestCode], [publicInterestName], [publicInterestDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('VIOLATION_AFFECTS_A_MASSGIS_MAPPED_ENVIRONMENTAL_JUSTICE_EJ_POPULATION_POSITIVE', 'VIOLATION AFFECTS A MASSGIS MAPPED ENVIRONMENTAL JUSTICE (EJ) POPULATION (+)', 'Violation impacts an environmental justice population', 0, '2026-03-23 14:24:03.905', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[PublicInterest] WHERE [publicInterestCode] = 'PAYMENT_OF_A_PENALTY_WOULD_THREATEN_THE_CONTINUED_PROVISION_OF_AN_ESSENTIAL_SERVICE_NEGATIVE')
    INSERT INTO [dbo].[PublicInterest] ([publicInterestCode], [publicInterestName], [publicInterestDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('PAYMENT_OF_A_PENALTY_WOULD_THREATEN_THE_CONTINUED_PROVISION_OF_AN_ESSENTIAL_SERVICE_NEGATIVE', 'PAYMENT OF A PENALTY WOULD THREATEN THE CONTINUED PROVISION OF AN ESSENTIAL SERVICE (-)', 'Penalty payment could threaten essential service provision', 0, '2026-03-23 14:24:03.905', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[PublicInterest] WHERE [publicInterestCode] = 'OTHER')
    INSERT INTO [dbo].[PublicInterest] ([publicInterestCode], [publicInterestName], [publicInterestDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('OTHER', 'OTHER', 'Other public interest factor', 0, '2026-03-23 14:24:03.905', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[PublicInterest] WHERE [publicInterestCode] = 'LITIGATION_MIGHT_IMPEDE_THE_DEPARTMENTS_ABILITY_TO_ENFORCE_LAWS_AND_REGULATIONS')
    INSERT INTO [dbo].[PublicInterest] ([publicInterestCode], [publicInterestName], [publicInterestDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('LITIGATION_MIGHT_IMPEDE_THE_DEPARTMENTS_ABILITY_TO_ENFORCE_LAWS_AND_REGULATIONS', 'LITIGATION MIGHT IMPEDE THE DEPARTMENT''S ABILITY TO ENFORCE LAWS/REGULATIONS', 'Litigation may hinder enforcement capability', 0, '2026-03-23 14:24:03.905', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[PublicInterest] WHERE [publicInterestCode] = 'PAYMENT_OF_A_PENALTY_COULD_CAUSE_VIOLATOR_TO_CHOOSE_BETWEEN_PAYING_PENALTY_OR_REMEDIATION')
    INSERT INTO [dbo].[PublicInterest] ([publicInterestCode], [publicInterestName], [publicInterestDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('PAYMENT_OF_A_PENALTY_COULD_CAUSE_VIOLATOR_TO_CHOOSE_BETWEEN_PAYING_PENALTY_OR_REMEDIATION', 'PAYMENT OF A PENALTY COULD CAUSE VIOLATOR TO CHOOSE BETWEEN PAYING PENALTY OR REMEDIATION', 'Penalty may force tradeoff between payment and remediation', 0, '2026-03-23 14:24:03.905', 'SYSTEM', NULL, NULL);
GO

-- Table [dbo].[RemedyAndMitigate] does not exist on destination. Assuming it will be created.
-- Data for RemedyAndMitigate
IF NOT EXISTS (SELECT 1 FROM [dbo].[RemedyAndMitigate] WHERE [remedyAndMitigateCode] = 'VIOLATORS_RESPONSE_WENT_BEYOND_THE_EXPECTED_STEPS_TO_REMEDY_THE_VIOLATION_NEGATIVE')
    INSERT INTO [dbo].[RemedyAndMitigate] ([remedyAndMitigateCode], [remedyAndMitigateName], [remedyAndMitigateDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('VIOLATORS_RESPONSE_WENT_BEYOND_THE_EXPECTED_STEPS_TO_REMEDY_THE_VIOLATION_NEGATIVE', 'VIOLATOR''S RESPONSE WENT BEYOND THE EXPECTED STEPS TO REMEDY THE VIOLATION (-)', 'Violator response exceeded expected remedy steps', 0, '2026-03-23 14:14:29.165', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[RemedyAndMitigate] WHERE [remedyAndMitigateCode] = 'VIOLATORS_RESPONSE_WAS_NOT_TIMELY_AND_OR_ADEQUATE_POSITIVE')
    INSERT INTO [dbo].[RemedyAndMitigate] ([remedyAndMitigateCode], [remedyAndMitigateName], [remedyAndMitigateDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('VIOLATORS_RESPONSE_WAS_NOT_TIMELY_AND_OR_ADEQUATE_POSITIVE', 'VIOLATOR''S RESPONSE WAS NOT TIMELY AND/OR ADEQUATE (+)', 'Violator response was not timely and/or adequate', 0, '2026-03-23 14:14:29.165', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[RemedyAndMitigate] WHERE [remedyAndMitigateCode] = 'VIOLATOR_HAD_DID_NOT_HAVE_CONTROL_OVER_THE_SPEED_OF_REMEDY_POSITIVE_NEGATIVE')
    INSERT INTO [dbo].[RemedyAndMitigate] ([remedyAndMitigateCode], [remedyAndMitigateName], [remedyAndMitigateDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('VIOLATOR_HAD_DID_NOT_HAVE_CONTROL_OVER_THE_SPEED_OF_REMEDY_POSITIVE_NEGATIVE', 'VIOLATOR HAD/DID NOT HAVE CONTROL OVER THE SPEED OF REMEDY (+/-)', 'Violator had or did not have control over the speed of remedy', 0, '2026-03-23 14:14:29.165', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[RemedyAndMitigate] WHERE [remedyAndMitigateCode] = 'CORRECTED_FAILED_TO_MITIGATE_HARM_AT_OR_AFTER_AN_INSPECTION_NEGATIVE_POSITIVE')
    INSERT INTO [dbo].[RemedyAndMitigate] ([remedyAndMitigateCode], [remedyAndMitigateName], [remedyAndMitigateDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('CORRECTED_FAILED_TO_MITIGATE_HARM_AT_OR_AFTER_AN_INSPECTION_NEGATIVE_POSITIVE', 'CORRECTED/FAILED TO MITIGATE HARM AT OR AFTER AN INSPECTION (-/+)', 'Corrected or failed to mitigate harm at or after an inspection', 0, '2026-03-23 14:14:29.165', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[RemedyAndMitigate] WHERE [remedyAndMitigateCode] = 'RETAINED_FAILED_TO_RETAIN_APPROPRIATE_PROFESSIONAL_NEGATIVE_POSITIVE')
    INSERT INTO [dbo].[RemedyAndMitigate] ([remedyAndMitigateCode], [remedyAndMitigateName], [remedyAndMitigateDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('RETAINED_FAILED_TO_RETAIN_APPROPRIATE_PROFESSIONAL_NEGATIVE_POSITIVE', 'RETAINED/FAILED TO RETAIN APPROPRIATE PROFESSIONAL (LSP, PE, SCIENTIST/SPECIALIST) (-/+)', 'Retained or failed to retain appropriate professional support', 0, '2026-03-23 14:14:29.165', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[RemedyAndMitigate] WHERE [remedyAndMitigateCode] = 'OTHER')
    INSERT INTO [dbo].[RemedyAndMitigate] ([remedyAndMitigateCode], [remedyAndMitigateName], [remedyAndMitigateDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('OTHER', 'OTHER', 'Other remedy and mitigation factor', 0, '2026-03-23 14:14:29.165', 'SYSTEM', NULL, NULL);
GO

-- Table [dbo].[Section] is already in sync with DEV.

-- Table [dbo].[StaffRole] is already in sync with DEV.

-- Table [dbo].[StepsToPrevent] does not exist on destination. Assuming it will be created.
-- Data for StepsToPrevent
IF NOT EXISTS (SELECT 1 FROM [dbo].[StepsToPrevent] WHERE [stepsToPreventCode] = 'VIOLATOR_KNEW_OF_THE_LEGAL_REQUIREMENTS_POSITIVE_ONLY')
    INSERT INTO [dbo].[StepsToPrevent] ([stepsToPreventCode], [stepsToPreventName], [stepsToPreventDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('VIOLATOR_KNEW_OF_THE_LEGAL_REQUIREMENTS_POSITIVE_ONLY', 'VIOLATOR KNEW OF THE LEGAL REQUIREMENTS (+ ONLY)', 'Violator was aware of legal requirements', 0, '2026-03-23 14:11:54.563', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[StepsToPrevent] WHERE [stepsToPreventCode] = 'FAILURE_TO_EMPLOY_BEST_MANAGEMENT_PRACTICES_POSITIVE')
    INSERT INTO [dbo].[StepsToPrevent] ([stepsToPreventCode], [stepsToPreventName], [stepsToPreventDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('FAILURE_TO_EMPLOY_BEST_MANAGEMENT_PRACTICES_POSITIVE', 'FAILURE TO EMPLOY BEST MANAGEMENT PRACTICES (+)', 'Best practices not applied', 0, '2026-03-23 14:11:54.563', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[StepsToPrevent] WHERE [stepsToPreventCode] = 'EMS_COMMITMENT_TO_DEVELOP_AND_IMPLEMENT_NEGATIVE')
    INSERT INTO [dbo].[StepsToPrevent] ([stepsToPreventCode], [stepsToPreventName], [stepsToPreventDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('EMS_COMMITMENT_TO_DEVELOP_AND_IMPLEMENT_NEGATIVE', 'EMS - COMMITMENT TO DEVELOP AND IMPLEMENT (-)', 'Commitment exists but not yet implemented', 0, '2026-03-23 14:11:54.563', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[StepsToPrevent] WHERE [stepsToPreventCode] = 'VIOLATOR_HAD_OR_DID_NOT_HAVE_CONTROL_OVER_THE_VIOLATING_EVENTS')
    INSERT INTO [dbo].[StepsToPrevent] ([stepsToPreventCode], [stepsToPreventName], [stepsToPreventDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('VIOLATOR_HAD_OR_DID_NOT_HAVE_CONTROL_OVER_THE_VIOLATING_EVENTS', 'VIOLATOR HAD/DID NOT HAVE CONTROL OVER THE VIOLATING EVENTS (+/-)', 'Control over events was partial or absent', 0, '2026-03-23 14:11:54.563', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[StepsToPrevent] WHERE [stepsToPreventCode] = 'FAILURE_TO_COMPLY_WITH_EXISTING_HLE_ACTION_REQUIREMENTS_POSITIVE')
    INSERT INTO [dbo].[StepsToPrevent] ([stepsToPreventCode], [stepsToPreventName], [stepsToPreventDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('FAILURE_TO_COMPLY_WITH_EXISTING_HLE_ACTION_REQUIREMENTS_POSITIVE', 'FAILURE TO COMPLY WITH EXISTING HLE-ACTION REQUIREMENTS (+)', 'HLE enforcement requirements not followed', 0, '2026-03-23 14:11:54.563', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[StepsToPrevent] WHERE [stepsToPreventCode] = 'FAILURE_TO_COMPLY_WITH_EXISTING_PERMIT_CONDITIONS_POSITIVE')
    INSERT INTO [dbo].[StepsToPrevent] ([stepsToPreventCode], [stepsToPreventName], [stepsToPreventDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('FAILURE_TO_COMPLY_WITH_EXISTING_PERMIT_CONDITIONS_POSITIVE', 'FAILURE TO COMPLY WITH EXISTING PERMIT CONDITION(S) (+)', 'Permit conditions not followed', 0, '2026-03-23 14:11:54.563', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[StepsToPrevent] WHERE [stepsToPreventCode] = 'FAILED_TO_COMPLY_WITH_CONDITIONS_OF_LOCAL_ENFORCEMENT_ACTION_POSITIVE')
    INSERT INTO [dbo].[StepsToPrevent] ([stepsToPreventCode], [stepsToPreventName], [stepsToPreventDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('FAILED_TO_COMPLY_WITH_CONDITIONS_OF_LOCAL_ENFORCEMENT_ACTION_POSITIVE', 'FAILED TO COMPLY WITH CONDITIONS OF LOCAL ENFORCEMENT ACTION (+)', 'Local enforcement conditions not met', 0, '2026-03-23 14:11:54.563', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[StepsToPrevent] WHERE [stepsToPreventCode] = 'EMS_COMMITMENT_NOT_FULFILLED_POSITIVE')
    INSERT INTO [dbo].[StepsToPrevent] ([stepsToPreventCode], [stepsToPreventName], [stepsToPreventDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('EMS_COMMITMENT_NOT_FULFILLED_POSITIVE', 'EMS - COMMITMENT NOT FULFILLED (+)', 'Commitment was not fulfilled', 0, '2026-03-23 14:11:54.563', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[StepsToPrevent] WHERE [stepsToPreventCode] = 'OTHER')
    INSERT INTO [dbo].[StepsToPrevent] ([stepsToPreventCode], [stepsToPreventName], [stepsToPreventDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('OTHER', 'OTHER', 'Other preventive actions', 0, '2026-03-23 14:11:54.563', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[StepsToPrevent] WHERE [stepsToPreventCode] = 'FAILURE_TO_ADHERE_TO_APPROVED_WORK_PRACTICES_POSITIVE')
    INSERT INTO [dbo].[StepsToPrevent] ([stepsToPreventCode], [stepsToPreventName], [stepsToPreventDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('FAILURE_TO_ADHERE_TO_APPROVED_WORK_PRACTICES_POSITIVE', 'FAILURE TO ADHERE TO APPROVED WORK PRACTICES (+)', 'Did not follow approved practices', 0, '2026-03-23 14:11:54.563', 'SYSTEM', NULL, NULL);
GO

-- Table [dbo].[StepsToRTC] does not exist on destination. Assuming it will be created.
-- Data for StepsToRTC
IF NOT EXISTS (SELECT 1 FROM [dbo].[StepsToRTC] WHERE [stepsToRTCCode] = 'IMPLEMENTED_FAILED_TO_CORRECT_VIOLATION_AT_OR_AFTER_INSPECTION_POSITIVE_NEGATIVE')
    INSERT INTO [dbo].[StepsToRTC] ([stepsToRTCCode], [stepsToRTCName], [stepsToRTCDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('IMPLEMENTED_FAILED_TO_CORRECT_VIOLATION_AT_OR_AFTER_INSPECTION_POSITIVE_NEGATIVE', 'IMPLEMENTED/FAILED TO CORRECT VIOLATION AT OR AFTER INSPECTION (-/+)', 'Implemented or failed to correct violation at or after inspection', 0, '2026-03-23 14:12:49.135', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[StepsToRTC] WHERE [stepsToRTCCode] = 'FAILED_TO_COMPLY_WITH_CONDITIONS_OF_LOCAL_ENFORCEMENT_ACTION_POSITIVE')
    INSERT INTO [dbo].[StepsToRTC] ([stepsToRTCCode], [stepsToRTCName], [stepsToRTCDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('FAILED_TO_COMPLY_WITH_CONDITIONS_OF_LOCAL_ENFORCEMENT_ACTION_POSITIVE', 'FAILED TO COMPLY WITH CONDITIONS OF LOCAL ENFORCEMENT ACTION (+)', 'Failure to comply with local enforcement action conditions', 0, '2026-03-23 14:12:49.135', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[StepsToRTC] WHERE [stepsToRTCCode] = 'OTHER')
    INSERT INTO [dbo].[StepsToRTC] ([stepsToRTCCode], [stepsToRTCName], [stepsToRTCDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('OTHER', 'OTHER', 'Other RTC-related factor', 0, '2026-03-23 14:12:49.135', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[StepsToRTC] WHERE [stepsToRTCCode] = 'FAILURE_TO_COMPLY_WITH_EXISTING_HLE_ACTION_REQUIREMENTS_POSITIVE')
    INSERT INTO [dbo].[StepsToRTC] ([stepsToRTCCode], [stepsToRTCName], [stepsToRTCDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('FAILURE_TO_COMPLY_WITH_EXISTING_HLE_ACTION_REQUIREMENTS_POSITIVE', 'FAILURE TO COMPLY WITH EXISTING HLE-ACTION REQUIREMENTS (+)', 'Failure to comply with existing HLE-action requirements', 0, '2026-03-23 14:12:49.135', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[StepsToRTC] WHERE [stepsToRTCCode] = 'SUBMITTED_FAILED_TO_SUBMIT_REQUESTED_INFORMATION_POSITIVE_NEGATIVE')
    INSERT INTO [dbo].[StepsToRTC] ([stepsToRTCCode], [stepsToRTCName], [stepsToRTCDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('SUBMITTED_FAILED_TO_SUBMIT_REQUESTED_INFORMATION_POSITIVE_NEGATIVE', 'SUBMITTED/FAILED TO SUBMIT REQUESTED INFORMATION (-/+)', 'Submitted or failed to submit requested information', 0, '2026-03-23 14:12:49.135', 'SYSTEM', NULL, NULL);
IF NOT EXISTS (SELECT 1 FROM [dbo].[StepsToRTC] WHERE [stepsToRTCCode] = 'PERFORMED_FAILED_TO_PERFORM_REQUIRED_ACTIONS_POSITIVE_NEGATIVE')
    INSERT INTO [dbo].[StepsToRTC] ([stepsToRTCCode], [stepsToRTCName], [stepsToRTCDesc], [isDeleted], [createdDt], [createdBy], [lastModifiedDt], [lastModifiedBy]) VALUES ('PERFORMED_FAILED_TO_PERFORM_REQUIRED_ACTIONS_POSITIVE_NEGATIVE', 'PERFORMED/FAILED TO PERFORM REQUIRED ACTION(S) (-/+)', 'Performed or failed to perform required actions', 0, '2026-03-23 14:12:49.135', 'SYSTEM', NULL, NULL);
GO

