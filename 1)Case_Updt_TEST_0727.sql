use EEA_CAS_Enterprise

ALTER TABLE [Case]
ADD externalCaseId NVARCHAR(100);



drop table if exists #tempPC;

SELECT 
distinct 
CPC.pencalc_id
,CPC.PENCALC_DESCRIPTION as caseName
 , 0 as isDeleted
 , CPC.PENCALC_START_DATE as createdDt
 , 'DataLoad' as createdBy
 , CPC.RERCDATE as rercDate
 , CPC.PENCALC_START_DATE as casePreparationDate
 , CPC.ENFORCEMENT_DOC_NUM as enforcementDocumentNumber
 , CPC.PENCALC_SEARCH_KEY as caseNumber
 , CPC.OTHER_FEE_1 as otherFees1
 , FC1.feeCommentId as feeComment1Id
 , CPC.OTHER_FEE_1_COMMENT as feeComment1Other
 , CPC.OTHER_FEE_2 as otherFees2
 , FC2.feeCommentId as feeComment2Id
 , CPC.OTHER_FEE_2_COMMENT as feeComment2Other
 , EDT.enforcementDocTypeId as enforcementDocTypeId
 , SEP as sep
 , EMS as ems
 , CASH_ASSESSED as cashAssessed
 , SUSPENDED_PENALTY as suspended
 , MC.mitigationCommentId as mitigationCommentId
 , CPC.MITIGATION_COMMENT as mitigationCommentOther
 , MR.mitigationReasonId as mitigationReasonId
 , ECONOMIC_BENEFIT_TOTAL as economicBenefit
 , TOTAL_ALTERNATIVE_PENALTIES as totalAlternativePenalties
 , TURA_FEE as tura
 , COMPLIANCE_FEE as complianceFee
 , TOTAL_FEES as totalFees
 , PENCALC_FINALIZED_DATE as finalDateExecuted
 , CALCULATED_TOTAL as finalCalculatedPenalty
 --, ACB_SITE.RO_ID as externalSiteId
 ,c1.activity_id as siteActivityId
 ,c2.activity_id as actorActivityId
 ,c1.RO_ID as ROId
 ,s.externalSiteId 
 ,s.sourceTypeId
 ,s.siteId as siteId
 ,act.actor_id as actorId
 ,act.actor_name as actorName
 ,act.first_name
 ,act.last_name
-- ,o.organizationid
-- ,per.personId
 , CS.caseStatusId as caseStatusId
 , CPC.PENCALC_ID as externalCaseId,
 '6050B189-75E9-4143-A8B9-ED9BCC860684' as agencyId
 , CALCULATED_TOTAL as totalAmountCalculatedPenaltyTotal
 , BASE_PENALTY_TOTAL as totalAmountBasePenaltyTotal
 , MAX_DAILY_PENALTY_TOTAL as totalAmountMaxPenaltyTotal
 , BASE_X_GRAVITY_TOTAL as totalAmountGravityTotal
 , ADJUSTED_PEN_COMP_STATE_MAX as totalAmountAdditionalRegulatoryFactorsTotal
 , CASE WHEN [ADJUSTED_PEN_COMP_STATE_MAX] > [MAX_DAILY_PENALTY_TOTAL] then [ADJUSTED_PEN_COMP_STATE_MAX] else [MAX_DAILY_PENALTY_TOTAL] end as totalAmountAdjustedPenaltyOrMaxDailyPenaltyTotal
 , NUMBER_OF_DAYS_TOTAL as totalAmountNumberOfDaysTotal
 , ADJ_PEN_COMP_ST_MAX_X_NUM_DAYS as totalAmountAdjustedPenaltyXNumberOfDaysTotal
 , MAX_DAILY_PEN_X_NUM_DAYS as totalAmountMaxPenaltyXNumberOfDaysTotal
 , CALCULATED_WO_ECONOMIC_TOTAL as totalAmountCompMaxPenaltyXAdjustPenaltyTotal
 , ECONOMIC_BENEFIT_TOTAL as totalAmountEconomicBenefitTotal
 ,'Total Penalty Amount' as totalAmountDescription
 into #tempPC
