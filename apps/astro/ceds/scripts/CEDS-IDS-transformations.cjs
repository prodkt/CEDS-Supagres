const fs = require("fs");

function cleanupSqlForPostgres(sqlContent, isReferenceData, fileName) {
  console.log(`Processing file: ${fileName}`);
  sqlContent = sqlContent.replace(
    /\/\*\*\*\*\*\* Object:.*?Script Date:.*?\*\*\*\*\*\*\/\s*/g,
    ""
  );
  sqlContent = sqlContent.replace(/SET ANSI_NULLS ON/g, "");
  sqlContent = sqlContent.replace(/SET QUOTED_IDENTIFIER ON/g, "");
  sqlContent = sqlContent.replace(/NONCLUSTERED/g, "");
  sqlContent = sqlContent.replace(
    /GO\s*EXEC\s+sys\.sp_addextendedproperty[\s\S]*?(?=GO|$)/g,
    ""
  );
  sqlContent = sqlContent.replace(/GO\s*GO\s*GO/g, "");
  sqlContent = sqlContent.replace(
    /\[(.*?)\] \[(.*?)\]\((.*?)\)/g,
    '"$1" $2($3)'
  );
  sqlContent = sqlContent.replace(/\[(.*?)\] \[(.*?)\]/g, '"$1" $2');
  sqlContent = sqlContent.replace(/varchar/g, "character varying");
  sqlContent = sqlContent.replace(
    /CREATE TABLE \[(.*?)].\[(.*?)]\(/g,
    'CREATE TABLE "$2"('
  );
  sqlContent = sqlContent.replace(
    /WITH \(.*?\) ON \[PRIMARY\]\s*\) ON \[PRIMARY\]/g,
    ""
  );
  sqlContent = sqlContent.replace(
    /WITH \(.*?\) ON \[PRIMARY\]\s*\) ON \[PRIMARY\](.*?)\]/g,
    ""
  );
  sqlContent = sqlContent.replace(
    /CONSTRAINT \[(.*?)\] PRIMARY KEY(.*?)\s*\(\s*\[(.*?)\] ASC\s*\)/g,
    'CONSTRAINT "$1" PRIMARY KEY ("$3"));'
  );
  sqlContent = sqlContent.replace(
    /GO\s*ALTER TABLE \[(.*?)\].\[(.*?)\]  WITH CHECK ADD  CONSTRAINT \[(.*?)\] FOREIGN KEY\(\[(.*?)\]\)\s*REFERENCES \[(.*?)\].\[(.*?)\] \(\[(.*?)\]\)\s*GO\s*ALTER TABLE \[(.*?)\].\[(.*?)\] CHECK CONSTRAINT \[(.*?)\]/g,
    'ALTER TABLE "$2" ADD CONSTRAINT "$3" FOREIGN KEY("$4") REFERENCES "$6" ("$7");'
  );
  sqlContent = sqlContent.replace(
    /ALTER TABLE \[(.*?)\].\[(.*?)\]  WITH CHECK ADD  CONSTRAINT \[(.*?)\] FOREIGN KEY\(\[(.*?)\]\)\s*REFERENCES \[(.*?)\].\[(.*?)\] \(\[(.*?)\]\)\s*ON UPDATE CASCADE\s*ON DELETE CASCADE\s*GO/g,
    'ALTER TABLE "$2" ADD CONSTRAINT "$3" FOREIGN KEY("$4") REFERENCES "$6" ("$7") ON UPDATE CASCADE ON DELETE CASCADE;'
  );
  sqlContent = sqlContent.replace(
    /ALTER TABLE \[(.*?)\]\.\[(.*?)\] CHECK CONSTRAINT \[(.*?)\]\s*/g,
    ""
  );
  sqlContent = sqlContent.replace(/\s*GO/g, "");
  sqlContent = sqlContent.replace(/datetime/g, "timestamptz");
  sqlContent = sqlContent.replace(/ncharacter/g, "character");
  sqlContent = sqlContent.replace(/int IDENTITY\(1\,1\)/g, "SERIAL");
  sqlContent = sqlContent.replace(/bit/g, "BOOLEAN");
  sqlContent = sqlContent.replace(
    /PRIMARY KEY(.*?)\s*\(\s*\[(.*?)\](.*?)ASC(.*?)\s*\)/g,
    'PRIMARY KEY ("$2"));'
  );
  sqlContent = sqlContent.replace(
    /PRIMARY KEY(.*?)\s*\(\s*\[(.*?)\](.*?)ASC,\s*\[(.*?)\](.*?)ASC(.*?)\s*\)/g,
    'PRIMARY KEY ("$2", "$4"));'
  );
  sqlContent = sqlContent.replace(
    /UNIQUE(.*?)\s*\(\s*\[(.*?)\](.*?)ASC,\s*\[(.*?)\](.*?)ASC(.*?)\s*\)/g,
    'UNIQUE ("$2", "$4"));'
  );
  sqlContent = sqlContent.replace(
    /\)\;WITH \(PAD_INDEX \= OFF, STATISTICS_NORECOMPUTE \= OFF\, IGNORE_DUP_KEY \= OFF\, ALLOW_ROW_LOCKS \= ON, ALLOW_PAGE_LOCKS \= ON\, OPTIMIZE_FOR_SEQUENTIAL_KEY \= OFF\) ON \[PRIMARY\]\s*,/g,
    ","
  );
  sqlContent = sqlContent.replace(
    /CONSTRAINT \[(.*?)\] UNIQUE \(\"(.*?)\"\, \"(.*?)\"\);/g,
    'CONSTRAINT "$1" UNIQUE ("$2", "$3"));'
  );
  sqlContent = sqlContent.replace(/nchar/g, "character varying");
  sqlContent = sqlContent.replace(/ TEXTIMAGE_ON \[PRIMARY\]/g, "");
  sqlContent = sqlContent.replace(
    /UNIQUE(.*?)\s*\(\s*\[(.*?)\](.*?)ASC,\s*\[(.*?)\](.*?)ASC,\s*\[(.*?)\](.*?)ASC(.*?)\s*\)/g,
    'UNIQUE ("$2", "$4", "$6"));'
  );
  sqlContent = sqlContent.replace(
    /UNIQUE(.*?)\s*\(\s*\[(.*?)\](.*?)ASC,\s*\[(.*?)\](.*?)ASC,\s*\[(.*?)\](.*?)ASC,\s*\[(.*?)\](.*?)ASC(.*?)\s*\)/g,
    'UNIQUE ("$2", "$4", "$6", "$8"));'
  );
  sqlContent = sqlContent.replace(/CONSTRAINT \[(.*?)\]/g, 'CONSTRAINT "$1"');
  sqlContent = sqlContent.replace(
    /ALTER TABLE \[(.*?)\]\.\[(.*?)\] ADD  CONSTRAINT "(.*?)"  DEFAULT \(\(0\)\) FOR \[(.*?)\]/g,
    'ALTER TABLE "$2" ALTER COLUMN "PrimaryTelephoneNumberIndicator" SET DEFAULT FALSE;'
  );
  sqlContent = sqlContent.replace(/int IDENTITY\(2000\,1\)/g, "SERIAL");
  sqlContent = sqlContent.replace(/varying\(max\)/g, "varying");
  sqlContent = sqlContent.replace(/tinyint/g, "smallint");
  sqlContent = sqlContent.replace(/IDENTITY\(\d+\,\d+\)/g, "SERIAL"); // General handling of IDENTITY
  sqlContent = sqlContent.replace(/\) ON \[PRIMARY\]/g, ");");
  sqlContent = sqlContent.replace(/CLUSTERED/g, "");
  sqlContent = sqlContent.replace(/NONCLUSTERED/g, "");
  sqlContent = sqlContent.replace(/"datetime"/g, "timestamptz");
  sqlContent = sqlContent.replace(/"BIT"/g, "BOOLEAN");
  sqlContent = sqlContent.replace(/"date"/g, "DATE");
  sqlContent = sqlContent.replace(/"int"/g, "INT");
  sqlContent = sqlContent.replace(/"bit"/g, "BOOLEAN");
  sqlContent = sqlContent.replace(/"SERIAL"/g, "SERIAL");
  sqlContent = sqlContent.replace(/"BIGSERIAL"/g, "BIGSERIAL");
  sqlContent = sqlContent.replace(/"nchar"/g, "CHAR");
  sqlContent = sqlContent.replace(/"char"/g, "CHAR");
  sqlContent = sqlContent.replace(/"float"/g, "FLOAT");
  sqlContent = sqlContent.replace(/"decimal"/g, "DECIMAL");
  sqlContent = sqlContent.replace(/"numeric"/g, "NUMERIC");
  sqlContent = sqlContent.replace(/"money"/g, "MONEY");
  sqlContent = sqlContent.replace(/"smallmoney"/g, "SMALLMONEY");
  sqlContent = sqlContent.replace(/"tinyint"/g, "INT");
  sqlContent = sqlContent.replace(/"smallint"/g, "SMALLINT");
  sqlContent = sqlContent.replace(/"bigint"/g, "BIGINT");
  sqlContent = sqlContent.replace(/"bit"/g, "BOOLEAN");
  sqlContent = sqlContent.replace(/"uniqueidentifier"/g, "UUID");
  sqlContent = sqlContent.replace(/"text"/g, "TEXT");
  sqlContent = sqlContent.replace(/"ntext"/g, "TEXT");
  sqlContent = sqlContent.replace(/"xml"/g, "XML");
  sqlContent = sqlContent.replace(/"hierarchyid"/g, "HIERARCHYID");
  sqlContent = sqlContent.replace(/"geography"/g, "GEOGRAPHY");
  sqlContent = sqlContent.replace(/"geometry"/g, "GEOMETRY");
  sqlContent = sqlContent.replace(/@/g, ":");

  sqlContent = sqlContent.replace(/SET IDENTITY_INSERT .* ON/g, "");
  sqlContent = sqlContent.replace(/SET IDENTITY_INSERT .* OFF/g, "");

  sqlContent = sqlContent.replace(
    /Assessment_AssessmentELDevelopmentalDomain/g,
    "Assess_ELDevDomain"
  );
  sqlContent = sqlContent.replace(
    /AssessmentParticipantSession_Accommodation/g,
    "AssessParticipSess_Accom"
  );
  sqlContent = sqlContent.replace(
    /AssessmentPersonalNeedScreenReader_RefAssessmentNeedLinkIndicationType/g,
    "AssessPerNeed_RefAssessNeedLinkIndType"
  );
  sqlContent = sqlContent.replace(
    /AssessmentPersonalNeedsProfileScreenEnhancement_DataCollection/g,
    "AssessPerNeedProf_DataColl"
  );
  sqlContent = sqlContent.replace(
    /AssessmentRegistration_RefAssessmentRegistrationCompletionStatus/g,
    "AssessReg_RefAssessRegComplStatus"
  );
  sqlContent = sqlContent.replace(
    /AssessmentSubtest_AssessmentELDevelopmentalDomain_AssessmentSubtest/g,
    "AssessSubtest_AssessELDevDomain_AssessSubtest"
  );
  sqlContent = sqlContent.replace(
    /AssessmentSubtest_AssessmentELDevelopmentalDomain_RefAssessmentELDevelopmentalDomain/g,
    "AssessSubtest_AssessELDevDomain_RefAssessELDevDomain"
  );
  sqlContent = sqlContent.replace(
    /BuildingSpaceUtilization_RefBuildingInstructionalSpaceFactorType/g,
    "BuildSpaceUtil_RefBuildInstrSpaceFactorType"
  );
  sqlContent = sqlContent.replace(
    /BuildingSystemCategory_RefBuildingCommMgmtComponentSystemType/g,
    "BuildSysCat_RefBuildCommMgmtCompSysType"
  );
  sqlContent = sqlContent.replace(
    /BuildingSystemCategory_RefBuildingCoolingGenerationSystemType/g,
    "BuildSysCat_RefBuildCoolGenSysType"
  );
  sqlContent = sqlContent.replace(
    /BuildingSystemCategory_RefBuildingHeatingGenerationSystemType/g,
    "BuildSysCat_RefBuildHeatGenSysType"
  );
  sqlContent = sqlContent.replace(
    /BuildingSystemCategory_RefBuildingMechanicalConveyingSystemType/g,
    "BuildSysCat_RefBuildMechConveySysType"
  );
  sqlContent = sqlContent.replace(
    /BuildingSystemCategory_RefBuildingVerticalTransportationSystemType/g,
    "BuildSysCat_RefBuildVertTransSysType"
  );
  sqlContent = sqlContent.replace(
    /BuildingSystemComponent_RefFacilitySystemOrComponentCondition/g,
    "BuildSysComp_RefFacilitySysOrCompCond"
  );
  sqlContent = sqlContent.replace(
    /CompetencyDefAssociation_RefLearningResourceCompetencyAlignmentType/g,
    "CompDefAssoc_RefLearnResCompAlignType"
  );
  sqlContent = sqlContent.replace(
    /CompetencyDefinition_RefCompetencyDefinitionNodeAccessibilityProfile/g,
    "CompDef_RefCompDefNodeAccProf"
  );
  sqlContent = sqlContent.replace(
    /CredentialDefinitionDefAgentCredentialDefinition_CredentialDefinition/g,
    "CredDefAgntCredDef_CredDef"
  );
  sqlContent = sqlContent.replace(
    /CredentialDefinition_RefCredentialDefinitionIntendedPurposeType/g,
    "CredDef_RefCredDefIntendedPurpType"
  );
  sqlContent = sqlContent.replace(
    /ELChildDevelopmentalAssessment_RefChildDevelopmentalScreeningStatus/g,
    "ELChildDevAssess_RefChildDevScreeningStatus"
  );
  sqlContent = sqlContent.replace(
    /ELChildDevelopmentalAssessment_RefDevelopmentalEvaluationFinding/g,
    "ELChildDevAssess_RefDevEvalFinding"
  );
  sqlContent = sqlContent.replace(
    /ELOrganizationMonitoring_RefOrganizationMonitoringNotifications/g,
    "ELOrgMon_RefOrgMonNotifications"
  );
  sqlContent = sqlContent.replace(
    /ELStaffEmployment_RefELServiceProfessionalStaffClassification/g,
    "ELStaffEmpl_RefELServiceProfStaffClass"
  );
  sqlContent = sqlContent.replace(
    /FacilityDesignConstruction_RefBuildingEnergyConservationMeasureType/g,
    "FacDesigConstr_RefBuildEnergyConservationMeasureType"
  );
  sqlContent = sqlContent.replace(
    /FacilityDesignConstruction_RefFacilityConstructionMaterialType/g,
    "FacDesigConstr_RefFacilConstrMaterialType"
  );
  sqlContent = sqlContent.replace(
    /FacilityDesignConstruction_RefFacilitySiteImprovementLocationType/g,
    "FacDesigConstr_RefFacilSiteImprovementLocationType"
  );
  sqlContent = sqlContent.replace(
    /FinancialAccount_RefFinancialAccountGASBRevenueClassification/g,
    "FinAcct_RefFinAcctGASBRevClassification"
  );
  sqlContent = sqlContent.replace(
    /FinancialAccount_RefFinancialExpenditureLevelOfInstructionCode/g,
    "FinAcct_RefFinExpendLevelOfInstructCode"
  );
  sqlContent = sqlContent.replace(
    /FinancialAccountLocal_RefFinancialAccountLocalBalanceSheetCode/g,
    "FinAcctLocal_RefFinAcctLocalBalanceSheetCode"
  );
  sqlContent = sqlContent.replace(
    /FinancialAccountLocal_RefFinancialAccountLocalFundClassification/g,
    "FinAcctLocal_RefFinAcctLocalFundClassification"
  );
  sqlContent = sqlContent.replace(
    /FinancialAccountLocal_RefFinancialAccountLocalGASBRevenueClassification/g,
    "FinAcctLocal_RefFinAcctLocalGASBRevClassification"
  );
  sqlContent = sqlContent.replace(
    /FinancialAccountLocal_RefFinancialExpenditureLocalFunctionCode/g,
    "FinAcctLocal_RefFinExpendLocalFunctionCode"
  );
  sqlContent = sqlContent.replace(
    /FinancialAccountLocal_RefFinancialExpenditureLocalLevelOfInstructionCode/g,
    "FinAcctLocal_RefFinExpendLocalLevelOfInstructCode"
  );
  sqlContent = sqlContent.replace(
    /IDEAEligibilityEvaluationCategory_RefIDEAEligibilityEvaluationCategory/g,
    "IDEAEligEvalCat_RefIDEAEligEvalCategory"
  );
  sqlContent = sqlContent.replace(
    /IndividualizedProgramAccessibleFormat_RefAccessibleFormatIssuedIndicator/g,
    "IndividProgAccFormat_RefAccessFormatIssuedIndicator"
  );
  sqlContent = sqlContent.replace(
    /IndividualizedProgramAccessibleFormat_RefAccessibleFormatRequiredIndicator/g,
    "IndividProgAccFormat_RefAccessFormatRequiredIndicator"
  );
  sqlContent = sqlContent.replace(
    /IndividualizedProgramAccessibleFormat_RefAccessibleFormatType/g,
    "IndividProgAccFormat_RefAccessFormatType"
  );
  sqlContent = sqlContent.replace(
    /IndividualizedProgramAccommodationSubject_IndividualizedProgramAccommodation/g,
    "IndividProgAccommSubject_IndividProgAccomm"
  );
  sqlContent = sqlContent.replace(
    /IndividualizedProgramAccommodationSubject_RefSCEDCourseSubjectArea/g,
    "IndividProgAccommSubject_RefSCEDCourseSubjectArea"
  );
  sqlContent = sqlContent.replace(
    /IndividualizedProgramAssessmentAccommodation_AssessmentAccommodation/g,
    "IndividProgAssessAccomm_AssessAccomm"
  );
  sqlContent = sqlContent.replace(
    /IndividualizedProgramAssessmentAccommodation_IndividualizedProgramAssessment/g,
    "IndividProgAssessAccomm_IndividProgAssess"
  );
  sqlContent = sqlContent.replace(
    /IndividualizedProgramEligibilityEvaluation_EligibilityEvaluation/g,
    "IndividProgEligibilEval_EligibilEval"
  );
  sqlContent = sqlContent.replace(
    /IndividualizedProgramEligibilityEvaluation_IndividualizedProgramEligibility/g,
    "IndividProgEligibilEval_IndividProgEligibil"
  );
  sqlContent = sqlContent.replace(
    /IndividualizedProgramEligibilityEvaluation_RefIEPEligibilityEvaluationType/g,
    "IndividProgEligibilEval_RefIEPEligibilEvalType"
  );
  sqlContent = sqlContent.replace(
    /IndividualizedProgramMeetingAttendee_IndividualizedProgramMeeting/g,
    "IndividProgMeetAttendee_IndividProgMeet"
  );
  sqlContent = sqlContent.replace(
    /IndividualizedProgramProgressGoal_IndividualizedProgramProgressReport/g,
    "IndividProgProgressGoal_IndividProgProgressReport"
  );
  sqlContent = sqlContent.replace(
    /IndividualizedProgramProgressReport_IndividualizedProgramProgressReportPlan/g,
    "IndividProgProgressReport_IndividProgProgressReportPlan"
  );
  sqlContent = sqlContent.replace(
    /IndividualizedProgramProgressReport_RefIPSPProgressReportType/g,
    "IndividProgProgressReport_RefIPSPProgressReportType"
  );
  sqlContent = sqlContent.replace(
    /IndividualizedProgramProgressReportPlan_IndividualizedProgram/g,
    "IndividProgProgressReportPlan_IndividProg"
  );
  sqlContent = sqlContent.replace(
    /IndividualizedProgramProgressReportPlan_RefIPSPProgressReportSchedule/g,
    "IndividProgProgressReportPlan_RefIPSPProgressReportSched"
  );
  sqlContent = sqlContent.replace(
    /IndividualizedProgramProgressReportPlan_RefIPSPProgressReportType/g,
    "IndividProgProgressReportPlan_RefIPSPProgressReportType"
  );
  sqlContent = sqlContent.replace(
    /IndividualizedProgramService_RefIndividualizedProgramPlannedServiceType/g,
    "IndividProgService_RefIndividProgPlannedServiceType"
  );
  sqlContent = sqlContent.replace(
    /K12CharterSchoolAuthorizerAgency_RefCharterSchoolAuthorizerType/g,
    "K12CharterAuthorizerAgency_RefCharterAuthorizerType"
  );
  sqlContent = sqlContent.replace(
    /K12OrganizationStudentResponsibility_RefStudentSchoolAffiliationStateDefinedStatus/g,
    "K12OrgStudentResponsibil_RefStudentSchoolAffilStDefStatus"
  );
  sqlContent = sqlContent.replace(
    /K12SchoolStatus_RefProgressAchievingEnglishLanguageProficiencyIndicatorStatus/g,
    "K12Status_RefProgressAchievEngLangProficiencyIndicatorStatus"
  );
  sqlContent = sqlContent.replace(
    /K12StaffAssignment_RefSpecialEducationTeacherQualificationStatus/g,
    "K12StaffAssign_RefSpecialEduTeacherQualStatus"
  );
  sqlContent = sqlContent.replace(
    /LearningResource_RefHighQualityInstructionalMaterialIndicator/g,
    "LearnResource_RefHighQualInstructMaterialIndicator"
  );
  sqlContent = sqlContent.replace(
    /LearningResourceIdentifier_RefLearningResourceIdentificationSystem/g,
    "LearnResourceIdent_RefLearResourceIdentSystem"
  );
  sqlContent = sqlContent.replace(
    /LearningResourceMediaFeature_RefLearningResourceMediaFeatureType/g,
    "LearnResourceMediaFeat_RefLearnResourceMediaFeatType"
  );
  sqlContent = sqlContent.replace(
    /LearningResourcePhysicalMedia_RefLearningResourcePhysicalMediaType/g,
    "LearnResourcePhysicalMedia_RefLearnResourcePhysicalMediaType"
  );
  sqlContent = sqlContent.replace(
    /OrganizationAccreditation_RefHigherEducationInstitutionAccreditationStatus/g,
    "OrgAccred_RefHigherEduInstitutionAccredStatus"
  );
  sqlContent = sqlContent.replace(
    /OrganizationCalendarSessionRelationship_OrganizationCalendarSession/g,
    "OrgCalSessionRelation_OrgCalSession"
  );
  sqlContent = sqlContent.replace(
    /OrganizationFederalAccountability_RefAdditionalTargetedSupportAndImprovementStatus/g,
    "OrgFedAcctabil_RefAdditionalTargetedSupportImproveStatus"
  );
  sqlContent = sqlContent.replace(
    /OrganizationFederalAccountability_RefComprehensiveSupportAndImprovementStatus/g,
    "OrgFedAcctabil_RefCompreSupportImproveStatus"
  );
  sqlContent = sqlContent.replace(
    /OrganizationFederalAccountability_RefTargetedSupportAndImprovementStatus/g,
    "OrgFedAcctabil_RefTargetedSupportImproveStatus"
  );
  sqlContent = sqlContent.replace(
    /OrganizationFinancialFinancialAccountLocal_FinancialAccountLocal/g,
    "OrgFinFinAcctLocal_FinAcctLocal"
  );
  sqlContent = sqlContent.replace(
    /OrganizationFinancialFinancialAccountLocal_OrganizationFinancial/g,
    "OrgFinFinAcctLocal_OrgFin"
  );
  sqlContent = sqlContent.replace(
    /OrganizationPersonRoleRelationship_OrganizationPersonRole_Parent/g,
    "OrgPersonRoleRelation_OrgPersonRole_Parent"
  );
  sqlContent = sqlContent.replace(
    /OrganizationPopulationServed_RefStudentSupportServiceAvailabilityType/g,
    "OrgPopulationServed_RefStudentSupportServiceAvailabilityType"
  );
  sqlContent = sqlContent.replace(
    /OrganizationSalaryScheduleCriteriaValue_OrganizationSalaryScheduleCriteria/g,
    "OrgSalSchedCriteriaValue_OrgSalSchedCriteria"
  );
  sqlContent = sqlContent.replace(
    /OrganizationSalaryScheduleCriteriaValueSalary_OrganizationSalaryScheduleCriteriaValue/g,
    "OrgSalSchedCriteriaValueSal_OrgSalSchedCriteriaValue"
  );
  sqlContent = sqlContent.replace(
    /OrganizationSalaryScheduleCriteriaValueSalary_OrganizationSalaryScheduleSalary/g,
    "OrgSalSchedCriteriaValueSal_OrgSalSchedSal"
  );
  sqlContent = sqlContent.replace(
    /OrganizationSalaryScheduleSalary_RefStandardOccupationalClassification/g,
    "OrgSalSchedSal_RefStandardOccupationClassification"
  );
  sqlContent = sqlContent.replace(
    /OrganizationTechnicalAssistance_RefTechnicalAssistanceDeliveryType/g,
    "OrgTechAssist_RefTechAssistDeliveryType"
  );
  sqlContent = sqlContent.replace(
    /Person_AssessmentPersonalNeedsProfile_AssessmentPersonalNeedsProfile/g,
    "Person_AssessPerNeedProf_AssessPerNeed"
  );
  sqlContent = sqlContent.replace(
    /PersonPersonalInformationVerification_RefPersonalInformationType/g,
    "PersonPersonalInfoVerification_RefPersonalInfoType"
  );
  sqlContent = sqlContent.replace(
    /PersonTransportationEligibility_RefTransportationPublicExpenseEligibilityType/g,
    "PersonTranspoEligibil_RefTranspoPublicExpenseEligibilType"
  );
  sqlContent = sqlContent.replace(
    /PersonTransportationEligibility_RefTransportationStateAidQualificationType/g,
    "PersonTransportEligibil_RefTranspoStateAidQualType"
  );
  sqlContent = sqlContent.replace(
    /ProgramParticipationAttainment_RefEdFactsAcademicOrCareerAndTechnicalOutcomeExitType/g,
    "ProgParticAttain_RefEdFactsAcademCareerTechOutExitType"
  );
  sqlContent = sqlContent.replace(
    /ProgramParticipationAttainment_RefEdFactsAcademicOrCareerAndTechnicalOutcomeType/g,
    "ProgParticAttain_RefEdFactsAcademCareerTechOutType"
  );
  sqlContent = sqlContent.replace(
    /ProgramParticipationCte_RefPerkinsPostProgramPlacementIndicator/g,
    "ProgParticCte_RefPerkinsPostProgPlaceIndicator"
  );
  sqlContent = sqlContent.replace(
    /ProgramParticipationTeacherPrep_RefAltRouteToCertificationOrLicensure/g,
    "ProgParticTeachPrep_RefAltRouteToCertOrLicensure"
  );
  sqlContent = sqlContent.replace(
    /RefAdditionalTargetedSupportAndImprovementStatus_Organization/g,
    "RefAdditionTargetSupportAndImproveStatus_Org"
  );
  sqlContent = sqlContent.replace(
    /RefFinancialAccountLocalBalanceSheetCode_RefFinancialAccountCodingSystemOrganizationType/g,
    "RefFinAcctLocalBalSheetCode_RefFinAcctCodingSysOrgType"
  );
  sqlContent = sqlContent.replace(
    /RefFinancialAccountLocalFundClassification_RefFinancialAccountCodingSystemOrganizationType/g,
    "RefFinAcctLocalFundClassification_RefFinAcctCodingSysOrgType"
  );
  sqlContent = sqlContent.replace(
    /RefFinancialAccountLocalProgramCode_RefFinancialAccountCodingSystemOrganizationType/g,
    "RefFinAcctLocalProgCode_RefFinAcctCodingSysOrgType"
  );
  sqlContent = sqlContent.replace(
    /RefFinancialAccountLocalRevenueCode_RefFinancialAccountCodingSystemOrganizationType/g,
    "RefFinAcctLocalRevCode_RefFinAcctCodingSysOrgType"
  );
  sqlContent = sqlContent.replace(
    /RefFinancialExpenditureLocalFunctionCode_RefFinancialAccountCodingSystemOrganizationType/g,
    "RefFinExpendLocalFunctCode_RefFinAcctCodeSysOrgType"
  );
  sqlContent = sqlContent.replace(
    /RefFinancialExpenditureLocalLevelOfInstructionCode_Organization/g,
    "RefFinExpendLocalLevelOfInstructCode_Org"
  );
  sqlContent = sqlContent.replace(
    /RefFinancialExpenditureLocalLevelOfInstructionCode_RefFinancialAccountCodingSystemOrganizationType/g,
    "RefFinExpendLocalLevInstructCode_RefFinAcctCodeSysOrgType"
  );
  sqlContent = sqlContent.replace(
    /RefFinancialExpenditureLocalObjectCode_RefFinancialAccountCodingSystemOrganizationType/g,
    "RefFinExpendLocalObjectCode_RefFinAcctCodeSysOrgType"
  );
  sqlContent = sqlContent.replace(
    /PersonPersonalInformationVerification_RefPersonalInformationVerification/g,
    "PersonPersonalInfoVerification_RefPersonalInfoVerifi"
  );
  sqlContent = sqlContent.replace(
    /RefEdFactsAcademicOrCareerAndTechnicalOutcomeExitType_Organization/g,
    "RefEdFactsAcadCareerTechOutcomeExitType_Org"
  );
  sqlContent = sqlContent.replace(
    /RefEdFactsAcademicOrCareerAndTechnicalOutcomeType_Organization/g,
    "RefEdFactsAcadCareerTechOutcomeType_Org"
  );

  // Fix PRIMARY KEY constraints
  sqlContent = sqlContent.replace(
    /CONSTRAINT "PK_[^"]+"\s+PRIMARY KEY\s+\("\$1"\)/g,
    (match, p1, offset, string) => {
      const tableName = string.match(/CREATE TABLE "([^"]+)"/)[1];
      return `PRIMARY KEY ("${tableName}Id")`;
    }
  );

  sqlContent = sqlContent.replace(
    /IF EXISTS\((.*?)\)\s*BEGIN/g,
    "IF EXISTS ($1) THEN"
  );

  sqlContent = sqlContent.replace(/@updateExisting/g, "update_existing");
  sqlContent = sqlContent.replace(
    /CREATE FUNCTION/g,
    "CREATE OR REPLACE FUNCTION"
  );

  sqlContent = sqlContent.replace(/TOP\s*\((\d+)\)/g, "LIMIT $1");

  sqlContent = sqlContent.replace(/GETDATE\(\)/g, "CURRENT_TIMESTAMP");

  sqlContent = sqlContent.replace(/WITH\s*\(NOLOCK\)/g, "");

  sqlContent = sqlContent.replace(/^\s*[\r\n]/gm, "");
  return sqlContent;
}

const inputFiles = [
  // '../reference-data/Populate-CEDS-Ref-Tables.sql',
  // '../metadata/Populate-CEDS-Element-Tables.sql',
  "../ddl/manipulated__pre-transformation/CEDS-IDS__manipulated.sql",
];

inputFiles.forEach((inputFile) => {
  fs.readFile(inputFile, "utf8", (err, data) => {
    if (err) {
      console.error(`Error reading file ${inputFile}:`, err);
      return;
    }

    // Clean up the SQL content
    const isReferenceData = inputFile.includes("Populate-CEDS-Ref-Tables.sql");
    const cleanedSql = cleanupSqlForPostgres(data, isReferenceData, inputFile);

    // Write the cleaned SQL to a new file
    const outputFile = inputFile.replace(
      ".sql",
      "../ddl/supagres/SUPAGRES-CEDS-IDS.sql"
    );
    fs.writeFile(outputFile, cleanedSql, (err) => {
      if (err) {
        console.error(`Error writing file ${outputFile}:`, err);
        return;
      }
      console.log(
        `Cleanup complete for ${inputFile}. Please review '${outputFile}' for any remaining issues.`
      );
    });
  });
});
