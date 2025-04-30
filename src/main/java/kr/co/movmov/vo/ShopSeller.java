package kr.co.movmov.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("ShopSeller")
public class ShopSeller {
	private int id;
	private String name;
}
