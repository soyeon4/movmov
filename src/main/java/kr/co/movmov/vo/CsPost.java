package kr.co.movmov.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("CsPost")
public class CsPost {

	private int id;
	private String postType;
	private Category category;
	private String title;
	private String content;
	private int postTop;
	private Date createdDate;
	private Date updatedDate;
	private int viewCount;
	
}