FROM
src.cee_prod_pencalc                             CPC
LEFT JOIN dbo.EnforcementDocType        EDT ON CPC.DOCUMENT_TYPE = EDT.enforcementDocTypeCode
LEFT JOIN dbo.FeeComment                FC1 ON CPC.OTHER_FEE_1_COMMENT = FC1.feeCommentName
LEFT JOIN dbo.FeeComment                FC2 ON CPC.OTHER_FEE_2_COMMENT = FC2.feeCommentName
LEFT JOIN dbo.MitigationComment         MC ON CPC.MITIGATION_COMMENT = MC.mitigationCommentName
LEFT JOIN dbo.MitigationReason          MR ON CPC.MITIGATION_POLICY = MR.mitigationReasonName
--LEFT JOIN
--          (SELECT ACB.ACTIVITY_ID
 --               , ACB.RO_ID
 --               , ALT.*
 --          FROM
 --          src.ara_combo           ACB
 --          JOIN src.ara_l_type ALT ON ALT.TYPE_ID = ACB.COMBO_TYPE_ID AND ALT.TYPE_CODE = 'PENCALC RO1'
 --          WHERE ACB.ACTIVITY_ID IS NOT NULL
 --        AND ACB.RO_ID IS NOT NULL) ACB_SITE ON ACB_SITE.ACTIVITY_ID = CPC.ACTIVITY_ID
 left join src.ara_COMBO_prod c1 on c1.activity_id=cpc.ACTIVITY_ID and c1.COMBO_TYPE_ID in (515)
--left join  src.ara_ro ro on ro.RO_ID=c1.RO_ID --and c.ro_id is not null and c.actor_id is not null
left join src.ara_COMBO c2 on c2.activity_id=cpc.ACTIVITY_ID and c2.COMBO_TYPE_ID in (277) and (c2.end_date>getdate() or c2.end_date='1753-01-01 00:00:00.000')
LEFT JOIN src.ara_activity_Prod              AA ON CPC.ACTIVITY_ID = AA.ACTIVITY_ID
LEFT JOIN src_prod.l_type                ALT_STATUS ON ALT_STATUS.TYPE_ID = AA.STATUS_ID
LEFT JOIN dbo.CaseStatus                CS ON CS.caseStatusCode = ALT_STATUS.TYPE_CODE
left join src.ara_actor_prod act on act.actor_id=c2.actor_id
left join [EEA_SMS].dbo.site s on s.externalsiteid=cast(c1.RO_ID as nvarchar(255)) and (s.sourceTypeid in (1,4,5) or s.sourcetypeid is null)
order by 1; --5136
--5136
--67


--select * from #tempPC where ROid is not null order by 1; --5069   --5116
--select * from #tempPC where siteid is not null order by 1; --4431  (638) --4975



drop table if exists #tempPC1;
select * into #tempPC1 from #tempPC;


alter table #tempPC1
add epicsActorId int;

alter table #tempPC1
add araActorId int;


drop table if exists #tempPen;
select distinct t.*,asd.source_where,
TRY_CAST(RIGHT(asd.source_where,LEN(asd.source_where) - CHARINDEX('=', asd.source_where)
         ) AS INT
       ) AS epicsActorId,
TRY_CAST(RIGHT(target_where,LEN(target_where) - CHARINDEX('=', target_where)
         ) AS INT
       ) AS araActorId
into #tempPen
from #tempPC t
left JOIN    src.ara_sync_data asd
    ON asd.target_where = CONCAT('ACTOR_ID=', t.actorid)
--left join src.src.ara_sync_data asd on t.target_where 
where asd.source_table='EPICS.ACTOR' and asd.target_table='ARA.ACTOR'



update #tempPC1
set epicsActorid=tp.epicsActorId , araActorId=tp.araActorId
from #tempPC1 t
join #tempPen tp on t.pencalc_id=tp.pencalc_id


--select * from #tempPC1 where epicsactorid is not null
--order by 1; --1681


drop table if exists #x;
select t.*,p.partyId,o.organizationId,per.personId into #x from #temppc1 t
join EEA_SMS.dbo.party p on cast(t.epicsActorId as nvarchar(255))=p.externalPartyId and p.sourceTypeId=3
left join EEA_SMS.dbo.Organization o on o.partyId=p.partyid --and o.organizationTypeId in(5,6,15)
left join EEA_SMS.dbo.person per on per.partyId=p.partyid


