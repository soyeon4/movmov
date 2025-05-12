package kr.co.movmov.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import kr.co.movmov.vo.WishMovie;

public interface WishMovieMapper {

  void insertWishMovie(WishMovie wishMovie);

  void deleteWishMovie(int wishNo);

  WishMovie getWishMovieByUserIdAndMovieNo(@Param("userId") String userId, @Param("movieNo") int movieNo);

  List<WishMovie> getWishMoviesbyUserId(String userId);

  int getTotalWishMovieRowsByUserId(String userId);

  List<WishMovie> getWishMoviesbyUserIdPaging(Map<String, Object> condition);

}