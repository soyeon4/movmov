package kr.co.movmov.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@Alias("Review")
public class Review {
	private int no;
	private int star;
	private String comment;
	private Date createdDate;
	private Date updatedDate;
	private User user;
	private Movie movie;
	private String openStatus;
	private int likeCnt;
}
