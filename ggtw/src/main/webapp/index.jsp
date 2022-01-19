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
<!-- 
 media속성(반응형) 웹의 크기를 지정할때 사용(해상도)
 screen and (min-width:768px)(최소 해상도 픽셀)->해상도 이하 tablet.css적용
-->
<link href="css/index.css" rel="stylesheet" type="text/css"
         media="screen and (min-width:768px)"> 
<link href="css/tablet.css" rel="stylesheet" type="text/css"
         media="screen and (max-width:768px)"> <!--테블릿화면 적용 스타일시트-->
<!-- jQuery를 이용한 상단메뉴처리 : 마우스 올리면 서브메뉴 보이게 하기-->
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="js/index.js"></script>
<script src="js/jquery.cycle2.js"></script>
 </head>
 <body  onload="document.login.mem_id.focus()">
 	<div class="wrap"><!-- 본문 전체 -->
 		<!-- 웹페이지 상단부분 -->
 		<header class="hd1">
 			<h1>GoGoTaiwan</h1>
 			<!-- 메뉴바 -->
 			<nav class="nv1">
 				<div><a href="#" class="main1">소개</a>
 					 <ul class="sub">
 					 	<li><a href="#">홈소개</a></li>
 						<li><a href="#" class="a1">투어소개</a>
 							<ul class="sub1">
 								<li><a href="#">예스진지</a></li>
 								<li><a href="#">시티투어</a></li>
 								<li><a href="#">화련투어</a></li>
 							</ul>
 						</li>
 						<li><a href="#">차량소개</a></li>
 					</ul>
 				</div>	
 				<div><a href="#" class="main2">요금안내</a></div>
 				<div><a href="#" class="main3">공지사항</a></div>
 				<div><a href="board/list.jsp" class="main4">예약신청</a></div>
			</nav>
 			<nav class="nv2">
 				<%if(mem_id!=null){ %> 
				 	<ul>
	 					<li><a href="user/Logout.jsp">Logout</a></li>
	 					<li><a href="user/Login.jsp">회원관리</a></li>
 					</ul>
				<% }else {%>	 			
	 				<ul>
	 					<li><a href="user/Login.jsp">Login</a></li>
	 					<li><a href="user/agreement.jsp">회원가입</a></li>
	 				</ul>
	 			<% }%>
 			</nav>
 		</header>
 		<header class="hd2">
			<h2>모바일메뉴바</h2>
 		</header>
 		
 		<!-- 웹페이지 본문부분 -->
 		<!-- 상단 배너 이미지 -->
 		<div class="cycle-slideshow">
 			<img src="img/sc1-img3.jpg" alt="sc-3">
 			<img src="img/sc1-img2.jpg" alt="sc-2">
 			<img src="img/sc1-img1.jpg" alt="sc-1">
 		</div>
 		<!-- 메인 콘텐츠 -->
 		<section class="sc2">모바일 차량소개<br><img src="img/at1-img1.jpg"></section>
 		<section class="sc3">모바일 이벤트<br><img src="img/at1-img8.jpg"  width="400" height="400"></section>
 		<article class="at1">
 			<h3>차량 소개</h3>
 			<div class="d1">
 				<figure>
 					<img src="img/at1-img1.jpg" alt="at-1">
 					<figcaption class="fc1">
 						<img src="img/at1-img5.png"> 택시투어(최대4인)
 					</figcaption>
 				</figure>
 			</div>
 			 <div class="d2">
 				<figure>
 					<img src="img/at1-img2.jpg" alt="at-2">
 					<figcaption class="fc2">
 						<img src="img/at1-img6.png"> 벤투어(최대9인)
 					</figcaption>
 				</figure>
 			</div>
 			 <div class="d3">
 				<figure>
 					<img src="img/at1-img3.jpg" alt="at-3">
 					<figcaption class="fc3">
 						<img src="img/at1-img7.png"> 버스투어(최대45인)
 					</figcaption>
 				</figure>
 			</div>
 		</article>
 		<article class="at2">
 			<img src="img/at1-img8.jpg">
 			<div id="dv1">
 				<h3>E V E N T</h3>
 				<br><br>
 				<h6>코로나 극복 응원 이벤트!</h6>
 				<h5>택시투어예약시</h5>
 				<h6>땅콩아이스크림제공</h6>
 				<br>
 				<button id="btn1">예약신청</button>
 				<button id="btn2">투어 상세 보기</button>
 				</div>
 		</article>
 		<article class="at3">
 			<embed src="vd/main_vd.mp4" [width:"450px" height:"300px"]>
 		</article>
 		<article class="at4">
	 		<img src="img/vd.PNG" alt="riview">
 		</article>
 		
 		<!-- 웹페이지 하단부분 -->
 		<footer class="ft1">
 			<nav class="nv3">
 				<ul>
 					<li><a href="#">서비스 이용약관</a></li>
 					<li class="l1">|</li>
  					<li><a href="#">개인정보처리 방침</a></li>
 					<li class="l1">|</li>
 					<li><a href="#">고객서비스 센터</a></li>
 					<li class="l1">|</li>
  					<li><a href="#">환불정책</a></li>
 				</ul>
 				<br>
 			</nav>
 			<nav class="nv4">
 				<ul>
 					<li>대표 : 김대만</li>
 					<li>대표번호 : 02-123-4567</li>
 					<li>ggtw@gmail.com</li>
 					<li>서울시 행복구 여행동 418 투어빌딩 309호</li>
 				</ul>	
 			</nav>
 		</footer>
 	</div> 
 </body>