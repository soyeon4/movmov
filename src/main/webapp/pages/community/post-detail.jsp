<%@page import="kr.co.movmov.vo.CommentArranger"%>
<%@page import="kr.co.movmov.utils.Pagination"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="kr.co.movmov.vo.Comment"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.movmov.mapper.CommentMapper"%>
<%@page import="java.util.Date"%>
<%@page import="kr.co.movmov.vo.Post"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@page import="kr.co.movmov.mapper.PostMapper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/*
		요청 URL
			/pages/community/post-detail.jsp?pno=xxx
			/pages/community/post-detail.jsp?pno=xxx&pg=xxx
		
			name		value
			----------------
			pno			게시글 번호
			pg			댓글 페이지 번호
	*/

	int postNo = StringUtils.strToInt(request.getParameter("pno"));
	int pageNo = StringUtils.strToInt(request.getParameter("pg"), 1);

	PostMapper postMapper = MybatisUtils.getMapper(PostMapper.class);
	postMapper.updatePostViewCount(postNo);
	Post post = postMapper.getPostByNo(postNo);
	
	User loginedUser = (User) session.getAttribute("LOGIN_USER");
	boolean isLoggedIn = loginedUser != null;
	String userId = "";
	String userNickname = "";
	if (isLoggedIn) {
		userId = loginedUser.getId();
		userNickname = loginedUser.getNickname();
	}
	
	// 추천 목록 불러오기
	List<String> upvoteIds = postMapper.getUpvoteIds(postNo);
	Gson gson = new Gson();
	String upvoteJson = gson.toJson(upvoteIds);
	
	// 댓글 불러오기
	CommentMapper commentMapper = MybatisUtils.getMapper(CommentMapper.class);
	List<Comment> allPostComments = commentMapper.getCommentsByPostNo(postNo);
	CommentArranger commentArranger = new CommentArranger();
	
	// 댓글 페이지네이션
	List<List<Comment>> commentPages = commentArranger.paginateComments(allPostComments, 5);
	int totalPages = commentPages.size();
	int pagesPerBlock = 5;
	List<Comment> currentPageComments = commentPages.get(pageNo - 1);
	
	String jsonComments = gson.toJson(currentPageComments);
	String jsonAllComments = gson.toJson(allPostComments);
	
	// 하단 게시글 목록
	int boardId = post.getBoardType().getId();
	List<Post> recentPosts = postMapper.getRecentPostsByBoardId(boardId);
	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MovMov Community</title>
<link rel="icon" href="../../resources/images/common/favicon.ico">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="../../resources/style/common/main.css">
<link rel="stylesheet" href="../../resources/style/community/post-detail.css">
</head>
<body>
	
	<!-- 헤더 -->
	<%@ include file="../common/header.jsp"%>
	
	<!-- 로그인 요구 팝업 -->
	<dialog id="login-warning-dialog" closedby="any">
		<form method="dialog">
			<p>해당 기능을 사용하려면 로그인해야 합니다.</p>
			<menu>
				<button type="button" id="btn-login-trigger">로그인</button>
				<button type="button" id="btn-close-warning" class="button-return">돌아가기</button>
			</menu>
		</form>
	</dialog>
	
	<div class="container">
    <!-- 🔷 게시판 이름 -->
<%
	if (post.getBoardType().getId() == 300) {
%>
    <div class="board-label">
    	<a href="community-forum.jsp?bid=300">🎬 영화게시판</a>
    </div>
<%
	} else {
%>
    <div class="board-label">
    	<a href="community-forum.jsp?bid=301">🎈 자유게시판</a>
    </div>
<%
	}
%>
    <!-- 📌 상세 글 내용 -->
		<div class="post-detail">
			<!-- 말머리 -->
			<div class="post-title">
<%
	if ("Y".equals(post.getIsSpoiler())) {
%>
				<span class="post-tag spoiler">스포일러</span>
<%
	}
%>
				<span class="post-tag header"><%=post.getHeader().getName() %></span>
				<h2><%=post.getTitle() %></h2>
			</div>
			<div class="post-author">
				<img class="author-img" alt="profile-pic"
					src="../../resources/images/common/default-profile.png" />
				<span><%=post.getUser().getNickname() %></span>
			</div>
<%
	boolean updated = false;
	if (post.getCreatedDate().compareTo(post.getUpdatedDate()) != 0) {
		updated = true;
	}
