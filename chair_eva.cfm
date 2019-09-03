 
  
<noscript>
	<center><strong>Javascript is currently disabled on your browser. Please enable Javascript and try this page again.</strong></center>
	<cfset mySiteFromJavascriptCheck365 = "https://" & #CGI.HTTP_HOST# & #GetHttpRequestData().headers.SCRIPT_NAME#>
	<cfoutput><meta http-equiv="refresh" content="0;url=/JavascriptDoesNotExist.cfm?mySiteFrom=#mySiteFromJavascriptCheck365#" /></cfoutput>
</noscript>

<link href="styles/styles.css" rel="stylesheet" type="text/css">
   <cfset test=1> <!---  //for test, will delete once move to prod--->
   <cfsetting requesttimeout="3600" /> <!---3600/60=60min--->
  

 <!---cfset BodyOnloadVar='DisablingBackFunctionality()'--->
   <cfinclude template="../includes/page_header_new.cfm">
 <!---cfmodule template="fes/TimeOutWarning.cfm" WarningThreshold = "2" TimeOutMinutes = "30"--->

 <cfscript>
       chair=createObject("component","chair");
	 
		 chair.init(dbname,dblogin,dbpasswd);
		 
		 //closed 05/23/2011 reopen next year
		 //reopen 05/30/2022
		 //closed 07/29/2014
		 //closed 11/02/2015
		 //closed 11/01/2015
		 //opened 09/22/2017
		  //closed 10/24/2017
	   // chair.location('index.cfm');  //closed 10/08/2018


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

		  //person=chair.facultyData(faculty_id);
		  if(IsDefined('get_year'))
			cyear=#get_year#;
		else
			cyear=#chair.current_fiscal_yr#;
		lyear=cyear-1;

		 //chairs=chair.Chair_List(faculty_id,cyear);
		// race=chair.getRace();
		// locations=chair.getLOC();

		 work_site=chair.getWorksite_DES();
		 comment_des=chair.getComment_DES('N');
		 section_des=chair.getSection_DES('N');
		  question_des=chair.getQuestion_DES('N');
		 question_des1=chair.getQuestion_DES('N',section_des.section_des_id[1]);
		  question_des2=chair.getQuestion_DES('N',section_des.section_des_id[2]);
		   question_des3=chair.getQuestion_DES('N',section_des.section_des_id[3]);
		    question_des4=chair.getQuestion_DES('N',section_des.section_des_id[4]);
			 question_des5=chair.getQuestion_DES('N',section_des.section_des_id[5]);
			  question_des6=chair.getQuestion_DES('N',section_des.section_des_id[6]);
			   question_des7=chair.getQuestion_DES('N',section_des.section_des_id[7]);
			    question_des8=chair.getQuestion_DES('N',section_des.section_des_id[8]);
			   question_des9=chair.getQuestion_DES('N',section_des.section_des_id[9]);

		// dept_list=chair.getDepts();
	   dept_list=chair.getDepts(cyear);
		// rank_list=chair.getRank();
		    question_count=0;



 </cfscript>
 <script language="JavaScript" type="text/javascript" src="/med/prod/database/chair/includes/js/qforms.js"></script>
<script language="JavaScript" type="text/javascript" src="/med/prod/database/chair/includes/js/check.js"></script>
 
<script language="JavaScript" type="text/javascript">
	 qFormAPI.setLibraryPath("/med/prod/database/chair/includes/js/");
	 qFormAPI.include("*"); 
	 
 
function StartAtDefault()
{
	document.getElementById("dept_chair").selectedIndex = 0;
//	document.getElementById("div_id").selectedIndex = 0;


}

function isDefined(variable)
{
return (!(!( variable||false )))
}

 

</script> 

<cfdump var="#dept_list#"></cfdump>
<form name="chair_form"  method="post" action="eva_result.cfm"  >
<input name="faculty_id" id="faculty_id" type="hidden" value="<cfoutput>#faculty_id#</cfoutput>">
<input name="chair_id" id="chair_id" type="hidden" value="">
<input name="dept" id="dept" type="hidden" value="">
 <input type="hidden" name="q_1_list">
  <input type="hidden" name="q_2_list">
   <input type="hidden" name="q_3_list">
    <input type="hidden" name="q_4_list">
	 <input type="hidden" name="q_5_list">
	  <input type="hidden" name="q_6_list">
	   <input type="hidden" name="q_7_list">
	    <input type="hidden" name="q_8_list">
		<input type="hidden" name="q_9_list">
 <input type="hidden" name="dq_1_list">
  <input type="hidden" name="dq_2_list">
   <input type="hidden" name="dq_3_list">
    <input type="hidden" name="dq_4_list">
	 <input type="hidden" name="dq_5_list">
	  <input type="hidden" name="dq_6_list">
	   <input type="hidden" name="dq_7_list">
	    <input type="hidden" name="dq_8_list">
		<input type="hidden" name="dq_9_list">


