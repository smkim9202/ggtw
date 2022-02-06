<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="board.*"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
<title>글수정 하기</title>
  <link href="../css/style.css" rel="stylesheet" type="text/css">
  <script src="../js/script.js"></script>
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css" 
	integrity="sha384-lKuwvrZot6UHsBSfcMvOkWwlCMgc0TaWr+30HWe3a4ltaBwTZhyTEggF5tJv8tbt" 
	crossorigin="anonymous">
</head>
<%
 //content.jsp->글수정버튼 클릭=>updateForm.jsp?num=3&pageNum=1
   int num=Integer.parseInt(request.getParameter("num"));//"3"->3(메서드의 매개변수때문에)
   String pageNum=request.getParameter("pageNum");//페이지번호->수정,삭제페이지로 이동
  
   BoardDAO dbPro=new BoardDAO();//메서드 호출목적
   BoardDTO article=dbPro.updateGetArticle(num);
   System.out.println("updateForm.jsp의 article=>"+article);//null (메서드 또는 매개변수문제)
%>
<body>  
	<div id="container"><!-- 본문 전체 -->
		<jsp:include page="/top.jsp" />
		
		<div id="contents">
<center><h3>글수정</h3><br>
<form method="post" name="writeform" 
          action="updatePro.jsp?pageNum=<%=pageNum%>" onsubmit="return writeSave()">
<table width="400" border="1" cellspacing="0" cellpadding="0"  align="center">
  <tr>
    <td  width="70"align="center">이 름</td>
    <td align="left" width="330">
       <input type="text" size="10" maxlength="10" name="writer"
                  value="<%=article.getWriter()%>">
	   <input type="hidden" name="num" value="<%=num%>">
	  <%--  <input type="hidden" name="pageNum" value="<%=pageNum %>"> --%>
	</td>
  </tr>
  <tr>
    <td  width="70"  align="center" >제 목</td>
    <td align="left" width="330">
       <input type="text" size="40" maxlength="50" name="subject" 
                 value="<%=article.getSubject()%>"></td>
  </tr>
  <tr>
    <td  width="70"   align="center">Email</td>
    <td align="left" width="330">
       <input type="text" size="40" maxlength="30" name="email" 
                 value="<%=article.getEmail()%>"></td>
  </tr>
  <tr>
    <td  width="70"  align="center" >내 용</td>
    <td align="left" width="330">
     <textarea name="content" rows="13" cols="40">
             <%=article.getContent()%>
    </textarea></td>
  </tr>
  <tr><!-- 암호는 본인이 직접 입력해서 확인목적 -->
    <td  width="70"   align="center" >비밀번호</td>
    <td align="left" width="330" >
     <input type="password" size="8" maxlength="12" name="passwd">
     
	 </td>
  </tr>
  <tr>      
   <td colspan=2 align="center"> 
     <input type="submit" value="글수정" >  
     <input type="reset" value="다시작성">
     <input type="button" value="목록보기" 
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
