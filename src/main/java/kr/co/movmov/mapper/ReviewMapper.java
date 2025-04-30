package kr.co.movmov.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.movmov.vo.Review;

public interface ReviewMapper {
	
	List<Review> getReviewsByUserId(String userId);

	List<Review> getReviewsByMovieNo(int movieNo);
	
	Review getReviewByUserIdAndMovieNo(@Param("userId") String userId, @Param("movieNo") int movieNo);
	
	void insertReview(Review review);
	
	void updateReview(Review review);
}
