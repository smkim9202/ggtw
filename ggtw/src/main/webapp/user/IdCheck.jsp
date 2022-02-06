<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="hewon.MemberDAO" %>
<%-- <jsp:useBean id="memMgr" class="hewon.MemberDAO" scope="page"/> --%>
<%
   //소스를 변경해도 바로 반영이 안되는 경우->서버에서 기본적으로 전의 페이지 불러오기(저장하기때문에)
   response.setHeader("Cache-Control","no-cache");//요청시 메모리에 저장X
   response.setHeader("Pragma","no-cache");//메모리에 저장X
   response.setDateHeader("Expires",0);//보관X
%>
<%
   //script.js(idCheck(id)->IdCheck.jsp?mem_id='nup')
   String mem_id=request.getParameter("mem_id");
   System.out.println("IdCheck.jsp의 mem_id=>"+mem_id);
   //MemberDAO 객체필요=>loginCheck메서드호출해야 되기때문에
	MemberDAO memMgr=new MemberDAO();
    boolean check=memMgr.checkId(mem_id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중복ID체크</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<br>
<center>
<b><%=mem_id %></b>
<%
    if(check){//if(check==true){ 이미 존재하는 아이디라면
    	out.println("는 이미 존재하는 아이디입니다.<p>"); 
    }else{//존재하는 아이디가 아니라면
    	out.println("는 사용가능한 아이디입니다.<p>");
    }
%>
<br><br>
<!-- 자바스크립트에서 자기 자신의 창을 가리키는 예약어 self
       window.open()<-> winodw.close() -->
<a href="#" onclick="self.close()">닫기</a> 
</center>
</body>
</html>


