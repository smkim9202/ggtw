package hewon;

//DTO 작성->1.테이블에 있는 필드별로 저장,조회하기위해서 필요
//                2.메서드의 매개변수형,반환형을 지정하기위해서 필요(Call By Reference)

public class ZipcodeDTO {
                         //우편번호  시,도   소도시, 읍면동, 나머지 주소
	private String zipcode,area1,area2,area3,area4;

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getArea1() {
		return area1;
	}

	public void setArea1(String area1) {
		this.area1 = area1;
	}

	public String getArea2() {
		return area2;
	}

	public void setArea2(String area2) {
		this.area2 = area2;
	}

	public String getArea3() {
		return area3;
	}

	public void setArea3(String area3) {
		this.area3 = area3;
	}

	public String getArea4() {
		return area4;
	}

	public void setArea4(String area4) {
		this.area4 = area4;
	}
}
