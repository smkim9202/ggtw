package board;

//DBConnectionMgr(DB접속,관리) ,BoardDTO(매개변수,반환형(객체),레코드 담는 역할)

import java.sql.*;//DB사용
import java.util.*;//ArrayList,List을 사용

public class BoardDAO {

	private DBConnectionMgr pool=null;//1.연결객체를 선언(멤버변수)
	//공통->메서드
	private Connection con=null;
	private PreparedStatement pstmt=null;//sql구문
	private ResultSet rs=null;//select구문의 결과값(table형태)
	private String sql="";//실행시킬 SQL구문 저장
	
	//2.생성자를 통해서 상대방의 객체생성=>의존관계(ex 바늘과 실)
	public BoardDAO() {
		try {
			pool=DBConnectionMgr.getInstance();//상대방객체명 사용가능
		}catch(Exception e) {
			System.out.println("DB접속 오류=>"+e);
		}
	}
	//3.업무에 따라서 호출메서드를 작성->비즈니스 로직
	//1.페이징 처리를 위한 전체 레코드수를 구해와야한다.
	//select count(*) from board->select count(*) from member
	public int getArticleCount() { //getMemberCount()->MemberDAO
		int x=0;
		try {
			con=pool.getConnection();
			System.out.println("con=>"+con);
			sql="select count(*) from board";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {//레코드갯수(1개이상)존재한다면
				x=rs.getInt(1);//변수명=rs.get자료형(필드명 또는 인덱스번호)=>필드명X
			}
		}catch(Exception e) {
			System.out.println("getArticleCount() 에러유발=>"+e);
		}finally {
			pool.freeConnection(con,pstmt,rs);
		}
		return x;
	}
	//2.글목록보기에 대한 메서드구현->레코드 한개이상->한 페이지당 10개씩 끊어서 보여준다
	//1)레코드의 시작번호  2)불러올 레코드의 갯수(끝번호가 아님X)
	public List getArticles(int start,int end) {//getArticles(int start,int end)
		List articleList=null;//ArrayList articleList=null;
		
		try {
			con=pool.getConnection();
			/*
			 * 그룹번호가 가장 최신의 글을 중심으로 정렬하되(내림차순),만약에 level이 
			 * 같은 경우에는 step값으로 오름차순을 통해서 몇번째 레코드번호를  기준해서
			 * 몇개까지 정렬할것인가를 지정해주는 SQL구문
			 * select * from member order by id,name desc limit ?,?
			 */
			sql="select * from"
					+ "(select  rownum rnum, num, writer, email, subject, passwd, reg_date,"
					+ "readcount, ref, re_step, re_level, content, ip "
					+ "from board "
					+ "order by ref desc,re_step) "
					+ "where rnum >= ? and rnum <= ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1,start-1);//mysql은 레코드순번이 내부적으로 0부터 시작
			pstmt.setInt(2, end);//불러와서 담을 갯수(ex 10개)
			rs=pstmt.executeQuery();
			if(rs.next()) {//보여주는 결과가 있다면=>최소 1개는 존재
				articleList=new ArrayList(end);//10=>end갯수만큼 데이터를 담을공간 생성
				do {
					BoardDTO article=new BoardDTO();//MemberDTO mem=>필드별로 담을것.
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setEmail(rs.getString("email"));
					article.setSubject(rs.getString("subject"));
					article.setPasswd(rs.getString("passwd"));
					article.setReg_date(rs.getTimestamp("reg_date"));//오늘날짜
					article.setReadcount(rs.getInt("readcount"));//조회수->0
					article.setRef(rs.getInt("ref"));//그룹번호->신규-답변글을 묶어주는 역할
					article.setRe_step(rs.getInt("re_step"));//답변글의 나오는 순서(y축)
					article.setRe_level(rs.getInt("re_level"));//들여쓰기(답변의 깊이)
					article.setContent(rs.getString("content"));//글내용
					article.setIp(rs.getString("ip"));//원격주소 ip주소
					//추가
					articleList.add(article);//생략하면 데이터가 저장X->for문 에러유발
				}while(rs.next());
			}
		}catch(Exception e) {
			System.out.println("getArticles() 에러유발=>"+e);
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return articleList;
	}

	//---게시판의 글쓰기 및 답변달기
	//insert into board values(?,?,,,,)
	public void insertArticle(BoardDTO article) {//~(MemberDTO mem)
		//1.article->신규글인지 답변글인지 확인
		int num=article.getNum();//신규글 (0)  답변글이면 0이 아니다
		int ref=article.getRef();
		int re_step=article.getRe_step();
		int re_level=article.getRe_level();
		
		int number=0;//데이터를 저장하기위한 게시물번호(new)
		System.out.println("insertArticle의 내부 num="+num);//0 신규글
		System.out.println("ref="+ref+",re_step=>"
		                             +re_step+",re_level"+re_level);
		
		try {
			con=pool.getConnection();
			sql="select max(num) from board";//4
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {//데이터가 있는 경우
				number=rs.getInt(1)+1;//최대값+1->2,3,4,5,,,,
			}else {//데이터가 없는 경우
				number=1;
			}
			//답변글이라면
			if(num!=0) {//양수이면서 1이상
				//같은 그룹번호를 가지고 있으면서 나보다 step값이 큰 게시물을 찾아서 그 step하나 증가
			  sql="update board set re_step=re_step+1 where ref=? and re_step >?";
			  pstmt=con.prepareStatement(sql);
			  pstmt.setInt(1, ref);
			  pstmt.setInt(2, re_step);
			  int update=pstmt.executeUpdate();
			  System.out.println("댓글수정유무(update)=>"+update);//1.성공, 0(실패)
			  //답변글
			  re_step=re_step+1;
			  re_level=re_level+1;
			}else {//신규글이라면 num=0;(list.jsp->글쓰기)
				ref=number;//1,2,3,4,,,,
				re_step=0;
				re_level=0;
			}
			//12개->num,reg_date,readcount(생략)->default
			//작성날짜->sysdate,now()을 이용해서 직접	 작성가능 (mysql)->num,readcount
			sql="insert into board(writer,email,subject,passwd,reg_date,";
			sql+=" ref,re_step,re_level,content,ip,num) values (?,?,?,?,?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, article.getWriter());//웹에서 이미 데이터 저장된 상태
			pstmt.setString(2, article.getEmail());
			pstmt.setString(3, article.getSubject());
			pstmt.setString(4, article.getPasswd());
			pstmt.setTimestamp(5, article.getReg_date());//5번째에 ? 대신에 now()
			//------------ref,re_step,re_level에 대한 계산이 적용된 상태에서 저장
			pstmt.setInt(6,ref);//5
			pstmt.setInt(7,re_step);//0
			pstmt.setInt(8,re_level);//0
			//----------------------------------------------
			//System.out.println("article.getContent()=>"+article.getContent());//null
			pstmt.setString(9, article.getContent());//내용
			pstmt.setString(10, article.getIp());//request.getRemoteAddr();
			pstmt.setInt(11, number);
			int insert=pstmt.executeUpdate();
			System.out.println("게시판의 글쓰기 성공유무(insert)=>"+insert);
		}catch(Exception e) {
			System.out.println("insertArticle()메서드 에러유발=>"+e);
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	//3.글상세보기
	//<a href="content.jsp?num=3&pageNum=1">
	//형식1)select * from board where num=3;
	//형식2)update board set readcount=readcount+1 where num=3;
	//public MemberDTO getMember(String id){~}
	public BoardDTO getArticle(int num) {
       BoardDTO article=null;//ArrayList articleList=null;
		
		try {
			con=pool.getConnection();
			
			sql="update board set readcount=readcount+1 where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1,num);//mysql은 레코드순번이 내부적으로 0부터 시작
			int update=pstmt.executeUpdate();
			System.out.println("조회수 증가유무(update)="+update);
			
			sql="select * from board where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1,num);//mysql은 레코드순번이 내부적으로 0부터 시작
			rs=pstmt.executeQuery();
			
			if(rs.next()) {//보여주는 결과가 있다면=>최소 1개는 존재
				   article=makeArticleFromResult();
				  /*  따로 메서드로 뽑아내서 메서드로 호출하기위해서
				    article=new BoardDTO();//MemberDTO mem=>필드별로 담을것.
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setEmail(rs.getString("email"));
					article.setSubject(rs.getString("subject"));
					article.setPasswd(rs.getString("passwd"));
					article.setReg_date(rs.getTimestamp("reg_date"));//오늘날짜
					article.setReadcount(rs.getInt("readcount"));//조회수->0
					article.setRef(rs.getInt("ref"));//그룹번호->신규-답변글을 묶어주는 역할
					article.setRe_step(rs.getInt("re_step"));//답변글의 나오는 순서(y축)
					article.setRe_level(rs.getInt("re_level"));//들여쓰기(답변의 깊이)
					article.setContent(rs.getString("content"));//글내용
					article.setIp(rs.getString("ip"));//원격주소 ip주소
				  */
			}
		}catch(Exception e) {
			System.out.println("getArticle() 에러유발=>"+e);
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return article;
	}
	//---중복된 레코드 한개를 담을 수 있는 메서드를 따로 만들어서 처리------
	private BoardDTO makeArticleFromResult() throws Exception{
		    BoardDTO article=new BoardDTO();//MemberDTO mem=>필드별로 담을것.
			article.setNum(rs.getInt("num"));
			article.setWriter(rs.getString("writer"));
			article.setEmail(rs.getString("email"));
			article.setSubject(rs.getString("subject"));
			article.setPasswd(rs.getString("passwd"));
			article.setReg_date(rs.getTimestamp("reg_date"));//오늘날짜
			article.setReadcount(rs.getInt("readcount"));//조회수->0
			article.setRef(rs.getInt("ref"));//그룹번호->신규-답변글을 묶어주는 역할
			article.setRe_step(rs.getInt("re_step"));//답변글의 나오는 순서(y축)
			article.setRe_level(rs.getInt("re_level"));//들여쓰기(답변의 깊이)
			article.setContent(rs.getString("content"));//글내용
			article.setIp(rs.getString("ip"));
			return article;
	}
	
	//----------------------------------------------------------------
	//4.글수정하기위한 데이터 찾아서 보여주기
	//형식)select * from board where num=?(3)
	public BoardDTO updateGetArticle(int num) {
		  BoardDTO article=null;
			//조회수 증가X
			try {
				con=pool.getConnection();
				sql="select * from board where num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1,num);//mysql은 레코드순번이 내부적으로 0부터 시작
				rs=pstmt.executeQuery();
				if(rs.next()) {//보여주는 결과가 있다면=>최소 1개는 존재
					 article=makeArticleFromResult();   
				}
			}catch(Exception e) {
				System.out.println("updateGetArticle() 에러유발=>"+e);
			}finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return article;//updateForm.jsp에서 호출
	}
	
	//5.글수정하기=>본인인지 확인절차=>회원탈퇴(암호를 비교=>탈퇴)와 동일한 기능
	//글수정하기=글쓰기와 동일한 구조
	public int updateArticle(BoardDTO article) {//insertArticle(BoardDTO article)
		
		String dbpasswd=null;//db에서 찾은 암호를 저장
		int x=-1;//게시물의 수정성공유무
		
		try {
			con=pool.getConnection();
			sql="select passwd from board where num=?";//4
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, article.getNum());
			rs=pstmt.executeQuery();
			if(rs.next()) {//데이터가 있는 경우
				dbpasswd=rs.getString("passwd");
				System.out.println("dbpasswd=>"+dbpasswd);//확인한 후에 삭제
				if(dbpasswd.equals(article.getPasswd())) {
					sql="update board set writer=?,email=?,subject=?,passwd=?,";
					sql+=" content=?  where num=?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, article.getWriter());//웹에서 이미 데이터 저장된 상태
					pstmt.setString(2, article.getEmail());
					pstmt.setString(3, article.getSubject());
					pstmt.setString(4, article.getPasswd());
					pstmt.setString(5, article.getContent());//내용
					pstmt.setInt(6, article.getNum());
					
					int update=pstmt.executeUpdate();
					System.out.println("게시판의 글수정 성공유무(update)=>"+update);
					x=1;//글수정 성공
				}else {//암호가 틀린경우
					x=0;//수정실패
				}
			}//if(rs.next())
		}catch(Exception e) {
			System.out.println("updateArticle()메서드 에러유발=>"+e);
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return x;//updatePro.jsp에서 반환을 받음 x
	}
	
	//6.글삭제하기->회원탈퇴(=글수정하기)와 기능이 동일
	//형식)select passwd from board where num=?
	//형식2)delete from board where num=?
	public int deleteArticle(int num,String passwd) {
		
		String dbpasswd=null;//db에서 찾은 암호를 저장
		int x=-1;//게시물의 삭제성공유무
		
		try {
			con=pool.getConnection();
			sql="select passwd from board where num=?";//4
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);//No value specified parameter 1(매개변수에 대한값이 없을때) 
			rs=pstmt.executeQuery();
			if(rs.next()) {//데이터가 있는 경우
				dbpasswd=rs.getString("passwd");
				System.out.println("dbpasswd=>"+dbpasswd);//확인한 후에 삭제
				if(dbpasswd.equals(passwd)) {//db에 저장된암호==웹상의 암호
					sql="delete from board where num=?";
					pstmt=con.prepareStatement(sql);
					pstmt.setInt(1, num);//웹에서 이미 데이터 저장된 상태
					int delete=pstmt.executeUpdate();
					System.out.println("게시판의 글삭제 성공유무(delete)=>"+delete);
					x=1;//글삭제 성공
				}else {//암호가 틀린경우
					x=0;//삭제실패
				}
			}//if(rs.next())
		}catch(Exception e) {
			System.out.println("deleteArticle()메서드 에러유발=>"+e);
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return x;//deletePro.jsp에서 반환을 받음 x
	}
	//
}





