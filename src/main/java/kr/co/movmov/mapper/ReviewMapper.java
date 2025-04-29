package kr.co.movmov.mapper;

import java.util.List;

import kr.co.movmov.vo.Review;

public interface ReviewMapper {
	
	List<Review> getReviewsByUserId(String userId);

	List<Review> getReviewsByMovieNo(int movieNo);
	
	Review getReviewByUserIdAndMovieNo(String userId, int movieNo);
}