<table style="padding:5px;   width:100%; margin-left:auto; margin-right:auto;">
 
 <tr><td><table  border-spacing:0px;  >

<tr><td><table><tr><td><table  bgcolor="#CCCCCC"; class="DEMO">
<tr><td colspan="2"></td></tr>
<tr span class="style5"><td width="25%" align="right"><strong>Department Chair: (required)</strong></td>
      <td width="75%"><select name="dept_chair" id="dept_chair" onChange="getDeptChair(this)">
	   <option value=""  selected>&nbsp;</option>
        
    <cfoutput query="dept_list">
	 <option value="#DEPT_ID_SEQ#-#EMPLID#" >#dept_list.DEPT_NM#: #NAME#</option>
	</cfoutput>
   </select></td>
    </tr>
<tr><td colspan="2">&nbsp;</td></tr>
 
  
	 
 
  
	 

		</table> </td></tr>
 <tr><td> 
     <cfoutput><table>
	 <tr>
      <td colspan="2">&nbsp;</td>
    </tr>
    

	<tr><td colspan="2" align="right">
	<table style="width:100%; padding:0px; border-spacing:0px;">
          <tr>
            <td width="40%" style="width:40%;"></td>
            <td width="60" colspan="6" style="width:60%;"></td>
          </tr>

		  <tr>
            <td colspan="7" style="width:40%;"><span class="style3"><strong>Note: *N/A indicates insufficient information on which to base an opinion</strong></span></td>
          </tr>

		    <tr>
            <td width="40%" class="line_upper" style="width:40%;"></td>
            <td class="line_upper"><strong>Strongly Disagree</strong></td>
            <td class="line_upper" ><strong>Disagree</strong></td>
            <td class="line_upper" ><strong>Neutral</strong></td>
            <td class="line_upper" ><strong>Agree</strong></td>
            <td class="line_upper"><strong>Strongly Agree</strong></td>
            <td class="line_upper"><strong>N/A</strong><span class="style1">*</span></td>
          </tr>
		  <tr>
            <td width="40%" class="line_upper" style="width:40%;"></td>
            <td   class="line_upper"><strong>1</strong></td>
            <td   class="line_upper"><strong>2</strong></td>
            <td   class="line_upper"><strong>3</strong></td>
            <td   class="line_upper"><strong>4</strong></td>
            <td   class="line_upper"><strong>5</strong></td>
            <td   class="line_upper">&nbsp;</td>
          </tr>

		  <tr>
            <td style="width:40%;"><p><strong>#section_des.section_des[1]#</strong></p>
			<input type="hidden" name="section_1" value="#section_des.section_des_id[1]#">
			</td>
            <td colspan="6" >&nbsp;</td>
          </tr>

		  <cfset i=0>
		 	<cfloop query="question_des1">
			 <cfset i=i+1>
			       <tr>
            <td class="line_bottom" style="width:40%;">
			<cfset question_count=question_count+1>
			#question_count#.&nbsp;#question_des1.question_des#
			<input type="hidden" name="sqd_1_#i#" value="#question_des1.question_des_id#">
			 </td>
            <td class="line_upper" ><input type="radio" name="sq_1_#i#" value="1"  /></td>
            <td class="line_upper" ><input type="radio" name="sq_1_#i#" value="2"   /></td>
            <td class="line_upper" ><input type="radio" name="sq_1_#i#" value="3"   /></td>
            <td class="line_upper" ><input type="radio" name="sq_1_#i#" value="4"   /></td>
            <td class="line_upper" ><input type="radio" name="sq_1_#i#" value="5"   /></td>
            <td class="line_upper" ><input type="radio" name="sq_1_#i#"  value="0" checked  /></td>
          </tr>
			</cfloop>
		        <tr>
            <td colspan="7" style="width:40%;"><br /></td>
          </tr>
		  <tr>
            <td width="40%" class="line_upper" style="width:40%;"></td>
            <td class="line_upper" ><strong>Strongly Disagree</strong></td>
            <td class="line_upper"><strong>Disagree</strong></td>
            <td class="line_upper" ><strong>Neutral</strong></td>
            <td class="line_upper"  ><strong>Agree</strong></td>
            <td class="line_upper"  ><strong>Strongly Agree</strong></td>
            <td class="line_upper"  ><strong>N/A</strong><span class="style1">*</span></td>
          </tr>

          <tr>
            <td   class="line_upper"></td>
            <td   class="line_upper"><strong>1</strong></td>
            <td   class="line_upper"><strong>2</strong></td>
            <td   class="line_upper"><strong>3</strong></td>
            <td   class="line_upper"><strong>4</strong></td>
            <td   class="line_upper"><strong>5</strong></td>
            <td   class="line_upper">&nbsp;</td>
          </tr>

		      <tr>
            <td style="width:40%;"><strong>#section_des.section_des[2]#</strong>
			<input type="hidden" name="section_2" value="#section_des.section_des_id[2]#">
            </td>
            <td colspan="6" >&nbsp;</td>
          </tr>
		  <cfset i=0>
		 	<cfloop query="question_des2">
			 <cfset i=i+1>
			       <tr>
            <td class="line_bottom" style="width:40%;"><cfset question_count=question_count+1>
			#question_count#.&nbsp;#question_des2.question_des#
			<input type="hidden" name="sqd_2_#i#" value="#question_des2.question_des_id#">
			</td>
            <td class="line_upper" ><input type="radio" name="sq_2_#i#" value="1"  /></td>
            <td class="line_upper" ><input type="radio" name="sq_2_#i#" value="2"   /></td>
            <td class="line_upper" ><input type="radio" name="sq_2_#i#" value="3"   /></td>
            <td class="line_upper" ><input type="radio" name="sq_2_#i#" value="4"   /></td>
            <td class="line_upper" ><input type="radio" name="sq_2_#i#" value="5"   /></td>
            <td class="line_upper" ><input type="radio" name="sq_2_#i#"  value="0" checked  /></td>
          </tr>
			</cfloop>
		    <tr>
            <td colspan="7" style="width:40%;"><br /></td>
          </tr>
		   <tr>
            <td width="40%" class="line_upper" style="width:40%;"></td>
            <td class="line_upper" ><strong>Strongly Disagree</strong></td>
            <td class="line_upper" ><strong>Disagree</strong></td>
            <td class="line_upper" ><strong>Neutral</strong></td>
            <td class="line_upper" ><strong>Agree</strong></td>
            <td class="line_upper" ><strong>Strongly Agree</strong></td>
            <td class="line_upper" ><strong>N/A</strong><span class="style1">*</span></td>
          </tr>

		     <tr>
            <td style="width:40%;" class="line_upper"></td>
            <td  class="line_upper"><strong>1</strong></td>
            <td  class="line_upper"><strong>2</strong></td>
            <td  class="line_upper"><strong>3</strong></td>
            <td  class="line_upper"><strong>4</strong></td>
            <td  class="line_upper"><strong>5</strong></td>
            <td  class="line_upper">&nbsp;</td>
          </tr>

		   <tr>
            <td height="29" style="width:40%;"><strong>#section_des.section_des[3]#</strong>
			<input type="hidden" name="section_3" value="#section_des.section_des_id[3]#"></td>
            <td colspan="6" >&nbsp;</td>
          </tr>
		   <cfset i=0>
		 	<cfloop query="question_des3">
			 <cfset i=i+1>
			       <tr>
            <td class="line_bottom" style="width:40%;"><cfset question_count=question_count+1>
			#question_count#.&nbsp;#question_des3.question_des#
			<input type="hidden" name="sqd_3_#i#" value="#question_des3.question_des_id#">
			</td>
            <td class="line_upper" ><input type="radio" name="sq_3_#i#" value="1"  /></td>
            <td class="line_upper" ><input type="radio" name="sq_3_#i#" value="2"   /></td>
            <td class="line_upper" ><input type="radio" name="sq_3_#i#" value="3"   /></td>
            <td class="line_upper" ><input type="radio" name="sq_3_#i#" value="4"   /></td>
            <td class="line_upper" ><input type="radio" name="sq_3_#i#" value="5"   /></td>
            <td class="line_upper" ><input type="radio" name="sq_3_#i#"  value="0" checked  /></td>
          </tr>
			</cfloop>
		   <tr>
            <td colspan="7" style="width:40%;"><br /></td>
          </tr>          <tr>
            <td width="40%" class="line_upper" style="width:40%;"></td>
            <td class="line_upper" ><strong>Strongly Disagree</strong></td>
            <td class="line_upper" ><strong>Disagree</strong></td>
            <td class="line_upper" ><strong>Neutral</strong></td>
            <td class="line_upper" ><strong>Agree</strong></td>
            <td class="line_upper" ><strong>Strongly Agree</strong></td>
            <td class="line_upper" ><strong>N/A</strong><span class="style1">*</span></td>
          </tr>
		   <tr>
            <td style="width:40%;" class="line_upper"></td>
            <td  class="line_upper"><strong>1</strong></td>
            <td  class="line_upper"><strong>2</strong></td>
            <td  class="line_upper"><strong>3</strong></td>
            <td  class="line_upper"><strong>4</strong></td>
            <td  class="line_upper"><strong>5</strong></td>
            <td  class="line_upper">&nbsp;</td>
          </tr>
          <tr>
            <td style="width:40%;"><strong>#section_des.section_des[4]#</strong>
			<input type="hidden" name="section_4" value="#section_des.section_des_id[4]#">
			</td>
            <td colspan="6" >&nbsp;</td>
          </tr>
		  <cfset i=0>
		 	<cfloop query="question_des4">
			 <cfset i=i+1>
			       <tr>
            <td class="line_bottom" style="width:40%;"><cfset question_count=question_count+1>
			#question_count#.&nbsp;#question_des4.question_des#
			<input type="hidden" name="sqd_4_#i#" value="#question_des4.question_des_id#">
			</td>
            <td class="line_upper" ><input type="radio" name="sq_4_#i#" value="1"  /></td>
            <td class="line_upper" ><input type="radio" name="sq_4_#i#" value="2"   /></td>
            <td class="line_upper" ><input type="radio" name="sq_4_#i#" value="3"   /></td>
            <td class="line_upper" ><input type="radio" name="sq_4_#i#" value="4"   /></td>
            <td class="line_upper" ><input type="radio" name="sq_4_#i#" value="5"   /></td>
            <td class="line_upper" ><input type="radio" name="sq_4_#i#"  value="0" checked  /></td>
          </tr>
			</cfloop>
          <tr>
            <td colspan="7" style="width:40%;"><br /></td>
          </tr>          <tr>
            <td width="40%" class="line_upper" style="width:40%;"></td>
            <td class="line_upper" ><strong>Strongly Disagree</strong></td>
            <td class="line_upper" ><strong>Disagree</strong></td>
            <td class="line_upper" ><strong>Neutral</strong></td>
            <td class="line_upper" ><strong>Agree</strong></td>
            <td class="line_upper" ><strong>Strongly Agree</strong></td>
            <td class="line_upper" ><strong>N/A</strong><span class="style1">*</span></td>
          </tr>
          <tr>
            <td style="width:40%;" class="line_upper"></td>
            <td  class="line_upper"><strong>1</strong></td>
            <td  class="line_upper"><strong>2</strong></td>
            <td  class="line_upper"><strong>3</strong></td>
            <td  class="line_upper"><strong>4</strong></td>
            <td  class="line_upper"><strong>5</strong></td>
            <td  class="line_upper">&nbsp;</td>
          </tr>
          <tr>
            <td style="width:40%;"><strong>#section_des.section_des[5]#</strong>
			<input type="hidden" name="section_5" value="#section_des.section_des_id[5]#">
			</td>
            <td colspan="6" >&nbsp;</td>
          </tr>
           <cfset i=0>
		 	<cfloop query="question_des5">
			 <cfset i=i+1>
			       <tr>
            <td class="line_bottom" style="width:40%;"><cfset question_count=question_count+1>
			#question_count#.&nbsp;#question_des5.question_des#
			<input type="hidden" name="sqd_5_#i#" value="#question_des5.question_des_id#">
			</td>
            <td class="line_upper" ><input type="radio" name="sq_5_#i#" value="1"  /></td>
            <td class="line_upper" ><input type="radio" name="sq_5_#i#" value="2"   /></td>
            <td class="line_upper" ><input type="radio" name="sq_5_#i#" value="3"   /></td>
            <td class="line_upper" ><input type="radio" name="sq_5_#i#" value="4"   /></td>
            <td class="line_upper" ><input type="radio" name="sq_5_#i#" value="5"   /></td>
            <td class="line_upper" ><input type="radio" name="sq_5_#i#"  value="0" checked  /></td>
          </tr>
			</cfloop>
          <tr>
            <td colspan="7" style="width:40%;"><br /></td>
          </tr>          <tr>
            <td width="40%" class="line_upper" style="width:40%;"></td>
            <td class="line_upper" ><strong>Strongly Disagree</strong></td>
            <td class="line_upper" ><strong>Disagree</strong></td>
            <td class="line_upper" ><strong>Neutral</strong></td>
            <td class="line_upper" ><strong>Agree</strong></td>
            <td class="line_upper" ><strong>Strongly Agree</strong></td>
            <td class="line_upper" ><strong>N/A</strong><span class="style1"><span class="style1">*</span></span></td>
          </tr>
          <tr>
            <td style="width:40%;" class="line_upper"></td>
            <td  class="line_upper"><strong>1</strong></td>
            <td  class="line_upper"><strong>2</strong></td>
            <td  class="line_upper"><strong>3</strong></td>
            <td  class="line_upper"><strong>4</strong></td>
            <td  class="line_upper"><strong>5</strong></td>
            <td  class="line_upper">&nbsp;</td>
          </tr>

          <tr>
            <td style="width:40%;"><p><strong>#section_des.section_des[6]#</strong></p>
			<input type="hidden" name="section_6" value="#section_des.section_des_id[6]#">
			</td>
            <td colspan="6" >&nbsp;</td>
          </tr>
         <cfset i=0>
		 	<cfloop query="question_des6">
			 <cfset i=i+1>
			       <tr>
            <td class="line_bottom" style="width:40%;"><cfset question_count=question_count+1>
			#question_count#.&nbsp;#question_des6.question_des#
			<input type="hidden" name="sqd_6_#i#" value="#question_des6.question_des_id#">
			</td>
            <td class="line_upper" ><input type="radio" name="sq_6_#i#" value="1"  /></td>
            <td class="line_upper" ><input type="radio" name="sq_6_#i#" value="2"   /></td>
            <td class="line_upper" ><input type="radio" name="sq_6_#i#" value="3"   /></td>
            <td class="line_upper" ><input type="radio" name="sq_6_#i#" value="4"   /></td>
            <td class="line_upper" ><input type="radio" name="sq_6_#i#" value="5"   /></td>
            <td class="line_upper" ><input type="radio" name="sq_6_#i#"  value="0" checked  /></td>
          </tr>
			</cfloop>
          <tr>
            <td colspan="7" style="width:40%;"><br /></td>
          </tr>          <tr>
            <td width="40%" class="line_upper" style="width:40%;"></td>
            <td class="line_upper" ><strong>Strongly Disagree</strong></td>
            <td class="line_upper" ><strong>Disagree</strong></td>
            <td class="line_upper" ><strong>Neutral</strong></td>
            <td class="line_upper" ><strong>Agree</strong></td>
            <td class="line_upper" ><strong>Strongly Agree</strong></td>
            <td class="line_upper" ><strong>N/A</strong><span class="style1"><span class="style1">*</span></span></td>
          </tr>
          <tr>
            <td style="width:40%;" class="line_upper"></td>
            <td  class="line_upper"><strong>1</strong></td>
            <td  class="line_upper"><strong>2</strong></td>
            <td  class="line_upper"><strong>3</strong></td>
            <td  class="line_upper"><strong>4</strong></td>
            <td  class="line_upper"><strong>5</strong></td>
            <td  class="line_upper">&nbsp;</td>
          </tr>
          <tr>
            <td style="width:40%;"><p><strong>#section_des.section_des[7]#</strong></p>
			<input type="hidden" name="section_7" value="#section_des.section_des_id[7]#">
			</td>
            <td colspan="6" >&nbsp;</td>
          </tr>
 			 <cfset i=0>
		 	<cfloop query="question_des7">
			 <cfset i=i+1>
			       <tr>
            <td class="line_bottom" style="width:40%;"><cfset question_count=question_count+1>
			#question_count#.&nbsp;#question_des7.question_des#
			<input type="hidden" name="sqd_7_#i#" value="#question_des7.question_des_id#">
			 </td>
            <td class="line_upper" ><input type="radio" name="sq_7_#i#" value="1"  /></td>
            <td class="line_upper" ><input type="radio" name="sq_7_#i#" value="2"   /></td>
            <td class="line_upper" ><input type="radio" name="sq_7_#i#" value="3"   /></td>
            <td class="line_upper" ><input type="radio" name="sq_7_#i#" value="4"   /></td>
            <td class="line_upper" ><input type="radio" name="sq_7_#i#" value="5"   /></td>
            <td class="line_upper" ><input type="radio" name="sq_7_#i#"  value="0" checked  /></td>
          </tr>
			</cfloop>


          <tr>
            <td colspan="7" style="width:40%;"><br /></td>
          </tr>
          <tr>
            <td width="40%" class="line_upper" style="width:40%;"></td>
            <td class="line_upper" ><strong>Poor</strong></td>
            <td class="line_upper" ><strong>Fair</strong></td>
            <td class="line_upper" ><strong>Good</strong></td>
            <td class="line_upper" ><strong>Very Good</strong></td>
            <td class="line_upper" ><strong>Excellent</strong></td>
            <td class="line_upper" >&nbsp;</td>
          </tr>
		  <tr>
            <td style="width:40%;" class="line_upper"></td>
            <td  class="line_upper"><strong>1</strong></td>
            <td  class="line_upper"><strong>2</strong></td>
            <td  class="line_upper"><strong>3</strong></td>
            <td  class="line_upper"><strong>4</strong></td>
            <td  class="line_upper"><strong>5</strong></td>
            <td  class="line_upper">&nbsp;</td>
          </tr>
          <tr>
            <td style="width:40%;" ><strong>#section_des.section_des[8]#</strong>
			<input type="hidden" name="section_8" value="#section_des.section_des_id[8]#">
			</td>
            <td colspan="6" class="line_upper" >&nbsp;</td>
          </tr>
		  <cfset i=0>
		 	<cfloop query="question_des8">
			 <cfset i=i+1>
			       <tr>
            <td class="line_bottom" style="width:40%;"><cfset question_count=question_count+1>
			#question_count#.&nbsp;#question_des8.question_des#
			<input type="hidden" name="sqd_8_#i#" value="#question_des8.question_des_id#">
			</td>
            <td class="line_upper" ><input type="radio" name="sq_8_#i#" value="1"  /></td>
            <td class="line_upper" ><input type="radio" name="sq_8_#i#" value="2"   /></td>
            <td class="line_upper" ><input type="radio" name="sq_8_#i#" value="3"   /></td>
            <td class="line_upper" ><input type="radio" name="sq_8_#i#" value="4"   /></td>
            <td class="line_upper" ><input type="radio" name="sq_8_#i#" value="5"  checked  /></td>

          </tr>
			</cfloop>
		  <!---
		   <cfoutput query="comment_des">
		  <tr>
            <td colspan="7" style="width:40%;">#comment_des.COMMENT_DES#</td>
          </tr>
		   <tr>
            <td colspan="7" style="width:40%; text-align:center;"><textarea name="#comment_des.COMMENT_DES_ID#" cols="70" rows="15"></textarea></td>
          </tr>
		  </cfoutput>
		  --->

          <tr>
            <td colspan="7" style="width:40%;"><br /></td>
          </tr>
          <tr>
            <td colspan="7" style="width:40%;"><strong>#section_des.section_des[9]#</strong>
			<input type="hidden" name="section_9" value="#section_des.section_des_id[9]#">
			</td>
          </tr>
          <tr>
            <td colspan="7" style="width:40%;"></td>
          </tr>
		  <cfset i=0>
		 	<cfloop query="comment_des">
			 <cfset i=i+1>
			<tr> <td colspan="7" style="width:40%;">#comment_des.COMMENT_DES#
			<input type="hidden" name="cd_9_#i#" value="#comment_des.comment_des_id#">
			</td> </tr>
            <tr> <td colspan="7" style="width:40%; text-align:center;"><textarea name="comments_#i#" cols="70" rows="15"></textarea></td></tr>
			</cfloop>
			<tr><td colspan="7" style="width:40%;">
			To provide comments and suggestions regarding this form, click <a href="mailto:SOM-WEB@LISTSERV.CC.EMORY.EDU">here</a>			</td>
			</tr>

          <!---tr> <td colspan="7" style="width:40%;">Please provide comments and suggestions regarding this form:

			</td> </tr>
             <tr> <td colspan="7" style="width:40%; text-align:center;"><textarea name="feedback" cols="70" rows="5"></textarea></td></tr--->
          <!---tr>
            <td colspan="7" style="width:40%;"><span class="style1"><span class="style1">*</span><strong>N/A indicates insufficient information on which to base an opinion</strong></span></td>
          </tr--->
          <!---tr>
            <td colspan="7" style="width:40%; text-align:center;">
            <input name="submit" class="btstyle" type="submit" value="Submit" onClick="return pack()"  />
			<!---input name="submit" class="btstyle" type="button" value="Submit" onClick="return pack()"  /--->
           
          </tr--->

