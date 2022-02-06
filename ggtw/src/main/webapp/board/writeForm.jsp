<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>예약게시판</title>
  <link href="../css/style.css" rel="stylesheet" type="text/css">
  <script src="../js/script.js"></script>
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css" 
	integrity="sha384-lKuwvrZot6UHsBSfcMvOkWwlCMgc0TaWr+30HWe3a4ltaBwTZhyTEggF5tJv8tbt" 
	crossorigin="anonymous">
</head>
  <%
    //list.jsp(글쓰기)->신규글, content.jsp(글상세보기->글쓰기(답변글))
    int num=0,ref=1,re_step=0,re_level=0;//전달->writePro.jsp에 전달(신규글)
   
    //content.jsp에서 매개변수가 전달
    if(request.getParameter("num")!=null){//0은 아니고,음수X=>양수 1이상
    	num=Integer.parseInt(request.getParameter("num"));//"3"->3
    	ref=Integer.parseInt(request.getParameter("ref"));
    	re_step=Integer.parseInt(request.getParameter("re_step"));
    	re_level=Integer.parseInt(request.getParameter("re_level"));
    	System.out.println("content.jsp에서 넘어온 매개변수 확인");
    	System.out.println("num="+num+",ref="+ref+
    			                   ",re_step="+re_step+",re_level="+re_level);
    }
  %>
<body> 
	<div id="container"><!-- 본문 전체 -->
		<jsp:include page="/top.jsp" />
		
		<div id="contents">
			<center><h3>예약신청</h3><br>
<!-- onsubmit이벤트 처리="return 호출할 함수명()"(true) -->
<form method="post" name="writeform" action="writePro.jsp"
         onsubmit="return writeSave()">
     <!--입력하지 않고 매개변수로 전달해서 테이블에 저장(hidden) 4개  -->
     <input type="hidden" name="num" value="<%=num%>">
     <input type="hidden" name="ref" value="<%=ref%>">
     <input type="hidden" name="re_step" value="<%=re_step%>">
     <input type="hidden" name="re_level" value="<%=re_level%>">
     
<table width="400" border="1" cellspacing="0" cellpadding="0" align="center">
   <tr>
    <td align="right" colspan="2" >
	    <a href="list.jsp"> 글목록</a> 
   </td>
   </tr>
   <tr>
    <td  width="70" align="center">이 름</td>
    <td  width="330">
       <input type="text" size="10" maxlength="10" name="writer"></td>
  </tr>
  <tr>
    <td  width="70"  align="center" >제 목</td>
    <td  width="330">
       <input type="text" size="40" maxlength="50" name="subject"></td>
  </tr>
  <tr>
    <td  width="70"   align="center">Email</td>
    <td  width="330">
       <input type="text" size="40" maxlength="30" name="email" ></td>
  </tr>
  <tr>
    <td  width="70"   align="center" >내 용</td>
    <td  width="330" >
     <textarea name="content" rows="13" cols="40"></textarea> </td>
  </tr>
  <tr>
    <td  width="70"  align="center" >비밀번호</td>
    <td  width="330" >
     <input type="password" size="8" maxlength="12" name="passwd"> 
	 </td>
  </tr>
<tr>      
 <td colspan=2  align="center"> 
  <input type="submit" value="글쓰기" >  
  <input type="reset" value="다시작성">
  <input type="button" value="목록보기" OnClick="window.location='list.jsp'">
</td></tr></table>    
</form>
		</center></div>
		
		<jsp:include page="/bottom.jsp" />
	
	</div><!-- 본문 전체 -->      
</body>
</html>      
