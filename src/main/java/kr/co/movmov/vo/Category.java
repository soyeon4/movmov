package kr.co.movmov.vo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("Category")
public class Category {
	private int id;
	private String name;
	private String type;
}
