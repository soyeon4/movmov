package kr.co.movmov.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

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
	Post getPostByNo(int postNo);
	
	/**
	 * 게시판 고유번호를 전달받아서 해당 게시판의
	 * 최신 5개 게시글 목록을 가져온다.
	 * 삭제된 게시글은 불러오지 않는다.
	 * @param boardNo 게시판 번호
	 * @return 게시글 목록
	 */
	List<Post> getRecentPostsByBoardId(int boardId);
	
	/**
	 * 게시글을 업데이트한다.
	 * @param post 업데이트된 게시글
	 */
	void updatePost(Post post);
	
	/**
	 * 게시글 작성 직후 해당 게시글 페이지로 갈 수 있도록
	 * post_no_seq.currval을 반환한다.
	 * @return 현재 게시글 시퀀스 값
	 */
	int getCurrentPostNo();
	
	/**
	 * 조건에 맞는 게시글의 총 개수를 반환한다.
	 * @param condition 조건 목록
	 * @return 필터링된 게시글 개수
	 */
	int getTotalRows(Map<String, Object> condition);
	
	/**
	 * 페이지네이션 고려한 게시글 목록 불러오기
	 * @param condition 필터링 조건
	 * @return 게시글 목록
	 */
	List<Post> getPosts(Map<String, Object> condition);
	
	/**
	 * 해당 게시글을 추천한 아이디 목록 불러오기
	 * @param postNo 게시글 번호
	 * @return 유저 아이디 리스트
	 */
	List<String> getUpvoteIds(int postNo);
	
	/**
	 * 게시글 조회수를 증가시킨다.
	 * @param postNo 게시글 번호
	 */
	void updatePostViewCount(int postNo);
	
	/**
	 * 게시글 추천수를 업데이트한다.
	 * @param postNo 게시글 번호
	 */
	void updatePostUpvoteCount(int postNo);
	
	/**
	 * 게시글 댓글수를 업데이트한다.
	 * @param postNo 게시글 번호
	 */
	void updatePostCommentCount(int postNo);
	
	/**
	 * 게시글 번호를 댓글 필터링/페이지네이션 객체를 통해 받은
	 * 보이는 댓글 개수를 테이블에 저장시킨다.
	 * @param commentCount
	 */
	void setPostCommentCount(@Param("postNo") int postNo,
							@Param("commentCount") int commentCount);

	/**
	 * 추천 테이블에 게시글/댓글 번호와 추천한 유저 아이디를 저장시킨다.
	 * @param info 게시글 번호, 댓글 번호, 유저 아이디
	 */
	void insertUpvote(Map<String, Object> info);
	
	/**
	 * 게시글 번호를 전달받아서 추천수를 반환한다.
	 * @param postNo 게시글 번호
	 * @return 추천수
	 */
	int getUpvoteCount(int postNo);
	
	List<Post> getRecentPostsByUserId(String userId);
	
	int getTotalPostRowsByUserId(String userId);
	
	/**
	 * 게시글 번호를 전달받아서
	 * 해당 게시글의 신고 개수를 업데이트한다.
	 * @param postNo 게시글 번호
	 */
	void updatePostReportCount(int postNo);
}
