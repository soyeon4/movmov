<%@page import="kr.co.movmov.vo.WishMovie"%>
<%@page import="kr.co.movmov.mapper.WishMovieMapper"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.movmov.mapper.ReviewMapper"%>
<%@page import="kr.co.movmov.vo.Review"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="kr.co.movmov.vo.User"%>
<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.mapper.UserMapper"%>

<%
    User user = (User) session.getAttribute("LOGIN_USER");
	String userId = user.getId();	

	ReviewMapper reviewMapper = MybatisUtils.getMapper(ReviewMapper.class);
	WishMovieMapper whisMovieMapper = MybatisUtils.getMapper(WishMovieMapper.class);
	
	List<WishMovie> wishMovies = whisMovieMapper.getWishMoviesbyUserId(userId);
	List<Review> reviews = reviewMapper.getReviewsByUserId(userId);
%>
	

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>마이페이지 | McvMov</title>

  <!-- ✅ 추가한 필수 링크들 -->
  <!-- 구글 폰트 (Noto Sans KR) -->
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">

  <!-- Font Awesome 아이콘 -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

  <!-- 메인 공통 CSS -->
  <link rel="stylesheet" href="/movmov/resources/style/common/main.css">

  <!-- 마이페이지 전용 watcha 스타일 -->
  <link rel="stylesheet" href="/movmov/resources/style/mypage/watcha.css">

  <!-- Tailwind CSS -->
  <script src="https://cdn.tailwindcss.com"></script>
</head>

<!-- ✅ body에 기본 색상 적용 -->
<body class="bg-gray-100 text-gray-900">

  <!-- ✅ (필요하면 header.jsp include 추가 가능) -->
  <%@ include file="../common/header.jsp" %>

  <!-- 마이페이지 본문 -->
  <section class="container">

    <!-- 프로필 요약 -->
    <div class="profile-box">
      <img src="/movmov/resources/images/mypage/default-profile.png" alt="기본 프로필" class="profile-img" />
      <div>
        <h2><%=user.getName() %></h2>
        <p class="bio"><%=user.getEmail() %></p>
        <div class="stats">
<%
			int totalReviewCount = reviews.size();
			int totalWishMovieCount = wishMovies.size(); 
%>
        <a href="reviews-ratings.jsp">총 리뷰 <%=totalReviewCount %></a>
          <a href="wishlist.jsp">찜한 작품<%=totalWishMovieCount %></a>
        </div>
      </div>
      <a href="settings.jsp" class="settings-btn" title="설정">⚙</a>
    </div>

    <!-- 최근 활동 -->
    <div class="recent-section">
      <h3>최근 활동</h3>
      <div class="recent-box">
        <div>
          <h4>최근 리뷰</h4>
          <ul>
<%

	int reviewcount = 0;
	for (Review review : reviews) {
		if (reviewcount <= 4) {
%>      
            <li><a href="#">🎬 [<%=review.getMovie().getTitle() %>] - <%=review.getComment() %></a></li>
<%
		reviewcount++;
		}
	}
%>        
          </ul>
          <a href="reviews-ratings.jsp" class="more">더보기</a>
        </div>
        <div>
          <h4>찜한 작품</h4>
          <ul>
<%	

	int wishMoviecount = 0;
	for (WishMovie wishMovie : wishMovies) {
		if (wishMoviecount <= 4) {
%>          
            <li><a href="#">📌 <%=wishMovie.getMovie().getTitle() %></a></li>
<%
		System.out.println("wishMovie.getMovie().getTitle(): " + wishMovie.getMovie().getTitle());
		wishMoviecount++;
		}
	}
		
		
%>            
          </ul>
          <a href="wishlist.jsp" class="more">더보기</a>
        </div>
      </div>
    </div>

    <!-- 링크 카드 -->
    <div class="link-grid">
      <a href="reviews-ratings.jsp" class="link-card">
        <h4>나의 리뷰 및 평가</h4>
        <p>작성한 리뷰와 별점 확인</p>
      </a>
      <a href="review-calendar.jsp" class="link-card">
        <h4>리뷰 캘린더</h4>
        <p>날짜별 감상 기록</p>
      </a>
      <a href="user-community.jsp" class="link-card">
        <h4>나의 게시글</h4>
        <p>작성한 게시글</p>
      </a>
      <a href="wishlist.jsp" class="link-card">
        <h4>찜한 작품</h4>
        <p>보관한 작품</p>
      </a>
    </div>
  </section>

  <!-- ✅ Footer include -->
  <%@ include file="../common/footer.jsp" %>
</body>
</html>
