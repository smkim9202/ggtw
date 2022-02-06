<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="hewon.MemberDAO" %>
<%
 //RegisterProc.jsp->MemberInsert.jsp
  request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="mem"  class="hewon.MemberDTO" />
<jsp:setProperty name="mem" property="*" />
<%
	MemberDAO memMgr=new MemberDAO();
    boolean check=memMgr.memberInsert(mem);//회원가입 메서드 호출
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입확인</title>
</head>
<body>
<br>
<center>
<%
    if(check){//if(check==true){ 회원가입에 성공했다면
    	out.println("<b>회원가입을 축하드립니다.</b><p>");
        out.println("<a href=Login.jsp>로그인</a>");
    }else{//실패한 경우
    	out.println("<b>다시 입력하여 주십시오.</b><p>");
        out.println("<a href=Register.jsp>다시 가입</a>");
    }
%>
</center>
</body>
</html>


