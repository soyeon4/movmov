package kr.co.movmov.vo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@Alias("MovieGenreMap")
public class MovieGenreMap {
	private Movie movie;
	private Genre genre;
}
