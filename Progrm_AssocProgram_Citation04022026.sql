use eea_cas_enterprise;


SELECT 
    ac.activity_category_id,
    ac.activity_category_code   AS primary_program_code,
    ac.activity_category_desc   AS primary_program_desc
into #temp
FROM 
    src_prod.activity_category ac
WHERE 
    ac.related_activity_category_id = (
        SELECT  activity_category_id
        FROM   src_prod.activity_category
        WHERE  activity_category_code = 'CITATION'
    )
ORDER BY 
    ac.activity_category_code;


select * into #temp1 from #temp where primary_program_code in ('DW','WAT','WES','WET')


update businessunit
	set businessunitcode='OWM', businessunitdesc='OWM - Watershed Management'
	where businessunitid='7AFD7D65-EA95-4677-9AAA-700474CCE30B'



	insert into businessunit(businessUnitCode,businessUnitname,businessUnitDesc,businessUnitTypeId,externalbusinessunitid,startDate,isdeleted,createddt,createdby,lastModifiedDt,lastmodifiedby)
select
primary_program_code as businessunitcode,
primary_program_desc as businessunitname,
concat(primary_program_code,' - ',primary_program_desc) as businessunitdesc,
'EA7F1B63-61A2-4C4A-B709-F9007E18ED09' as businessunittypeid,
ACTIVITY_CATEGORY_ID as externalbusinessunitid,
getdate() as startdate,
0 as isDeleted,
getdate() as createdDt,
'System' as createdBy,
getdate() as lastmodifieddt,
'System' as lastModifiedBy
from #temp1

---------------------------------------------------------------------------------------------------------------
/*
update businessunit
	set isDeleted=1
	--select *
	from businessunit bu
	join #temp t on t.primary_program_code<>bu.businessUnitCode


update businessunit
	set isDeleted=0
	--select *
	from businessunit bu
	join #temp t on t.primary_program_code=bu.businessUnitCode
*/
------------------------------------------------------------------------------------------------------------------------

insert into AppDataBusinessUnit(appdataid,businessunitid,isdeleted,createddt,createdby)
  select '454D6DD1-4A92-4B0D-A8F3-A18E167A384F' as appdataid,
  businessunitid,
  0 as isdeleted,
  getdate() as createddt,
  'System' as createdby
  from BusinessUnit where businessUnitCode in ('DW','WAT','WES','WET')



drop  table if exists #citbu;
select bu.businessUnitCode,bu.businessUnitId 
into #citbu
from Appdatabusinessunit ad
  join businessunit bu on bu.businessUnitId=ad.businessUnitId 
  join #temp t on t.primary_program_code=bu.businessUnitCode
  where ad.appDataId='454D6DD1-4A92-4B0D-A8F3-A18E167A384F'

  select * from #citbu