--select * from #x order by 1;

drop table if exists #temppencalc;
select distinct t.*,x.partyId, x.organizationId,x.personId 
into #tempPencalc
from #temppc1 t
left join #x x on x.PENCALC_ID=t.PENCALC_ID
--where t.pencalc_id<=5568
order by 1;


--select * from #tempPencalc --where pencalc_id=550
--order by 1;
/*
select PENCALC_ID,count(*)
from #temppencalc
group by pencalc_id
having count(*)>1
*/

drop table if exists #tempPCF;
SELECT  *,ROW_NUMBER() OVER (PARTITION BY pencalc_id ORDER BY pencalc_id) AS rn
into #tempPCF
FROM #tempPencalc;


--select * from #tempPCF where sourcetypeid=5 and rn=2;
--select * from #tempPCF where PENCALC_ID=390



drop table if exists #tempPencalcFinal;
select * into #tempPencalcFinal from #tempPCF where rn=1;

--select * from #tempPencalcFinal where MitigationCommentother is not null
--select * from MitigationComment
--select MITIGATION_COMMENT,MITIGATION_POLICY from src.cee_prod_PENCALC where MITIGATION_COMMENT is not null --951

--select * from CaseStatus

update #tempPencalcFinal
set caseStatusId='27F886A6-C940-4C9C-8023-950B7C1B1229'
--select * 
from #tempPencalcFinal 
where caseStatusId is null




INSERT INTO [Case] ( caseName, isDeleted, createdDt, createdBy, rercDate, casePreparationDate
                   , enforcementDocumentNumber, caseNumber, otherFees1, feeComment1Id, feeComment1Other
                   , otherFees2, feeComment2Id, feeComment2Other, enforcementDocTypeId, sep, ems, cashAssessed
                   , suspended, mitigationCommentId, mitigationCommentOther, mitigationReasonId, economicBenefit
                   , totalAlternativePenalties, tura, complianceFee, totalFees, finalDateExecuted, finalCalculatedPenalty
                   , siteId, caseStatusId, organizationId, personId, externalCaseId,agencyId, totalAmountCalculatedPenaltyTotal
 , totalAmountBasePenaltyTotal
 , totalAmountMaxPenaltyTotal
 , totalAmountGravityTotal
 , totalAmountAdditionalRegulatoryFactorsTotal
 , totalAmountAdjustedPenaltyOrMaxDailyPenaltyTotal
 , totalAmountNumberOfDaysTotal
 , totalAmountAdjustedPenaltyXNumberOfDaysTotal
 , totalAmountMaxPenaltyXNumberOfDaysTotal
 , totalAmountCompMaxPenaltyXAdjustPenaltyTotal
 , totalAmountEconomicBenefitTotal
 , totalAmountDescription)


				 
select caseName, isDeleted, createdDt, createdBy, rercDate, casePreparationDate
                   , enforcementDocumentNumber
                   , caseNumber
                   , otherFees1
                   , feeComment1Id
                   , feeComment1Other
                   , otherFees2
                   , feeComment2Id
                   , feeComment2Other
                   , enforcementDocTypeId
                   , sep
                   , ems
                   , cashAssessed
                   , suspended
                   , mitigationCommentId
                   , mitigationCommentOther
                   , mitigationReasonId
                   , economicBenefit
                   , totalAlternativePenalties
                   , tura
                   , complianceFee
                   , totalFees
                   , finalDateExecuted
                   , finalCalculatedPenalty
                   , siteId
                   , caseStatusId
				   , organizationId
				   , personId
				   , externalCaseId
				   , agencyId 
				   , totalAmountCalculatedPenaltyTotal
 , totalAmountBasePenaltyTotal
 , totalAmountMaxPenaltyTotal
 , totalAmountGravityTotal
 , totalAmountAdditionalRegulatoryFactorsTotal
 , totalAmountAdjustedPenaltyOrMaxDailyPenaltyTotal
 , totalAmountNumberOfDaysTotal
 , totalAmountAdjustedPenaltyXNumberOfDaysTotal
 , totalAmountMaxPenaltyXNumberOfDaysTotal
 , totalAmountCompMaxPenaltyXAdjustPenaltyTotal
 , totalAmountEconomicBenefitTotal
 , totalAmountDescription
into #pcFinal
				   from #tempPencalcFinal


