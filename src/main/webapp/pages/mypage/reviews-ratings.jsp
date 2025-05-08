<%@page import="kr.co.movmov.vo.Movie"%>
<%@page import="kr.co.movmov.mapper.MovieMapper"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.movmov.vo.Review"%>
<%@page import="kr.co.movmov.mapper.ReviewMapper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	User user = (User) session.getAttribute("LOGIN_USER");
	String userId = user.getId();
	
	ReviewMapper reviewMapper = MybatisUtils.getMapper(ReviewMapper.class);
	MovieMapper movieMapper = MybatisUtils.getMapper(MovieMapper.class);
	
	List<Review> reviews = reviewMapper.getReviewsByUserId(userId);

	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>나의 리뷰 및 평가</title>
  <link rel="stylesheet" href="../style/watcha.css"> 
    <!-- ✅ 추가한 필수 링크들 -->
  <!-- 구글 폰트 (Noto Sans KR) -->
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">

  <!-- Font Awesome 아이콘 -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

  <!-- 메인 공통 CSS -->
  <link rel="stylesheet" href="/movmov/resources/style/common/main.css">

  <!-- 마이페이지 전용 watcha 스타일 -->
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
    <div class="flex justify-end mb-4">
      <label for="sort" class="mr-2 font-medium">정렬:</label>
      <select id="sort" class="border rounded p-2">
        <option value="latest">최신순</option>
        <option value="rating">별점 높은순</option>
        <option value="title">제목순</option>
      </select>
    </div>

<%
	for (Review review : reviews) {
		int movieNo = review.getMovie().getNo();

%>
    <!-- 리뷰 목록 -->
    <div class="space-y-4">
      <!-- 리뷰 카드 예시 (5개) -->
      <div class="bg-white rounded-xl shadow p-4">
        <div class="flex justify-between items-center">
          <h3 class="text-lg font-semibold">🎬 <%=review.getMovie().getTitle() %> </h3>
          <span class="text-yellow-500 font-bold">★ <%=review.getStar() %></span>
        </div>
        <p class="text-sm text-gray-700 mt-2"><%=review.getComment() %></p>
        <div class="mt-3 text-right text-sm text-gray-500"><%=review.getCreatedDate() %></div>
      </div>
    </div>
<% 	
	}
%>   

<!-- 페이지네이션 -->
<div class="mt-10 flex justify-center space-x-2 text-sm">
  <a href="?page=1" class="px-3 py-1 border rounded bg-pink-500 text-white">1</a>
  <a href="?page=2" class="px-3 py-1 border rounded hover:bg-pink-400 hover:text-white">2</a>
  <a href="?page=3" class="px-3 py-1 border rounded hover:bg-pink-400 hover:text-white">3</a>
  <a href="?page=4" class="px-3 py-1 border rounded hover:bg-pink-400 hover:text-white">4</a>
  <a href="?page=5" class="px-3 py-1 border rounded hover:bg-pink-400 hover:text-white">5</a>
</div>

    <!-- 돌아가기 링크 -->
    <div class="mt-10 text-center">
      <a href="page.jsp" class="text-blue-600 hover:underline">← 마이페이지 홈으로</a>
    </div>
  </div>


  <!-- 푸터 -->
  <%@ include file="../common/footer.jsp" %>
</body>
</html>
