package kr.co.movmov.mapper;

import java.util.List;

import kr.co.movmov.vo.Category;

public interface CategoryMapper {

	/**
	 * 카테고리 고유번호를 전달받아서 카테고리 객체를 반환한다.
	 * @param catId 카테고리 고유번호
	 * @return 카테고리 객체
	 */
	Category getCategoryFromId(int catId);
	
	/**
	 * 카테고리 이름을 전달받아서 카테고리 객체를 반환한다.
	 * @param catType 카테고리 타입
	 * @return 카테고리 객체
	 */
	Category getCategoryFromType(String catType);
	
	/**
	 * 카테고리 이름을 전달받아서 그에 해당하는 모든 카테고리를 담은 리스트를 반환한다.
	 * @param catType 카테고리 타입
	 * @return 카테고리 목록
	 */
	List<Category> getCategoriesByType(String catType);
	
	/**
	 * 게시판별 고유번호를 키로 갖는 말머리를 모두 담은 리스트를 반환한다.
	 * @return 말머리 리스트
	 */
	List<Category> getAllBoardHeaders();
	
	/**
	 * 신고사유 목록을 담은 리스트를 반환한다.
	 * @return 신고사유 리스트
	 */
	List<Category> getAllReportHeaders();
	
}
