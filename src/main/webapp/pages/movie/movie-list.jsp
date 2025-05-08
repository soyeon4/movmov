<%@page import="kr.co.movmov.mapper.MovieGenreMapMapper"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@page import="kr.co.movmov.vo.Genre"%>
<%@page import="kr.co.movmov.mapper.GenreMapper"%>
<%@page import="kr.co.movmov.vo.Review"%>
<%@page import="kr.co.movmov.mapper.ReviewMapper"%>
<%@page import="kr.co.movmov.vo.Movie"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.mapper.MovieMapper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   MovieMapper movieMapper = MybatisUtils.getMapper(MovieMapper.class);
   List<Movie> movies = movieMapper.getMovies();
   
   ReviewMapper reviewMapper = MybatisUtils.getMapper(ReviewMapper.class);
   
   GenreMapper genreMapper = MybatisUtils.getMapper(GenreMapper.class);
   List<Genre> allGenres = genreMapper.getAllGenres();
   
   MovieGenreMapMapper movieGenreMapMapper = MybatisUtils.getMapper(MovieGenreMapMapper.class);
   
   
   //String loginedUserId = (String) session.getAttribute("LOGINED_USER_ID");
   
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>영화 목록</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="../../resources/style/movie/movie-list.css">
  <link
   href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap"
   rel="stylesheet">
  <link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
  <link rel="stylesheet" href="../../resources/style/common/main.css">
</head>
<body>
   <%@ include file="../common/header.jsp" %>
   <div class="search-container">
  <form action="movie-list.jsp" method="get" class="search-form">
    <div class="search-item">
      <label for="movie-title">영화제목</label>
      <input id="movie-title" name="title" value="<%=request.getParameter("title") != null ? request.getParameter("title") : "" %>" placeholder="제목" />
    </div>
    <div class="search-item">
      <label for="director-name">감독명</label>
      <input id="director-name" name="director" value="<%=request.getParameter("director") != null ? request.getParameter("director") : "" %>" placeholder="감독명" />
    </div>
    <div class="search-item">
      <label for="genre">장르</label>
      <select id="genre" name="genre">
        <option value="">장르 선택</option>
<%
   for (Genre genre : allGenres) {
%>
        <option value="<%=genre.getNo() %>" <%=genre.getNo() == StringUtils.strToInt(request.getParameter("genre"), 0) ? "selected" : "" %>><%=genre.getName() %></option>
<%
   }
%>     
      </select>
    </div>
    <div class="search-item">
      <label for="release-year">개봉연도</label>
      <select id="release-year" name="year">
        <option value="">연도 선택</option>
<%
   for (int i = 2000; i<2025; i++) {
%>
        <option value="<%=i %>" <%=i == StringUtils.strToInt(request.getParameter("year"), 0) ? "selected" : "" %>><%=i %></option>
<%
   }
%>
        <!-- 연도 옵션은 서버에서 동적으로 생성하거나 JavaScript로 추가할 수 있습니다 -->
      </select>
      </div>
      <div class="search-item">
      <label for="director-name">평점</label>
      
         <select name="star">
           <option value="">평점 선택</option>
           <option value="4" <%= "4".equals(request.getParameter("star")) ? "selected" : "" %>>4점 이상</option>
           <option value="3" <%= "3".equals(request.getParameter("star")) ? "selected" : "" %>>3점 이상</option>
           <option value="2" <%= "2".equals(request.getParameter("star")) ? "selected" : "" %>>2점 이상</option>
           <option value="1" <%= "1".equals(request.getParameter("star")) ? "selected" : "" %>>1점 이상</option>
         </select>
      </div>
      <div class="search-item">
      <label for="director-name">상영등급</label>
      
         <select name="rating">
           <option value="">상영등급 선택</option>
           <option value="all" <%= "all".equals(request.getParameter("rating")) ? "selected" : "" %>>전체</option>
           <option value="12" <%= "12".equals(request.getParameter("rating")) ? "selected" : "" %>>12세</option>
           <option value="15" <%= "15".equals(request.getParameter("rating")) ? "selected" : "" %>>15세</option>
           <option value="adult" <%= "adult".equals(request.getParameter("rating")) ? "selected" : "" %>>청불</option>
         </select>
      </div>
    <button type="submit" class="btn-search">검색</button>
  </form>
