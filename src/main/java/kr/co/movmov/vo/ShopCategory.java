package kr.co.movmov.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("ShopCategory")
public class ShopCategory {
	private int no;
	private String name;
}
