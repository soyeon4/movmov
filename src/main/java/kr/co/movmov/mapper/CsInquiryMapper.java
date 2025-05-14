package kr.co.movmov.mapper;

import java.util.List;

import kr.co.movmov.vo.Inquiry;
import kr.co.movmov.vo.User;

public interface CsInquiryMapper {

	List<Inquiry> getAllInquiries();	// 문의 내역 전체 조회
	
	List<Inquiry> getInquiryById(int InquiryId);	// inquiry_id로 특정 문의 내역 조회
	
	List<Inquiry> getInquiryByUserID(User userId);	// user_id로 특정 문의 내역 조회
	
}
