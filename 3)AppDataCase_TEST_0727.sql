use EEA_CAS_Enterprise;

insert into AppDataCase(appDataId, caseId, isDeleted, createdDt, createdBy,lastModifiedDt,lastModifiedBy)
  select
  '1277ADE2-4AC4-483B-9252-CD8315D7B187' as appdataId,
  caseId as caseId,
  0 as isDeleted,
  getdate() as createdDt,
  'DataLoad' as createdBy,
  getdate() as lastModifiedDt,
  'DataLoad' as lastModifiedBy
  from [case] 
  where createdby='DataLoad'


