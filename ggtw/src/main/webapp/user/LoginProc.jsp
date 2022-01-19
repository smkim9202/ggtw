<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="hewon.MemberDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 인증</title>
</head>
<body>
<jsp:useBean id="memMgr" class="hewon.MemberDAO" scope="page"/>
<%
   //Login.jsp=>2개의 매개변수
   String mem_id=request.getParameter("mem_id");
   String mem_passwd=request.getParameter("mem_passwd");
   System.out.println("mem_id=>"+mem_id+",mem_passwd=>"+mem_passwd);
   //MemberDAO 객체필요=>loginCheck메서드호출해야 되기때문에
	// MemberDAO memMgr=new MemberDAO();
     boolean check=memMgr.loginCheck(mem_id, mem_passwd);
%>
<%
    //check->LoginSuccess.jsp(인증화면),LoginError.jsp(에러메세지)
    if(check){//if(check==true){ 인증성공했다면
    	session.setAttribute("idKey",mem_id);//키명,저장할값(id계정명)
    	//response.sendRedirect("LoginSuccess.jsp");//단순히 페이지이동(공유X)
    	response.sendRedirect("Login.jsp");
    }else{//id가 없다면
    	response.sendRedirect("LogError.jsp");
    }
%>
</body>
</html>


