package kr.co.movmov.mapper;

import java.util.List;

import kr.co.movmov.vo.Order;
import kr.co.movmov.vo.ShopCartItem;
import kr.co.movmov.vo.User;

public interface OrderMapper {

	void insertOrder(Order order);
	
	List<ShopCartItem> getAllCartItemOfUser(User user);
	
	List<Order> getAllPaymentInfoOfUser(User user);
	
	
}