</div>
  <div class="container">
    <h1 class="mb-4">영화 목록</h1>
    <select class="form-select form-select-sm mb-3" name="sort" style="width: 140px;">
     <option value="length" <%= "length".equals(request.getParameter("sort")) ? "selected" : "" %>>상영시간 순</option>
     <option value="star" <%= "star".equals(request.getParameter("sort")) ? "selected" : "" %>>평점 순</option>
     <option value="reviews" <%= "reviews".equals(request.getParameter("sort")) ? "selected" : "" %>>리뷰 많은 순</option>
     <option value="year-asc" <%= "year-asc".equals(request.getParameter("sort")) ? "selected" : "" %>>개봉연도 오름차 순</option>
     <option value="year-desc" <%= "year-desc".equals(request.getParameter("sort")) ? "selected" : "" %>>개봉연도 내림차 순</option>
   </select>
    <table class="table table-hover align-middle">
      <thead class="table-light">
        <tr >
          <th scope="col" style="width: 5%;">포스터</th>
          <th scope="col" style="width: 10%;">제목</th>
          <th scope="col" style="width: 5%;">개봉연도</th>
          <th scope="col" style="width: 15%;">장르</th>
          <th scope="col" style="width: 10%;">감독</th>
          <th scope="col" style="width: 7%;">상영시간</th>
          <th scope="col" style="width: 7%;">상영등급</th>
          <th scope="col" style="width: 7%;">평균 별점</th>
        </tr>
      </thead>
      <tbody>
<% 
   for (Movie movie : movies) {
      List<Review> reviews = reviewMapper.getReviewsByMovieNo(movie.getNo());
      List<Genre> genres = movieGenreMapMapper.getGenresByMovieNo(movie.getNo());
      
      int starSum = 0;
      double starAvg = 0;
      
      for (Review review : reviews) {
         starSum += review.getStar();
      }
      starAvg = (reviews.size() != 0) ? (double) starSum / reviews.size() : 0;
%>
        <tr class="movie-row">
          <td><a href="movie-detail.jsp?movieNo=<%=movie.getNo() %>"><img src="../../resources/images/movie/<%=movie.getPosterImagePath() %>" alt="포스터" class="movie-poster"></a></td>
          <td><a href="movie-detail.jsp?movieNo=<%=movie.getNo() %>"><%=movie.getTitle() %></a></td>
          <td><%=movie.getReleaseYear() %> 년</td>
          <td>
          <%
                for (Genre genre : genres) {
          %>   
                <%=genre.getName() %>
          <%
                   }
          %> 
          </td>
          <td><%=movie.getDirector() %></td>
          <td><%=movie.getLength() %> 분</td>
          <td><%=movie.getRating() %></td>
          <td><%=String.format("%.1f", starAvg) %>점</td>
        </tr>
<%
   }
%>        
      </tbody>
    </table>
    <div class="d-flex justify-content-center mt-4">
  <button class="btn btn-outline-secondary me-2">이전</button>
  <button class="btn btn-outline-secondary me-2">1</button>
  <button class="btn btn-outline-secondary me-2">2</button>
  <button class="btn btn-outline-secondary me-2">3</button>
  <button class="btn btn-outline-secondary me-2">4</button>
  <button class="btn btn-outline-secondary me-2">5</button>
  <button class="btn btn-outline-secondary me-2">다음</button>
</div>
  </div>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
   <%@ include file="../common/footer.jsp" %>
</html>
    