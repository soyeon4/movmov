<%@page import="kr.co.movmov.utils.Pagination"%>
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
	// 페이지
	int pageNo = StringUtils.strToInt(request.getParameter("page"), 1);

	// 정렬조건
	String sort = request.getParameter("sort");

	// 검색조건
	String title = request.getParameter("title");
	String director = request.getParameter("director");
	String rating = request.getParameter("rating");
	int genreNo = StringUtils.strToInt(request.getParameter("genreNo"), 0);
	int year = StringUtils.strToInt(request.getParameter("year"), 0);
	int star = StringUtils.strToInt(request.getParameter("star"), 0);
	
	MovieMapper movieMapper = MybatisUtils.getMapper(MovieMapper.class);
	ReviewMapper reviewMapper = MybatisUtils.getMapper(ReviewMapper.class);
	GenreMapper genreMapper = MybatisUtils.getMapper(GenreMapper.class);
	MovieGenreMapMapper movieGenreMapMapper = MybatisUtils.getMapper(MovieGenreMapMapper.class);

	// 검색조건
	Map<String, Object> condition = new HashMap<>();
	
	if (sort != null && !sort.isEmpty()) {
		condition.put("sort", sort);
	}
	condition.put("title", title != null ? title : "");
	condition.put("director", director != null ? director : "");
	condition.put("rating", rating != null ? rating : "");
	if (genreNo != 0) condition.put("genreNo", genreNo);
	if (year != 0) condition.put("year", year);
	if (star != 0) condition.put("star", star);
	
	condition.put("offset", (pageNo - 1) * 10);
	condition.put("rows", 10);
	
	
	
	
	List<Genre> allGenres = genreMapper.getAllGenres();
	
	// 페이지네이션 객체
	int totalRows = movieMapper.getTotalRows(condition);
	Pagination pagination = new Pagination(pageNo, totalRows, 10);
	
	List<Movie> movies = movieMapper.getMovies(condition);

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
  <link rel="icon" href="resources/images/common/favicon.ico">
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
      <select id="genre" name="genreNo">
        <option value="">장르 선택</option>
