<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	/*
		/pages/community-forum?btype=xxx
		
		btype		300		영화게시판
		btype		301		자유게시판
	*/
	String boardType = request.getParameter("btype");

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
	if (("300").equals(boardType)) {
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
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
					<th>댓글</th>
					<th>추천</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>101</td>
					<td><span class="post-category">[후기]</span> <a
						href="post-detail.html">전공의생활 2화 진짜 최고</a></td>
					<td>movielover</td>
					<td>2025-04-21 14:32</td>
					<td>132</td>
					<td>4</td>
					<td>25</td>
				</tr>
				<tr>
					<td>100</td>
					<td><span class="post-category">[질문]</span> 오늘 뭐 볼까요?</td>
					<td>영화덕후</td>
					<td>2025-04-20 11:05</td>
					<td>98</td>
					<td>2</td>
					<td>7</td>
				</tr>
				<tr>
					<td>99</td>
					<td><span class="post-category">[스포일러]</span> 듄2 후기 (주의)</td>
					<td>듄매니아</td>
					<td>2025-04-19 17:22</td>
					<td>261</td>
					<td>6</td>
					<td>30</td>
				</tr>
			</tbody>
		</table>
		<form id="write-post" method="post" action="post-form.jsp">
			<input type="hidden" name="boardType" value="<%=boardType %>">
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
		
	</script>

</html>
