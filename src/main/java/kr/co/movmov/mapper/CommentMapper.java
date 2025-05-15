package kr.co.movmov.mapper;

import java.util.List;
import java.util.Map;

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
	
	/**
	 * 댓글 객체를 전달받아서 테이블의 댓글 정보를 업데이트한다.
	 * @param comment 댓글 객체
	 */
	void updateComment(Comment comment);
	
	/**
	 * 댓글의 총 개수를 반환한다.
	 * @param condition 조건 목록
	 * @return 댓글 개수
	 */
	int getTotalRows(Map<String, Object> condition);
	
	/**
	 * 조건에 맞는 댓글 목록을 반환한다.
	 * @param condition 조건 목록
	 * @return 댓글 리스트
	 */
	List<Comment> getCommentsByCondition(Map<String, Object> condition);
	
	/**
	 * comment_no_seq.currval을 반환한다.
	 * @return 작성된 댓글 번호
	 */
	int getCurrentCommentNo();
	
	/**
	 * 댓글 번호를 전달받아서
	 * 해당 댓글의 신고 개수를 업데이트한다.
	 * @param commentNo 댓글 번호
	 */
	void updateCommentReportCount(int commentNo);
	
}
