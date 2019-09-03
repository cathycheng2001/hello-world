
<cfinclude template="../includes/page_header_new.cfm"> 
 <link href="css1.css" rel="stylesheet" type="text/css">
 
<cfscript>
	     chair=createObject("component","chair");
		 chair.init(dbname,dblogin,dbpasswd);
	 
	
	
	// Todo - check the authorization privileges for this page
if ( IsDefined('session.authenticated_user_emplid') ){
	//Per Greco, Add hard code for Greg Jones (GJONES – EMPLID: 0010182) and Melanie Lingerfelt (MLINGE2 - EMPLID: 0380391) 10/01/2015  
		 
			emplid=#session.authenticated_user_emplid#;
	}
	else{ 
		emplid=-1;
	}
	
	supreppermission="no";
chairpermission="no";
divisionpermission="no";
user_role=chair.getUserRole_new(emplid);

 
	  
	  //08/23/07 Track previous data
	  
	if(IsDefined('get_year'))
		cyear=#get_year#;
	else 
		cyear=#chair.current_fiscal_yr#;
		 
		//Super User 104
	//view whole SOM
	if(user_role.rl_id_seq EQ '104' or user_role.rl_id_seq EQ '103')
		supreppermission="yes";
		//Department Chair 102
//	else if(user_role.rl_id_seq EQ '102')
//		chairpermission="yes";
		// for Medicine department
	//else if(user_role.rl_id_seq EQ '102' and user_role.DEPT_ID_SEQ  EQ dom_dept_id)
	//	divisionpermission="yes";
	//Per Greco, Add hard code for Greg Jones (GJONES – EMPLID: 0010182) and Melanie Lingerfelt (MLINGE2 - EMPLID: 0380391) 10/01/2015  
 //Per Deepthi, Add   Nancy Runner-NRUNNER and Angela Daniels-ADANIE5 10/09/2017 	
	else if( session.netegrity_user_id EQ 'GJONES' or session.netegrity_user_id EQ 'MLINGE2' or session.netegrity_user_id EQ 'NRUNNER' 
	or session.netegrity_user_id EQ 'ADANIE5' or session.netegrity_user_id EQ 'N577549' )
	 		supreppermission="yes";
	else
		 chair.location("index.cfm");
		 
	 
		
		 if (chairpermission  EQ "yes"){
		 			dept_avg_rage=chair.DEPT_RATE(cyear,user_role.DEPT_ID_SEQ);
					 
					}
		 else 
		 		 		dept_avg_rage=chair.DEPT_RATE(cyear);
       
</cfscript>
 
	 
	 
 
<!---cfdump var="#multi_COM#"--->
 
 <!---cfdump var="#multi_rate#"--->
  <!---cfdump var="#avg_rate#"--->
    <!---cfdump var="#div_COM#"--->
	 
 
 
<script language="javascript"> 
function toggle(index) {
   if(index==1){
	var ele = document.getElementById("toggleText");
	var text = document.getElementById("displayText");
	}
	if(index==2){
	var ele = document.getElementById("toggleText2");
	var text = document.getElementById("displayText2");
	}
	if(index==3){
	var ele = document.getElementById("toggleText3");
	var text = document.getElementById("displayText3");
	}
		if(index==5){
	var ele = document.getElementById("toggleText5");
	var text = document.getElementById("displayText5");
	}
	if(ele.style.display == "block") {
    		ele.style.display = "none";
		text.innerHTML = "Show";
  	}
	else {
		ele.style.display = "block";
		text.innerHTML = "Hide";
	}
} 
</script>

 
<table border="0">
	<tr><td height="500" > 
<div align="center"> <div align="center"><font size=4 class="header"><strong> Department Chair Evaluation Average Rate &nbsp;<cfoutput>#cyear# </cfoutput></strong></font> 
  <br>
  <br>
  <br>
