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
}
