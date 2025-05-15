package kr.co.movmov.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import kr.co.movmov.vo.Review;

public interface ReviewMapper {
	
	List<Review> getReviewsByUserId(String userId);

	List<Review> getReviewsByMovieNo(int movieNo);
	
	List<Review> getReviewsByUserIdSort(Map<String, Object> condition);
	
	Review getReviewByUserIdAndMovieNo(@Param("userId") String userId, @Param("movieNo") int movieNo);
	
	Review getReviewByReviewNo(int reviewNo);
	
	void insertReview(Review review);
	
	void updateReview(Review review);
	
	void updateReviewLikeCnt(Review review);
	
	void deleteReview(int reviewNo);
	
	int getTotalRows(Map<String, Object> condition);
	
	List<Review> getReviews(Map<String, Object> condition);

	int getTotalReviewRowsByUserId(String userId);
	
}
