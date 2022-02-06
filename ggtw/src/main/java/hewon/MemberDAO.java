package hewon;

//DB에 연결해서 웹상에서 호출할 메서드들만 따로 사용할 수 있도록 설계된 클래스
//업무에 따라서 클래스들끼리 연결해서 사용하는 방법=>has a 관계(객체생성=>상대방의 메서드가 필요)
import java.sql.*;//DB관련
import java.util.*;//자료구조->Vector,ArrayList,HashMap~

public class MemberDAO {

	//1.멤버변수에 연결할 클래스의 객체를 선언(예약)
	private DBConnectionMgr pool=null;//getConnection(),freeConnection()필요
	
	//2-2.모든 메서드에서 공통으로 사용할 멤버변수
	private Connection con=null;
	private PreparedStatement pstmt=null;//SQL구문실행목적
	private ResultSet rs=null;//select구문때문에 
	private String sql="";//실행시킬 SQL구문 저장목적(SQL구문 자체는 문자이다.)
	
	//2.생성자를 통해서 자동으로 객체를 생성->연결
	public MemberDAO() {//상대방(DBConnectionMgr)의 객체를  얻어오는구문 사용
		try {
			pool=DBConnectionMgr.getInstance();//정적메서드
			//pool=new DBConnectionMgr();//일반메서드라면
			System.out.println("pool=>"+pool);
		}catch(Exception e) {
			System.out.println("DB연결실패=>"+e);//e.toString()
		}
	}
	//3.업무분석에 따른 웹상에서 호출할 메서드를 작성=>반복
	//1)회원로그인->id,passwd(nup,1234)
	//select id,passwd from member where id='nup' and passwd='1234';
	//select->메서드의 반환값 O(int or boolean) where 조건식->매개변수가 존재 2개
	public boolean loginCheck(String id,String passwd) {
		//1.DB연결
		boolean check=false;
		//2.SQL구문(insert,update,select,delete~)
		try {
			con=pool.getConnection();//이미 만들어서 Connection 반환
			System.out.println("con=>"+con);
			sql="select id,passwd from member where id=? and passwd=?";
			pstmt=con.prepareStatement(sql);//~prepareStatment(실행시킬 sql구문)
			pstmt.setString(1, id);//매개변수로 전달(1.?의 순서 2.저장할값)
			pstmt.setString(2, passwd);
			rs=pstmt.executeQuery();
			check=rs.next();//데이터가 존재=>true or 없으면 false
		}catch(Exception e) {
			System.out.println("loginCheck() 실행에러유발=>"+e);//e.toString()
		}finally {
		//3.DB연결해제=>rs.close(); pstmt.close(),con.close();
			pool.freeConnection(con, pstmt, rs);
		}
		return check;//LoginProc.jsp에서 호출한경우
	}
	//2)중복id를 체크해주는 메서드(p446)=>sql구문먼저 찾아본다.(오류시)
	//select id from member where id='kkk';
	public boolean  checkId(String id) {
		boolean check=false;//초기값=>지역변수
		try {
			con=pool.getConnection();//연결객체를 대여받음
			sql="select id from member where id=?";//? 실시간으로 전달받음
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);//index~ 에러유발,//NullPointerException이 발생
			rs=pstmt.executeQuery();//select구문을 실행
			check=rs.next();//true or false
			System.out.println("checkId메서드의 check=>"+check);
		}catch(Exception e) {//}catch(SQLException e){
			System.out.println("checkId() 실행오류=>"+e);
		}finally {
		    pool.freeConnection(con, pstmt, rs);	
		}
		return check;
	}
	
	//3)우편번호 검색
	//select * from zipcode where area3 like '미아2동%'
	//public Vector<ZipcodeDTO>~
	//레코드 단위로 저장(DTO)->ArrayList(배열)
	//=>조회하기 쉽게 하기위해서(웹에 출력하기편하게 하기위한)
	public ArrayList<ZipcodeDTO> zipcodeRead(String area3){
		//레코드 한개이상 담을 변수(객체)선언
		ArrayList<ZipcodeDTO> zipList=new ArrayList();//미리 생성하기
		try {
			con=pool.getConnection();
			//sql="select * from zipcode where area3 like '미아2동%'";
			sql="select * from zipcode where area3 like '"+area3+"%'";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			System.out.println("검색된 sql구문확인=>"+sql);//?=>전달받은 매개변수를 확인X
			//검색된 레코드들을 필드별로 ArrayList을 담는 구문
			while(rs.next()) {//검색된 레코드를 보여줄 수 있는 동안
				ZipcodeDTO tempZipcode=new ZipcodeDTO();
				tempZipcode.setZipcode(rs.getString("zipcode"));//"142-813"
				tempZipcode.setArea1(rs.getString("area1"));
				tempZipcode.setArea2(rs.getString("area2"));// null
				tempZipcode.setArea3(rs.getString("area3"));// null
				tempZipcode.setArea4(rs.getString("area4"));// null
				//ArrayList에 담는 구문을 작성=>화면에 zipList객체가 null이 출력 0개
				zipList.add(tempZipcode);
			}	
		}catch(Exception e) {
			System.out.println("zipcodeRead() 실행오류=>"+e);
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return zipList;//ZipCheck.jsp에서 메서드의 반환값->for문(필드별로 출력)
	}
	//4)회원가입
	//insert into member values(?,?~)=>반환값X ->매개변수가 8개
	//(String id,String passwd,~String job)->객체지향프로그래밍 방식
	//public seScan(Scanner sc)
	public boolean memberInsert(MemberDTO mem) {
		boolean check=false;//회원가입 성공유무
		try {
			con=pool.getConnection();//연결객체를 대여받음
			//--트랜잭션->오라클의 필수->자동으로 commit X
			con.setAutoCommit(false);//default->con.setAutoCommit(true);
			//----------------------------------------------
			sql="insert into member values(?,?,?,?,?,?,?,?)";//? 실시간으로 전달받음
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, mem.getMem_id());//index~ 에러유발,//NullPointerException이 발생
			pstmt.setString(2, mem.getMem_passwd());
			pstmt.setString(3, mem.getMem_name());
			pstmt.setString(4, mem.getMem_email());
			pstmt.setString(5, mem.getMem_phone());
			pstmt.setString(6, mem.getMem_zipcode());
			pstmt.setString(7, mem.getMem_address());
			pstmt.setString(8, mem.getMem_job());
			
			int insert=pstmt.executeUpdate();//반환값->1(성공), 0 (실패)
			con.commit();//수동으로 commit()
			System.out.println("insert(데이터 입력유무)=>"+insert);
			if(insert > 0) {//if(insert==1){
				check=true;//데이터 성공확인
			}
		}catch(Exception e) {//}catch(SQLException e){
			System.out.println("memberInsert() 실행오류=>"+e);
		}finally {
		    pool.freeConnection(con, pstmt);	
		}
		return check;//memberInsert.jsp에서 메서드의 반환값으로 확인(성공유무)
	}
	//5)회원수정->특정 회원 찾기(nup,test,imsi,,,,)
	//select * from member where id='nup';=>매개변수 O ,반환형 O
	//public Scanner getScan(){}
	public MemberDTO getMember(String mem_id) {
		MemberDTO mem=null;//id값에 해당되는 레코드 한개를 저장할 객체선언
		try {
			con=pool.getConnection();//연결객체를 대여받음
			sql="select * from member where id=?";//? 실시간으로 전달받음
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, mem_id);
			rs=pstmt.executeQuery();//select구문을 실행
			//id값에 해당되는 레코드 한개를 if(rs.next())->한개이상=>while(rs.next())
			if(rs.next()) {
				//찾은값->Setter메서드의 매개변수로 저장->웹에 출력->Getter Method
				mem=new MemberDTO();
				mem.setMem_id(rs.getString("id"));
				mem.setMem_passwd(rs.getString("passwd"));
				mem.setMem_name(rs.getString("name"));
				mem.setMem_phone(rs.getString("phone"));
				mem.setMem_zipcode(rs.getString("zipcode"));
				mem.setMem_address(rs.getString("address"));
				mem.setMem_email(rs.getString("e_mail"));//필드명이 틀리면 에러유발 O
				mem.setMem_job(rs.getString("job"));
			}
		}catch(Exception e) {//}catch(SQLException e){
			System.out.println("getMember() 실행오류=>"+e);
		}finally {
		    pool.freeConnection(con, pstmt, rs);	
		}
		return mem;//MemberUpdate.jsp에서 받아서 필드별로 출력
	}
	//6)찾은 회원을 수정->insert메서드와 동일(sql구문이 틀리다)
	public boolean memberUpdate(MemberDTO mem) {//SangDTO sang
		boolean check=false;//회원수정 성공유무
		try {
			con=pool.getConnection();//연결객체를 대여받음
			//--트랜잭션->오라클의 필수->자동으로 commit X
			con.setAutoCommit(false);
			//----------------------------------------------
            sql="update member set passwd=?,name=?,e_mail=?,phone=?,"
					+" zipcode=?,address=?,job=? where id=?";//? 실시간으로 전달받음
			pstmt=con.prepareStatement(sql);
			
			pstmt.setString(1, mem.getMem_passwd());
			pstmt.setString(2, mem.getMem_name());
			pstmt.setString(3, mem.getMem_email());
			pstmt.setString(4, mem.getMem_phone());
			pstmt.setString(5, mem.getMem_zipcode());
			pstmt.setString(6, mem.getMem_address());
			pstmt.setString(7, mem.getMem_job());
			pstmt.setString(8, mem.getMem_id());//null
			
			int update=pstmt.executeUpdate();//반환값->1(성공), 0 (실패)
			con.commit();//수동으로 commit()
			System.out.println("update(데이터 수정유무)=>"+update);
			if(update==1) {
				check=true;//데이터 수정성공확인
			}
		}catch(Exception e) {//}catch(SQLException e){
			System.out.println("memberUpdate() 실행오류=>"+e);
		}finally {
		    pool.freeConnection(con, pstmt);	
		}
		return check;//MemberUpdate.jsp에서 메서드의 반환값으로 확인(성공유무)
	}
	
	//7)회원탈퇴->비밀번호를 확인절차(id값을 이용)->delete from  member where id=?
	public int memberDelete(String id,String passwd) {
		String dbpasswd="";//DB상에서 찾은 암호를 저장
		int x=-1;//회원탈퇴유무
		
		try {
			con=pool.getConnection();
			con.setAutoCommit(false);//트랜잭션처리
			sql="select passwd from member where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1,id);
			rs=pstmt.executeQuery();
			//암호를 찾았다면 
			if(rs.next()) {
				dbpasswd=rs.getString("passwd");
				System.out.println("dbpasswd=>"+dbpasswd);
				//dbpasswd(DB상암호)=웹상의 암호(passwd)
				if(dbpasswd.equals(passwd)) {
					sql="delete from member where id=?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1,id);
					int delete=pstmt.executeUpdate();
					System.out.println("delete(회원탈퇴 성공유무)=>"+delete);//1 or 0
					con.commit();//실제테이블에 반영
					x=1;//회원탈퇴 성공
				}else {
					x=0;//회원탈퇴 실패=>암호가 틀려서
				}
			}else {//암호가 존재하지 않은 경우
				x=-1;
			}
		}catch(Exception e) {
			System.out.println("memberDelete() 실행오류=>"+e);
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return x;
	}
	
}
