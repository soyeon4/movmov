package kr.co.movmov.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("ShopCartItem")
public class ShopCartItem {

	private int no;
	private int quantity;
	private Date createdDate;
	private Date updatedDate;
	
	// private String userId;
	private User user;
	
	// private int itemNo;
	private ShopItem item;
	
	// private int optionNo;
	private ShopItemOption option;
	
	public int getOrderPrice() {
		return item.getPrice()*quantity;
	}
}
