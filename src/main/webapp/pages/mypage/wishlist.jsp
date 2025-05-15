<%@page import="java.util.*"%>
<%@page import="kr.co.movmov.vo.*"%>
<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.utils.Pagination"%>
<%@page import="kr.co.movmov.mapper.WishMovieMapper"%>
<%@page import="kr.co.movmov.mapper.MovieMapper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	User user = (User) session.getAttribute("LOGIN_USER");
	String userId = user.getId();

	int pageNo = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
	int rows = 4;

	WishMovieMapper wishMovieMapper = MybatisUtils.getMapper(WishMovieMapper.class);
	MovieMapper movieMapper = MybatisUtils.getMapper(MovieMapper.class);

	int totalRows = wishMovieMapper.getTotalWishMovieRowsByUserId(userId);
	Pagination pagination = new Pagination(pageNo, totalRows, rows);

	Map<String, Object> condition = new HashMap<>();
	condition.put("userId", userId);
	condition.put("offset", pagination.getOffset());
	condition.put("limit", pagination.getRows());
		
	List<WishMovie> wishMovies = wishMovieMapper.getWishMoviesbyUserIdPaging(condition);

	int beginPage = Math.max(1, pagination.getBeginPage());
	int endPage = Math.max(beginPage, pagination.getEndPage());
%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>📌 찜한 콘텐츠 - MovMov</title>
	<link rel="stylesheet" href="/movmov/resources/style/common/main.css">
	<script src="https://cdn.tailwindcss.com"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body class="bg-gray-100 text-gray-900">

<%@ include file="../common/header.jsp" %>

<main class="max-w-7xl mx-auto p-8">
	<h2 class="text-2xl font-bold mb-6">📌 찜한 콘텐츠</h2>

	<form id="form-page" method="get" action="wishlist.jsp">
		<input type="hidden" name="page" value="<%=pagination.getCurrentPage()%>">
	</form>

	<div class="grid grid-cols-1 md:grid-cols-2 gap-6">
<%
		if (wishMovies == null || wishMovies.isEmpty()) {	
%>
			<p class="text-center text-gray-500">찜한 영화가 없습니다.</p>
<% 		} else {

		for (WishMovie wish : wishMovies) {
			Movie movie = movieMapper.getMovieByNo(wish.getMovie().getNo());
%>
		<div class="bg-white rounded-xl shadow p-4 flex gap-4">
			<img src="/movmov/resources/images/movie/<%=movie.getPosterImagePath()%>" alt="<%=movie.getTitle()%>" class="w-24 h-36 object-cover rounded">
			<div class="flex flex-col justify-between">
				<a href="../movie/movie-detail.jsp?movieNo=<%=wish.getMovie().getNo() %>" class="font-bold text-lg mb-1"><%=movie.getTitle()%></a>
				<p class="text-sm text-gray-700">🎬 <%=movie.getDirector()%></p>
				<p class="text-sm text-gray-700">👥 <%=movie.getActor()%></p>
			</div>
		</div>
<% 		}
	} 
%>
	</div>

			<!-- 페이지네이션 -->
			<div class="pagination mt-10 text-center">
<% 		if (!pagination.isFirst()) 
			{ 
%>
			<a href="#" class="page-link px-3 py-1" data-page-no="<%=pagination.getPrevPage()%>">이전</a>
<% 
			} 
        for (int i = beginPage; i <= endPage; i++) 	{ 
 			if (i == pagination.getCurrentPage()) 
			{ 
%>
				<span class="page-link px-3 py-1 bg-pink-500 text-white font-bold"><%=i%></span>
<% 			} else { 

%>
					<a href="#" class="page-link px-3 py-1" data-page-no="<%=i%>"><%=i%></a>
<% 
				   }  
		} 
	    if (!pagination.isLast()) 
			{ 
%>
		    	<a href="#" class="page-link px-3 py-1" data-page-no="<%=pagination.getNextPage()%>">다음</a>
<% 
			} 
%>
		  </div>

		<div class="mt-10 text-center">
			<a href="page.jsp" class="text-blue-600 hover:underline text-sm">← 마이페이지 홈으로</a>
		</div>
</main>

<%@ include file="../common/footer.jsp" %>

<script>
	$(".page-link").click(function () {
		let pageNo = $(this).data("page-no");
		$("input[name=page]").val(pageNo);
		$("#form-page").submit();
		return false;
	});
</script>

</body>
</html>
