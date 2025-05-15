package kr.co.movmov.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@Alias("ReviewLike")
public class ReviewLike {
	private int no;
	private Review review;
	private User user;
	private Date createdDate; 
}
