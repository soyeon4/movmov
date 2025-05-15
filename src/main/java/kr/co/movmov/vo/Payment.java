package kr.co.movmov.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class Payment {
	private int payId;
	private int payStatusId;
	private User user;
	private ShopItem item; 
	private ShopItemOption option; 
	private int payAmount;
	private Date payDate;
	private int ptUseAmount;
	private int ptEarnAmount;
	private Address address;
	private int payMethodId;
	private String request;
	private int itemQuantity;
}