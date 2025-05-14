<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@ page import="kr.co.movmov.mapper.CategoryMapper" %>
<%@ page import="kr.co.movmov.vo.Category" %>
<%@ page import="kr.co.movmov.utils.MybatisUtils" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/*
		요청 정보
			- 요청 URL
				/pages/community/post-form.jsp?bid=xxx
			- 요청 파라미터
				name		value
				--------------------
				bid			300
							301
		게시글 작성 폼 설정
			1. bid 값에 따라 기본 선택된 게시판을 설정하고 해당 말머리를 불러온다.
	*/
	
	int boardId = StringUtils.strToInt(request.getParameter("bid"));
	CategoryMapper catMapper = MybatisUtils.getMapper(CategoryMapper.class);
	List<Category> movieHeaders = catMapper.getCategoriesByType("영화게시글");
	List<Category> freeHeaders = catMapper.getCategoriesByType("자유게시글");
	
	Gson gson = new Gson();
	String movieHeadersJson = gson.toJson(movieHeaders);
	String freeHeadersJson = gson.toJson(freeHeaders);

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
<link rel="stylesheet" href="../../resources/style/community/post-form.css">
</head>
<body>
	<!-- 헤더 -->
	<%@ include file="../common/header.jsp"%>

	<section class="form-container">
		<form id="form-create-post" method="post" action="create-post.jsp">
			<!-- 🔷 게시판 이름 -->
			<div class="board-tab-container">
				<div class="board-label" board-id="300">🎬 영화게시판</div>
				<div class="board-label" board-id="301">🎬 자유게시판</div>
				<input type="hidden" name="boardId" id="board-type-id" value="<%=boardId %>">
			</div>

			<!-- ✍️ 글쓰기 폼 -->
			<div class="post-form">
				<h2>게시글 작성</h2>
				<!-- 스포일러 여부 선택 -->
				<div class="form-group">
					<div class="tooltip-group">
						<div class="field">스포일러</div>
						<div class="input-tooltip" id="spoiler-tooltip">스포일러 여부는 필수 선택사항입니다.</div>
					</div>
					<input type="hidden" name="spoiler" id="contains-spoiler">
					<div class="header-toggle-group">
						<button type="button"
							class="tag-toggle spoiler"
							data-value="Y">스포일러 있음</button>
						<button type="button"
							class="tag-toggle spoiler"
							data-value="N">스포일러 없음</button>
					</div>
				</div>
				<!-- 🔖 말머리 선택 -->
				<div class="form-group">
					<div class="tooltip-group">
						<div class="field">말머리</div>
						<div class="input-tooltip" id="header-tooltip">말머리는 필수 선택사항입니다.</div>
					</div>
					<input type="hidden" name="header" id="header-select">
					<div class="header-toggle-group" id="post-headers">
<%
	for (Category header : (boardId == 300 ? movieHeaders : freeHeaders)) {
%>
						<button type="button" class="tag-toggle header"
							data-value="<%=header.getId()%>"><%=header.getName()%></button>
<%
	}
%>
					</div>
				</div>

				<!-- 제목 입력 -->
				<div class="form-group">
					<div class="tooltip-group">
						<label>제목</label>
						<div class="input-tooltip" id="title-tooltip">제목은 두 글자 이상이어야 합니다.</div>
					</div>
						<input type="text" name="title" placeholder="제목을 입력하세요">
				</div>

				<!-- 내용 입력 -->
				<div class="form-group">
					<div class="tooltip-group">
						<label>내용</label>
						<div class="input-tooltip" id="content-tooltip">내용은 10 글자 이상이어야 합니다.</div>
					</div>
					<textarea name="content" placeholder="내용을 입력하세요"></textarea>
					<div class="buttons-section">
						<button type="submit" class="submit-btn">등록하기</button>
						<button type="button" class="return-btn button-return">돌아가기</button>
					</div>
				</div>
			</div>
		</form>
	</section>

	<!-- 푸터 -->
	<%@ include file="../common/footer.jsp"%>
	
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script type="text/javascript">
		let boardId = <%=boardId %>;
		let movieHeaders = JSON.parse('<%=movieHeadersJson %>');
		let freeHeaders = JSON.parse('<%=freeHeadersJson %>');
	</script>
	<script src="/movmov/resources/script/community/post-form.js"></script>
</body>
</html>
