<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.vo.Genre"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.movmov.mapper.MovieGenreMapMapper"%>
<%@page import="kr.co.movmov.vo.Movie"%>
<%@page import="kr.co.movmov.mapper.MovieMapper"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int movieNo = StringUtils.strToInt(request.getParameter("movieNo"));
	
	MovieMapper movieMapper = MybatisUtils.getMapper(MovieMapper.class);
	
	Movie movie = movieMapper.getMovieByNo(movieNo);
	
	MovieGenreMapMapper movieGenreMapMapper = MybatisUtils.getMapper(MovieGenreMapMapper.class);
	List<Genre> genres = movieGenreMapMapper.getGenresByMovieNo(movieNo);

	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title><%=movie.getTitle() %> - 평가하기</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="../../resources/style/movie/movie-review.css">
  <link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
<link rel="stylesheet" href="../../resources/style/common/main.css">
</head>
</head>
<body>
	<%@ include file="../common/header.jsp" %>
	
	<div class="container my-5">
    <div class="row mb-4 align-items-stretch grid-wrapper">
      <!-- 포스터 -->
      <div class="col-lg-4 text-center mb-4 h-100">
        <img src="../../resources/images/movie/<%=movie.getPosterImagePath() %>" alt="포스터" class="img-fluid rounded">
      </div>
      <!-- 우측 영역: 제목(상단) + 별점·한줄평+버튼(하단) -->
      <div class="col-lg-8 d-flex flex-column h-100">
        <!-- 제목 및 기본 정보 (상단 고정) -->
        <div class="pt-1">
          <h1><%=movie.getTitle() %></h1>
          <p><%=movie.getReleaseYear() %> · 
          <%
          		for (Genre genre : genres) {
          %>	
          		<%=genre.getName() %>
          <%
          			}
          %>  
          · <%=movie.getLength() %>분 · <%=movie.getRating() %></p>
        </div>
        <!-- 영화 설명 -->
        <div class="mb-auto" id="description">
          <h2>줄거리</h2>
          <p><%=movie.getPlot() %></p>
        </div>
    
        <!-- 이 div에 mt-auto 추가해서 아래로 밀기 -->
        <div class="mb-auto">
          <!-- 별점과 한 줄 평 -->
          <div class="mb-3">
            <h3>내 별점: ${userRating} ★</h3>
            <p><strong>코멘트:</strong> ${userReview}</p>
          </div>
          </div>
          </div>
	
  <div class="container my-5">
    <h1 class="mb-4">${movie.title} 평가하기</h1>
    <form action="/submitRating" method="post">
      <input type="hidden" name="movieId" value="${movie.id}">
      
      <!-- 별 평점 선택 -->
      <div class="mb-4">
        <label for="rating" class="form-label">평점</label>
        <div class="star-rating">
		  <input type="radio" id="star5" name="rating" value="5">
		  <label for="star5">★</label>
		  <input type="radio" id="star4" name="rating" value="4">
		  <label for="star4">★</label>
		  <input type="radio" id="star3" name="rating" value="3">
		  <label for="star3">★</label>
		  <input type="radio" id="star2" name="rating" value="2">
		  <label for="star2">★</label>
		  <input type="radio" id="star1" name="rating" value="1">
		  <label for="star1">★</label>
		</div>
      </div>

      <!-- 코멘트 입력 -->
      <div class="mb-4">
        <label for="comment" class="form-label">코멘트</label>
        <textarea class="form-control" id="comment" name="comment" rows="4" placeholder="영화에 대한 생각을 남겨주세요"></textarea>
      </div>
      
      <!-- 버튼 -->
      <button action type="submit" class="btn btn-primary">제출</button>
      <a href="detail.html" class="btn btn-secondary">취소</a>
    </form>
  </div>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
<%@ include file="../common/footer.jsp" %>
</html>