/*
update [case]
set caseName = p.casename , isDeleted = p.isdeleted, createdDt =p.createdDt, createdBy = p.createdBy, rercDate = p.rercDate, casePreparationDate = p.casePreparationDate
                   , enforcementDocumentNumber = p.enforcementDocumentNumber
                   , caseNumber = p.caseNumber
                   , otherFees1 = p.otherFees1
                   , feeComment1Id = p.feeComment1Id
                   , feeComment1Other = p.feeComment1Other
                   , otherFees2 = p.otherFees2
                   , feeComment2Id = p.feeComment2Id
                   , feeComment2Other = p.feeComment2Other
                   , enforcementDocTypeId = p.enforcementDocTypeId
                   , sep = p.sep
                   , ems = p.ems
                   , cashAssessed = p.cashAssessed
                   , suspended = p.suspended
                   , mitigationCommentId = p.mitigationCommentId
                   , mitigationCommentOther = p.mitigationCommentOther
                   , mitigationReasonId = p.mitigationReasonId
                   , economicBenefit = p.economicBenefit
                   , totalAlternativePenalties = p.totalAlternativePenalties
                   , tura = p.tura
                   , complianceFee = p.complianceFee
                   , totalFees = p.totalFees
                   , finalDateExecuted = p.finalDateExecuted
                   , finalCalculatedPenalty = p.finalCalculatedPenalty
                   , siteId = p.siteid
                   , caseStatusId = p.caseStatusId
				   , organizationId = p.organizationId
				   , personId = p.personId
				   , externalCaseId = p.externalCaseId
				   , agencyId = p.agencyId
				   , totalAmountCalculatedPenaltyTotal = p.totalAmountCalculatedPenaltyTotal
 , totalAmountBasePenaltyTotal = p.totalAmountBasePenaltyTotal
 , totalAmountMaxPenaltyTotal = p.totalAmountMaxPenaltyTotal
 , totalAmountGravityTotal = p.totalAmountGravityTotal
 , totalAmountAdditionalRegulatoryFactorsTotal = p.totalAmountAdditionalRegulatoryFactorsTotal
 , totalAmountAdjustedPenaltyOrMaxDailyPenaltyTotal = p.totalAmountAdjustedPenaltyOrMaxDailyPenaltyTotal
 , totalAmountNumberOfDaysTotal = p.totalAmountNumberOfDaysTotal
 , totalAmountAdjustedPenaltyXNumberOfDaysTotal = p.totalAmountAdjustedPenaltyXNumberOfDaysTotal
 , totalAmountMaxPenaltyXNumberOfDaysTotal =p.totalAmountMaxPenaltyXNumberOfDaysTotal
 , totalAmountCompMaxPenaltyXAdjustPenaltyTotal = p.totalAmountCompMaxPenaltyXAdjustPenaltyTotal
 , totalAmountEconomicBenefitTotal = p.totalAmountEconomicBenefitTotal
 , totalAmountDescription = p.totalAmountDescription
from [case] c
join #pcFinal p on c.externalcaseid=p.externalcaseid
*/
--5136 records

/*
update [case]
set agencyId='6050B189-75E9-4143-A8B9-ED9BCC860684'
where createdBy='DataLoad'
*/



/*
select c.caseId,c.externalCaseId,c.siteid,bus.BusinessUnitId,bu.BusinessUnitCode,bu.BusinessUnitDesc 
from [case] c 
left join [EEA_SMS_DEV_T].dbo.Site s on s.siteid=c.siteId
left join [EEA_SMS_DEV_T].dbo.businessunitSite bus on bus.siteId=s.siteId
left join [EEA_SMS_DEV_T].dbo.BusinessUnit bu on bus.BusinessUnitId=bu.BusinessUnitId
where c.createdby='DataLoad' and s.siteid is  null 
*/