<tr><td colspan="7" style="width:40%;">&nbsp;</td></tr>
	</table>
 </td></tr>

	</table></cfoutput>
</td></tr>
 <tr><td><table  border-spacing:0px;  >

<tr><td><table><tr><td><table  bgcolor="#CCCCCC"; class="DEMO">
<tr><td colspan="2"></td></tr>
<!---tr span class="style5"><td width="25%" align="right"><strong>Department Chair: (required)</strong></td>
      <td width="75%"><select name="dept_chair" id="dept_chair" onChange="getDeptChair(this)">
	   <option value=""  selected>&nbsp;</option>
        
    <cfoutput query="dept_list">
	 <option value="#DEPT_ID_SEQ#-#EMPLID#" >#dept_list.DEPT_NM#: #NAME#</option>
	</cfoutput>
   </select></td>
    </tr>
<tr><td colspan="2">&nbsp;</td></tr>
<tr><td colspan="2"><span class="style3">Demographic Data: (optional)</span></td>
 </tr--->
  
	<tr span class="style5"><td width="25%" align="right"><strong>Division Name:</strong></td>
      <td width="75%"><input type="hidden" name="div_id" id="div_id"  value="0"><input name="div_nm" id="div_nm" type="text" size="60" value="" />
	 
	  </td>
    </tr>
 
 
