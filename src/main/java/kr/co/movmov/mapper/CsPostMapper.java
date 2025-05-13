package kr.co.movmov.mapper;

import java.util.List;
import java.util.Map;

import kr.co.movmov.vo.CsPost;

public interface CsPostMapper {
	
	// 타입별 게시글 조회 (예: FAQ 게시글 전체, 공지사항 전체, 문의유형 전체)
	List<CsPost> getPostsByType(Map<String, Object> param); 


    // 총 게시글 수 조회 (FAQ, 공지사항, 문의유형 각각)
    int getTotalRows(Map<String, Object> param);  
    
/*
    getPostById(): 게시글 상세조회

    insertPost(): 게시글 등록
    updatePost(): 게시글 수정
    deletePost(): 게시글 삭제

    getPostsWithCategory(): 카테고리와 함께 게시글 조회

    카테고리 타입별로 id로 조회할 수도 있어서 getPostsByType()과 별도로 구현?
    getInquiryPostsByCategory(): 1:1문의 전용 카테고리별 조회
}
 */
}