/*
select p.externalcaseid,c.caseId,ea.ENV_AGENCY_ID, ea.ENV_AGENCY_NAME,ea.ENV_AGENCY_SHORT_NAME,
case when ENV_AGENCY_SHORT_NAME like '%AQ%' then 'AQ'
     when ENV_AGENCY_SHORT_NAME like '%HW%' then 'HW'
	 when ENV_AGENCY_SHORT_NAME like '%SW%' then 'SW'
	 when ENV_AGENCY_SHORT_NAME like '%BWS%' then 'WSC' 
	 when ENV_AGENCY_SHORT_NAME like '%WS%' then 'WS'
	 when ENV_AGENCY_SHORT_NAME like '%WM%' then 'WM'
	 when ENV_AGENCY_SHORT_NAME like '%WW%' then 'WW'
	 when ENV_AGENCY_SHORT_NAME like '%WPC%' then 'WPC'
	 when ENV_AGENCY_SHORT_NAME like '%LES%' then 'LES'
	 end as bu
from #pcFinal p
left join [case] c on c.externalCaseId=p.externalcaseid
left join EEA_SMS_PROD.dbo.site s on s.siteid=p.siteid
left join EEA_SMS_PROD.src.FMF_REGULATED_OBJECT1 ro on ro.REG_OBJ_ID=s.externalSiteId
left join EEA_SMS_PROD.src.SAT_ENV_AGENCY ea on ea.ENV_AGENCY_ID=ro.ENV_AGENCY_ID
*/

drop table if exists #tempCaseBU;
select p.externalcaseid,c.caseId,p.siteid,s.externalSiteId,s.sourceTypeid,ea.ENV_AGENCY_ID, ea.ENV_AGENCY_NAME,ea.ENV_AGENCY_SHORT_NAME,
case when ENV_AGENCY_SHORT_NAME like '%AQ%' then 'AQ'
     when ENV_AGENCY_SHORT_NAME like '%HW%' then 'HW'
	 when ENV_AGENCY_SHORT_NAME like '%SW%' then 'SW'
	 when ENV_AGENCY_SHORT_NAME like '%BWS%' then 'WSC'
	 when ENV_AGENCY_SHORT_NAME like '%IWW%' then null
	 when ENV_AGENCY_SHORT_NAME like '%WS%' then 'WS'
	 when ENV_AGENCY_SHORT_NAME like '%WM%' then 'WM'
	 when ENV_AGENCY_SHORT_NAME like '%WW%' then 'WW'
	 when ENV_AGENCY_SHORT_NAME like '%WPC%' then 'WPC'
	 when ENV_AGENCY_SHORT_NAME like '%LES%' then 'LES'
	 end as bu,bu.BusinessUnitId as BUId,bu.BusinessUnitCode as BUCode,bu.BusinessUnitName as BUName,
	 buun.businessUnitCode,buun.businessUnitId
into #tempCaseBU
from #pcFinal p 
left join [case] c on c.externalCaseId=p.externalcaseid
left join EEA_SMS.dbo.site s on s.siteid=p.siteid
left join EEA_SMS.dbo.BusinessUnitSite bus on bus.siteId=s.siteId
left join EEA_SMS.dbo.BusinessUnit bu on bu.BusinessUnitId=bus.BusinessUnitId
left join EEA_SMS.src.FMF_REGULATED_OBJECT ro on ro.REG_OBJ_ID=s.externalSiteId
left join EEA_SMS.src.SAT_ENV_AGENCY ea on ea.ENV_AGENCY_ID=ro.ENV_AGENCY_ID
left join BusinessUnit buun on buun.businessUnitcode=bu.BusinessUnitcode
--where bu.BusinessUnitCode not in ('DEP')  --2099
--2513

select * from #tempCaseBU where businessUnitCode in ('WM')


insert into CaseBusinessUnit(caseId,businessUnitId,isDeleted,createdDt,createdBy,lastModifiedDt,lastModifiedBy)
select caseId,businessUnitId,0 as isDeleted, getdate() as createdDt, 'DataLoad' as createdBy,
getdate() as lastModifiedDt, 'DataLoad' as lastModifiedBy
from #tempCaseBU 
where businessUnitId is not null and businessUnitCode not in ('DEP')




/*
select * from [case] p
join #tempPCF t on t.PENCALC_ID=p.externalcaseid
where t.rn=2 and t.sourceTypeid=5 --and t.PENCALC_ID=390
*/

/*
select * from businessunit


update casebusinessunit
set businessunitid='76490C75-902E-4AC2-9C88-71A7C8DAF8A1'
select * from CaseBusinessUnit cbu
join [case] c on c.caseId=cbu.caseId
*/




--where p.siteid is not null  --4928
--208