</div>
<div align="center">
    <table align="center" border="1" cellpadding="5" cellspacing="0" width="90%"  >
      <!---tr valign="top" bgcolor="#999999" align="center">
           <TH   ROWSPAN=1 width="50">Division Name</TH> 
           <TH   COLSPAN=3 >&nbsp;</TH>  
	       <TH   COLSPAN=4  >&nbsp;</TH> 
	        <TH   COLSPAN=3  >&nbsp;</TH> 
	        <TH   COLSPAN=3  >&nbsp;</TH> 
	         <TH   COLSPAN=3  >&nbsp;</TH> 
		       
    </TR--->
	 <cfoutput query="dept_avg_rage"> 
	   <tr  align="center">
       <cfset  dept_list=chair.getDepts(cyear,dept_id)>
	     <td align="center" rowspan="6">  #dept_list.DEPT_NM#：#dept_list.NAME# (#COUNT#)
         
         </td>
	  <TH   COLSPAN=3 ><a href="chair_question_des.cfm?##se1" target="_blank">Evaluation of Faculty</a></TH>  
	       <TH   COLSPAN=5  ><a href="chair_question_des.cfm?##se2" target="_blank"> Faculty Compensation and Rewards</a></TH> 
	        <TH   COLSPAN=5  ><a href="chair_question_des.cfm?##se3" target="_blank"> Mentoring</a></TH> 
	        <TH   COLSPAN=5  > <a href="chair_question_des.cfm?##se4" target="_blank"> Faculty Support</a></TH> 
	         <TH   COLSPAN=4  ><a href="chair_question_des.cfm?##se5" target="_blank">Faculty Appointments and Promotions</a></TH>    </tr>
       <tr valign="top">
	     
	   
         <td align="center"> Q1</td>
          <td align="center">Q2</td>
	       <td align="center">Q3</td>
		   
	       <td align="center"> Q1</td>
          <td align="center">Q2</td>
	       <td align="center">Q3</td> 
          <td align="center">Q4</td>
		    <td align="center">Q5</td>
		  
	       <td align="center"> Q1</td>
          <td align="center">Q2</td>
	       <td align="center">Q3</td>
		      <td align="center">Q4</td>
	       <td align="center">Q5</td>
	        
	       <td align="center"> Q1</td>
          <td align="center">Q2</td>
	       <td align="center">Q3</td>
		    <td align="center">Q4</td>
	       <td align="center">Q5</td> 
	      
	       <td align="center"> Q1</td>
          <td align="center">Q2</td>
	       <td align="center">Q3</td>
	          <td align="center">Q4</td>
		     
	</TR>
      
	     <tr valign="top">
	      
	      <td align="center"> #Q11#</td>
           <td align="center">#Q12#</td>
	        <td align="center">#Q13#</td>
	         <td align="center"> #Q21#</td>
           <td align="center">#Q22#</td>
	        <td align="center">#Q23#</td>
	          <td align="center"> #Q24#</td>
			   <td align="center"> #Q25#</td>
           
	         <td align="center"> #Q31#</td>
           <td align="center">#Q32#</td>
	        <td align="center">#Q33#</td>
			  <td align="center">#Q34#</td>
	        <td align="center">#Q35#</td>
	        
	         <td align="center"> #Q41#</td>
           <td align="center">#Q42#</td>
	        <td align="center">#Q43#</td>
			 <td align="center">#Q44#</td>
	        <td align="center">#Q45#</td>
	      
	         <td align="center"> #Q51#</td>
           <td align="center">#Q52#</td>
	        <td align="center">#Q53#</td>
	         <td align="center">#Q54#</td>
		      
		 
	    </tr> 
	    <tr  align="center">
	<TH   COLSPAN=5><a href="chair_question_des.cfm?##se6" target="_blank">Faculty Recruitment and Retention</a></TH>
	    <TH   COLSPAN=15  ><a href="chair_question_des.cfm?##se7" target="_blank">Communication and Leadership</a></TH>
	      <TH   COLSPAN=5 ><a href="chair_question_des.cfm?##se8" target="_blank">Overall Evaluation</a></TH>
	     </tr>
		 
	     <tr valign="top">
	      
	   <td align="center"> Q1</td>
           <td align="center">Q2</td>
	        <td align="center">Q3</td>
			   <td align="center">Q4</td>
                 <td align="center">Q5</td>
	         
	          <td align="center"> Q1</td>
           <td align="center">Q2</td>
	        <td align="center">Q3</td>
	          <td align="center"> Q4</td>
	         <td align="center"> Q5</td>
	          <td align="center"> Q6</td>
           <td align="center">Q7</td>
	        <td align="center">Q8</td>
	         <td align="center"> Q9</td>
			  <td align="center">Q10</td>
	        <td align="center">Q11</td>
	         <td align="center"> Q12</td>
			  <td align="center"> Q13</td>
               <td align="center"> Q14</td>
			  <td align="center"> Q15</td>
	          
	            <td align="center"  COLSPAN=5> Q</td>
	    </TR>
	     <tr valign="top"> 
	      <td align="center"> #Q61#</td>
           <td align="center">#Q62#</td>
	        <td align="center">#Q63#</td>
			   <td align="center">#Q64#</td>
	        <td align="center">#Q65#</td>
	           <td align="center"> #Q71#</td>
           <td align="center">#Q72#</td>
	        <td align="center">#Q73#</td>
	          <td align="center"> #Q74#</td> 
	           <td align="center"> #Q75#</td>
           <td align="center">#Q76#</td>
	        <td align="center">#Q77#</td>
	          <td align="center"> #Q78#</td> 
	           <td align="center"> #Q79#</td>
			    <td align="center">#Q710#</td>
	          <td align="center"> #Q711#</td> 
	           <td align="center"> #Q712#</td>
           <td align="center"> #Q713#</td>
            <td align="center"> #Q714#</td>
           <td align="center"> #Q715#</td>
		         <td align="center"  COLSPAN=5> #Q81#</td>
	    </tr>
      </cfoutput>
	    
  
    </table>
  
  </div>
 
 
 
  
<p>&nbsp;</p>
 
  	</td>
	</tr>  </table>  
 <cfinclude template="../includes/page_footer_new.cfm">   
  
 
	
