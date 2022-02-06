<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!Doctype html>
<%
   //DelCheckForm.jsp?mem_id='nup'
   String mem_id=request.getParameter("mem_id");
%>
<html>
 <head>
  <TITLE>회원탈퇴 확인</TITLE>
  <link href="../css/style.css" rel="stylesheet" type="text/css">
  <script src="../js/script.js"></script>
  <script language="JavaScript" src="../js/script.js?ver=1"></script>
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css" 
	integrity="sha384-lKuwvrZot6UHsBSfcMvOkWwlCMgc0TaWr+30HWe3a4ltaBwTZhyTEggF5tJv8tbt" 
	crossorigin="anonymous">
<SCRIPT LANGUAGE="JavaScript">
	   function delCheck(){
        if(document.del.passwd.value==""){
           alert("비밀번호를 입력해주세요!");
		   document.del.passwd.focus();
		   return;
		}
	  //예정대로 action값이 지정한 페이지로 이동
        document.del.submit();//전송
	  }
</SCRIPT>
 </HEAD>

 <BODY onload="document.del.passwd.focus()">
	<div id="container"><!-- 본문 전체 -->
		<jsp:include page="/top.jsp" />
		
		<div id="contents">
			<center>
			
     <TABLE>
     <!-- deletePro.jsp(memberDelete(id,passwd)호출 
            action="요청페이지.jsp?매개변수=전달할값&매개변수명2=값2&~
      -->
    <form name="del" method="post" 
              action="deletePro.jsp?mem_id=<%=mem_id%>">
     <TR>
		<TD align="center" colspan="2">
	<b><%=mem_id%>님 비밀번호를 입력해주세요</b><br></TD>
     </TR>
     <TR>
		<TD>비밀번호</TD>
		<TD><INPUT TYPE="password" NAME="passwd"><br></TD>
     </TR>
     <TR>
	    <td colspan="2"><div align="center">
		<INPUT TYPE="button" value="탈퇴" onclick="delCheck()">&nbsp;&nbsp;&nbsp;
		<INPUT TYPE="button" value="취소"
        onclick="document.location.href='Login.jsp?mem_id=<%=mem_id%>'">
		</div></TD>
     </TR>
	 <!-- hidden값 전달 -->
	 <%-- <input type="hidden" name="mem_id" value="<%=mem_id%>"> --%>
	 <!--  -->
	 </form>
     </TABLE>
		</center></div>
		
		<jsp:include page="/bottom.jsp" />
	
	</div><!-- 본문 전체 -->

 </BODY>
</HTML>
