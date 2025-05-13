package kr.co.movmov.mapper;

import java.util.List;
import java.util.Map;

import kr.co.movmov.vo.Faq;

public interface FaqMapper {
	
	List<Faq> getFaqs();	// FAQ 전체 조회

	List<Faq> getFaqsByCategory(Map<String, Object> param);		// 카테고리별 FAQ 조회
	
	int getTotalRows(Map<String, Object> param);		// 총 FAQ 수 조회

}
