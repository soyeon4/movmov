package kr.co.movmov.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class Address {

	private int id;
	private String addressName;
	private String road;
	private String detail;
	private User user;	
	private String receiverPhone;
	private String receiverName;
	private String zipcode;
}