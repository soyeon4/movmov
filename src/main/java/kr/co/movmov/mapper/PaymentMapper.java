package kr.co.movmov.mapper;

import java.util.List;

import kr.co.movmov.vo.Payment;
import kr.co.movmov.vo.User;

public interface PaymentMapper {

	void insertPayment(Payment payment);
	
	Payment getPaymentById(int id);
	
	Payment getRecentPayment(User user);
	
	List<Payment> getRecentFivePayment(User user);
	
	List<Payment> getAllPaymentOfUser(User user);
	
	void updatePaymentStatus(Payment payment);
}