<tr span class="style5">
      <td width="25%" align="right"><strong>Gender:</strong></td>
      <td width="75%"><label>
        <input type="radio" name="gender" value="M" id="male" />
        Male</label>
        <label>
        <input type="radio" name="gender" value="F" id="female" />
        Female</label></td>
    </tr>
	<tr span class="style5">
      <td width="25%" align="right"><strong>Rank:</strong></td>
      <td width="75%"><!---input name="rank" type="text" size="20" /--->
	   <select name="rank">
	 <option value="">&nbsp;</option>
	 <option value="Professor">Professor</option>
	 <option value="Associate Professor">Associate Professor</option>
	  <option value="Assistant Professor">Assistant Professor</option>
	    <option value="Instructor">Instructor</option>
	    <option value="Senior Associate">Senior Associate</option>
	  
	  
   </select>
	  </td>
    </tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr  span class="style5">
      <td colspan="2"> <strong>Please rank the following activities based on your percentage of effort from the highest(1) to lowest (4):</strong> <br>
        <table style="padding:5px; border-spacing:5px; width:50%;  "  span class="style5">
          <tr align="center">
            <td style="width:30%"><div align="right"><strong>Clinical Responsibilities:</strong></div></td>
            <td style="width:5%"><label>
              <input type="radio" name="activity_clinical" value="1" id="1" />
              1</label>
            </td>
            <td style="width:5%"><label>
              <input type="radio" name="activity_clinical" value="2" id="2" />
              2</label></td>
            <td style="width:5%"><label>
              <input type="radio" name="activity_clinical" value="3" id="3" />
              3</label></td>
            <td style="width:5%"><label>
              <input type="radio" name="activity_clinical" value="4" id="4" />
              4</label></td>
          </tr>
          <tr align="center">
            <td style="width:30%"><div align="right"><strong>Teaching:</strong></div></td>
            <td style="width:5%"><label>
              <input type="radio" name="activity_teaching" value="1" id="1" />
              1</label>
            </td>
            <td style="width:5%"><label>
              <input type="radio" name="activity_teaching" value="2" id="2" />
              2</label></td>
            <td style="width:5%"><label>
              <input type="radio" name="activity_teaching" value="3" id="3" />
              3</label></td>
            <td style="width:5%"><label>
              <input type="radio" name="activity_teaching" value="4" id="4" />
              4</label></td>
          </tr>
           <tr align="center">
            <td style="width:30%"><div align="right"><strong>Research:</strong></div></td>
            <td style="width:5%"><label>
              <input type="radio" name="activity_research" value="1" id="1" />
              1</label>
            </td>
            <td style="width:5%"><label>
              <input type="radio" name="activity_research" value="2" id="2" />
              2</label></td>
            <td style="width:5%"><label>
              <input type="radio" name="activity_research" value="3" id="3" />
              3</label></td>
            <td style="width:5%"><label>
              <input type="radio" name="activity_research" value="4" id="4" />
              4</label></td>
          </tr>
          <tr align="center">
            <td style="width:30%"><div align="right"><strong>Administration:</strong></div></td>
            <td style="width:5%"><label>
              <input type="radio" name="activity_admin" value="1" id="1" />
              1</label>
            </td>
            <td style="width:5%"><label>
              <input type="radio" name="activity_admin" value="2" id="2" />
              2</label></td>
            <td style="width:5%"><label>
              <input type="radio" name="activity_admin" value="3" id="3" />
              3</label></td>
            <td style="width:5%"><label>
              <input type="radio" name="activity_admin" value="4" id="4" />
              4</label></td>
          </tr>
        </table></td></tr>
		<tr valign="top" span class="style5">
      <td width="25%" align="right"><strong>Please indicate your primary work site:</strong></td>
      <td><cfoutput><table width="100%" span class="style5">
          <tr nowrap valign="top">
            <td width="30%"><label>
              <input type="radio" name="work_site" value="#work_site.worksite_des_id[1]#" id="work_site" />
              #work_site.worksite_des[1]#</label></td>
            <td width="25%"><label>
              <input type="radio" name="work_site" value="#work_site.worksite_des_id[2]#" id="work_site" />
              #work_site.worksite_des[2]#</label></td>
            <td width="20%"><label>
              <input type="radio" name="work_site" value="#work_site.worksite_des_id[3]#" id="work_site" />
               #work_site.worksite_des[3]#</label></td>
            <td width="25%"><label>
              <input type="radio" name="work_site" value="#work_site.worksite_des_id[4]#" id="work_site" />
               #work_site.worksite_des[4]#</label></td>
          </tr>
          <tr valign="top">
            <td width="30%"><label>
              <input type="radio" name="work_site" value="#work_site.worksite_des_id[5]#" id="work_site" />
               #work_site.worksite_des[5]#</label></td>
            <td width="25%"><label>
              <input type="radio" name="work_site" value="#work_site.worksite_des_id[6]#" id="work_site" />
               #work_site.worksite_des[6]#</label></td>
            <td width="20%" colspan="2"><label>
              <input type="radio" name="work_site" value="#work_site.worksite_des_id[7]#" id="work_site" />
               #work_site.worksite_des[7]#</label>
			   <input  name="work_site_other" id="work_site" >
			   
           </td>

          </tr>
        </table>
      </cfoutput></td>
    </tr>
	<tr  span class="style5">
      <td width="25%" align="right"><strong>Faculty Appointment:</strong></td>
      <td><cfoutput><table width="100%" span class="style5">
          <tr nowrap valign="top">
            <td width="30%"><label>
              <input type="radio" name="appt" value="F" id="appt" />
              Full Time</label></td>
            <td width="25%"><label>
              <input type="radio" name="appt" value="P" id="appt" />
              Part Time</label></td>
			  <td colspan="2"></td>


          </tr>

        </table>
      </cfoutput></td>
    </tr>
	<tr><td colspan="2">&nbsp;</td></tr></table></td><td width="15%">&nbsp;</td></tr></table></td></tr>

	<!---requested by Dr. Weiss 01/08/2009--->
	<!---tr>
      <td width="25%" align="right"><strong>Please Select Your Chair:</strong></td>
      <td><select name="chair_id"  onChange="checkChair(this)">
	      <option value=""  >&nbsp;</option>
	       <cfoutput query="chairs">
	         <option value="#chairs.med_id_seq#" >#chairs.person_name#</option>
           </cfoutput>
	      </select> </td>
    </tr--->

		</table> </td></tr>

		<tr>
            <td colspan="7" style="width:40%; text-align:center;">
            <input name="submit" class="btstyle" type="submit" value="Submit" onClick="return pack()"  />
			<!---input name="submit" class="btstyle" type="button" value="Submit" onClick="return pack()"  /--->
            </td>
          </tr>
