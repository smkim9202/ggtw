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
  <title>GGTW</title>
  <link href="css/index.css" rel="stylesheet" type="text/css"> 
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css" 
	integrity="sha384-lKuwvrZot6UHsBSfcMvOkWwlCMgc0TaWr+30HWe3a4ltaBwTZhyTEggF5tJv8tbt" 
	crossorigin="anonymous">
</head>
<body>
	<div id="container"><!-- 본문 전체 -->
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
							<li><a href="fare/taxi.jsp">택시투어</a></li>
							<li><a href="fare/ben.jsp">벤투어</a></li>
							<li><a href="fare/bus.jsp">버스투어</a></li>							
						</ul>					
					</li>
					<li><a href="#">공지사항</a></li>
					<li><a href="board/list.jsp">예약신청</a></li>
				</ul>
			</nav>
			<nav id="navUser"><!-- 로그인/회원가입-->
 				<%if(mem_id!=null){ %> 
				 	<ul id="topMenu">
	 					<li><a href="user/Logout.jsp">Logout</a></li>
	 					<li><a href="user/Login.jsp">Mypage</a></li>
 					</ul>
				<% }else {%>	 			
	 				<ul id="topMenu">
	 					<li><a href="user/Login.jsp">Login</a></li>
	 					<li><a href="user/agreement.jsp">Join</a></li>
	 				</ul>
	 			<% }%>
			</nav>		
			
		</header>
		<div id="slideShow"><!-- 롤링배너 -->
			<div id="slides">
				<img src="img/sc1-img1.jpg" alt="sc-1">
	 			<img src="img/sc1-img2.jpg" alt="sc-2">
	 			<img src="img/sc1-img3.jpg" alt="sc-3"> 
	 			<!--자동 배너로 바꾸기 
				<button id="prev">&lt;</button>
				<button id="next">&gt;</button>-->						
			</div>			
		</div>
		<div id="contents">
			<div id="tabMenu"><!-- 탭 메뉴 -->
				<input type="radio" id="tab1" name="tabs" checked>
				<label for="tab1">공지사항</label>
				<input type="radio" id="tab2" name="tabs">
				<label for="tab2">예약신청</label>
				
				<div id="notice" class="tabContent">
					<h2>공지사항 내용입니다.</h2>
					<ul>
						<li>게시물1</li>
						<li>게시물2</li>
						<li>게시물3</li>
						<li>게시물4</li>
						<li>게시물5</li>
					</ul>
				</div>
				
				<div id="reservation" class="tabContent">
					<h2>예약신청 현황입니다.</h2>
					<ul>
						<li>예약1</li>
						<li>예약2</li>
						<li>예약3</li>
						<li>예약4</li>
						<li>예약5</li>
					</ul>
				</div>
			</div>
			<div id="sLinks"><!-- 원형 퀵 링크 -->
				<h3>요금안내</h3>
				<ul>
					<li>
						<a href="fare/taxi.jsp">
							<span id="quick-icon1"></span>
							<span id="quick-title">택시투어</span>
						</a>
					</li>
					<li>
						<a href="fare/ben.jsp">
							<span id="quick-icon2"></span>
							<span id="quick-title">벤투어</span>
						</a>
					</li>
					<li>
						<a href="fare/bus.jsp">
							<span id="quick-icon3"></span>
							<span id="quick-title">버스투어</span>
						</a>
					</li>
				</ul>
			</div>
			<div id="video"><!-- 홍보 영상 -->
				<h3>홍보 영상</h3>
				<embed src="vd/main_vd.mp4" []>
			</div>
			<div id="event"><!-- 이벤트 -->
				<h3>이벤트</h3>

				<div id="eventPic">
					<img src="img/eventimg.jpg">
				</div>
				<div id="eventTable">
					<table>
						<tr><th>코로나 극복 응원 이벤트!</th></tr>
						<tr><td>택시투어예약시<br>땅콩아이스크림제공<br>
							2인당 1개씩! 총 2개!!<br>지금바로신청하세요!</td></tr>
						<tr><td>
							<button onclick = "location.href = 'board/list.jsp'" id="btn1">예약신청</button>
 							<button onclick = "location.href = 'fare/taxi.jsp'"  id="btn2">투어 상세 보기</button></td></tr>
					</table>
				</div>
						
			</div>
		</div>
		<footer><!-- 풋터 -->
			<div id="bottomMenu">
				<ul>
					<li><a href='#'>회사 소개</a></li>
					<li><a href='#'>개인정보처리방침</a></li>
					<li><a href='#'>여행약관</a></li>
					<li><a href='#'>사이트맵</a></li>
				</ul>
				<div id="sns">
					<ul>
						<li><a href="#"><i class="fab fa-instagram"></i></a></li>
						<li><a href="#"><i class="fab fa-facebook-square"></i></a></li>
						<li><a href="#"><i class="fab fa-line"></i></a></li>
					</ul>
				</div>
			</div>
			<div id="company">
				<p>서울특별시 행복구 여행동 투어빌딩 (대표전화) 02-123-4567</p>
			</div>
		</footer>
	
	
	
	</div><!-- 본문 전체 -->
	<script src="js/slideshow.js"></script>
</body>
</html>