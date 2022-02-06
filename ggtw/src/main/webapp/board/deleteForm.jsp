<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
  //deleteForm.jsp?num=2&pageNum=1=>deletePro.jsp(deleteArticle메서드 호출)
  int num=Integer.parseInt(request.getParameter("num"));//삭제할 게시물번호
  String pageNum=request.getParameter("pageNum");//페이지 이동때문에 필요
  System.out.println
     ("deleteForm.jsp의 num="+num+",pageNum="+pageNum);
%>
<html>
<head>
<title>게시판</title>
  <link href="../css/style.css" rel="stylesheet" type="text/css">
  <script src="../js/script.js"></script>
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css" 
	integrity="sha384-lKuwvrZot6UHsBSfcMvOkWwlCMgc0TaWr+30HWe3a4ltaBwTZhyTEggF5tJv8tbt" 
	crossorigin="anonymous">
</head>

<body >
	<div id="container"><!-- 본문 전체 -->
		<jsp:include page="/top.jsp" />
		
		<div id="contents">
<center><h3>글삭제</h3><br>
<form method="POST" name="delForm"  action="deletePro.jsp" 
   onsubmit="return deleteSave()"> 
 <table border="1" align="center" cellspacing="0" cellpadding="0" width="360">
  <tr height="30">
     <td align=center>
       <b>비밀번호를 입력해 주세요.</b></td>
  </tr>
  <tr height="30">
     <td align=center >비밀번호 :   
       <input type="password" name="passwd" size="8" maxlength="12">
	   <input type="hidden" name="num" value="<%=num%>">
	   <input type="hidden" name="pageNum" value="<%=pageNum %>">
	</td>
 </tr>
 <tr height="30">
    <td align=center>
      <input type="submit" value="글삭제" >
      <input type="button" value="글목록" 
       onclick="document.location.href='list.jsp?pageNum=<%=pageNum %>'">     
   </td>
 </tr>  
</table> 
</form>
		</center></div>
		
		<jsp:include page="/bottom.jsp" />
	
	</div><!-- 본문 전체 -->
</body>
</html> 
