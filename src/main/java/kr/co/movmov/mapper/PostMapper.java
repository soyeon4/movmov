package kr.co.movmov.mapper;

import kr.co.movmov.vo.Post;

public interface PostMapper {

	/**
	 * 새 게시글을 전달받아서 테이블에 저장시킨다.
	 * @param post 게시글 객체
	 */
	void insertPost(Post post);
}
