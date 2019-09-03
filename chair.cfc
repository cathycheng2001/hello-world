<cfcomponent displayname="CHAIR">
<cffunction name="init" access="public">
	<cfargument name="dbname" required="false" default="-1"/>
	<cfargument name="dblogin" required="false" default="-1"/>
	<cfargument name="dbpasswd" required="false" default="-1"/>
	<cfargument name="max_rows" required="false" default="-1"/>
	<cfscript>
		this.dbname=dbname;
		this.dblogin=dblogin;
		this.dbpasswd=dbpasswd;
		this.max_rows=max_rows;
		this.report_status=-1;
		 
	</cfscript>
</cffunction>

  <cfset dom_dept_id="11" ><!--- department of Medicine, for chief eva--->

<cfscript>
   yearToLookAt = dateformat(now(),'yyyy');
     monthToLookAt=dateformat(now(),'mm');
   this.current_fiscal_yr=yearToLookAt;
   this.current_date=dateformat(now(),'mm/dd/yyyy');
   
   //01/27/2010 Deadline is March 1 st
     if (monthToLookAt  LT 3)
  	 this.current_fiscal_yr=yearToLookAt-1;
	 
	 //01/17/2013
	 this.current_fiscal_yr=yearToLookAt;
</cfscript>

<cffunction name="getDivListByDept" access="public">
<cfargument name="dept" required="yes">
<cfargument name="div_id" required="no">
<cfquery name="getDivisionsByDept" datasource="#this.dbname#" username="#this.dblogin#" password="#this.dbpasswd#">
select distinct div_id div_id_seq, FULL_DIV_NAME div_nm
             from MED_CORE.VW_MAIN_SOM_DEPT_DIV DEPT
where dept_id  = '#dept#' AND DEPT.FULL_DEPT_NAME IS NOT NULL  AND DEPT.EXCLUDE_DEPT_INDICATOR='N'  
<cfif isDefined('div_id')>
			AND div_id='#div_id#'
</cfif>
 
</cfquery>
<cfreturn getDivisionsByDept>
</cffunction>

<cffunction name="location" output="false" returnType="void">
        <cfargument name="url" type="string" required="true">
        <cfargument name="addToken" type="boolean" default="true" required="false">
        <cflocation url="#url#" addToken="#addToken#">
</cffunction>

<cffunction name="facultyData">
	<cfargument name="faculty_id"  type="numeric" required="yes">
	  <CFTRY> 
	<cfquery name="q_person" datasource="#this.dbname#" username="#this.dblogin#" password="#this.dbpasswd#">
		 
				 
                 
					Select distinct FIRST_NAME || ' ' || LAST_NAME FULL_NM,  DEPT_ID_SEQ 
			FROM med_core.vw_med_info_new 
 	 			Where EMPLID = '#faculty_id#' 
	</cfquery>
	<cfreturn q_person>
	<cfcatch type="database">  
</cfcatch>
</CFTRY>  
</cffunction>

<cffunction name="personData">
	<cfargument name="faculty_id" required="true" /> 
	<cfquery name="q_person" datasource="#this.dbname#" username="#this.dblogin#" password="#this.dbpasswd#">
		 SELECT DISTINCT MED.EMPLID ,FIRST_NAME || ' ' || LAST_NAME person_name,
	 MED.DEPT_ID_SEQ , MED.DIV_ID_SEQ
	FROM  med_core.vw_med_info_new  MED
	where med.EMPLID='#faculty_id#'
	 
	</cfquery>
	<cfreturn q_person> 
</cffunction>

<cffunction name="getName">
	<cfargument name="emplid"  type="numeric" required="yes">
 	<cfquery name="n_person" datasource="#this.dbname#" username="#this.dblogin#" password="#this.dbpasswd#">
		SELECT   DISTINCT MED.EMPLID, FIRST_NAME || ' ' || LAST_NAME person_name 
			FROM    med_core.vw_med_info_new  MED
 	 			Where med.EMPLID='#emplid#' 
	</cfquery>
	<cfreturn n_person> 
</cffunction> 

<cffunction name="getLOC">
	 
 	<cfquery name="locs" datasource="#this.dbname#" username="#this.dblogin#" password="#this.dbpasswd#">
		SELECT   DISTINCT LOCATION_ID_SEQ, LOCATION  
			FROM   MED_CORE.LOCATION
	</cfquery>
	<cfreturn locs> 
</cffunction> 


<cffunction name="getRace"> 
	<cfquery name="race" datasource="#this.dbname#" username="#this.dblogin#" password="#this.dbpasswd#">
		Select *
			From MED_CORE.ETHNICITY 
		ORDER BY EMORY_RACE_DESC
	</cfquery>
	<cfreturn race> 
</cffunction>

 

<!---cffunction name="Chair_List">
	<cfargument name="faculty_id"  type="numeric" required="yes">
	<cfargument name="year"  type="string" required="yes"> 
	<cfargument name="chair_id"  type="numeric" required="no">
	 
	<cfquery name="chairlist" datasource="#this.dbname#" username="#this.dblogin#" password="#this.dbpasswd#">
		SELECT   DISTINCT MED.MED_ID_SEQ,first_nm ||' '||mid_initial||' '||last_nm person_name,
		ROLE.DEPT_ID_SEQ, dept.DEPT_NM,  ROLE.DIV_ID_SEQ,ROLE.RL_ID_SEQ  
		FROM   med_core.vw_med_info MED, cdcr_dba.cdcr_med_role ROLE ,med_core.dept dept
		WHERE  
		 ROLE.MED_ID_SEQ=MED.MED_ID_SEQ 
		  and role.DEPT_ID_SEQ=dept.DEPT_ID_SEQ
		and ROLE.RL_ID_SEQ='102'
		and ACTIVE_JOB_CD_IND=1 
  		and MED.PRIMARY_POS_IND=1
		<cfif isDefined('chair_id') AND #chair_id# GT 0>
			AND ROLE.MED_ID_SEQ=#chair_id#
		<cfelse>
		and ROLE.MED_ID_SEQ not in (
			Select CHAIR_MED_ID_SEQ 
			From CHAIR_EVA_DBA.REGISTER
 	 		Where faculty_id= '#faculty_id#' 
			AND FISCAL_YEAR  = '#year#' 
		) 
		and dept.ACTIVE_DEPT_IND=1 
		ORDER BY person_name
		</cfif>
		 
	</cfquery> 
	  	<cfreturn chairlist>   
