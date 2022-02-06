<%@ page contentType="text/html;charset=UTF-8" import="hewon.*"%>
<!Doctype html>
<html>
 <head>
  <meta charset="UTF-8">
<title>회원확인</title>
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
<%
  /*
    MemberUpdate.jsp?mem_id='nup' ->get방식으로 요청한 경우
    String mem_id=request.getParameter("mem_id");//값을 입력 or 링크걸기(get요청)
    <input type="hidden" name="mem_id" value="nup">//hidden객체를 이용해서 전달
  */
    String mem_id=(String)session.getAttribute("idKey");//session.setAttribute("idKey",~)
    System.out.println("MemberUpdate.jsp의 mem_id=>"+mem_id);//null인지 확인(디버깅코딩)
    MemberDAO memMgr=new MemberDAO();
    MemberDTO mem=memMgr.getMember(mem_id);
    System.out.println("MemberUpdate.jsp의 mem=>"+mem);
%>

<table align="center" border="0" cellspacing="0" cellpadding="5" >
  <tr> 
    <td align="center" valign="middle"> 
      <table border="1" cellspacing="0" cellpadding="2"  align="center">
        <form name="regForm" method="post" action="MemberUpdateProc.jsp">
          <!-- 직접 입력을 받는것이 아닌경우 hidden객체로 전달한다. -->
          <input type="hidden" name="mem_id"  value="<%=mem_id%>">
          <tr align="center" bgcolor="#07c"> 
            <td colspan="3"><font color="#FFFFFF"><b>회원 수정</b></font></td>
          </tr>
          <tr> <!-- 화면에 보이기만하고 전달은 안되는 이유는 input box에 출력X -->
            <td width="16%">아이디</td>
            <td width="57%"><%=mem.getMem_id() %></td>
            <td width="27%">아이디를 적어 주세요.</td>
          </tr>
          <tr> 
            <td>패스워드</td>
            <td> <input type="password" name="mem_passwd" size="15"
                  value="<%=mem.getMem_passwd()%>"> </td>
            <td>패스워드를 적어주세요.</td>
          </tr>
          
          <tr> 
            <td>이름</td>
            <td> <input type="text" name="mem_name" size="15"
                   value="<%=mem.getMem_name()%>"> </td>
            <td>고객실명을 적어주세요.</td>
          </tr>
          <tr> 
            <td>이메일</td>
            <td> <input type="text" name="mem_email" size="27"
                  value="<%=mem.getMem_email()%>"> </td>
            <td>이메일을 적어주세요.</td>
          </tr>
          <tr>  
            <td>전화번호</td>
            <td> <input type="text" name="mem_phone" size="20"
                value="<%=mem.getMem_phone()%>"> </td>
            <td>연락처를 적어 주세요.</td>
          </tr>
		  <tr>  
            <td>우편번호</td>
            <td> <input type="text" name="mem_zipcode" size="7"
                  value="<%=mem.getMem_zipcode()%>">
                 <input type="button" value="우편번호찾기" onClick="zipCheck()"></td>
            <td>우편번호를 검색 하세요.</td>
          </tr>
		  <tr>  
            <td>주소</td>
            <td><input type="text" name="mem_address" size="70"
                 value="<%=mem.getMem_address()%>"></td>
            <td>주소를 적어 주세요.</td>
          </tr>
		  <tr>  
            <td>직업</td>
            <!-- 콤보박스에 없는 값을 필드에 저장시키면 연결이
                   안된것처럼 나옴 -->
            <td><select name=mem_job>
 					<option value="0">선택하세요.
 					<option value="회사원">회사원
 					<option value="연구전문직">연구전문직
 					<option value="교수학생">교수학생
 					<option value="일반자영업">일반자영업
 					<option value="공무원">공무원
 					<option value="의료인">의료인
 					<option value="법조인">법조인
 					<option value="종교,언론,에술인">종교.언론/예술인
 					<option value="농,축,수산,광업인">농/축/수산/광업인
 					<option value="주부">주부
 					<option value="무직">무직
 					<option value="프로그래머">프로그래머
 					<option value="기타">기타
				  </select>
				   <script>
				    document.regForm.mem_job.value="<%=mem.getMem_job()%>"
				   </script>
				  </td>
            <td>직업을 선택 하세요.</td>
          </tr>
          <tr> 
            <td colspan="3" align="center"> 
             <input type="submit" value="수정완료"> 
              &nbsp; &nbsp; &nbsp; 
             <input type="reset" value="다시쓰기">&nbsp; &nbsp; &nbsp; 
             <input type="button" value="수정취소" onclick="history.back()"> 
            </td>
          </tr>
        </form>
      </table>
    </td>
  </tr>
</table>
		</center></div>
		
		<jsp:include page="/bottom.jsp" />
	
	</div><!-- 본문 전체 -->
</body>
</html>
