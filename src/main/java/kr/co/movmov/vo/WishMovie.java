package kr.co.movmov.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@Alias("WishMovie")
public class WishMovie {
	private int no;
	private User user;
	private Movie movie;
	private Date createdDate;
}