</cffunction--->

<!---cffunction name="Chief_List">
	<cfargument name="faculty_id"  type="numeric" required="yes">
	<cfargument name="year"  type="string" required="yes"> 
	<cfargument name="chief_id"  type="numeric" required="no">
 
	<cfquery name="chieflist" datasource="#this.dbname#" username="#this.dblogin#" password="#this.dbpasswd#">
		SELECT   DISTINCT MED.MED_ID_SEQ,first_nm ||' '||mid_initial||' '||last_nm person_name,
		ROLE.DEPT_ID_SEQ, dept.DEPT_NM,  ROLE.DIV_ID_SEQ,ROLE.RL_ID_SEQ  ,div.DIV_NM
		FROM   med_core.vw_med_info MED, cdcr_dba.cdcr_med_role ROLE ,med_core.dept dept, med_core.div div
		WHERE  
		 ROLE.MED_ID_SEQ=MED.MED_ID_SEQ 
		  and role.DEPT_ID_SEQ=dept.DEPT_ID_SEQ
		   and role.DIV_ID_SEQ=div.DIV_ID_SEQ
		and ROLE.RL_ID_SEQ='105'
		and ACTIVE_JOB_CD_IND=1 
  		and MED.PRIMARY_POS_IND=1
		<cfif isDefined('chief_id') AND #chief_id# GT 0>
			AND ROLE.MED_ID_SEQ=#chief_id#
		<cfelse>
		and ROLE.MED_ID_SEQ not in (
			Select CHAIR_MED_ID_SEQ 
			From CHAIR_EVA_DBA.REGISTER
 	 		Where faculty_id= '#faculty_id#' 
			AND FISCAL_YEAR  = '#year#' 
		) 
		 and dept.ACTIVE_DEPT_IND=1
		 and div.ACTIVE_DIV_IND=1
		ORDER BY person_name
		</cfif>
		 
	</cfquery> 
	  	<cfreturn chieflist>   
</cffunction--->

 

<cffunction name="getComment_DES"> 
	<cfargument name="is_chief"  type="string" required="yes"> 
	<cfquery name="comments_des" datasource="#this.dbname#" username="#this.dblogin#" password="#this.dbpasswd#">
		Select *
			From CHAIR_EVA_DBA.COMMENT_DES
		    Where IS_CHIEF='#is_chief#'
		ORDER BY  COMMENT_DES_ID
	</cfquery>
	<cfreturn comments_des> 
</cffunction>

<cffunction name="getWorksite_DES"> 
	<cfquery name="site_des" datasource="#this.dbname#" username="#this.dblogin#" password="#this.dbpasswd#">
		Select *
			From CHAIR_EVA_DBA.WORKSITE_DES
		ORDER BY worksite_des_id
	</cfquery>
	<cfreturn site_des> 
</cffunction>

<cffunction name="getSection_DES"> 
<cfargument name="is_chief"  type="string" required="yes"> 
	<cfquery name="section_des" datasource="#this.dbname#" username="#this.dblogin#" password="#this.dbpasswd#">
		Select *
			From CHAIR_EVA_DBA.SECTION_DES
			
			  <!--- Where IS_CHIEF='#is_chief#'--->
		ORDER BY  section_des_id 
	</cfquery>
	<cfreturn section_des> 
</cffunction>
  
<cffunction name="getQuestion_DES"> 
<cfargument name="is_chief"  type="string" required="yes"> 
<cfargument name="section_des_id"  type="numeric" required="no">
	<cfquery name="ques_des" datasource="#this.dbname#" username="#this.dblogin#" password="#this.dbpasswd#">
		Select *
			From CHAIR_EVA_DBA.QUESTION_DES
			Where
		<cfif isDefined('section_des_id')>
			   section_des_id ='#section_des_id#' And
		</cfif>
			  IS_CHIEF='#is_chief#'
		ORDER BY  section_des_id, order_des_id 
	</cfquery>
	<cfreturn ques_des> 
</cffunction>

<cffunction name="getDepts"> 
	<cfargument name="cyear"  type="numeric" required="yes">
<cfargument name="dept_id"  type="numeric" required="no">
<cfquery name="multi_dept" datasource="#this.dbname#" username="#this.dblogin#" password="#this.dbpasswd#">
 
 <!---select EMPLID,  NAME,   DEPT_ID DEPT_ID_SEQ, CHAIR_DEPT_DESCR   DEPT_NM
FROM   VW_BASE_SOM_DEPT_CHAIR_DATA --->
	select EMPLID,  NAME,   DEPT_ID DEPT_ID_SEQ, CHAIR_DEPT_DESCR   DEPT_NM
FROM CHAIR_EVA_DBA.CHAIR_TABLE
WHERE	current_year='2019'
     <cfif isDefined('dept_id')>
			   AND DEPT_ID  ='#dept_id#'  
</cfif>
     order by CHAIR_DEPT_DESCR
</cfquery>
<cfreturn multi_dept> 
</cffunction>

<cffunction name=Insert_REGISTER> 
  <cfargument name="faculty_id"  type="numeric" required="yes">
  <cfargument name="chair_dept_id"  type="numeric" required="yes">
  <cfargument name="cyear"  type="string" required="yes">
    <cftry> 
 <cfquery  name="insertREG"  datasource="#this.dbname#" username="#this.dblogin#" password="#this.dbpasswd#">
 	INSERT INTO  CHAIR_EVA_DBA.REGISTER_NEW
	(FACULTY_EMPLID,FACULTY_ID ,FISCAL_YEAR, CHAIR_DEPTID, CHAIR_MED_ID_SEQ)
	VALUES 	 ('#faculty_id#','0','#cyear#','#chair_dept_id#','0' ) 
