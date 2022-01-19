<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.Timestamp,board.*"%>
<%
     request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="article" class="board.BoardDTO" />
<jsp:setProperty name="article" property="*" />
<%
   
    String pageNum=request.getParameter("pageNum");
    System.out.println("updatePro.jsp의 매개변수확인(pageNum)=>"+pageNum);
   
   BoardDAO dbPro=new BoardDAO();
   int check=dbPro.updateArticle(article);
   if(check==1){//글수정에 성공했다면
	  //response.sendRedirect("이동할페이지명.jsp?page=3")
	  //http-equiv="Refresh" =>새로 고침 옵션
	  //content="초단위(몇초동안 멈춘후);url=이동할페이지명?매개변수명=전달할값
%>
<meta http-equiv="Refresh"  
          content="0;url=list.jsp?pageNum=<%=pageNum%>">
<%}else { %>
<script>
   alert("비밀번호가 맞지않습니다.\n다시 비밀번호를 확인요망!");
   history.go(-1);//history.back();
</script>
<%} %>



