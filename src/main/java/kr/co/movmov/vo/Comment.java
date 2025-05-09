package kr.co.movmov.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("Comment")
public class Comment {
	
	private int no;
	private int postNo;
	private User user;
	private String content;
	private Date createdDate;
	private Date updatedDate;
	private String isDeleted;
	private String isReported;
	private int parentCommentNo;
	private int reportCount;
	
}
