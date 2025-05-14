package kr.co.movmov.vo;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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
	
	private List<Comment> replies = new ArrayList<>();
	
	// 모든 답글 불러오는 유틸리티 메소드
	public int getTotalNestedCount() {
		int count = 1;
		for (Comment reply : replies) {
			count += reply.getTotalNestedCount();
		}
		return count;
	}
}
