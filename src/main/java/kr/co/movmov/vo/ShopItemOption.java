package kr.co.movmov.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("ShopItemOption")
public class ShopItemOption {

	private int optionId;
	private String optionName;
	private int stock;
	
	private int itemId;
	private ShopItem item;
	
}
