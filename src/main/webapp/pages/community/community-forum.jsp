<%@page import="kr.co.movmov.vo.Post"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.movmov.mapper.PostMapper"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	/*
		/pages/community-forum?bid=xxx
		
		bid		300		영화게시판
		bid		301		자유게시판
		
		1. 게시판 고유번호에 따라 해당 게시글 목록을 불러온다.
	*/
	int boardId = StringUtils.strToInt(request.getParameter("bid"), 300);
	PostMapper postMapper = MybatisUtils.getMapper(PostMapper.class);
	List<Post> boardPosts = postMapper.getPostsByBoardId(boardId);

	User loginedUser = (User) session.getAttribute("LOGIN_USER");
	boolean isLoggedIn = loginedUser != null;
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
<link rel="stylesheet"
	href="../../resources/style/community/community-forum.css">
</head>
<body>
	<!-- 헤더 -->
	<%@ include file="../common/header.jsp"%>

	<div class="boards-container">
		<div class="board-header">
<%
	if (boardId == 300) {
%>
			<div class="board-title">🎬 영화게시판</div>
<%
	} else {
%>
			<div class="board-title">🎈 자유게시판</div>
<%
	}
%>
			<div class="search-bar">
				<input type="text" placeholder="제목 또는 작성자 검색">
				<button>검색</button>
			</div>
		</div>

		<table class="board-table">
			<colgroup>
				<col style="width: 6%">
				<col style="width: 46%">
				<col style="width: 15%">
				<col style="width: 15%">
				<col style="width: 6%">
				<col style="width: 6%">
				<col style="width: 6%">
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>댓글</th>
					<th>조회수</th>
					<th>추천</th>
				</tr>
			</thead>
			<tbody>
<%
	for (Post post : boardPosts) {
%>
				<tr>
					<td><%=post.getNo() %></td>
					<td>
						<span class="tag-spoiler"><%=("Y".equals(post.getIsSpoiler()) ? "[스포일러]" : "") %></span>
						<span class="tag-header"><%=post.getHeader().getName() %></span>
						<a href="post-detail.jsp?pno=<%=post.getNo() %>"><%=post.getTitle() %></a>
					</td>
					<td><%=post.getUser().getNickname() %></td>
					<td><%=StringUtils.simpleDate(post.getCreatedDate()) %></td>
					<td><%=post.getCommentCount() %></td>
					<td><%=post.getViewCount() %></td>
					<td><%=post.getUpvoteCount() %></td>
				</tr>
<%
	}
%>
			</tbody>
		</table>
		<form id="write-post" method="get" action="post-form.jsp">
			<input type="hidden" name="boardType" value="<%=boardId %>">
			<button type="submit" class="write-btn">✍️ 글쓰기</button>
		</form>
		<div class="pagination">
			<button>&laquo;</button>
			<button class="active">1</button>
			<button>2</button>
			<button>3</button>
			<button>4</button>
			<button>5</button>
			<button>&raquo;</button>
		</div>
	</div>
</body>
	<!-- 푸터 -->
	<%@ include file="../common/footer.jsp"%>
	
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script type="text/javascript">
		let isLoggedIn = <%=isLoggedIn %>;
	
		$("#write-post").submit(function() {
			if (!isLoggedIn) {
				$("#btn-header-login").trigger("click");
				$("input[name=redirectUrl]").val("post-form.jsp?boardType=<%=boardId %>");
				return false;
			}
			return true;
		});

	</script>

</html>
