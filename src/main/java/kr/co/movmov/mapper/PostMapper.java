package kr.co.movmov.mapper;

import java.util.List;

import kr.co.movmov.vo.Post;

public interface PostMapper {

	/**
	 * 새 게시글을 전달받아서 테이블에 저장시킨다.
	 * @param post 게시글 객체
	 */
	void insertPost(Post post);
	
	/**
	 * 게시글 고유번호를 전달받아서 게시글을 가져온다.
	 * @param postNo 게시글 번호
	 * @return 게시글 객체
	 */
	Post getPostById(int postNo);
	
	/**
	 * 게시판 고유번호를 전달받아서 게시글 목록을 가져온다.
	 * 삭제된 게시글은 불러오지 않는다.
	 * @param boardNo 게시판 번호
	 * @return 게시글 목록
	 */
	List<Post> getPostsByBoardId(int boardId);
}
