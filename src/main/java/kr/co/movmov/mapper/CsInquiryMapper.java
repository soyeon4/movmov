package kr.co.movmov.mapper;

import java.util.List;

import kr.co.movmov.vo.Inquiry;
import kr.co.movmov.vo.User;

public interface CsInquiryMapper {

	List<Inquiry> getAllInquiries();	// 문의 내역 전체 조회
	
	List<Inquiry> getInquiryById(int inquiryId);	// inquiry_id로 특정 문의 내역 조회
	
	List<Inquiry> getInquiryByUserID(String userId);	// user_id로 특정 문의 내역 조회
	
	List<Inquiry> getInquiryByCategory(String userId);	// user_id로 특정 문의 내역 조회
	
	List<Inquiry> getInquiryByUserIdAndInquiryId(User userId, Inquiry inquiryId);  // user_id, inquiry_id로 특정 문의내역
	
	List<Inquiry> getFilteredInquiries(String category, String status, String excludeSecret, String myQnaOnly);  // 필터된 문의 목록을 반환하는 메서드

	void insertInquiry(Inquiry inquiry);
}