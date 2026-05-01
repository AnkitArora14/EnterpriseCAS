use eea_cas_enterprise;


update AppDataBusinessUnit
  set isDeleted=1
  --select * 
  from AppDataBusinessUnit adbu
  join BusinessUnit bu on bu.businessUnitId=adbu.businessUnitId
  where bu.businessUnitCode in ('WS','PFAS','LES','WW','IWW','MUN','CSI')


  update businessunit
  set isDeleted=1
  where businessunitcode in ('WS','PFAS','LES','WW','IWW','MUN','CSI');


  
  --relationship of associatedProgram in BusinessUnitAssociatedProgram is to Program level only

  update BusinessUnitAssociatedProgram
  set isdeleted=0
  --select * 
  from BusinessUnitAssociatedProgram buap
  join BusinessUnit bu on bu.businessunitid=buap.businessUnitId
  join AssociatedProgram ap on ap.associatedProgramId=buap.associatedProgramId
  where businessunitcode in ('EEA','DEP','BAW','BWSC','BAS','BWR')
  
  ---------------------------------------------------------------------------------------------------------------------------------------------
  
  -- Fix for WPC as per new list
  
  update BusinessUnitAssociatedProgram
set isDeleted=1
--select buap.businessUnitAssociatedProgramId,bu.businessUnitId,bu.businessUnitCode,ap.associatedProgramId,
--ap.associatedProgramCode,ap.associatedProgramShortName,ap.associatedProgramName 
from BusinessUnitAssociatedProgram buap
  join businessunit bu on bu.businessUnitId=buap.businessUnitId
  join AssociatedProgram ap on ap.associatedProgramId=buap.associatedProgramId
  where bu.businessUnitCode='WPC'

  --select * from AssociatedProgram where associatedProgramCode like '%WPC%'


insert into BusinessUnitAssociatedProgram(businessunitid,associatedProgramId,isDeleted,createdDt,createdBy,lastModifiedDt,lastModifiedBy)

select '6629730C-A3C0-4F05-B1A1-4BA8049DF45D' as businessunitid,
ap.AssociatedProgramId,
0 as isdeleted,
getdate() as createdDt,
'System' as createdBy,
getdate() as lastModifiedDt,
'System' as lastModifiedBy
from src_prod.GROUP_LOCATION gl 
join associatedprogram ap on gl.GROUP_LOCATION_CODE=ap.associatedProgramCode
and gl.GROUP_LOCATION_CODE like '%WPC%'
and gl.group_location_id in (208,209,124,147,121,177,131,122,123,203)


insert into BusinessUnitAssociatedProgram(businessunitid,associatedProgramId,isDeleted,createdDt,createdBy,lastModifiedDt,lastModifiedBy)
select '6629730C-A3C0-4F05-B1A1-4BA8049DF45D' as businessunitid,
'96997051-3484-44C7-BA79-7C5E90AEC640' as associatedProgramId,
0 as isdeleted,
getdate() as createdDt,
'System' as createdBy,
getdate() as lastModifiedDt,
'System' as lastModifiedBy;
 


---------------------------------------------------------------------------------------------------------------------------------------------------------------  
  
 -- Fix for SW as per new list

   update BusinessUnitAssociatedProgram
set isDeleted=1
--select buap.businessUnitAssociatedProgramId,bu.businessUnitId,bu.businessUnitCode,ap.associatedProgramId,
--ap.associatedProgramCode,ap.associatedProgramShortName,ap.associatedProgramName 
from BusinessUnitAssociatedProgram buap
  join businessunit bu on bu.businessUnitId=buap.businessUnitId
  join AssociatedProgram ap on ap.associatedProgramId=buap.associatedProgramId
  where bu.businessUnitCode='SW'
  and ap.associatedProgramCode in ('SW-CE','SW-WE','SW-NE','SW-SE')

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Fix for HW as per new list

  update BusinessUnitAssociatedProgram
set isDeleted=1
--select buap.businessUnitAssociatedProgramId,bu.businessUnitId,bu.businessUnitCode,ap.associatedProgramId,
--ap.associatedProgramCode,ap.associatedProgramShortName,ap.associatedProgramName 
from BusinessUnitAssociatedProgram buap
  join businessunit bu on bu.businessUnitId=buap.businessUnitId
  join AssociatedProgram ap on ap.associatedProgramId=buap.associatedProgramId
  where bu.businessUnitCode='HW'
  and ap.associatedProgramCode in ('HW-CE','HW-WE','HW-NE','HW-SE')

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Fix for ERP as per new list

    update BusinessUnitAssociatedProgram
set isDeleted=1
--select buap.businessUnitAssociatedProgramId,bu.businessUnitId,bu.businessUnitCode,ap.associatedProgramId,
--ap.associatedProgramCode,ap.associatedProgramShortName,ap.associatedProgramName 
from BusinessUnitAssociatedProgram buap
  join businessunit bu on bu.businessUnitId=buap.businessUnitId
  join AssociatedProgram ap on ap.associatedProgramId=buap.associatedProgramId
  where bu.businessUnitCode='ERP'
  and ap.associatedProgramCode in ('ERP-Engines/Turbines','ERP-Boilers')


insert into BusinessUnitAssociatedProgram(businessunitid,associatedProgramId,isDeleted,createdDt,createdBy,lastModifiedDt,lastModifiedBy)
select '76490C75-902E-4AC2-9C88-71A7C8DAF8A1' as businessunitid,
ap.AssociatedProgramId,
0 as isdeleted,
getdate() as createdDt,
'System' as createdBy,
getdate() as lastModifiedDt,
'System' as lastModifiedBy
from src_prod.GROUP_LOCATION gl 
join associatedprogram ap on gl.GROUP_LOCATION_CODE=ap.associatedProgramCode
and gl.GROUP_LOCATION_CODE in ('ERP-Sewer Connections','ERP-PP')

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Fix for AQ as per new list

  update BusinessUnitAssociatedProgram
set isDeleted=1
--select buap.businessUnitAssociatedProgramId,bu.businessUnitId,bu.businessUnitCode,ap.associatedProgramId,
--ap.associatedProgramCode,ap.associatedProgramShortName,ap.associatedProgramName 
from BusinessUnitAssociatedProgram buap
  join businessunit bu on bu.businessUnitId=buap.businessUnitId
  join AssociatedProgram ap on ap.associatedProgramId=buap.associatedProgramId
  where bu.businessUnitCode='AQ'
  and ap.associatedProgramCode not in 
  ('AQ-ASB','AQ-GHG','AQ-Low Emission Vehicle','AQ-MS','AQ-OHH','AQ-SII','AQ-SS','AQ-Tank Trucks','ERP-Boilers','ERP-Dry Cleaners','ERP-Printers','ERP-Engines/Turbines')


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
update AssociatedProgram
set isdeleted=1 
where associatedProgramCode in ('ERP-Boilers','ERP-Engines/Turbines','SW-CE','SW-SE','SW-NE','SW-WE','HW-CE','HW-SE','HW-NE','HW-WE',
'WPC-NE','WPC-WE','WPC-SE','CON','WPC-01','WPC-02','WPC-CE','AQ-WE','AQ-Ride Share','AQ-SE','AQ-NE','DAQC','AQ-CE','AQ-SI','AQ-LA');
