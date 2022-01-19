<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="hewon.MemberDAO" %>
<%
    //추가 deletePro.jsp?mem_id='nup',passwd(직접 입력 O)
    String mem_id=request.getParameter("mem_id");//입력X
    String passwd=request.getParameter("passwd");//입력 O
    
    System.out.println("deletePro.jsp의 mem_id=>"
                              +mem_id+",passwd="+passwd);
    
	MemberDAO memMgr=new MemberDAO();
    int check=memMgr.memberDelete(mem_id,passwd);//회원탈퇴메서드 호출
    System.out.println("deletePro.jsp의 회원삭제유무(check)=>"+check);//1 or 0
%>
<%
    if(check==1){//회원삭제에 성공했다면
    	session.invalidate();//세션종료(메모리 자동해제)
 %>
    <script>
        alert("<%=mem_id%>님 성공적으로 탈퇴처리 되었습니다.");
        location.href="Login.jsp";//로그인 되기전의 창의 모습
    </script>
  <% }else{ %>
      <script>
        alert("비밀번호가 틀립니다.\n 다시 한번 확인하시기 바랍니다.");
        history.back();
    </script>
   <%} %>



