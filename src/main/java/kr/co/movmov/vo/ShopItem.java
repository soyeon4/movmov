package kr.co.movmov.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("ShopItem")
public class ShopItem {
	
	private int id;
	private String name;
	private String component;
	private String description;
	private int price;
	private int discountRate;
	private int stock;
	private String soldOut;
	private String imagePath;
	private Date createdDate;
	private Date updatedDate;
	private String hasOption;
	private int imageCount;
	

	private int categoryNo;
	private ShopCategory category;
	
	private int sellerId;
	private ShopSeller seller;
	
}
