<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
     //웹상에서 로그인했는지 안했는지 확인
     //session.setAttribute("idKey",mem_id)->LoginProc.jsp를 거쳤는지 확인?
     String mem_id=(String)session.getAttribute("idKey");//Object->String
     System.out.println("Login.jsp의 mem_id=>"+mem_id);//null
 %>
<!Doctype html>
<html>
 <head>
  <meta charset="UTF-8">
  <title>로그인</title>
  <link href="../css/style.css" rel="stylesheet" type="text/css">
  <script src="../js/script.js"></script>
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css" 
	integrity="sha384-lKuwvrZot6UHsBSfcMvOkWwlCMgc0TaWr+30HWe3a4ltaBwTZhyTEggF5tJv8tbt" 
	crossorigin="anonymous">
</head>
<body onload="document.login.mem_id.focus()">
	<div id="container"><!-- 본문 전체 -->
		<jsp:include page="/top.jsp" />
		
		<div id="contents">
			<center>
			<!-- mem_id의 상태에따라 로그인 처리 -->
	 		<!-- 로그인 인증 성공  -->
				<%if(mem_id!=null){ %> 
					<b><%=mem_id %></b>님 환영합니다.<p>
					당신은 제한된 기능을 사용할 수가 있습니다.<p>
					<br>
					<a href="MemberUpdate.jsp">회원수정</a> |
					<a href="DelCheckForm.jsp?mem_id=<%=mem_id%>">회원탈퇴</a> |
					<a href="Logout.jsp">로그아웃</a> |
					<a href="../index.jsp">메인페이지</a>
				<% }else {%>
			<!-- 로그인 안된 상태 -->
				<table>
					<form name="login" method="post" action="LoginProc.jsp">
					<tr>
						<th align="center" colspan="2">
							<h4>로그인</h4>
						</th>
					</tr>
					<tr>
						<td>아이디</td>
						<td><input type="text" name="mem_id"></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="mem_passwd"></td>
					</tr>
					<tr>
						<td colspan="2"><div align="center">
							<input type="button" value="로그인" onclick="loginCheck()"> 
							&nbsp;
							<input type="button" value="회원가입" onclick="memberReg()">
						</div></td>
					</tr>
					</form>
				</table>
			<% } %>
		</center></div>
		
		<jsp:include page="/bottom.jsp" />
	
	</div><!-- 본문 전체 -->

</body>
</html>
