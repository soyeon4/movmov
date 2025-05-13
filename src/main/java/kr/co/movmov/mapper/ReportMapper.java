package kr.co.movmov.mapper;

import kr.co.movmov.vo.Report;

public interface ReportMapper {
	
	/**
	 * 신고 객체를 전달받아서 테이블에 저장시킨다.
	 * @param report 신고 객체
	 */
	void insertReport(Report report);

}
