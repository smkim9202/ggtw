<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*,hewon.*"%>
<!DOCTYPE html>
<jsp:useBean id="memMgr" class="hewon.MemberDAO" />
<%
  //script.js=>ZiCheck()=>ZipCheck.jsp?check=y =>Get방식으로 전달
  request.setCharacterEncoding("utf-8");//한글처리
  
  String check=request.getParameter("check");//y->n
  String area3=request.getParameter("area3");
  System.out.println("ZipCheck.jsp의 check="+check+",area3=>"+area3);
  ArrayList<ZipcodeDTO> zipcodeList=memMgr.zipcodeRead(area3);
  int totalList=zipcodeList.size();
  System.out.println("검색된 총레코드수(totalList)=>"+totalList);//14
  
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>우편번호 검색</title>
<link href="../css/style.css" rel="stylesheet"  type="text/css">
<script>
//동이름을 체크할 함수선언
  function dongCheck(){
	  if(document.zipForm.area3.value==""){
		  alert("동이름을 먼저 입력하세요!");
		  document.zipForm.area3.focus();
		  return;
	  }
	  document.zipForm.submit();//action="ZipCheck.jsp"로 전송하라
  }
  //검색된 레코드중에서 내주소와 가장 가까운 주소를 링크클릭
  //형식) Register.jsp(부모창)의 특정항목에 값을 넣어주는 함수=>부모창(opener), 자식창(self)
  //형식2)opener.document.폼객체명.입력양식.속성=값
  function sendAddress(zipcode,area1,area2,area3,area4){
	  var address=area1+" "+area2+" "+area3+" "+area4;
	  opener.document.regForm.mem_zipcode.value=zipcode;
	  opener.document.regForm.mem_address.value=address;
	  self.close();//self=>ZipCheck.jsp(자식창)
  }
</script>
</head>
<body>
  <center>
  	<br><br><br>
    <b>우편번호 찾기</b>
    <table>
   <form name="zipForm" method="post"  action="ZipCheck.jsp">
        <tr>
        <td><br>
        동이름 입력:<input type="text"  name="area3">
        <input type="button" value="검색"
                   onclick="dongCheck()">
        </td>
        </tr>    
        <!-- form태그내부에서 값을 입력하지 않고도 특정데이터값을 전달(hidden 객체)
               name="전달할 매개변수명" value="전달할값"
          -->
        <input type="hidden" name="check" value="n">
   </form>
 <%
     //검색어를 입력하고 검색버튼을 눌렀다면
     if(check.equals("n")){
    	 if(zipcodeList.isEmpty()){//검색된 레코드가 없다면
    	  //if(zipcodeList.size()==0){
 %>
      <tr><td align="center">
            <br>검색된 레코드가 없습니다.
          </td>
      </tr>
   <%}else { %>
   <tr><td align="center"><br>
   *검색후 ,아래 우편번호를 클릭하면 자동으로
     입력됩니다</td></tr>
  <%
      for(int i=0;i<totalList;i++){
    	  ZipcodeDTO zipBean=zipcodeList.get(i);//zipcodeList.elementAt(i);
    	  String tempZipcode=zipBean.getZipcode();//우편번호
    	  String tempArea1=zipBean.getArea1().trim();//시 ->"서울      "->"서울"
    	  String tempArea2=zipBean.getArea2().trim();//구
    	  String tempArea3=zipBean.getArea3().trim();//동
    	  String tempArea4=zipBean.getArea4().trim();//나머지
  %>
  <tr><td>
          <a href="JavaScript:sendAddress('<%=tempZipcode%>',
                                                           '<%=tempArea1%>',
                                                           '<%=tempArea2%>',
                                                           '<%=tempArea3%>',
                                                           '<%=tempArea4%>')">
          <%=tempZipcode%>&nbsp;<%=tempArea1%>&nbsp;
          <%=tempArea2%>&nbsp;<%=tempArea3%>&nbsp;
          <%=tempArea4%>
  </a><br>
   <%
           }//for
        } //inner if
     }//outer if
   %>
    </td></tr>
    <tr><td align="center"><br>
<a href="JavaScript:this.close()">닫기</a>                      
    </table>
  </center>
</body>
</html>