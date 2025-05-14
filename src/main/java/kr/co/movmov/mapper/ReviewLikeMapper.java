package kr.co.movmov.mapper;

import org.apache.ibatis.annotations.Param;

import kr.co.movmov.vo.ReviewLike;

public interface ReviewLikeMapper {
	void insertReviewLike(ReviewLike reviewLike);
	
	void deleteReviewLike(int reviewLikeNo);
	
	ReviewLike getReviewLikeByUserIdAndReviewNo(@Param("userId") String userId, @Param("reviewNo") int reviewNo);
}