<%
   for (Genre genre : allGenres) {
%>
        <option value="<%=genre.getNo() %>" <%=genre.getNo() == StringUtils.strToInt(request.getParameter("genreNo"), 0) ? "selected" : "" %>><%=genre.getName() %></option>

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
			  <option value="전체" <%= "전체".equals(request.getParameter("rating")) ? "selected" : "" %>>전체</option>
			  <option value="12세" <%= "12세".equals(request.getParameter("rating")) ? "selected" : "" %>>12세</option>
			  <option value="15세" <%= "15세".equals(request.getParameter("rating")) ? "selected" : "" %>>15세</option>
			  <option value="청불" <%= "청불".equals(request.getParameter("rating")) ? "selected" : "" %>>청불</option>
			</select>
		</div>

    <button type="submit" class="btn-search">검색</button>
  </form>
</div>
  <div class="container">
    <h1 class="mb-4">영화 목록</h1>
    <form id="sort-form" action="movie-list.jsp" method="get" onchange="document.getElementById('sort-form').submit();">
    <select class="form-select form-select-sm mb-3" name="sort" style="width: 150px;">
	  <option value="">정렬 기준</option>
	  <option value="length-asc" <%= "length-asc".equals(request.getParameter("sort")) ? "selected" : "" %>>상영시간 짧은 순</option>
	  <option value="length-desc" <%= "length-desc".equals(request.getParameter("sort")) ? "selected" : "" %>>상영시간 긴 순</option>
	  <option value="star-asc" <%= "star-asc".equals(request.getParameter("sort")) ? "selected" : "" %>>평균평점 낮은 순</option>
	  <option value="star-desc" <%= "star-desc".equals(request.getParameter("sort")) ? "selected" : "" %>>평균평점 높은 순</option>
	  <option value="reviews" <%= "reviews".equals(request.getParameter("sort")) ? "selected" : "" %>>리뷰 많은 순</option>
	  <option value="wishes" <%= "wishes".equals(request.getParameter("sort")) ? "selected" : "" %>>찜 많은 순</option>
	  <option value="year-asc" <%= "year-asc".equals(request.getParameter("sort")) ? "selected" : "" %>>개봉연도 오래된 순</option>
	  <option value="year-desc" <%= "year-desc".equals(request.getParameter("sort")) ? "selected" : "" %>>개봉연도 최신 순</option>
	</select>
	  <input type="hidden" name="title" value="<%=request.getParameter("title") != null ? request.getParameter("title") : "" %>">
	  <input type="hidden" name="director" value="<%=request.getParameter("director") != null ? request.getParameter("director") : "" %>">
	  <input type="hidden" name="genreNo" value="<%=genreNo != 0 ? genreNo : "" %>">
		<input type="hidden" name="year" value="<%=year != 0 ? year : "" %>">
		<input type="hidden" name="star" value="<%=star != 0 ? star : "" %>">
	  <input type="hidden" name="rating" value="<%=request.getParameter("rating") != null ? request.getParameter("rating") : "" %>">
	  <input type="hidden" name="page" value="1">
	  
	</form>

    <table class="table table-hover align-middle">
      <thead class="table-light">
        <tr >
          <th scope="col" style="width: 2%;">포스터</th>
          <th scope="col" style="width: 10%;">제목</th>
          <th scope="col" style="width: 7%;">개봉연도</th>
          <th scope="col" style="width: 5%;">국가</th>
          <th scope="col" style="width: 15%;">장르</th>
          <th scope="col" style="width: 10%;">감독</th>
          <th scope="col" style="width: 7%;">상영시간</th>
          <th scope="col" style="width: 7%;">상영등급</th>
          <th scope="col" style="width: 7%;">평균 별점</th>
          <th scope="col" style="width: 7%;">찜 수</th>
        </tr>
      </thead>
      <tbody>
<% 
   for (Movie movie : movies) {
      List<Genre> genres = movieGenreMapMapper.getGenresByMovieNo(movie.getNo());
%>
        <tr class="movie-row">
          <td><a href="movie-detail.jsp?movieNo=<%=movie.getNo() %>"><img src="../../resources/images/movie/<%=movie.getPosterImagePath() %>" alt="포스터" class="movie-poster"></a></td>
          <td><a href="movie-detail.jsp?movieNo=<%=movie.getNo() %>"><%=movie.getTitle() %></a></td>
          <td><%=movie.getReleaseYear() %> 년</td>
          <td><%=movie.getCountry() %></td>
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
          <td><%=String.format("%.1f", movie.getAvgStar()) %>점 (<%=movie.getReviewCnt() %>명)</td>
          <td><%=movie.getWishCnt() %></td>
        </tr>
<%
   }
%>        
      </tbody>
    </table>
<% 
	if (pagination.getTotalPages() > 0) { 
%>

    <div class="d-flex justify-content-center mt-4">
<%
	//검색조건 및 정렬 파라미터 유지
	String queryParams = "";
		if (title != null) queryParams += "&title=" + title;
		if (director != null) queryParams += "&director=" + director;
		if (rating != null) queryParams += "&rating=" + rating;
		if (genreNo != 0) queryParams += "&genreNo=" + genreNo;
		if (year != 0) queryParams += "&year=" + year;
		if (star != 0) queryParams += "&star=" + star;
		if (sort != null) queryParams += "&sort=" + sort;
	//이전 버튼
	if (!pagination.isFirst()) {
%>
	  <a href="movie-list.jsp?page=<%=pagination.getPrevPage()%><%=queryParams%>" class="btn btn-outline-secondary me-2">이전</a>
<%
	}
	
	// 페이지 번호들
	for (int i = pagination.getBeginPage(); i <= pagination.getEndPage(); i++) {
%>
	  <a href="movie-list.jsp?page=<%=i%><%=queryParams%>"
	     class="btn btn-outline-secondary me-2 <%= i == pagination.getCurrentPage() ? "active" : "" %>"><%=i%></a>
<%
	}
	
	// 다음 버튼
	if (!pagination.isLast()) {
%>
	  <a href="movie-list.jsp?page=<%=pagination.getNextPage()%><%=queryParams%>" class="btn btn-outline-secondary me-2">다음</a>
<%
	}
%>
</div>
<% 
	} else {
%>
	<div class="text-center my-5">
    <p class="text-muted fs-5">검색 결과가 없습니다.</p>
  </div>
	



<%
	}
%>
  </div>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
   <%@ include file="../common/footer.jsp" %>
</html>
    