</cfquery>
  <cfreturn 1>  <cfcatch type="database"> 
	<cfreturn -1>
</cfcatch>
</CFTRY> 
</cffunction>

 <cffunction name="Get_EVA_SEQ_ID"> 
<cfquery name="eva_seq_id" datasource="#this.dbname#" username="#this.dblogin#" password="#this.dbpasswd#">
 select chair_eva_dba.eva_seq_id.nextval eva_seq_id
 from dual
</cfquery>
<cfreturn eva_seq_id> 
</cffunction>
 

<cffunction name=Insert_PROFILE> 
  <cfargument name="eva_seq_id"  type="numeric" required="yes">
  <cfargument name="form_struct" required="yes">
  <cfargument name="cyear"  type="string" required="yes">
    <cfargument name="is_dept"  type="string" required="yes"> 
	 <cftry> 
     
 <cfquery  name="insertCEMP"  datasource="#this.dbname#" username="#this.dblogin#" password="#this.dbpasswd#">
 	INSERT INTO  CHAIR_EVA_DBA.EVALUATOR_PROFILE_NEW
	(EVA_SEQ_ID ,FISCAL_YEAR,CHAIR_MED_ID_SEQ,RANK,RACE,
	CLINICAL_EFFORT,TEACHING_EFFORT,RESEARCH_EFFORT,ADM_EFFORT,
	PRI_WORKSITE_ID,PRI_WORKSITE_OTHER,
	SUB_STATUS,IS_DEPT,APPOINTMENT,DEPT_ID, DIV_ID,DEPT_ID_SEQ, DIV_ID_SEQ
	,DIV_NM,CHAIR_EMPLID) 
	VALUES 	 (#eva_seq_id#,'#cyear#', '#form_struct.dept#', 
	<cfif isDefined('form_struct.rank')>'#form_struct.rank#'<cfelse>''</cfif>,
	<cfif isDefined('form_struct.gender')>'#form_struct.gender#'<cfelse>''</cfif>,
	<cfif isDefined('form_struct.activity_clinical')>'#form_struct.activity_clinical#'<cfelse>''</cfif>,
	<cfif isDefined('form_struct.activity_teaching')>'#form_struct.activity_teaching#'<cfelse>''</cfif>,
	<cfif isDefined('form_struct.activity_research')>'#form_struct.activity_research#'<cfelse>''</cfif>,
	<cfif isDefined('form_struct.activity_admin')>'#form_struct.activity_admin#'<cfelse>''</cfif>,
	<cfif isDefined('form_struct.work_site')>'#form_struct.work_site#'<cfelse>''</cfif>,
	<cfif isDefined('form_struct.work_site_other')>'#form_struct.work_site_other#'<cfelse>''</cfif>,
	1,'#is_dept#', 
	<cfif isDefined('form_struct.appt')>'#form_struct.appt#'<cfelse>''</cfif>,
 	'#form_struct.dept#',
	'#form_struct.div_id#','0','0'
	<cfif isDefined('form_struct.div_nm')>,'#form_struct.div_nm#'<cfelse>''</cfif>
    ,'#form_struct.chair_id#'
	)
	
	
</cfquery>
  <cfreturn 1><cfcatch type="database"> 
	<cfreturn -1>
</cfcatch>
</CFTRY> 
</cffunction>

