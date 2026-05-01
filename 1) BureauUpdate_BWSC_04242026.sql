use EEA_CAS_Enterprise;


alter table citation
add bureauId uniqueidentifier;



update citation
set primaryprogramid='B0F6C96B-DF5D-4DC8-85F1-FE1B1FD87AE5', bureauId='DF3F0BD7-ECFD-49AA-AC9E-540876EF39E7'
--select * 
from citation c
join BusinessUnit bu on bu.businessunitid=c.primaryProgramId
where bu.businessUnitCode='BWSC'



update citation
set bureauId=bu.parentBusinessUnitId
--select c.primaryprogramid,c.bureauid,bu.businessunitcode,bu.businessunitid,bu.parentbusinessunitid,bup.businessunitId,bup.businessunitcode 
from citation c
join BusinessUnit bu on bu.businessunitid=c.primaryProgramId
--join businessunit bup on bu.parentBusinessUnitId=bup.businessUnitId


 EXEC sp_rename 'citation.primaryprogramid', 'programId', 'COLUMN';






