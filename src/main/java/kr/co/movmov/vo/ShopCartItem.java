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
	
	// private String user_id;
	private User user;
	
	// private int item_id;
	private ShopItem item;
	
	// private int option_id;
	private ShopItemOption option;
}
