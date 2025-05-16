package kr.co.movmov.mapper;

import java.util.List;
import java.util.Map;

import kr.co.movmov.vo.Movie;

public interface MovieMapper {
	
	int getTotalRows(Map<String, Object> condition);
	
	List<Movie> getMovies(Map<String, Object> condition);
	
	Movie getMovieByNo(int no); 
	
	void updateMovieReviewCntOrWishCnt(Movie movie);

}
