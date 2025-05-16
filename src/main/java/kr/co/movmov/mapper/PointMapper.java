package kr.co.movmov.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.movmov.vo.Point;
import kr.co.movmov.vo.User;

public interface PointMapper {
	
	void insertPoint(Point point);
	
	List<Point> getAllPointHistoryOfUser(User user);
	
	List<Point> getRecentFivePoint(User user);
	
	int getUserPoint(User user);
	
	void updateUserPoint(@Param("user") User user, @Param("pointAmount") int pointAmount);
}