</table>
</form>
 <script language="JavaScript" type="text/javascript">
 //alert(document.getElementById("div_id").value);
  	objForm = new qForm("chair_form"); 
	 
	//objForm.required("chair_id,dept,rank,activity_clinical,activity_teaching,activity_research,activity_admin,work_site,appt" ); 
	//objForm.required(" dept,rank,gender,activity_clinical,activity_teaching,activity_research,activity_admin,work_site,appt" ); 
	  objForm.required("dept_chair");
 	//objForm.chair_id.description="Chair"; 
	objForm.dept_chair.description="Department Chair"; 
	//objForm.div_id.description="Division";  
	//objForm.rank.description="Rank"; 
	//objForm.rank.gender="Gender"; 
	//objForm.activity_clinical.description="Effort for Clinical Responsibilities";  
	//objForm.activity_teaching.description="Effort for Clinical Responsibilities";  
	//objForm.activity_research.description="Effort for Clinical Responsibilities";  
	//objForm.activity_admin.description="Effort for Clinical Responsibilities";  
	//objForm.work_site.description="Primary Work Site";   
	// objForm.appt.description="Faculty Appointment";  
	
	//08/08/2018
  function getDeptChair( comb ){ 
  	var res=comb.value; 
	  res = res.split("-");
	   document.chair_form.dept.value =res[0];
	  document.chair_form.chair_id.value =res[1];
	 // alert(document.chair_form.dept.value);
	 // alert(chair_form.chair_id.value);
	  
  }  
	 
  </script>

   <cfinclude template="../includes/page_footer_new.cfm">
