<%@page import="kr.co.movmov.vo.User"%>
<%@page import="kr.co.movmov.vo.Genre"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.movmov.mapper.MovieGenreMapMapper"%>
<%@page import="kr.co.movmov.vo.Movie"%>
<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.mapper.MovieMapper"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	User loginedUser = (User) session.getAttribute("LOGINED_USER");
	
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
  <title><%=movie.getTitle() %> - 영화 상세</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Custom CSS -->
  <link rel="stylesheet" href="../../resources/style/movie/movie-detail.css">
  <link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap"
	rel="stylesheet">
  <link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
  <link rel="stylesheet" href="../../resources/style/common/main.css">
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
<%
	// 로그인 시
	//if (loginedUser != null) {
%>
        <!-- 이 div에 mt-auto 추가해서 아래로 밀기 -->
        <div class="mb-auto">
          <!-- 별점과 한 줄 평 -->
          <div class="mb-3">
            <h3>내 별점: ${userRating} ★</h3>
            <p><strong>코멘트:</strong> <%=movie.getPlot() %></p>
          </div>
          <!-- 평가/보고싶어요 버튼 -->
          <div class="action-buttons">
            <form action="movie-review.jsp?movieNo=<%=movieNo %>" method="post" class="d-inline-block me-2">
              <input type="hidden" name="movieId" value="1">
              <button type="submit" class="btn btn-lg btn-primary">평가하기</button>
            </form>
            <form action="/wishlist" method="post" class="d-inline-block">
              <input type="hidden" name="movieId" value="1">
              <input type="hidden" name="userId" value="">
              <button type="submit" class="btn btn-lg btn-outline-secondary">찜하기</button>
            </form>
          </div>
        </div>
<%
	//}
%>
      </div>
    </div>


    

    <div class="row">
      <div class="col-lg-12">
        
        <!-- 출연/제작인원 -->
        <section class="content-section" id="cast-crew">
          <h2>제작 및 출연</h2>
          <ul>
            <li><strong>감독:</strong> <%=movie.getDirector() %></li>
            <li><strong>출연:</strong> <%=movie.getActor() %></li>
          </ul>
        </section>
        <!-- 코멘트 모음 -->
        <section class="content-section" id="comments">
          <h2>코멘트 모음</h2>
          <div class="comment">
            <p><strong>영화팬</strong> <small class="text-muted">2025-04-20</small></p>
            <p>이 영화는 정말 혁신적이었어요. 액션과 스토리가 잘 결합되어 너무 좋았어요!</p>
          </div>
          <div class="comment">
            <p><strong>영화덕후</strong> <small class="text-muted">2025-04-21</small></p>
            <p>처음 봤을 때 충격적이었고, 아직도 그 장면들이 기억에 남아요.</p>
          </div>
        </section>
      </div>
    </div>
  </div>

  <%@ include file="../common/footer.jsp" %>>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>