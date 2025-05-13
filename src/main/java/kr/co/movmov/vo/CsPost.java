package kr.co.movmov.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("CsPost")
public class CsPost {
	int id;
	String postType;
	Category category;
	String title;
	String content;
	int postTop;
	Date createdDate;
	Date updatedDate;
	int viewCount;
}