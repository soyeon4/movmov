package kr.co.movmov.mapper;

import java.util.List;

import kr.co.movmov.vo.Comment;

public interface CommentMapper {

	/**
	 * 댓글 고유번호를 전달받아서 댓글을 반환한다.
	 * @param CommentNo 댓글 번호
	 * @return 댓글 객체
	 */
	Comment getCommentByNo(int commentNo);
	
	/**
	 * 댓글 객체를 전달받아서 테이블에 저장한다.
	 * @param comment 댓글 객체
	 */
	void insertComment(Comment comment);
	
	/**
	 * 게시글 번호를 전달받아서 댓글 목록을 반환한다.
	 * @param PostNo 게시글 번호
	 * @return 댓글 목록
	 */
	List<Comment> getCommentsByPostNo(int postNo);
	
}
