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
    //추가
    String mem_id=request.getParameter("mem_id");
    System.out.println("MemberUpdateProc.jsp의 mem_id=>"+mem_id);//null
    
	MemberDAO memMgr=new MemberDAO();
    boolean check=memMgr.memberUpdate(mem);//회원수정메서드 호출
    System.out.println("MemberUpdateProc.jsp의 회원수정유무(check)=>"+check);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원수정확인</title>
</head>
<body bgcolor="#FFFFCC">
<br>
<center>
<%
    if(check){//if(check==true){ 회원수정에 성공했다면
 %>
    <script>
        alert("성공적으로 수정되었습니다.");
        location.href="Login.jsp";
    </script>
  <% }else{ %>
      <script>
        alert("수정도중 에러가 발생이 되었습니다.");
        history.back();
    </script>
   <%} %>
</center>
</body>
</html>


