package kr.co.movmov.mapper;

import java.util.List;

import kr.co.movmov.vo.Order;
import kr.co.movmov.vo.User;

public interface OrderMapper {

	void insertOrder(Order order);
	
	List<Order> getAllPaymentInfoOfUser(User user);
	
	
}