<cffunction name=Add_RATE> 
  <cfargument name="eva_seq_id"  type="numeric" required="yes">
  <cfargument name="form_struct" required="yes">
   
   <cftransaction >
		<cfscript>
	 	#this.Insert_LIST(eva_seq_id,1,form_struct.section_1,form_struct.dq_1_list,form_struct.q_1_list)#;//1=Section 1;
	 	#this.Insert_LIST(eva_seq_id,2,form_struct.section_2,form_struct.dq_2_list,form_struct.q_2_list)#;//2=Section 2;
	    #this.Insert_LIST(eva_seq_id,3,form_struct.section_3,form_struct.dq_3_list,form_struct.q_3_list)#;//3=Section 3;
	 	#this.Insert_LIST(eva_seq_id,4,form_struct.section_4,form_struct.dq_4_list,form_struct.q_4_list)#;//4=Section 4;
	 	#this.Insert_LIST(eva_seq_id,5,form_struct.section_5,form_struct.dq_5_list,form_struct.q_5_list)#;//5=Section 5;
	 	#this.Insert_LIST(eva_seq_id,6,form_struct.section_6,form_struct.dq_6_list,form_struct.q_6_list)#;//6=Section 6;
	 	#this.Insert_LIST(eva_seq_id,7,form_struct.section_7,form_struct.dq_7_list,form_struct.q_7_list)#;//7=Section 7; 
	 	#this.Insert_LIST(eva_seq_id,8,form_struct.section_8,form_struct.dq_8_list,form_struct.q_8_list)#;//8=Section 8;
		//06/07/2011 #this.Insert_LIST(eva_seq_id,9,form_struct.section_9,form_struct.dq_9_list,form_struct.q_9_list)#;//9=Comments;
		#this.Insert_COM_Query(eva_seq_id,1,form_struct.comments_1)#;
		#this.Insert_COM_Query(eva_seq_id,2,form_struct.comments_2)#;
		#this.Insert_COM_Query(eva_seq_id,3,form_struct.comments_3)#;
		</cfscript>
	</cftransaction>
		 
   
 </cffunction>
 
  <cffunction name=Insert_LIST> 
  		<cfargument name="eva_seq_id" type="numeric" required="yes">
		 <cfargument name="type"  type="numeric" required="yes" >
		<cfargument name="section" type="numeric" required="yes">
      	<cfargument name="list1" required="yes">
	 	<cfargument name="list2" required="yes"> 
		 
	  <CFSCRIPT>
	  	content1="";
		content2="";
		 
     	For (i=1;i LTE ListLen(list1, "^"); i=i+1){
	 	 content1=GetToken(list1, i, "^"); 
		 content2=GetToken(list2, i, "^"); 
		  if( #type# LT "9")
         	#this.Insert_RATE_Query(eva_seq_id,section,content1,content2)#;
		 // else
		  	//#this.Insert_COM_Query(eva_seq_id,content1,content2)#;
		 }
	</CFSCRIPT>
</cffunction>
 
 
  
 <cffunction name=Insert_RATE_Query> 
  <cfargument name="eva_seq_id"  type="numeric" required="yes">
  <cfargument name="section" type="numeric" required="yes">
  <cfargument name="question" type="numeric" required="yes">
  <cfargument name="rate" type="numeric" required="yes">
   <cfif #rate# GT '0'>
      <cftry>     
  <cfquery  name="insertRATE"  datasource="#this.dbname#" username="#this.dblogin#" password="#this.dbpasswd#">
 			INSERT INTO  CHAIR_EVA_DBA.RATE_NEW
			(EVA_SEQ_ID ,SECTION_DES_ID,QUESTION_DES_ID,RATE )
			VALUES ('#eva_seq_id#', '#section#','#question#','#rate#') 
				</cfquery>   <cfreturn 1><cfcatch type="database"> 
	<cfreturn -1>
</cfcatch>
</CFTRY>  </cfif>
</cffunction>

 <cffunction name=Insert_COM_Query> 
  <cfargument name="eva_seq_id"  type="numeric" required="yes">
   <cfargument name="com" type="numeric" required="yes">
  <cfargument name="com_des"type="string" required="yes">
  <cftry>
<cfquery  name="insertRATE"  datasource="#this.dbname#" username="#this.dblogin#" password="#this.dbpasswd#">
 			INSERT INTO  CHAIR_EVA_DBA.COMMENTS_NEW
			(EVA_SEQ_ID ,COMMENT_DES_ID,COMMENTS )
			VALUES ('#eva_seq_id#', '#com#','#com_des#') 
			</cfquery>    <cfreturn 1><cfcatch type="database"> 
	<cfreturn -1>
</cfcatch>
</CFTRY> 
</cffunction>

<!---cffunction name=Update_REGISTER> 
  <cfargument name="faculty_id"  type="numeric" required="yes">
   <cfargument name="chair_id"  type="numeric" required="yes">
  <cfargument name="chief_id"  type="numeric" required="yes">
  <cfargument name="cyear"  type="string" required="yes">
     
 <cfquery  name="updateREG"  datasource="#this.dbname#" username="#this.dblogin#" password="#this.dbpasswd#">
 	UPDATE  CHAIR_EVA_DBA.REGISTER
	SET CHIEF_MED_ID_SEQ=#chief_id#
	WHERE FACULTY_ID=#faculty_id#
	AND  FISCAL_YEAR='#cyear#'
	AND  CHAIR_MED_ID_SEQ=#chair_id#
	 
</cfquery>
  <cfreturn 1>  
</cffunction--->

<!---cffunction name=Update_PROFILE> 
  <cfargument name="eva_seq_id"  type="numeric" required="yes">
    <cfargument name="chief_id"  type="numeric" required="yes">   
	   
 <cfquery  name="updateCEMP"  datasource="#this.dbname#" username="#this.dblogin#" password="#this.dbpasswd#">
 	UPDATE  CHAIR_EVA_DBA.EVALUATOR_PROFILE
	SET CHIEF_MED_ID_SEQ=#chief_id#
	WHERE EVA_SEQ_ID=#eva_seq_id# 
</cfquery>
   <cfreturn 1>
</cffunction--->

<cffunction name="getUserRole" access="public">
<cfargument name="emplid" required="yes">
<cfquery name="getRoles" datasource="#this.dbname#" username="#this.dblogin#" password="#this.dbpasswd#">
	 
		select distinct
     FM.DEPT_ID  DEPT_ID_SEQ,FM.DIV_ID DIV_ID_SEQ  , DEPT.FULL_DEPT_NAME DEPT_NM,
     DEPT.FULL_DIV_NAME DIV_NM 
     ,MD.FIRST_NAME,MD.LAST_NAME,MD.MIDDLE_NAME,MD.JOB_DESC  
     ,FR.RL_DESC,  FR.RL_ID_SEQ 
     from  CDCR_DBA.CDCR_MED_ROLE_NEW FM 
         LEFT OUTER JOIN MED_CORE.VW_MAIN_SOM_DEPT_DIV DEPT ON ( FM.DEPT_ID=DEPT.DEPT_ID AND   FM.DIV_ID=DEPT.DIV_ID)
         JOIN MED_CORE.VW_MED_INFO_NEW MD on (FM.EMPLID = MD.EMPLID) 
         JOIN CDCR_DBA.CDCR_ROLE FR on (FM.RL_ID_SEQ = FR.RL_ID_SEQ  )  
         AND   FM.EMPLID='#emplid#'
         AND DEPT.FULL_DEPT_NAME IS NOT NULL  AND DEPT.EXCLUDE_DEPT_INDICATOR='N' 
</cfquery>
<cfreturn getRoles>
</cffunction>

<!---08/02/2018--->
<cffunction name="getUserRole_new" access="public">
<cfargument name="emplid" required="yes">
<cfquery name="getRoles" datasource="#this.dbname#" username="#this.dblogin#" password="#this.dbpasswd#">
	 select distinct RL_ID_SEQ ,DEPT_ID DEPT_ID_SEQ
     from  CDCR_DBA.CDCR_MED_ROLE_NEW   
         where   EMPLID='#emplid#'
         
</cfquery>
<cfreturn getRoles>
</cffunction>

<!---cffunction name="DEPT_COM" access="public">
 <cfargument name="cyear"  type="string" required="yes">
<cfargument name="dept_id" required="no">
   
 <cfquery name="multi_COM" datasource="#this.dbname#" username="#this.dblogin#" password="#this.dbpasswd#">
	 	
	 	select eep.EVA_SEQ_ID,dept_id, eep.CHAIR_EMPLID,   com1.comments Expand_or_clarify_areas, com2.comments Suggestions_for_chair , 
com3.comments Additional_comments_for_Dean 
	from chair_eva_dba.evaluator_profile_new eep ,
	chair_eva_dba.comments_new com1,chair_eva_dba.comments_new com2,chair_eva_dba.comments_new com3  
	where  
  com1.comment_des_id=1 and com1.EVA_SEQ_ID=eep.EVA_SEQ_ID	
	and com2.comment_des_id=2 and com2.EVA_SEQ_ID=eep.EVA_SEQ_ID
	and com3.comment_des_id=3 and com3.EVA_SEQ_ID=eep.EVA_SEQ_ID 
	and (com1.comments is not null or com2.comments is not null or com3.comments is not null)
	and eep.FISCAL_YEAR='#cyear#'
	<cfif isDefined('dept_id')>
	and eep.dept_id=#dept_id#
	</cfif>
	order by DEPT_ID, EVA_SEQ_ID
	</cfquery>
<cfreturn multi_COM>
</cffunction--->

<!---cffunction name="DIV_COM" access="public">
 <cfargument name="cyear"  type="string" required="yes">
<cfargument name="div" required="no">
 
 <cfquery name="div_COM" datasource="#this.dbname#" username="#this.dblogin#" password="#this.dbpasswd#">
	 	
	 	select  eep.EVA_SEQ_ID, div.DIV_NM ,   com1.comments Expand_or_clarify_areas, com2.comments Suggestions_for_chief , com3.comments Additional_comments_for_Chair 
	from chair_eva_dba.evaluator_profile eep, med_core.div,
	chair_eva_dba.comments_new com1,chair_eva_dba.comments_new com2,chair_eva_dba.comments_new com3  
	where  eep.DIV_ID_SEQ=div.DIV_ID_SEQ
	and com1.comment_des_id=4 and com1.EVA_SEQ_ID=eep.EVA_SEQ_ID	
	and com2.comment_des_id=5 and com2.EVA_SEQ_ID=eep.EVA_SEQ_ID
	and com3.comment_des_id=6 and com3.EVA_SEQ_ID=eep.EVA_SEQ_ID 
	and (com1.comments is not null or com2.comments is not null or com3.comments is not null)
	and eep.FISCAL_YEAR='#cyear#'
	<!---and eep.DEPT_ID_SEQ=11--->
	and eep.DEPT_ID_SEQ=536
	order by div.DIV_NM
	</cfquery>
<cfreturn div_COM>
</cffunction--->
 
 <cffunction name="DEPT_RATE" access="public">
  <cfargument name="cyear"  type="string" required="yes">
<cfargument name="dept_id" required="no">
 
 <cfquery name="dept_r" datasource="#this.dbname#" username="#this.dblogin#" password="#this.dbpasswd#">
	 	<!---select  dept.SOM_DEPT_NM,    count(dept.SOM_DEPT_NM) count,--->
			select  dept_id,    count(dept_id) count,
		round(avg(rate11.RATE),2) q11 ,round(avg(rate12.RATE),2) q12 ,round(avg(rate13.RATE),2) q13
		,round(avg(rate21.RATE),2) q21,round(avg(rate22.RATE),2) q22,round(avg(rate23.RATE),2) q23,round(avg(rate24.RATE),2) q24,round(avg(rate25.RATE),2) q25
		,round(avg(rate31.RATE),2) q31,round(avg(rate32.RATE),2) q32,round(avg(rate33.RATE),2) q33,round(avg(rate34.RATE),2) q34,round(avg(rate35.RATE),2) q35
		,round(avg(rate41.RATE),2) q41,round(avg(rate42.RATE),2) q42,round(avg(rate43.RATE),2) q43,round(avg(rate44.RATE),2) q44,round(avg(rate45.RATE),2) q45
		,round(avg(rate51.RATE),2) q51,round(avg(rate52.RATE),2) q52,round(avg(rate53.RATE),2) q53,round(avg(rate54.RATE),2) q54 
		,round(avg(rate61.RATE),2) q61,round(avg(rate62.RATE),2) q62,round(avg(rate63.RATE),2) q63,round(avg(rate64.RATE),2) q64 ,round(avg(rate65.RATE),2) q65
		,round(avg(rate71.RATE),2) q71,round(avg(rate72.RATE),2) q72,round(avg(rate73.RATE),2) q73,round(avg(rate74.RATE),2) q74 
		,round(avg(rate75.RATE),2) q75,round(avg(rate76.RATE),2) q76,round(avg(rate77.RATE),2) q77,round(avg(rate78.RATE),2) q78 
		,round(avg(rate79.RATE),2) q79
		,round(avg(rate710.RATE),2) q710,round(avg(rate711.RATE),2) q711,round(avg(rate712.RATE),2) q712,round(avg(rate713.RATE),2) q713
        , round(avg(rate714.RATE),2) q714 , round(avg(rate715.RATE),2) q715
		,round(avg(rate81.RATE),2) q81 
	from chair_eva_dba.evaluator_profile_new eep,   
	chair_eva_dba.rate_new rate11,chair_eva_dba.rate_new rate12,chair_eva_dba.rate_new rate13
	,chair_eva_dba.rate_new rate21,chair_eva_dba.rate_new rate22,chair_eva_dba.rate_new rate23,chair_eva_dba.rate_new rate24,chair_eva_dba.rate_new rate25
	,chair_eva_dba.rate_new rate31,chair_eva_dba.rate_new rate32,chair_eva_dba.rate_new rate33,chair_eva_dba.rate_new rate34,chair_eva_dba.rate_new rate35
	,chair_eva_dba.rate_new rate41,chair_eva_dba.rate_new rate42,chair_eva_dba.rate_new rate43,chair_eva_dba.rate_new rate44,chair_eva_dba.rate_new rate45
	,chair_eva_dba.rate_new rate51,chair_eva_dba.rate_new rate52,chair_eva_dba.rate_new rate53,chair_eva_dba.rate_new rate54 
	,chair_eva_dba.rate_new rate61,chair_eva_dba.rate_new rate62,chair_eva_dba.rate_new rate63,chair_eva_dba.rate_new rate64 ,chair_eva_dba.rate_new rate65
	,chair_eva_dba.rate_new rate71,chair_eva_dba.rate_new rate72,chair_eva_dba.rate_new rate73,chair_eva_dba.rate_new rate74 
	,chair_eva_dba.rate_new rate75,chair_eva_dba.rate_new rate76,chair_eva_dba.rate_new rate77,chair_eva_dba.rate_new rate78 
	,chair_eva_dba.rate_new rate79
	,chair_eva_dba.rate_new rate710,chair_eva_dba.rate_new rate711,chair_eva_dba.rate_new rate712  ,chair_eva_dba.rate_new rate713
    ,chair_eva_dba.rate_new rate714,chair_eva_dba.rate_new rate715
	,chair_eva_dba.rate_new rate81
	where  
	<cfif isDefined('dept_id')>
	 eep.CHAIR_MED_ID_SEQ=#dept_id#
	</cfif>
	<cfif cyear EQ '2010'>
	<cfelse>
	  eep.FISCAL_YEAR='#cyear#' 
	</cfif> 
	and rate11.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate11.SECTION_DES_ID(+)=1 and rate11.QUESTION_DES_ID(+)=1
	and rate12.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate12.SECTION_DES_ID(+)=1 and rate12.QUESTION_DES_ID(+)=2
	and rate13.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate13.SECTION_DES_ID(+)=1 and rate13.QUESTION_DES_ID(+)=3
	and rate21.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate21.SECTION_DES_ID(+)=2 and rate21.QUESTION_DES_ID(+)=4
	and rate22.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate22.SECTION_DES_ID(+)=2 and rate22.QUESTION_DES_ID(+)=5
	and rate23.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate23.SECTION_DES_ID(+)=2 and rate23.QUESTION_DES_ID(+)=6
	and rate24.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate24.SECTION_DES_ID(+)=2 and rate24.QUESTION_DES_ID(+)=7
	and rate25.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate25.SECTION_DES_ID(+)=2 and rate25.QUESTION_DES_ID(+)=8
	and rate31.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate31.SECTION_DES_ID(+)=3 and rate31.QUESTION_DES_ID(+)=9
	and rate32.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate32.SECTION_DES_ID(+)=3 and rate32.QUESTION_DES_ID(+)=10
	and rate33.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate33.SECTION_DES_ID(+)=3 and rate33.QUESTION_DES_ID(+)=11
	and rate34.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate34.SECTION_DES_ID(+)=3 and rate34.QUESTION_DES_ID(+)=12
	and rate35.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate35.SECTION_DES_ID(+)=3 and rate35.QUESTION_DES_ID(+)=121
	and rate41.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate41.SECTION_DES_ID(+)=4 and rate41.QUESTION_DES_ID(+)=13
	and rate42.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate42.SECTION_DES_ID(+)=4 and rate42.QUESTION_DES_ID(+)=14
	and rate43.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate43.SECTION_DES_ID(+)=4 and rate43.QUESTION_DES_ID(+)=15
	and rate44.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate44.SECTION_DES_ID(+)=4 and rate44.QUESTION_DES_ID(+)=16
	and rate45.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate45.SECTION_DES_ID(+)=4 and rate45.QUESTION_DES_ID(+)=17
	and rate51.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate51.SECTION_DES_ID(+)=5 and rate51.QUESTION_DES_ID(+)=18
	and rate52.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate52.SECTION_DES_ID(+)=5 and rate52.QUESTION_DES_ID(+)=19
	and rate53.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate53.SECTION_DES_ID(+)=5 and rate53.QUESTION_DES_ID(+)=20
	and rate54.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate54.SECTION_DES_ID(+)=5 and rate54.QUESTION_DES_ID(+)=21
	and rate61.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate61.SECTION_DES_ID(+)=6 and rate61.QUESTION_DES_ID(+)=22
	and rate62.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate62.SECTION_DES_ID(+)=6 and rate62.QUESTION_DES_ID(+)=23
	and rate63.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate63.SECTION_DES_ID(+)=6 and rate63.QUESTION_DES_ID(+)=24
	and rate64.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate64.SECTION_DES_ID(+)=6 and rate64.QUESTION_DES_ID(+)=25
    and rate65.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate65.SECTION_DES_ID(+)=6 and rate65.QUESTION_DES_ID(+)=161
	and rate71.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate71.SECTION_DES_ID(+)=7 and rate71.QUESTION_DES_ID(+)=26
	and rate72.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate72.SECTION_DES_ID(+)=7 and rate72.QUESTION_DES_ID(+)=27
	and rate73.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate73.SECTION_DES_ID(+)=7 and rate73.QUESTION_DES_ID(+)=28
	and rate74.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate74.SECTION_DES_ID(+)=7 and rate74.QUESTION_DES_ID(+)=29
	and rate75.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate75.SECTION_DES_ID(+)=7 and rate75.QUESTION_DES_ID(+)=30
	and rate76.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate76.SECTION_DES_ID(+)=7 and rate76.QUESTION_DES_ID(+)=31
	and rate77.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate77.SECTION_DES_ID(+)=7 and rate77.QUESTION_DES_ID(+)=32
	and rate78.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate78.SECTION_DES_ID(+)=7 and rate78.QUESTION_DES_ID(+)=33
	and rate79.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate79.SECTION_DES_ID(+)=7 and rate79.QUESTION_DES_ID(+)=34
	and rate710.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate710.SECTION_DES_ID(+)=7 and rate710.QUESTION_DES_ID(+)=171
	and rate711.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate711.SECTION_DES_ID(+)=7 and rate711.QUESTION_DES_ID(+)=35
	and rate712.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate712.SECTION_DES_ID(+)=7 and rate712.QUESTION_DES_ID(+)=36
	and rate713.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate713.SECTION_DES_ID(+)=7 and rate713.QUESTION_DES_ID(+)=172
    and rate714.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate714.SECTION_DES_ID(+)=7 and rate714.QUESTION_DES_ID(+)=37
    and rate715.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate715.SECTION_DES_ID(+)=7 and rate715.QUESTION_DES_ID(+)=38
	and rate81.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate81.SECTION_DES_ID(+)=8 and rate81.QUESTION_DES_ID(+)=39 
	 
	group by  dept_id
    order by  dept_id
	</cfquery>
<cfreturn dept_r>
</cffunction>

 <cffunction name="DIV_RATE" access="public">
  <cfargument name="cyear"  type="string" required="yes">
<cfargument name="div" required="no">
 
 <cfquery name="div_r" datasource="#this.dbname#" username="#this.dblogin#" password="#this.dbpasswd#">
select  eep.DIV_NM , count(eep.DIV_NM) count,
		 round(avg(rate11.RATE),2) q11 ,round(avg(rate12.RATE),2) q12 ,round(avg(rate13.RATE),2) q13
		,round(avg(rate21.RATE),2) q21,round(avg(rate22.RATE),2) q22,round(avg(rate23.RATE),2) q23,round(avg(rate24.RATE),2) q24 
		,round(avg(rate31.RATE),2) q31,round(avg(rate32.RATE),2) q32,round(avg(rate33.RATE),2) q33 
		,round(avg(rate41.RATE),2) q41,round(avg(rate42.RATE),2) q42,round(avg(rate43.RATE),2) q43
	 	,round(avg(rate51.RATE),2) q51,round(avg(rate52.RATE),2) q52,round(avg(rate53.RATE),2) q53 
		 ,round(avg(rate61.RATE),2) q61,round(avg(rate62.RATE),2) q62,round(avg(rate63.RATE),2) q63 
		,round(avg(rate71.RATE),2) q71,round(avg(rate72.RATE),2) q72,round(avg(rate73.RATE),2) q73,round(avg(rate74.RATE),2) q74 
		,round(avg(rate75.RATE),2) q75,round(avg(rate76.RATE),2) q76,round(avg(rate77.RATE),2) q77,round(avg(rate78.RATE),2) q78 
		,round(avg(rate79.RATE),2) q79
		,round(avg(rate81.RATE),2) q81
	from chair_eva_dba.evaluator_profile_new eep,
	 chair_eva_dba.rate_new rate11,chair_eva_dba.rate_new rate12,chair_eva_dba.rate_new rate13
	,chair_eva_dba.rate_new rate21,chair_eva_dba.rate_new rate22,chair_eva_dba.rate_new rate23,chair_eva_dba.rate_new rate24 
	,chair_eva_dba.rate_new rate31,chair_eva_dba.rate_new rate32,chair_eva_dba.rate_new rate33
	,chair_eva_dba.rate_new rate41,chair_eva_dba.rate_new rate42,chair_eva_dba.rate_new rate43 
    ,chair_eva_dba.rate_new rate51,chair_eva_dba.rate_new rate52,chair_eva_dba.rate_new rate53 
	,chair_eva_dba.rate_new rate61,chair_eva_dba.rate_new rate62,chair_eva_dba.rate_new rate63 
	,chair_eva_dba.rate_new rate71,chair_eva_dba.rate_new rate72,chair_eva_dba.rate_new rate73,chair_eva_dba.rate_new rate74 
	,chair_eva_dba.rate_new rate75,chair_eva_dba.rate_new rate76,chair_eva_dba.rate_new rate77,chair_eva_dba.rate_new rate78 
	,chair_eva_dba.rate_new rate79
	,chair_eva_dba.rate_new rate81 
	where  eep.FISCAL_YEAR='#cyear#' 
	and rate11.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate11.SECTION_DES_ID(+)=1 and rate11.QUESTION_DES_ID(+)=201
	and rate12.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate12.SECTION_DES_ID(+)=1 and rate12.QUESTION_DES_ID(+)=202
	and rate13.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate13.SECTION_DES_ID(+)=1 and rate13.QUESTION_DES_ID(+)=203
	and rate21.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate21.SECTION_DES_ID(+)=2 and rate21.QUESTION_DES_ID(+)=204
	and rate22.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate22.SECTION_DES_ID(+)=2 and rate22.QUESTION_DES_ID(+)=205
	and rate23.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate23.SECTION_DES_ID(+)=2 and rate23.QUESTION_DES_ID(+)=206 
	and rate24.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate24.SECTION_DES_ID(+)=2 and rate24.QUESTION_DES_ID(+)=207
	
	and rate31.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate31.SECTION_DES_ID(+)=3 and rate31.QUESTION_DES_ID(+)=209
	and rate32.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate32.SECTION_DES_ID(+)=3 and rate32.QUESTION_DES_ID(+)=210
	and rate33.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate33.SECTION_DES_ID(+)=3 and rate33.QUESTION_DES_ID(+)=211
	 
	and rate41.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate41.SECTION_DES_ID(+)=4 and rate41.QUESTION_DES_ID(+)=213
	and rate42.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate42.SECTION_DES_ID(+)=4 and rate42.QUESTION_DES_ID(+)=214
	and rate43.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate43.SECTION_DES_ID(+)=4 and rate43.QUESTION_DES_ID(+)=215
	
	and rate51.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate51.SECTION_DES_ID(+)=5 and rate51.QUESTION_DES_ID(+)=218
	and rate52.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate52.SECTION_DES_ID(+)=5 and rate52.QUESTION_DES_ID(+)=220
	and rate53.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate53.SECTION_DES_ID(+)=5 and rate53.QUESTION_DES_ID(+)=221
	 
	and rate61.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate61.SECTION_DES_ID(+)=6 and rate61.QUESTION_DES_ID(+)=222
	and rate62.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate62.SECTION_DES_ID(+)=6 and rate62.QUESTION_DES_ID(+)=223
	and rate63.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate63.SECTION_DES_ID(+)=6 and rate63.QUESTION_DES_ID(+)=224
	 
	and rate71.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate71.SECTION_DES_ID(+)=7 and rate71.QUESTION_DES_ID(+)=230
	and rate72.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate72.SECTION_DES_ID(+)=7 and rate72.QUESTION_DES_ID(+)=231
	and rate73.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate73.SECTION_DES_ID(+)=7 and rate73.QUESTION_DES_ID(+)=232
	and rate74.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate74.SECTION_DES_ID(+)=7 and rate74.QUESTION_DES_ID(+)=233
	and rate75.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate75.SECTION_DES_ID(+)=7 and rate75.QUESTION_DES_ID(+)=235
	and rate76.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate76.SECTION_DES_ID(+)=7 and rate76.QUESTION_DES_ID(+)=236
	and rate77.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate77.SECTION_DES_ID(+)=7 and rate77.QUESTION_DES_ID(+)=237
	and rate78.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate78.SECTION_DES_ID(+)=7 and rate78.QUESTION_DES_ID(+)=238
	and rate79.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate79.SECTION_DES_ID(+)=7 and rate79.QUESTION_DES_ID(+)=239
	and rate81.EVA_SEQ_ID(+)=eep.EVA_SEQ_ID and rate81.SECTION_DES_ID(+)=8 and rate81.QUESTION_DES_ID(+)=240 
	<!---and eep.DEPT_ID_SEQ=11--->
	and eep.DEPT_ID_SEQ=536
		group by  DIV_NM
	order by  DIV_NM
	 
</cfquery>
<cfreturn div_r>
</cffunction>

<cffunction name="GET_PROFILE" access="public">
 <cfargument name="cyear"  type="string" required="yes">
<cfargument name="eva_id" required="yes">
 
 <cfquery name="get_PRO" datasource="#this.dbname#" username="#this.dblogin#" password="#this.dbpasswd#">
	 	select eep.rank, eep.CLINICAL_EFFORT,eep.TEACHING_EFFORT,eep.RESEARCH_EFFORT,eep.ADM_EFFORT ,wds.worksite_des  ,eep.PRI_WORKSITE_ID,eep.APPOINTMENT,EEP.PRI_WORKSITE_OTHER
from chair_eva_dba.evaluator_profile_new eep, chair_eva_dba.worksite_des wds
where eep.EVA_SEQ_ID=#eva_id#
and eep.PRI_WORKSITE_ID=wds.WORKSITE_des_ID
and eep.FISCAL_YEAR='#cyear#' 
	</cfquery>
<cfreturn get_PRO>
</cffunction>

 <cffunction name="sendEmail" access="public">

  
 <cfargument name="title" type="string" required="true">
   <cfargument name="fromS" type="string" required="true">
    <cfargument name="toS" type="string" required="true">
	 <cfargument name="message" type="string" required="true">
<CFTRY>
<CFMAIL
  SUBJECT="#title#"  
  FROM="#fromS#"
  TO="#toS#"
 >
  
#message#
</cfmail>
<cfcatch >
 
	 
</cfcatch>
</CFTRY> 
 
</cffunction>

<!---cffunction name="getRank">
	  <cfquery name="get_Rank" datasource="#this.dbname#" username="#this.dblogin#" password="#this.dbpasswd#">
 SELECT DISTINCT  pos_desc.JOB_DESC 
   FROM  med_core.pos_desc, med_core.med, med_core.pos
   where 
   pos_desc.POS_DESC_ID_SEQ=pos.POS_DESC_ID_SEQ
 	and pos.MED_ID_SEQ=med.MED_ID_SEQ
 	and(  (POS_DESC.POS_TYP_ID_SEQ in (1,2,3,4,5)  and med.va_ind >= 1) 
	or 
  	      (POS_DESC.POS_TYP_ID_SEQ in (1,2) and POS.EMPLOYEE_CLASS_CD <> 'H')
		)
	order by JOB_DESC
 </cfquery>
<cfreturn get_Rank>
</cffunction--->

<cffunction name=Add_RATE2> 
  <cfargument name="eva_seq_id"  type="numeric" required="yes">
  <cfargument name="form_struct" required="yes">
   
   <cftransaction >
		<cfscript>
		#this.Insert_LIST(eva_seq_id,1,form_struct.section_1,form_struct.dq_1_list,form_struct.q_1_list)#;//1=Section 1;
		#this.Insert_LIST(eva_seq_id,2,form_struct.section_2,form_struct.dq_2_list,form_struct.q_2_list)#;//2=Section 2;
		#this.Insert_LIST(eva_seq_id,3,form_struct.section_3,form_struct.dq_3_list,form_struct.q_3_list)#;//3=Section 3;
		#this.Insert_LIST(eva_seq_id,4,form_struct.section_4,form_struct.dq_4_list,form_struct.q_4_list)#;//4=Section 4;
		#this.Insert_LIST(eva_seq_id,5,form_struct.section_5,form_struct.dq_5_list,form_struct.q_5_list)#;//5=Section 5;
		#this.Insert_LIST(eva_seq_id,6,form_struct.section_6,form_struct.dq_6_list,form_struct.q_6_list)#;//6=Section 6;
		#this.Insert_LIST(eva_seq_id,7,form_struct.section_7,form_struct.dq_7_list,form_struct.q_7_list)#;//7=Section 7; 
		#this.Insert_LIST(eva_seq_id,8,form_struct.section_8,form_struct.dq_8_list,form_struct.q_8_list)#;//8=Section 8;
		//06/07/2011 #this.Insert_LIST(eva_seq_id,9,form_struct.section_9,form_struct.dq_9_list,form_struct.q_9_list)#;//9=Comments;
		#this.Insert_COM_Query(eva_seq_id,4,form_struct.comments_1)#;
		#this.Insert_COM_Query(eva_seq_id,5,form_struct.comments_2)#;
		#this.Insert_COM_Query(eva_seq_id,6,form_struct.comments_3)#;
		</cfscript>
	</cftransaction>
		 
   
 </cffunction>
 
  <cffunction name="Get_DIV_NM"> 
   <cfargument name="eva_seq_id"  type="numeric" required="yes">
<cfquery name="eva_div_nm" datasource="#this.dbname#" username="#this.dblogin#" password="#this.dbpasswd#">
	SELECT DIV_NM 
 FROM CHAIR_EVA_DBA.EVALUATOR_PROFILE_NEW
 WHERE EVA_SEQ_ID=#eva_seq_id#
</cfquery>
<cfreturn eva_div_nm> 
</cffunction>
 
 
  
</cfcomponent>	
