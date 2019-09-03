<noscript>
	<center><strong>Javascript is currently disabled on your browser. Please enable Javascript and try this page again.</strong></center>
	<cfset mySiteFromJavascriptCheck365 = "http://" & #CGI.HTTP_HOST# & #GetHttpRequestData().headers.SCRIPT_NAME#>
	<cfoutput><meta http-equiv="refresh" content="0;url=/JavascriptDoesNotExist.cfm?mySiteFrom=#mySiteFromJavascriptCheck365#" /></cfoutput>
</noscript>
<link href="styles/styles.css" rel="stylesheet" type="text/css">
   <cfset test=1> <!---  //for test, will delete once move to prod--->
   <cfsetting requesttimeout="3600" /> <!---3600/60=60min--->
   <!---cfset dom_dept_id="11" /---><!--- department of Medicine, for chief eva--->
  <cfset dom_dept_id="536" /><!--- department of Medicine, for chief eva 12/12/2009--->

 <!---cfset BodyOnloadVar='DisablingBackFunctionality()'--->
   <cfinclude template="../includes/page_header_new.cfm">
 <!---cfmodule template="fes/TimeOutWarning.cfm" WarningThreshold = "2" TimeOutMinutes = "30"--->

 <cfscript>
       chair=createObject("component","chair");
		 chair.init(dbname,dblogin,dbpasswd);
		  if ( IsDefined('session.authenticated_user_emplid') ){
			checkID=#session.authenticated_user_emplid#;
		 }
		 if ( IsDefined('demo'))//for test, will delete once move to prod
			checkID=demo;

		 if ( IsDefined('checkID') )
		 	faculty_id=#checkID#;
		 else{
	 		faculty_id=-1; //invalid user
			abort();
			}

			 if(IsDefined('get_year'))
			cyear=#get_year#;
		else
			cyear=#chair.current_fiscal_yr#;
		lyear=cyear-1;

			insert_register=-1;
			insert_profile=-1;


		//  chair_name=chair.Chair_List(0,cyear,#FORM.chair_id#);
		 person=chair.personData(faculty_id);
		 
	 	 department=chair.getDepts(cyear,FORM.dept).dept_nm;

	  insert_register=chair.Insert_REGISTER(faculty_id,#FORM.dept#,cyear);
	  
	  
   eva_seq_id=chair.Get_EVA_SEQ_ID().eva_seq_id;

		 	is_dept='N';
		 if(person.DEPT_ID_SEQ  EQ FORM.dept)
		 	is_dept='Y';
 
		  insert_profile=chair.Insert_PROFILE(eva_seq_id,FORM,cyear,is_dept);

		//writeoutput(eva_seq_id);
		   if (insert_profile EQ '1')
		  	insert_rate=chair.Add_RATE(eva_seq_id,FORM);
		 // if ( IsDefined('FORM.feedback') and NOT trim(FORM.feedback) EQ '') {

		 //  chair.sendEmail("Chair Evaluation Feedback", "#LookupPeachEmail(faculty_id)#","SOM-WEB@LISTSERV.CC.EMORY.EDU", "#FORM.feedback#");
		  // }
 

	 </cfscript>
 <script language="JavaScript" type="text/javascript" src="/med/prod/database/chair/includes/js/qforms.js"></script>
<script language="JavaScript" type="text/javascript" src="/med/prod/database/chair/includes/js/check.js"></script>
<script language="JavaScript" type="text/javascript">
	 qFormAPI.setLibraryPath("/med/prod/database/chair/includes/js/");
	 qFormAPI.include("*");
</script>

<table style="padding:5px; border-spacing:5px; width:100%; margin-left:auto; margin-right:auto;" height="500">
 <cfoutput> <tr align="center"><td>
 	<!---cfif insert_register EQ '1' AND insert_profile EQ '1' --->
		Thank you for doing a chair evaluation for the Department of #department#.
		<br>

		
	<!---disable 06/04/2014	<cfif FORM.dept EQ dom_dept_id>
		<br>Please <a href="chief.cfm?eva_seq_id=#eva_seq_id#&chair=#FORM.dept#&chief=#FORM.div_id#">continue</a> for Division Chief Evaluation.
		<cfelse>
		<a href="javascript:self.close()">Close the window</a>

		</cfif>--->
		<!---/cfif--->



 	 </td></tr>

  <tr align="center"><td>

 	 </td></tr>
</cfoutput>
 </table>

   <cfinclude template="../includes/page_footer_new.cfm">
