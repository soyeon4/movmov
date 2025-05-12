package kr.co.movmov.vo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("Report")
public class Report {

	private int no;
	private Category category;
	private String details;
	private User user;
	private String type;	// "post" / "comment"
	private int contentNo;
	
}
