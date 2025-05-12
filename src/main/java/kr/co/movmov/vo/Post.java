package kr.co.movmov.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("Post")
public class Post {

	private int no;
	private User user;
	private Category header;
	private Category boardType;
	private String title;
	private String content;
	private Date createdDate;
	private Date updatedDate;
	private int viewCount;
	private int upvoteCount;
	private int commentCount;
	private String isDeleted;
	private String isReported;
	private String isSpoiler;
	private int reportCount;
	
}
