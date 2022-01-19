<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.Timestamp,board.*"%>
<%
     request.setCharacterEncoding("utf-8");
     //BoardDTO->Setter Method(5)+hidden(4) num,ref,re_level,re_step
     //BoardDAO->insertArticle(DTO객체)호출
%>
<jsp:useBean id="article" class="board.BoardDTO" />
<jsp:setProperty name="article" property="*" />
<%
    /* 멤버변수명과 input box의 name이름이 반드시 일치해야 setter Method호출
    String content=request.getParameter("content");
    System.out.println("content=>"+content);
    */
   //readcount(0),날짜(now()),원격주소 ip=>3개
   Timestamp temp=new Timestamp(System.currentTimeMillis());//컴퓨터시간
   article.setReg_date(temp);//오늘 날짜 계산해서 수동으로 저장
   article.setIp(request.getRemoteAddr());//원격ip 주소 저장
   
   BoardDAO dbPro=new BoardDAO();
   dbPro.insertArticle(article);
   response.sendRedirect("list.jsp");//입력한후 다시 DB접속->새로 고침해서 화면에 출력
%>


