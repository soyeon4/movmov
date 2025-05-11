package kr.co.movmov.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class Address {

	private int id;
	private String name;
	private String road;
	private String detail;
	private User user;	
}

