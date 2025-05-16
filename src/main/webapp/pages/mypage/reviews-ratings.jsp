<%@page import="kr.co.movmov.utils.Pagination"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="kr.co.movmov.vo.Movie"%>
<%@page import="kr.co.movmov.mapper.MovieMapper"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.movmov.vo.Review"%>
<%@page import="kr.co.movmov.mapper.ReviewMapper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	User user = (User) session.getAttribute("LOGIN_USER");
	String userId = user.getId();

	String sort = request.getParameter("sort") != null ? request.getParameter("sort") : "latest";

	ReviewMapper reviewMapper = MybatisUtils.getMapper(ReviewMapper.class);
	MovieMapper movieMapper = MybatisUtils.getMapper(MovieMapper.class);

	int pageNo = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
	int rows = 10;
	int totalRows = reviewMapper.getTotalReviewRowsByUserId(userId);

	Pagination pagination = new Pagination(pageNo, totalRows, rows);

	Map<String, Object> condition = new HashMap<>();
	condition.put("userId", userId);
	condition.put("sort", sort);
	condition.put("offset", pagination.getOffset());
	condition.put("limit", pagination.getRows());

	List<Review> reviews = reviewMapper.getReviewsByUserIdSort(condition);

	int beginPage = Math.max(1, pagination.getBeginPage());
	int endPage = Math.max(beginPage, pagination.getEndPage());
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>나의 리뷰 및 평가</title>
	<link rel="stylesheet" href="../style/watcha.css">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
	<link rel="stylesheet" href="/movmov/resources/style/common/main.css">
	<link rel="stylesheet" href="/movmov/resources/style/mypage/watcha.css">
	<script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 text-gray-800">

	<%@ include file="../common/header.jsp"%>

	<div class="max-w-4xl mx-auto py-10">
		<h1 class="text-2xl font-bold mb-6 text-center">나의 리뷰 및 평가</h1>

		<!-- 정렬 옵션 -->
		<form id="form-filter" method="get" action="reviews-ratings.jsp" class="flex justify-end mb-4">
			<label for="sort" class="mr-2 font-medium">정렬:</label>
			<select name="sort" class="border rounded p-2" onchange="this.form.submit()">
				<option value="latest" <%= "latest".equals(sort) ? "selected" : "" %>>최신순</option>
				<option value="rating" <%= "rating".equals(sort) ? "selected" : "" %>>별점 높은순</option>
				<option value="title" <%= "title".equals(sort) ? "selected" : "" %>>제목순</option>
			</select>
		</form>

		<!-- 리뷰 출력 -->
		<div class="space-y-4">
<% 		if (reviews == null || reviews.isEmpty()) 
		{ 
%>
			<p class="text-center text-gray-500">작성한 리뷰가 없습니다.</p>
<% 		} else {
			for (Review review : reviews) {
				int movieNo = review.getMovie().getNo();

%>
			<div class="bg-white rounded-xl shadow p-4">
				<div class="flex justify-between items-center">
					<a href="../movie/movie-detail.jsp?movieNo=<%=review.getMovie().getNo() %>" class="text-lg font-semibold">🎬 <%= review.getMovie().getTitle() %></a>
					<span class="text-yellow-500 font-bold">★ <%= review.getStar() %></span>
				</div>
				<p class="text-sm text-gray-700 mt-2"><%= review.getComment() %></p>
				<div class="mt-3 text-right text-sm text-gray-500">
					<%= StringUtils.detailDate(review.getCreatedDate()) %>
				</div>
			</div>
<% 		}
	} 
	
%>
		</div>

		<!-- 돌아가기 -->
		<div class="mt-10 text-center">
			<a href="page.jsp" class="text-blue-600 hover:underline">← 마이페이지홈으로</a>
		</div>
	</div>

	<!-- 페이지네이션 -->
	<div class="pagination mt-10 flex justify-center items-center space-x-2">
<% 		if (!pagination.isFirst()) 
		{ 
%>
			<a href="#" class="page-link px-3 py-1 border rounded hover:bg-gray-200" data-page-no="<%=pagination.getPrevPage()%>">이전</a>
<% 
		} 
 		for (int i = beginPage; i <= endPage; i++) {
			if (i == pagination.getCurrentPage()) { 
%>
				<span class="page-link px-3 py-1 border rounded bg-pink-500 text-white font-bold"><%=i%></span>
<% 			} else { 
%>
					<a href="#" class="page-link px-3 py-1 border rounded hover:bg-gray-200" data-page-no="<%=i%>"><%=i%></a>
<% 
				   }
		}	
%>

<% 		if (!pagination.isLast()) 
		{ 
%>
			<a href="#" class="page-link px-3 py-1 border rounded hover:bg-gray-200" data-page-no="<%=pagination.getNextPage()%>">다음</a>
<% 
		} 
%>
	</div>

	<!-- 페이지 넘김용 form -->
	<form id="form-page" method="get" action="reviews-ratings.jsp">
		<input type="hidden" name="sort" value="<%=sort != null ? sort : "latest"%>">
		<input type="hidden" name="page" value="<%=pagination.getCurrentPage()%>">
	</form>

	<!-- 페이지 클릭 처리 JS -->
	<script>
		$(".page-link").click(function () {
			let pageNo = $(this).data("page-no");
			let sort = $("select[name=sort]").val();
			$("input[name=page]").val(pageNo);
			$("input[name=sort]").val(sort);
			$("#form-page").submit();
			return false;
		});
	</script>

</body>
</html>