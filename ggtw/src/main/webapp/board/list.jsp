<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="board.*,java.util.*,java.text.SimpleDateFormat" %>
<!Doctype html>
<%
   //소스를 변경해도 바로 반영이 안되는 경우->서버에서 기본적으로 전의 페이지 불러오기(저장하기때문에)
   response.setHeader("Cache-Control","no-cache");//요청시 메모리에 저장X
   response.setHeader("Pragma","no-cache");//메모리에 저장X
   response.setDateHeader("Expires",0);//보관X
%>
<%!
     int pageSize=10;//numPerPage(페이지당 보여주는 게시물수(=레코드수))
     int blockSize=10;//pagePerBlock(블럭당 보여주는 페이지수 )10
    //작성날짜->년-월-일 시 분 초->SimpleDateFormat
    SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm");
%>
<%
  //게시판을 맨 처음 실행시키면 무조건 1페이지 부터 출력->가장 최근의 글이 나오게설정
  String pageNum=request.getParameter("pageNum");
  if(pageNum==null){
	  pageNum="1";//default(무조건 1페이지는 선택하지 않아도 보여줘야 되기때문에)
  }
  int currentPage=Integer.parseInt(pageNum);//"1"->1(=nowPage(현재페이지))
  //시작 레코드번호  (1-1)*10+1=1, (2-1)*10+1=11,(3-1)*10+1=21
  int startRow=(currentPage-1)*pageSize+1;
  int endRow=currentPage*pageSize;//1*10=10,2*10=20,3*10=30(마지막 레코드번호)
  
  int count=0;//총레코드수
  int number=0;//beginPerPage->페이지별로 시작하는 맨 처음에 나오는 게시물번호
  List articleList=null;//화면에 출력할 레코드를 저장할 변수(객체)
  
  BoardDAO dbPro=new BoardDAO();
  count=dbPro.getArticleCount();//select count(*) from board->member
  System.out.println("현재 레코드수(count)=>"+count);
  if(count > 0){
	  articleList=dbPro.getArticles(startRow, pageSize);//첫번째레코드번호,불러올갯수
	  System.out.println("list.jsp의 articleList=>"+articleList);//null?
  }
  //            122-(1-1)*10=122,121,120,119,118,117,,,
  //            122-(2-1)*10=122-10=112,111,110,,,
  number=count-(currentPage-1)*pageSize;
  System.out.println("페이지별  number=>"+number);
%>
<html>
 <head>
  <meta charset="UTF-8">
<title>예약신청</title>
  <link href="../css/style.css" rel="stylesheet" type="text/css">
  <script src="../js/script.js"></script>
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css" 
	integrity="sha384-lKuwvrZot6UHsBSfcMvOkWwlCMgc0TaWr+30HWe3a4ltaBwTZhyTEggF5tJv8tbt" 
	crossorigin="anonymous">
</head>
<body>
	<div id="container"><!-- 본문 전체 -->
		<jsp:include page="/top.jsp" />
		
		<div id="contents">
			<center>
			<h3>예약게시판(전체 글:<%=count%>)</h3><br>
<table width="800">
<tr>
    <td align="right">
    <a href="writeForm.jsp">글쓰기</a>
    </td>
</tr>
</table>
<!-- 데이터의 유무  -->
<%
  if(count==0){
%>
<table border="1" width="800" cellpadding="0" cellspacing="0" align="center"> 
   <tr>
       <td align="center">게시판에 저장된 글이 없습니다.</td>
   </tr>
</table>
<%}else { %>
<table border="1" width="800" cellpadding="0" cellspacing="0" align="center"> 
    <tr height="30"> 
      <td align="center"  width="50"  >번 호</td> 
      <td align="center"  width="250" >제   목</td> 
      <td align="center"  width="100" >작성자</td>
      <td align="center"  width="150" >작성일</td> 
      <td align="center"  width="50" >조 회</td> 
      <td align="center"  width="100" >IP</td>    
    </tr>
    <!-- 실질적으로 레코드를 출력시켜주는 부분(상품리스트,고객,주문리스트,예약자리스트,,, -->
    <%
       for(int i=0;i<articleList.size();i++){
          BoardDTO article=(BoardDTO)articleList.get(i);//articleList.elementAt(i);
    %>
   <tr height="30"><!-- 하나씩 감소하면서 출력하는 게시물번호 -->
    <td align="center"  width="50" ><%=number-- %></td>
    <td  width="250" >
	  <!-- 답변글인 경우 먼저 답변이미지를 부착시키는 코드 -->
	  <%
	      int wid=0;//공백을 계산하기위한 변수선언
	      if(article.getRe_level() > 0){//1 이상 답변글이라면
	    	   wid=7*(article.getRe_level());//7,14,21
	  %>
	  <img src="../img/level.gif" width="<%=wid%>" height="16">
	  <img src="../img/re.gif">
	  <%}else { %>
	  <img src="../img/level.gif" width="<%=wid%>" height="16"> 
	  <%} %>         <!-- num(게시물번호),pageNum(페이지 번호)  -->
  <a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>">
           <%=article.getSubject() %></a> 
        <% if(article.getReadcount()>=20){ %>
         <img src="../img/hot.gif" border="0"  height="16">
         <%} %>
        </td>
    <td align="center"  width="100"> 
       <a href="mailto:<%=article.getEmail() %>">
       <%=article.getWriter() %></a></td>
    <td align="center"  width="150">
    <%=sdf.format(article.getReg_date())%></td>
    <td align="center"  width="50"><%=article.getReadcount() %></td>
    <td align="center" width="100" ><%=article.getIp() %></td>
  </tr>
     <% } //for %>
</table>
<% } %>
<!-- 페이징 처리  -->
<%
   if(count > 0){//레코드가 한개이상이라면 
	 //1.총페이지수 구하기=>나머지를 계산=>있으면 페이지 하나 더 추가
	 //                      122/10=12.2+1.0=13.2=13              (122%10)=1
	 int pageCount=count/pageSize+(count%pageSize==0?0:1);
	 //2.시작페이지
	 int startPage=0;
	 
	 if(currentPage%blockSize!=0){//1~9,11~19,21~29
		 startPage=currentPage/blockSize*blockSize+1;//10/10=1*10+1=11
		                                                                     //20/10=2*10+1=21
	 }else{//10%10 (10,20,30,40~)
		 //                 ((10/10)-1)*10+1=1
		 startPage=((currentPage/blockSize)-1)*blockSize+1;
	 }
	 //종료페이지
	 int endPage=startPage+blockSize-1;//1+10-1=10
	 System.out.println("startPage="+startPage+",endPage="+endPage);
	 //블럭별로 구분해서 링크걸어서 출력(마지막 페이지 > 총페이지수)
	 //11>10->endPage=10
	 if(endPage > pageCount) endPage=pageCount;//마지막페이지=총페이지수
	 //1)이전 블럭 (11>10)
    if(startPage > blockSize){%>
   <a href="list.jsp?pageNum=<%=startPage-blockSize %>">[이전]</a>
   <% }
  //2)현재 블럭(1,2,[3]10)
     for(int i=startPage;i<=endPage;i++) {%>
    <a href="list.jsp?pageNum=<%=i%>">[<%=i %>]</a>
    <%}
     //3)다음 블럭    1~14<15
      if(endPage < pageCount) {%>
    <a href="list.jsp?pageNum=<%=startPage+blockSize %>">[다음]</a> 
   <%
      }//다음블럭
   }//if(count > 0)
    %>
		</center></div>
		
		<jsp:include page="/bottom.jsp" />
	
	</div><!-- 본문 전체 -->
</body>
</html>