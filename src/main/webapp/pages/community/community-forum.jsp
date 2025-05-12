<%@page import="kr.co.movmov.utils.Pagination"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="kr.co.movmov.vo.Post"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.movmov.mapper.PostMapper"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	/*
		/pages/community-forum?bid=xxx
		/pages/community-forum?bid=xxx&pg=xxx
		
		bid		300		영화게시판
		bid		301		자유게시판
		pg				페이지 번호
	*/
	int boardId = StringUtils.strToInt(request.getParameter("bid"), 300);
	PostMapper postMapper = MybatisUtils.getMapper(PostMapper.class);
	int pageNo = StringUtils.strToInt(request.getParameter("pg"), 1);
	
	// 페이지네이션 처리
	Map<String, Object> condition = new HashMap<>();
	condition.put("boardId", boardId);
	int totalRows = postMapper.getTotalRows(condition);
	int rows = 10;
	Pagination pagination = new Pagination(pageNo, totalRows, rows);
	int offset = pagination.getOffset();
	condition.put("offset", offset);
	condition.put("rows", rows);
	
	List<Post> boardPosts = postMapper.getPosts(condition);

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
				<tr onclick="window.location='post-detail.jsp?pno=<%=post.getNo() %>'">
					<td><%=post.getNo() %></td>
					<td>
						<span class="tag-spoiler"><%=("Y".equals(post.getIsSpoiler()) ? "[스포일러]" : "") %></span>
						<span class="tag-header"><%=post.getHeader().getName() %></span>
						<span><%=post.getTitle() %></span>
					</td>
					<td><%=post.getUser().getNickname() %></td>
<%
	String displayDate = "";
	if (StringUtils.isSameDay(post.getCreatedDate())) {
		displayDate = StringUtils.simpleTimeFormat(post.getCreatedDate());
	} else {
		displayDate = StringUtils.simpleDate(post.getCreatedDate());
	}
%>
					<td><%=displayDate %></td>
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
			<button type="button" id="btn-page-first">&laquo;</button>
<%
	int blockFirst = Math.max(Math.min(pagination.getTotalPages() - 4, pageNo - 2), 1);
	int blockLast = Math.min(Math.max(pagination.getPages(), pageNo + 2), pagination.getTotalPages());
	for (int i = blockFirst; i < blockLast + 1; i++) {
%>
			<button type="button"
				class="btn-page-no<%=(i == pageNo ? " active" : "") %>"><%=i %></button>
<%
	}
%>
			<button type="button" id="btn-page-last">&raquo;</button>
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
		
		$("#btn-page-first").on("click", function() {
			let params = $.param({
				bid: <%=boardId %>,
				pg: 1
			});
			window.location.href = window.location.pathname + '?' + params;
		});
		
		$("#btn-page-last").on("click", function() {
			let params = $.param({
				bid: <%=boardId %>,
				pg: <%=pagination.getTotalPages() %>
			});
			window.location.href = window.location.pathname + '?' + params;
		});
		
		$(".btn-page-no").on("click", function() {
			let params = $.param({
				bid: <%=boardId %>,
				pg: $(this).text()
			});
			window.location.href = window.location.pathname + '?' + params;
		});

	</script>

</html>
