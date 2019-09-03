<noscript>
	<center><strong>Javascript is currently disabled on your browser. Please enable Javascript and try this page again.</strong></center>
	<cfset mySiteFromJavascriptCheck365 = "http://" & #CGI.HTTP_HOST# & #GetHttpRequestData().headers.SCRIPT_NAME#>
	<cfoutput><meta http-equiv="refresh" content="0;url=/JavascriptDoesNotExist.cfm?mySiteFrom=#mySiteFromJavascriptCheck365#" /></cfoutput>
</noscript>  
<link href="styles/styles.css" rel="stylesheet" type="text/css">
   <cfset test=1> <!---  //for test, will delete once move to prod--->    
   <cfsetting requesttimeout="3600" /> <!---3600/60=60min---> 
   <cfset BodyOnloadVar = "StartAtDefault();">
  
 <!---cfset BodyOnloadVar='DisablingBackFunctionality()'--->
   <cfinclude template="../includes/page_header_new.cfm">  
 <!---cfmodule template="fes/TimeOutWarning.cfm" WarningThreshold = "2" TimeOutMinutes = "30"--->
 
 <cfscript>
       chair=createObject("component","chair");
		 chair.init(dbname,dblogin,dbpasswd);
		 
		  
		 if (IsDefined('session.authenticated_user_id') ) 
			checkID=#session.authenticated_user_id#;
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
		
		// chairs=chair.Chair_List(faculty_id,cyear);
		 race=chair.getRace();
		 locations=chair.getLOC();
		 
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
		 
		 dept_list=chair.getDepts(cyear);
		
		 loc=0;
		 
 </cfscript>
 <script language="JavaScript" type="text/javascript" src="/med/prod/database/chair/includes/js/qforms.js"></script>
<script language="JavaScript" type="text/javascript" src="/med/prod/database/chair/includes/js/check.js"></script>
<script language="JavaScript" type="text/javascript" src="../../includes/Spry/xpath.js"></script>
<script language="JavaScript" type="text/javascript" src="../../includes/Spry/SpryData.js"></script> 
<script language="JavaScript" type="text/javascript">
	 qFormAPI.setLibraryPath("/med/prod/database/chair/includes/js/");
	 qFormAPI.include("*"); 
	 
	 var dsDivs = new Spry.Data.XMLDataSet("Divs_xml.cfm?dept_id_seq=-1", "dataset/row", {useCache:false}); 
 
function UpdateEs()
{
	var DeptSelected = eval("document.chair_form.dept.value"); 
	var s="Divs_xml.cfm?dept_id_seq=" + DeptSelected; 
	if (document.getElementById("dept").selectedIndex==0)
		document.getElementById("div_id").selectedIndex = 0; 
	else{
		dsDivs.setURL("Divs_xml.cfm?dept_id_seq=" + DeptSelected);
		dsDivs.loadData(); 
	}
}

function StartAtDefault()
{
	document.getElementById("dept").selectedIndex = 0;
	document.getElementById("div_id").selectedIndex = 0;  
	 
	
}
 
function isDefined(variable)
{
return (!(!( variable||false )))
}

 

</script>
 
<cfoutput><table style="padding:5px; border-spacing:5px; width:100%; margin-left:auto; margin-right:auto;">
       
        <tr>
          <td  ><A name=se1></A><p><strong>#section_des.section_des[1]#</strong></p>
     
          </td> 
        </tr>
        <cfset i=0>
        <cfloop query="question_des1">
          <cfset i=i+1>
          <cfset loc=loc+1>
          <tr>
            <td class="line_bottom" >#loc#.  #question_des1.question_des#
                 
            </td>
          </tr>
        </cfloop>
       
        <tr>
          <td  class="line_upper" ></td>
        </tr>
        <tr>
          <td   class="line_upper"></td>
        </tr>
        <tr>
          <td ><A name=se2></A><strong>#section_des.section_des[2]#</strong>
               
          </td>
        </tr>
        <cfset i=0>
        <cfloop query="question_des2">
          <cfset i=i+1>
          <cfset loc=loc+1>
          <tr>
            <td class="line_bottom" >#loc#.  #question_des2.question_des#
                
            </td>
          </tr>
        </cfloop>
       
        <tr> </tr>
        <tr>
          <td  class="line_upper"></td>
        </tr>
        <tr>
          <td ><A name=se3></A><strong>#section_des.section_des[3]#</strong>
               
        </tr>
        <cfset i=0>
        <cfloop query="question_des3">
          <cfset i=i+1>
          <cfset loc=loc+1>
          <tr>
            <td class="line_bottom" >#loc#.  #question_des3.question_des#
                
            </td>
          </tr>
        </cfloop>
       
        <tr>
          <td  class="line_upper" ></td>
        </tr>
        <tr>
          <td  class="line_upper"></td>
        </tr>
        <tr>
          <td ><A name=se4></A><strong>#section_des.section_des[4]#</strong>
               
          </td>
        </tr>
        <cfset i=0>
        <cfloop query="question_des4">
        <cfset loc=loc+1>
          <cfset i=i+1>
          <tr>
            <td class="line_bottom" >#loc#.  #question_des4.question_des#
                
            </td>
          </tr>
        </cfloop>
       
        <tr>
          <td  class="line_upper" ></td>
        </tr>
        <tr>
          <td  class="line_upper"></td>
        </tr>
        <tr>
          <td ><A name=se5></A><strong>#section_des.section_des[5]#</strong>
              
          </td>
        </tr>
        <cfset i=0>
        <cfloop query="question_des5">
        <cfset loc=loc+1>
          <cfset i=i+1>
          <tr>
            <td class="line_bottom" >#loc#.  #question_des5.question_des#
                
            </td>
          </tr>
        </cfloop>
       
        <tr>
          <td  class="line_upper" ></td>
        </tr>
        <tr>
          <td  class="line_upper"></td>
        </tr>
        <tr>
          <td ><A name=se6></A><strong>#section_des.section_des[6]#</strong>
               
          </td>
        </tr>
        <cfset i=0>
        <cfloop query="question_des6">
        <cfset loc=loc+1>
          <cfset i=i+1>
          <tr>
            <td class="line_bottom" >#loc#.  #question_des6.question_des#
                 
            </td>
          </tr>
        </cfloop>
       
        <tr>
          <td  class="line_upper" ></td>
        </tr>
        <tr>
          <td  class="line_upper"></td>
        </tr>
        <tr>
          <td ><A name=se7></A><strong>#section_des.section_des[7]#</strong>
              
          </td>
        </tr>
        <cfset i=0>
        <cfloop query="question_des7">
          <cfset i=i+1>
          <cfset loc=loc+1>
          <tr>
            <td class="line_bottom" >#loc#.  #question_des7.question_des#
                
            </td>
          </tr>
        </cfloop>
       
        <tr>
          <td  class="line_upper" ></td>
        </tr>
        <tr>
          <td  class="line_upper"> </td>
        </tr>
        <tr>
          <td  ><A name=se8></A><strong>#section_des.section_des[8]#</strong>
              
          </td>
        </tr>
        <cfset i=0>
        <cfloop query="question_des8">
          <cfset i=i+1>
          <cfset loc=loc+1>
          <tr>
            <td class="line_bottom" >#loc#.  #question_des8.question_des#
                
            </td>
          </tr>
        </cfloop>
        <tr>
          <td colspan="7" ></td>
        </tr>
        <cfset i=0>
        <cfloop query="comment_des">
          <cfset i=i+1>
          
        </cfloop>
      </table>
     </cfoutput>
  
 
   <cfinclude template="../includes/page_footer_new.cfm">   
