<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
     //웹상에서 로그인했는지 안했는지 확인
     //session.setAttribute("idKey",mem_id)->LoginProc.jsp를 거쳤는지 확인?
     String mem_id=(String)session.getAttribute("idKey");//Object->String
     System.out.println("Login.jsp의 mem_id=>"+mem_id);//null
 %>
<!doctype html>
<html>
 <head>
  <meta charset="UTF-8">
  <title>택시요금</title>
  <link href="../css/style.css" rel="stylesheet" type="text/css">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css" 
	integrity="sha384-lKuwvrZot6UHsBSfcMvOkWwlCMgc0TaWr+30HWe3a4ltaBwTZhyTEggF5tJv8tbt" 
	crossorigin="anonymous">
  <script src="../js/script.js"></script>
</head>
<body onload="document.login.mem_id.focus()">
	<div id="container"><!-- 본문 전체 -->
		<jsp:include page="/top.jsp" />

		<div id="contents">
			<center>
			<h2>택시요금</h2>		
			<img src="../img/icon-1.jpg">
			</center>
		</div>
		
		<jsp:include page="/bottom.jsp" />
	
	</div><!-- 본문 전체 -->
</body>
</html>
