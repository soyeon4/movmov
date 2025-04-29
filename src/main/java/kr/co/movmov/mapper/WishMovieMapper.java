package kr.co.movmov.mapper;

import org.apache.ibatis.annotations.Param;

public interface WishMovieMapper {
	void insertWishMovie(@Param("UserId") String UserId, @Param("movieNo") int movieNo);
}
