<%@page import="kr.co.movmov.vo.Review"%>
<%@page import="kr.co.movmov.mapper.ReviewMapper"%>
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
	User user = (User) session.getAttribute("LOGIN_USER");
	// 전달받은 영화번호	
	int movieNo = StringUtils.strToInt(request.getParameter("movieNo"));
	
	MovieMapper movieMapper = MybatisUtils.getMapper(MovieMapper.class);
	MovieGenreMapMapper movieGenreMapMapper = MybatisUtils.getMapper(MovieGenreMapMapper.class);
	ReviewMapper reviewMapper = MybatisUtils.getMapper(ReviewMapper.class);
	
	// 영화정보 받아오기
	Movie movie = movieMapper.getMovieByNo(movieNo);
	
	// 영화장르 받아오기
	List<Genre> genres = movieGenreMapMapper.getGenresByMovieNo(movieNo);
	
	// 리뷰 불러오기
	Review review = reviewMapper.getReviewByUserIdAndMovieNo(user.getId(), movieNo);

	
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
<link rel="icon" href="resources/images/common/favicon.ico">
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
    
        
	</div>
	</div>
	</div>
  <div class="container my-5">
    <h1 class="mb-4">평가하기</h1>
<%
	// 리뷰가 없었으면
	if (review == null) {
%>	    
    <form action="review-add.jsp" method="post">
<%
	// 리뷰가 이미 존재하면
	} else {
%>
    <form action="review-update.jsp" method="post">
      <input type="hidden" name="reviewNo" value="<%=review.getNo() %>">
<%
	}
%>
      <input type="hidden" name="movieNo" value="<%=movie.getNo() %>">
<%
	// 리뷰가 없으면
	if (review == null) {
%>
      <!-- 별 평점 선택 -->
      <div class="mb-4">
        <label for="rating" class="form-label">평점</label>
        <div class="star-rating">
		  <input type="radio" id="star5" name="star" value="5">
		  <label for="star5">★</label>
		  <input type="radio" id="star4" name="star" value="4">
		  <label for="star4">★</label>
		  <input type="radio" id="star3" name="star" value="3">
		  <label for="star3">★</label>
		  <input type="radio" id="star2" name="star" value="2">
		  <label for="star2">★</label>
		  <input type="radio" id="star1" name="star" value="1">
		  <label for="star1">★</label>
		</div>
      </div>
<%
	// 리뷰가 있으면
	} else {
%>
      <!-- 별 평점 선택 -->
      <div class="mb-4">
        <label for="rating" class="form-label">평점</label>
        <div class="star-rating">
		  <input type="radio" id="star5" name="star" value="5" <%= review.getStar() == 5 ? "checked" : "" %>>
		  <label for="star5">★</label>
		  <input type="radio" id="star4" name="star" value="4" <%= review.getStar() == 4 ? "checked" : "" %>>
		  <label for="star4">★</label>
		  <input type="radio" id="star3" name="star" value="3" <%= review.getStar() == 3 ? "checked" : "" %>>
		  <label for="star3">★</label>
		  <input type="radio" id="star2" name="star" value="2" <%= review.getStar() == 2 ? "checked" : "" %>>
		  <label for="star2">★</label>
		  <input type="radio" id="star1" name="star" value="1" <%= review.getStar() == 1 ? "checked" : "" %>>
		  <label for="star1">★</label>
		</div>
      </div>
<%
	}
%>
      <!-- 코멘트 입력 -->
      <div class="mb-4">
        <label for="comment" class="form-label">코멘트</label>
<%
	// 리뷰가 없었으면
	if (review == null) {
%>	  
        <textarea class="form-control" id="comment" name="comment" rows="4" placeholder="영화에 대한 생각을 남겨주세요"></textarea>
<%
	} else {
%>
        <textarea class="form-control" id="comment" name="comment" rows="4"><%=review.getComment()%></textarea>
<%
	}
%>
      </div>
      <!-- 리뷰 공개 여부 -->
      <div class="mb-4">
		  <label class="form-label">리뷰 공개 여부</label>
		  <div>
		    <div class="form-check form-check-inline">
		      <input class="form-check-input" type="radio" name="openStatus" id="public" value="Y" <%=(review == null || "Y".equals(review.getOpenStatus())) ? "checked" : "" %>>
		      <label class="form-check-label" for="public">공개</label>
		    </div>
		    <div class="form-check form-check-inline">
		      <input class="form-check-input" type="radio" name="openStatus" id="private" value="N" <%=(review != null && "N".equals(review.getOpenStatus())) ? "checked" : "" %>>
		      <label class="form-check-label" for="private">비공개</label>
		    </div>
		  </div>
		</div>
      
      <!-- 버튼 -->
      <button type="submit" class="btn btn-primary">저장</button>
      <a href="movie-detail.jsp?movieNo=<%=movie.getNo()%>" class="btn btn-secondary">취소</a>
<%
	if (review != null) {
%>
		<a href="review-delete.jsp?reviewNo=<%=review.getNo()%>&movieNo=<%=movieNo %>" class="btn btn-secondary">삭제</a>
<%
	}
%>
    </form>
  </div>
  </div>
  </div>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
<%@ include file="../common/footer.jsp" %>
</html>
