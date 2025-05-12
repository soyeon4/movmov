<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="kr.co.movmov.mapper.PostMapper"%>
<%@page import="kr.co.movmov.vo.Post"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	PostMapper postMapper =MybatisUtils.getMapper(PostMapper.class);
	Map<String, Object> conditionAllMoviePosts = new HashMap<>();
	conditionAllMoviePosts.put("boardId", 300);
	conditionAllMoviePosts.put("rows", 5);
	Map<String, Object> conditionAllFreePosts = new HashMap<>();
	conditionAllFreePosts.put("boardId", 301);
	conditionAllFreePosts.put("rows", 5);
	Map<String, Object> conditionMoviePopular = new HashMap<>();
	conditionMoviePopular.put("sort", "views");
	conditionMoviePopular.put("rows", 5);
	Map<String, Object> conditionFreePopular = new HashMap<>();
	conditionFreePopular.put("boardId", 301);
	conditionFreePopular.put("sort", "views");
	conditionFreePopular.put("rows", 5);
	List<Post> moviePosts = postMapper.getPosts(conditionAllMoviePosts);
	List<Post> freePosts = postMapper.getPosts(conditionAllFreePosts);
	List<Post> popularMoviePosts = postMapper.getPosts(conditionMoviePopular);
	List<Post> popularFreePosts = postMapper.getPosts(conditionFreePopular);
	
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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
<link rel="stylesheet" href="../../resources/style/common/main.css">
<link rel="stylesheet" href="../../resources/style/community/community-main.css">
</head>
<body>
	<!-- 헤더 -->
	<%@ include file="../common/header.jsp"%>

	<main class="forum-container">
		<section class="notice-area">
			<div class="popular-block">
				<h2>📢 공지사항</h2>
				<div class="board-header">
					<span>번호</span> <span>제목</span> <span>작성자</span> <span>조회수</span>
				</div>
				<div class="board-row">
					<span>1</span> <span>[공지] 정기 점검 안내</span> <span>운영자</span> <span>1325</span>
				</div>
				<div class="board-row">
					<span>2</span> <span>[공지] 이벤트 시작</span> <span>운영자</span> <span>98</span>
				</div>
				<div class="board-row">
					<span>3</span> <span>[공지] 이번 주 굿즈 할인 이벤트!</span> <span>운영자</span> <span>989</span>
				</div>
			</div>
		</section>

		<section class="popular-posts">
			<div class="popular-block">
				<h2>🔥 영화게시판 인기</h2>
				<div class="board-header">
					<span>번호</span>
					<span>제목</span>
					<span>작성자</span>
					<span>조회수</span>
				</div>
<%
	for (Post post : popularMoviePosts) {
%>

				<div class="board-row">
					<a href="post-detail.jsp?pno=<%=post.getNo() %>">
					<span><%=post.getNo()%></span>
					<div class="col-title">
						<span class="spoiler"><%=("Y".equals(post.getIsSpoiler()) ? "스포" : "") %></span>
						<span class="header"><%=post.getHeader().getName()%></span>
						<span><%=post.getTitle()%></span>
					</div>
					<span class="nickname"><%=post.getUser().getNickname()%></span>
					<span><%=post.getViewCount()%></span>
					</a>
				</div>
<%
	}
%>
			</div>
			<div class="popular-block">
				<h2>🔥 자유게시판 인기</h2>
				<div class="board-header">
					<span>번호</span>
					<span>제목</span>
					<span>작성자</span>
					<span>조회수</span>
				</div>
<%
	for (Post post : popularFreePosts) {
%>

				<div class="board-row">
					<a href="post-detail.jsp?pno=<%=post.getNo() %>">
					<span><%=post.getNo()%></span>
					<div class="col-title">
						<span class="spoiler"><%=("Y".equals(post.getIsSpoiler()) ? "스포" : "") %></span>
						<span class="header"><%=post.getHeader().getName()%></span>
						<span><%=post.getTitle()%></span>
					</div>
					<span class="nickname"><%=post.getUser().getNickname()%></span>
					<span><%=post.getViewCount()%></span>
					</a>
				</div>
<%
	}
%>
			</div>
		</section>

		<section class="forums-container">
			<div class="forum">
				<h2>
					<a href="community-forum.jsp?bid=300">🎬 영화게시판</a>
				</h2>
				<div class="board-header">
					<span>번호</span>
					<span>제목</span>
					<span>작성자</span>
					<span>조회수</span>
				</div>
<%
	for (Post post : moviePosts) {
%>
				<div class="board-row">
					<a href="post-detail.jsp?pno=<%=post.getNo() %>">
					<span><%=post.getNo()%></span>
					<div class="col-title">
						<span class="spoiler"><%=("Y".equals(post.getIsSpoiler()) ? "스포" : "") %></span>
						<span class="header"><%=post.getHeader().getName()%></span>
						<span><%=post.getTitle()%></span>
					</div>
					<span class="nickname"><%=post.getUser().getNickname()%></span> <span><%=post.getViewCount()%></span>
					</a>
				</div>
<%
	}
%>
			</div>

			<div class="forum">
				<h2>
					<a href="community-forum.jsp?bid=301">🎈 자유게시판</a>
				</h2>
				<div class="board-header">
					<span>번호</span>
					<span>제목</span>
					<span>작성자</span>
					<span>조회수</span>
				</div>
<%
	for (Post post : freePosts) {
%>
				<div class="board-row">
					<a href="post-detail.jsp?pno=<%=post.getNo() %>">
					<span><%=post.getNo()%></span>
					<div class="col-title">
						<span class="spoiler"><%=("Y".equals(post.getIsSpoiler()) ? "스포" : "") %></span>
						<span class="header"><%=post.getHeader().getName()%></span>
						<span><%=post.getTitle()%></span>
					</div>
					<span class="nickname"><%=post.getUser().getNickname()%></span> <span><%=post.getViewCount()%></span>
					</a>
				</div>
<%
	}
%>
			</div>
		</section>
	</main>

	<!-- 푸터 -->
	<%@ include file="../common/footer.jsp"%>
</body>
</html>
