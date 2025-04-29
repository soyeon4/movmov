package kr.co.movmov.mapper;

import java.util.List;
import java.util.Map;

import kr.co.movmov.vo.Movie;

public interface MovieMapper {
	
	int getTotalRows(Map<String, Object> condition);
	
	List<Movie> getMovies();
	
	Movie getMovieByNo(int no); 
}
