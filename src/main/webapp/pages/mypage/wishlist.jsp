<%@page import="kr.co.movmov.mapper.MovieMapper"%>
<%@page import="org.eclipse.jdt.internal.compiler.ast.WhileStatement"%>
<%@page import="kr.co.movmov.vo.WishMovie"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.movmov.vo.Movie"%>
<%@page import="kr.co.movmov.mapper.WishMovieMapper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	User user = (User) session.getAttribute("LOGIN_USER");
	
	String userId = user.getId();

	WishMovieMapper wishMovieMapper = MybatisUtils.getMapper(WishMovieMapper.class);
	MovieMapper movieMapper = MybatisUtils.getMapper(MovieMapper.class);
	List<WishMovie> wishMovies = wishMovieMapper.getWishMoviesbyUserId(userId);
	

%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>찜한 콘텐츠 | McvMov</title>
  <link rel="stylesheet" href="../style/watcha.css" />
  <link rel="stylesheet" href="../style/wishlist.css" />	
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
<body class="bg-gray-100 text-gray-900">

  <%@ include file="../common/header.jsp" %>

  <main class="max-w-7xl mx-auto p-8">
    <h2 class="text-2xl font-bold mb-6">📌 찜한 콘텐츠</h2>
    <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
      <!-- 🎥 찜한 영화 -->
<%
for (WishMovie wishMovieNo : wishMovies) {
	int moviesNo = wishMovieNo.getMovie().getNo();
	Movie movie = movieMapper.getMovieByNo(moviesNo);
	
%>		

      <section>
        <h3 class="text-xl font-semibold mb-4">🎥 찜한 영화</h3>
        <div class="grid grid-cols-1 gap-4">
          <div class="bg-white rounded-xl shadow p-4 flex gap-4 items-start">
            <img src="../../resources/images/movie/<%=movie.getPosterImagePath() %>" alt="" class="w-24 h-36 object-cover rounded block">
            <div>
              <h4 class="font-bold text-lg mb-1"><%=movie.getTitle() %></h4>
              <p class="text-sm leading-relaxed text-gray-700"><%=movie.getDirector() %></p>
              <p class="text-sm leading-relaxed text-gray-700"><%=movie.getActor() %></p>
            </div>
          </div>
        </div>
      </section>
<% 
	}
%>
      <!-- 🛍️ 찜한 상품 -->
      <section>
        <h3 class="text-xl font-semibold mb-4">🛍️ 찜한 상품</h3>
        <div class="grid grid-cols-1 gap-4">
          <div class="bg-white rounded-xl shadow p-4 flex items-center gap-4">
            <img src="/resources/item1.jpg" alt="상품 이미지" class="w-24 h-24 object-contain block">
            <div>
              <h5 class="font-semibold mb-1">일반 관람권</h5>
              <p class="text-pink-500 font-bold text-sm">₩13,000</p>
            </div>
          </div>
        </div>
      </section>
    </div>

    <!-- ✅ 페이지네이션 추가 -->
    <div class="pagination mt-12 text-center">
      <a href="?page=1" class="inline-block px-4 py-2 rounded bg-pink-500 text-white font-bold">1</a>
      <a href="?page=2" class="inline-block px-4 py-2 rounded hover:bg-gray-300">2</a>
      <a href="?page=3" class="inline-block px-4 py-2 rounded hover:bg-gray-300">3</a>
      <a href="?page=4" class="inline-block px-4 py-2 rounded hover:bg-gray-300">4</a>
      <a href="?page=5" class="inline-block px-4 py-2 rounded hover:bg-gray-300">5</a>
    </div>

    <!-- 마이페이지 홈으로 -->
    <div class="mt-10 text-center">
      <a href="page.jsp" class="text-blue-600 hover:underline text-sm">← 마이페이지 홈으로</a>
    </div>
  </main>

  <%@ include file="../common/footer.jsp" %>
</body>
</html>
