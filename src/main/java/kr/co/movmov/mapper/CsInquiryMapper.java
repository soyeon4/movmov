package kr.co.movmov.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import kr.co.movmov.vo.Inquiry;
import kr.co.movmov.vo.User;

public interface CsInquiryMapper {

	List<Inquiry> getAllInquiries();	// 문의 내역 전체 조회
	
	List<Inquiry> getInquiryById(int inquiryId);	// inquiry_id로 특정 문의 내역 조회
	
	List<Inquiry> getInquiryByUserID(String userId);	// user_id로 특정 문의 내역 조회
	
	List<Inquiry> getInquiryByCategory(String userId);	// user_id로 특정 문의 내역 조회
	
//	List<Inquiry> getFilteredInquiries(@Param("categoryId") int categoryId,
//            @Param("status") int status,
//            @Param("excludeSecret") String excludeSecret,
//            @Param("userId") String userId);
	
	List<Inquiry> getFilteredInquiries(Map<String, Object> condition);

	void insertInquiry(Inquiry inquiry);
}