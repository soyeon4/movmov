package kr.co.movmov.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("Faq")
public class Faq {
	int id;
	Category category;
	String title;
	String content;
	Date createdDate;
	Date updatedDate;
}
