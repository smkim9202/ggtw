<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="board.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약게시판</title>
  <link href="../css/style.css" rel="stylesheet" type="text/css">
  <script src="../js/script.js"></script>
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css" 
	integrity="sha384-lKuwvrZot6UHsBSfcMvOkWwlCMgc0TaWr+30HWe3a4ltaBwTZhyTEggF5tJv8tbt" 
	crossorigin="anonymous">
</head>
<%
   //글상세보기=>게시판(상품의 정보를 자세히 (SangDetail.jsp))
   //list.jsp? num,pageNum
   int num=Integer.parseInt(request.getParameter("num"));//"3"->3(메서드의 매개변수때문에)
   String pageNum=request.getParameter("pageNum");//페이지번호->수정,삭제페이지로 이동
   SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm");
   BoardDAO dbPro=new BoardDAO();//메서드 호출목적
   BoardDTO article=dbPro.getArticle(num);
   //링크문자열의 길이를 줄이기 위해서
   int ref=article.getRef();
   int re_step=article.getRe_step();
   int re_level=article.getRe_level();
   System.out.println("content.jsp의 매개변수 확인용");
   System.out.println("ref="+ref+",re_step="+re_step+",re_level=>"+re_level);
%>
<body> 
	<div id="container"><!-- 본문 전체 -->
		<jsp:include page="/top.jsp" />
		
		<div id="contents">
			<center>
<center><h3>글내용 보기</h3><br>
<form>
<table width="800" border="1" cellspacing="0" cellpadding="0" align="center">  
  <tr height="30">
    <td align="center" width="200">글번호</td>
    <td align="center" width="200" align="center">
	     <%=article.getNum() %></td>
    <td align="center" width="200" >조회수</td>
    <td align="center" width="200" align="center">
	     <%=article.getReadcount() %></td>
  </tr>
  <tr height="30">
    <td align="center" width="200" >작성자</td>
    <td align="center" width="200" align="center">
	     <%=article.getWriter() %></td>
    <td align="center" width="200"  >작성일</td>
    <td align="center" width="200" align="center">
	     <%=sdf.format(article.getReg_date()) %></td>
  </tr>
  <tr height="30">
    <td align="center" width="200" >글제목</td>
    <td align="center" width="600" align="center" colspan="3">
	     <%=article.getSubject() %></td>
  </tr>
  <tr>
    <td align="center" width="200" >글내용</td>
    <td align="left" width="600" colspan="3">
    <pre><%=article.getContent() %></pre></td>
  </tr>
  <tr height="30">      
    <td colspan="4" align="center" > 
	  <input type="button" value="글수정" 
       onclick="document.location.href='updateForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">
	   &nbsp;&nbsp;&nbsp;&nbsp;
	  <input type="button" value="글삭제" 
       onclick="document.location.href='deleteForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">
	   &nbsp;&nbsp;&nbsp;&nbsp;
      <input type="button" value="답글쓰기" 
       onclick="document.location.href='writeForm.jsp?num=<%=num%>&ref=<%=ref%>&re_step=<%=re_step%>&re_level=<%=re_level%>'">
	   &nbsp;&nbsp;&nbsp;&nbsp;
       <input type="button" value="글목록" 
       onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">
    </td>
  </tr>
</table>    
</form>
		</center></div>
		
		<jsp:include page="/bottom.jsp" />
	
	</div><!-- 본문 전체 -->      
</body>
</html>      
