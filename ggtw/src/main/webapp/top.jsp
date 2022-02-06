<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
     //웹상에서 로그인했는지 안했는지 확인
     //session.setAttribute("idKey",mem_id)->LoginProc.jsp를 거쳤는지 확인?
     String mem_id=(String)session.getAttribute("idKey");//Object->String
     System.out.println("Login.jsp의 mem_id=>"+mem_id);//null
 %>

		<header>
			<div id="logo">
				<a href="${path}"><h1>Go Go Taiwan</h1></a>
			</div>
			<nav id="navMenu"><!-- 메뉴바 -->
				<ul id="topMenu">
					<li><a href="#">소개 <span>▼</span></a>
						<ul>
							<li><a href="#">회사소개</a></li>
							<li><a href="#">투어소개</a></li>
						</ul>
					</li>
					<li><a href="#">요금안내 <span>▼</span></a>
						<ul>
							<li><a href="#">택시투어</a></li>
							<li><a href="#">벤투어</a></li>
							<li><a href="#">버스투어</a></li>							
						</ul>					
					</li>
					<li><a href="#">공지사항</a></li>
					<li><a href="#">예약신청</a></li>
				</ul>
			</nav>
			<nav id="navUser"><!-- 로그인/회원가입-->
 				<%if(mem_id!=null){ %> 
				 	<ul id="topMenu">
				 		<li><a href="Logout.jsp">Logout</a></li>
	 					<li><a href="#">Mypage</a></li>
 					</ul>
				<% }else {%>	 			
	 				<ul id="topMenu">
	 					<li><a href="#">Login</a></li>
	 					<li><a href="#">Join</a></li>
	 				</ul>
	 			<% }%>
			</nav>		
			
		</header>