update AppDataBusinessUnit
set isdeleted=1
--select *
from AppDataBusinessUnit
where businessunitid not in(select businessunitid from #citbu)
and appDataId='454D6DD1-4A92-4B0D-A8F3-A18E167A384F'

------------------------------------------------------------------------------------------------------------------------

select group_location_code into #asocprog from [src_prod].[GROUP_LOCATION]
except
select associatedProgramCode from AssociatedProgram

--select * from #asocprog

--select * from src_prod.GROUP_LOCATION where GROUP_LOCATION_CODE in (select GROUP_LOCATION_CODE  from #asocprog)

insert into AssociatedProgram(associatedProgramCode,associatedProgramName,associatedProgramShortName,isDeleted,createdDt,createdBy)
select 
gl.GROUP_LOCATION_CODE as associatedprogramcode,
gl.GROUP_LOCATION_DESC as associatedprogramname,
gl.GROUP_LOCATION_S_DESC as associatedprogramshortname,
0 as isdeleted,
gl.START_DATE as createdDt,
'System' as createdBy
from src_prod.GROUP_LOCATION gl 
join #asocprog ap on ap.GROUP_LOCATION_CODE=gl.GROUP_LOCATION_CODE

--------------------------------------------------------------------------------------------------------------------------

drop table if exists #t2;

  SELECT DISTINCT
    ac.activity_category_id,
    ac.activity_category_code AS primary_program_code,
    ac.activity_category_desc AS primary_program_desc,
    gl.group_location_id AS primary_program_group_location_id,
    gl2.group_location_id AS associated_program_group_location_id,

    CASE
        WHEN gl.group_location_code = 'BWSC' THEN
            LEFT(
                gl2.group_location_code,
                CASE 
                    WHEN d.second_dash > 0 THEN d.second_dash
                    WHEN d.first_dash > 0 THEN d.first_dash
                    ELSE LEN(gl2.group_location_code)
                END
            ) + ISNULL(gl2.group_location_s_desc, '')

        WHEN d.first_dash > 0
             AND gl.group_location_code <> 
                 LEFT(gl2.group_location_code, d.first_dash - 1)
        THEN
            LEFT(gl2.group_location_code, d.first_dash - 1) +
            '-' + ISNULL(gl2.group_location_s_desc, '')

        ELSE
            gl.group_location_code +
            '-' + ISNULL(gl2.group_location_s_desc, '')
    END AS associated_program_name,

    gl2.group_location_code AS associated_program_code,
    gl2.group_location_s_desc AS associated_program_desc

	into #t2
FROM src_prod.activity_category ac

JOIN src.ara_activity_category_to_group actg
    ON ac.activity_category_id = actg.activity_category_id

JOIN src_prod.group_location gl
    ON actg.group_location_id = gl.group_location_id

JOIN src_prod.group_location_config glc
    ON gl.group_location_id = glc.parent_group_location_id

JOIN src_prod.group_location gl2
    ON gl2.group_location_id = glc.child_group_location_id


CROSS APPLY (
    SELECT 
        CHARINDEX('-', gl2.group_location_code) AS first_dash,
        CHARINDEX('-', gl2.group_location_code, 
                  CHARINDEX('-', gl2.group_location_code) + 1) AS second_dash
) d


JOIN src_prod.l_type lt
    ON gl2.group_location_type_id = lt.type_id
   AND lt.type_code = 'REGULATION'

WHERE
    gl2.group_location_code NOT IN ('AQ-SI', 'AQ-Ride Share')

    AND (ac.activity_category_code + gl2.group_location_code) NOT IN (
        'ERPERP-Engines/Turbines',
        'ERP-Sewer Connections',
        'ERPERP-Boilers'
    )

ORDER BY
    ac.activity_category_code,
    associated_program_name;




insert into BusinessUnitAssociatedProgram(businessunitid,associatedProgramId,isDeleted,createdDt,createdby,lastModifiedDt,lastModifiedBy)
select bu.businessUnitId,
ap.associatedProgramId,
0 as isdeleted,
getdate() as createdDt,
'System' as createdBy,
getdate() as lastmodifieddt,
'System' as lastmodifiedby
from #t2 t
join BusinessUnit bu on bu.businessUnitCode=t.primary_program_code 
join AssociatedProgram ap on ap.associatedProgramshortname=t.associated_program_desc
where t.primary_program_code in ('DW','WAT','WES','WET')


---------------------------------------------------------------------------------------------------------------------------------------------------------

update BusinessUnit
	set parentBusinessUnitId='6885FC73-4C6F-4E25-89DA-E4AB1A9F97F9'
	from BusinessUnit
	where businessUnitCode in ('WAT','WET','DW')

update BusinessUnit
	set parentBusinessUnitId='36DF9D2D-E971-4A4C-9010-21331475DBA5'
	from BusinessUnit
	where businessUnitCode in ('WES')

--------------------------------------------------------------------------------------------------------------------------------------------------------

drop table if exists #citPrimaryProg;

SELECT 
    ct.citation_id,

    -- Citation Name
    atc.activity_category_code + ' ' + 
    ct.citation_statute        + ' ' + 
    ct.citation_code           +
    ISNULL(ct.citation_class, '') +
    CASE 
        WHEN ct.citation_sequence IS NOT NULL 
        THEN '-' + ct.citation_sequence 
        ELSE '' 
    END AS citation_name,

    -- Primary Program
    atc.activity_category_id,
    atc.activity_category_code AS primary_program_code,
    atc.activity_category_desc AS primary_program_desc
into #citPrimaryProg
FROM src_prod.citation ct

JOIN src_prod.activity_type at
    ON ct.activity_type_id = at.activity_type_id

JOIN src_prod.activity_category atc
    ON at.activity_category_id = atc.activity_category_id

ORDER BY 
    atc.activity_category_code,
    citation_name;


----------------------------------------------------------------------------------------------------------------------------


drop table if exists #cit;
select 
c.CITATION_ID as citationNumber,
cpp.CITATION_NAME as citationName,
c.CITATION_CODE as citationCode,
c.PROMULGATION_DATE as promulgationDate,
case when c.READY_TO_SUNSET='Y' then 1 else null end as isReadyToSunset,
0 as isDeleted,
c.START_DATE as startDate,
case when c.END_DATE='1753-01-01 00:00:00' then null else c.END_DATE end  as endDate,
bu.businessUnitId as primaryProgramId,
cc.citationClassId as citationClassId,
cs.citationStatuteId as citationStatuteId,
cseq.citationSequenceId as citationSequenceId,
cst.citationStatusId as citationsStatus,
c.CITATION_CLASS as externalCitationClass,
c.CITATION_SEQUENCE as externalCitationSequence,
c.CITATION_STATUTE as externalCitationStatute,
c.status as externalcitationstatusid,
aty.ACTIVITY_TYPE_DESC as citationDescription,
c.CREATE_DATE as createdDt,
'DataLoad' as createdBy,
c.LAST_MODIFIED as lastmodifieddt,
c.LAST_MODIFIED_BY as lastmodifiedby,
'6050B189-75E9-4143-A8B9-ED9BCC860684' as agencyId
into #cit
from src_prod.CITATION c
left join citationClass cc on cc.citationClassCode=c.CITATION_CLASS
left join citationStatute cs on cs.citationStatuteName=c.CITATION_STATUTE
left join CitationSequence cseq on cseq.citationSequenceCode=c.CITATION_SEQUENCE
left join src_prod.L_TYPE lt on lt.TYPE_ID=c.STATUS
left join citationStatus cst on cst.citationStatusname=lt.TYPE_CODE
--left join src_prod.CE_LOOKUP_TABLE clt on clt.ID=c.STATUS
left join #citPrimaryProg cpp on cpp.CITATION_ID=c.CITATION_ID
left join businessunit bu on bu.businessUnitCode=cpp.primary_program_code 
left join src_prod.activity_type aty on aty.ACTIVITY_TYPE_ID=c.ACTIVITY_TYPE_ID 
--where c.CITATION_ID=20385

set identity_insert citation on

INSERT INTO [dbo].[Citation]
           ([citationNumber],[citationName],[citationCode],[promulgationDate],[isReadyToSunset],[isDeleted],[startDate],[endDate]
           ,[primaryProgramId],[citationClassId],[citationStatuteId],[citationSequenceId],[citationStatusId],[externalCitationClass]
           ,[externalCitationSequence],[externalCitationStatute],[externalCitationStatusId],[citationDescription],[createdDt]
           ,[createdBy],[lastModifiedDt],[lastModifiedBy],[agencyId])


select 
c.CITATION_ID as citationNumber,
cpp.CITATION_NAME as citationName,
c.CITATION_CODE as citationCode,
c.PROMULGATION_DATE as promulgationDate,
case when c.READY_TO_SUNSET='Y' then 1 else null end as isReadyToSunset,
0 as isDeleted,
c.START_DATE as startDate,
case when c.END_DATE='1753-01-01 00:00:00' then null else c.END_DATE end  as endDate,
bu.businessUnitId as primaryProgramId,
cc.citationClassId as citationClassId,
cs.citationStatuteId as citationStatuteId,
cseq.citationSequenceId as citationSequenceId,
cst.citationStatusId as citationsStatus,
c.CITATION_CLASS as externalCitationClass,
c.CITATION_SEQUENCE as externalCitationSequence,
c.CITATION_STATUTE as externalCitationStatute,
c.status as externalcitationstatusid,
aty.ACTIVITY_TYPE_DESC as citationDescription,
c.CREATE_DATE as createdDt,
'DataLoad' as createdBy,
c.LAST_MODIFIED as lastmodifieddt,
c.LAST_MODIFIED_BY as lastmodifiedby,
'6050B189-75E9-4143-A8B9-ED9BCC860684' as agencyId
--into #cit
from src_prod.CITATION c
left join citationClass cc on cc.citationClassCode=c.CITATION_CLASS
left join citationStatute cs on cs.citationStatuteName=c.CITATION_STATUTE
left join CitationSequence cseq on cseq.citationSequenceCode=c.CITATION_SEQUENCE
left join src_prod.L_TYPE lt on lt.TYPE_ID=c.STATUS
left join citationStatus cst on cst.citationStatusname=lt.TYPE_CODE
--left join src_prod.CE_LOOKUP_TABLE clt on clt.ID=c.STATUS
left join #citPrimaryProg cpp on cpp.CITATION_ID=c.CITATION_ID
left join businessunit bu on bu.businessUnitCode=cpp.primary_program_code 
left join src_prod.activity_type aty on aty.ACTIVITY_TYPE_ID=c.ACTIVITY_TYPE_ID 

set identity_insert citation off

----------------------------------------------------------------------------------------------------------------

INSERT INTO [dbo].[CitationPenalty]
           ([citationId],[baseAmount],[maxAmount],[expanPenalty],[maxDailyPenalty],[comment],[startDate]
           ,[endDate],[isDeleted],[createdDt],[createdBy],[lastModifiedDt],[lastModifiedBy],[externalCitationPenaltyId])

select
c.citationid as citationId,
cf.BASE_AMT as baseAmount,
cf.MAX_AMT as maxAmount,
cf.EXPAN_PENALTY as expanPenalty,
cf.MAX_DAILY_PENALTY as maxDailyPenalty,
cf.COMMENTS as comment,
cf.START_DATE as startDate,
case when cf.END_DATE='1753-01-01 00:00:00' then null else cf.END_DATE end  as endDate,
0 as isDeleted,
cf.CREATE_DATE as createdDt,
'System' as createdBy,
cf.LAST_MODIFIED as lastmodifiedDt,
cf.LAST_MODIFIED_BY as lastModiedBy,
cf.CITATION_FEE_ID as externalCitationPenaltyId
from src_prod.CITATION_FEE cf 
left join src_prod.citation pc on pc.CITATION_ID=cf.CITATION_ID
left join citation c on c.citationnumber=pc.CITATION_ID



drop table if exists #citAssocProg;

SELECT 
    ct.citation_id,

    -- Citation Name
    ct.citation_statute + ' ' + 
    ct.citation_code    + ' ' +
    ISNULL(ct.citation_class, '') +
    CASE 
        WHEN ct.citation_sequence IS NOT NULL 
        THEN '-' + CAST(ct.citation_sequence AS VARCHAR(20))
        ELSE '' 
    END AS citation_name,

    -- Associated Programs only
    gl.group_location_id,
    gl.group_location_code   AS associated_program_code,
    gl.group_location_s_desc AS associated_program_desc

into #citAssocProg
FROM src_prod.citation ct

JOIN src_prod.activity_type at
    ON ct.activity_type_id = at.activity_type_id

JOIN src_prod.activity_category ac
    ON at.activity_category_id = ac.activity_category_id

JOIN src_prod.activity_type_to_group atg
    ON ct.activity_type_id = atg.activity_type_id

JOIN src_prod.group_location gl
    ON atg.group_location_id = gl.group_location_id

WHERE
    -- Exclude Primary Program group location
    atg.group_location_id NOT IN (
        SELECT group_location_id
        FROM src_prod.ara_activity_category_to_group
        WHERE activity_category_id = ac.activity_category_id
    )

ORDER BY 
    ct.citation_id,
    gl.group_location_code;

---------------------------------------------------------------------------------------------------------

INSERT INTO [dbo].[CitationAssociatedProgram]
           ([citationId],[associatedProgramId],[isDeleted],[createdDt],[createdBy],[lastModifiedDt]
           ,[lastModifiedBy])

select 
c.citationId,
ap.associatedProgramId,
0 as isdeleted,
c.createdDt as createddt,
c.createdBy,
c.lastModifiedDt,
c.lastModifiedBy
from #citAssocProg cap
left join citation c on c.citationNumber=cap.CITATION_ID
--left join src_prod.CITATION cit on cit.CITATION_ID=cap.CITATION_ID
left join AssociatedProgram ap on cap.associated_program_code=ap.associatedProgramCode

---------------------------------------------------------------------------------------------------------------------

insert into AppDataCitation(appdataid,[citationId],[isDeleted],[createdDt],[createdBy],[lastModifiedDt]
           ,[lastModifiedBy])

select 
'454D6DD1-4A92-4B0D-A8F3-A18E167A384F' as appdataid,
c.citationId,
--c.citationNumber,
0 as isdeleted,
c.createdDt as createdDt,
c.createdBy as createdBy,
c.lastModifiedDt as lastModifiedDt,
c.lastModifiedBy
from
--#cit c
citation c
join src_prod.CITATION cit on cit.CITATION_ID=c.citationNumber

--------------------------------------------------------------------------------------------------------------------

UPDATE businessunit
SET businessunitname = 'Wall Experiment Station', businessUnitDesc='WES - Wall Experiment Station'
from businessunit 
where businessunitcode='WES'

UPDATE businessunit
SET businessunitname = 'Drinking Water Program', businessUnitDesc='DW - Drinking Water Program'
from businessunit 
where businessunitcode='DW'

UPDATE businessunit
SET businessunitname = 'Wetlands', businessUnitDesc='WET - Wetlands'
from businessunit 
where businessunitcode='WET'

UPDATE businessunit
SET businessunitname = 'Waterways', businessUnitDesc='WAT - Waterways'
from businessunit 
where businessunitcode='WAT'


/*
update citation
set endDate=null
from citation where endDate='1753-01-01'

update CitationPenalty
set endDate=null
from CitationPenalty where endDate='1753-01-01'
*/