%>
			<div class="post-meta">
				작성일:
				<%=StringUtils.simpleDateTimeFormat(post.getCreatedDate()) %>
				<%=(updated ? "| 수정일: " + StringUtils.simpleDateTimeFormat(post.getUpdatedDate()) : "") %>
				| 조회수:
				<%=post.getViewCount() %>
			</div>
			<hr class="divider">
			<div class="post-content"><%=post.getContent() %></div>
			<hr class="divider">
			<!-- ❤️ 추천 버튼 -->
			<div class="upvote-button">
				<button type="button" class="btn-upvote">
					<span class="upvote-icon"><%=(upvoteIds.contains(userId) ? "❤" : "♡" ) %></span>
					<span>추천</span><span id="upvote-cnt"><%=post.getUpvoteCount() %></span>
				</button>
			</div>
		</div>
		<div class="post-options">
<%
	if (post.getUser().getId().equals(userId)) {
%>
			<a href="post-form-edit.jsp?pno=<%=post.getNo() %>">수정</a>
			<a href="delete-post.jsp?pno=<%=post.getNo() %>"
				onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>
<%
	}
%>
			<a href="report-form.jsp?pno=<%=post.getNo() %>" class="report-button post">신고하기</a>
		</div>

		<!-- 💬 댓글 -->
		<div class="comment-header">
			<p>💬 댓글 [<%=post.getCommentCount() %>]</p>
		</div>
		<div class="comments-section">
<%
	for (Comment comment : currentPageComments) {
		request.setAttribute("comment", comment);
		request.setAttribute("level", 0);
%>
			<jsp:include page="commentBlock.jsp" />
<%
	}
%>
<%
	if (!allPostComments.isEmpty()) {
%>
			<div class="pagination">
				<button type="button" id="btn-page-first">&laquo;</button>
<%
		int blockFirst = Math.max(Math.min(totalPages - 4, pageNo - 2), 1);
		int blockLast = Math.min(Math.max(pagesPerBlock, pageNo + 2), totalPages);
		for (int i = blockFirst; i < blockLast + 1; i++) {
%>
				<button type="button"
					class="btn-page-no<%=(i == pageNo ? " active" : "") %>"><%=i %></button>
<%
		}
%>
				<button type="button" id="btn-page-last">&raquo;</button>
			</div>
<%
	}
%>
			<div class="comment-form create">
				<h4>댓글 작성</h4>
<%
	if (isLoggedIn) {
%>
				<div class="comment-author">
					<img class="author-img" src="../../resources/images/common/default-profile.png" alt="profile-pic"/>
					<span class="author-name"><%=loginedUser.getNickname() %></span>
				</div>
<%
	}
%>
				<form action="create-comment.jsp" method="post" id="create-comment">
					<input type="hidden" name="postNo" value="<%=postNo %>" />
					<input type="hidden" name="pg" value="<%=pageNo %>" />
					<textarea name="content" rows="4" placeholder="댓글을 입력하세요..."></textarea>
					<button type="submit" class="btn-create-comment">등록</button>
				</form>
			</div>
		</div>

		<!-- 📃 하단 관련 게시글 목록 -->
		<div class="related-posts">
			<a class="no-deco" href="community-forum.jsp?bid=<%=boardId %>">
				<h3>📋 <%=(boardId == 300 ? "영화" : "자유") %>게시판 다른 글</h3>
			</a>
<%
	for (Post recentPost : recentPosts) {
%>
			<a href="post-detail.jsp?pno=<%=recentPost.getNo() %>" class="no-deco">
				<div class="post-preview">
					<div class="title">
						<span class="spoiler"><%=("Y".equals(recentPost.getIsSpoiler()) ? "[스포일러]" : "") %></span>
						<span class="header"><%=recentPost.getHeader().getName() %></span>
						<span><%=recentPost.getTitle() %></span>
					</div>
					<div class="author"><%=recentPost.getUser().getNickname() %></div>
				</div>
			</a>
<%
	}
%>
		</div>
	</div>

	<!-- 푸터 -->
	<%@ include file="../common/footer.jsp"%>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script type="text/javascript">
		let isLoggedIn = <%=isLoggedIn %>;
		let userId = "<%=userId %>";
		let postUserId = "<%=post.getUser().getId() %>";
		let upvoteIdList = JSON.parse('<%=upvoteJson %>');
		let postNo = <%=postNo %>;
		let totalPages = <%=totalPages %>;
		let userNickname = "<%=userNickname %>";
	</script>
	<script src="/movmov/resources/script/community/post-detail.js"></script>
</body>
</html>