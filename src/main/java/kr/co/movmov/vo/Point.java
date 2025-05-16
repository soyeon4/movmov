package kr.co.movmov.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class Point {
	private int id;
	private int pointChangeAmount;
	private int typeId;
	private Payment payment;
	private int totalPoint;
	private User user;
	private Date createdAt;
	
	public String getPointType() {
		if(typeId == 100) {
			return "포인트 사용";
		}
		else if(typeId == 101) {
			return "구매적립";
		}
		
		else if(typeId == 102) {
			return "결제적립";
		}
		else {
			return "";
		}
	}
}

