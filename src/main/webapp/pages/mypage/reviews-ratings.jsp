<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="kr.co.movmov.vo.Movie"%>
<%@page import="kr.co.movmov.mapper.MovieMapper"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.movmov.vo.Review"%>
<%@page import="kr.co.movmov.mapper.ReviewMapper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    User user = (User) session.getAttribute("LOGIN_USER");
    String userId = user.getId();


    String sort = request.getParameter("sort");

    ReviewMapper reviewMapper = MybatisUtils.getMapper(ReviewMapper.class);
    MovieMapper movieMapper = MybatisUtils.getMapper(MovieMapper.class);

    
    Map<String, Object> condition = new HashMap<>();
    condition.put("userId", userId);
    condition.put("sort", sort);
 
    List<Review> reviews = reviewMapper.getReviewsByUserIdSort(condition);
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

  <!-- 상단 네비게이션 -->
  <%@ include file="../common/header.jsp" %>

  <!-- 본문 -->
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
    <% for (Review review : reviews) {
         int movieNo = review.getMovie().getNo();
    %>
      <div class="bg-white rounded-xl shadow p-4">
        <div class="flex justify-between items-center">
          <h3 class="text-lg font-semibold">🎬 <%= review.getMovie().getTitle() %></h3>
          <span class="text-yellow-500 font-bold">★ <%= review.getStar() %></span>
        </div>
        <p class="text-sm text-gray-700 mt-2"><%= review.getComment() %></p>
        <div class="mt-3 text-right text-sm text-gray-500"><%= review.getCreatedDate() %></div>
      </div>
    <% } %>
    </div>

    <!-- 돌아가기 -->
    <div class="mt-10 text-center">
      <a href="page.jsp" class="text-blue-600 hover:underline">← 마이페이지 홈으로</a>
    </div>
  </div>

  <!-- 푸터 -->
  <%@ include file="../common/footer.jsp" %>
</body>
</html>
