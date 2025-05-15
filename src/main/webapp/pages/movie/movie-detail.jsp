<%@page import="kr.co.movmov.utils.Pagination"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="kr.co.movmov.vo.ReviewLike"%>
<%@page import="kr.co.movmov.mapper.ReviewLikeMapper"%>
<%@page import="kr.co.movmov.vo.WishMovie"%>
<%@page import="kr.co.movmov.mapper.WishMovieMapper"%>
<%@page import="kr.co.movmov.vo.Review"%>
<%@page import="kr.co.movmov.mapper.ReviewMapper"%>
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
	
	User user = (User) session.getAttribute("LOGIN_USER");
	String userId = "";
	if (user != null) {
		userId = user.getId();
	};
	// 전달받은 영화번호, 페이지번호, 정렬기준
	int movieNo = StringUtils.strToInt(request.getParameter("movieNo"));
	int pageNo = StringUtils.strToInt(request.getParameter("pageNo"), 1);
	String sort = request.getParameter("sort");
	if (sort == null || sort.isEmpty()) {
	    sort = "date-desc";
	}
	
	Map<String, Object> condition = new HashMap<>();
	Map<String, Object> movieCondition = new HashMap<>();
	
	condition.put("movieNo", movieNo);
	condition.put("sort", sort);
	condition.put("sort", sort);
	
	// 페이지당 5개
	condition.put("offset", (pageNo - 1) * 5);
	condition.put("rows", 5);
	
	movieCondition.put("movieNo", movieNo);
	movieCondition.put("offset", 0);
	movieCondition.put("rows", 1);
	
	// 매퍼 불러오기
	MovieMapper movieMapper = MybatisUtils.getMapper(MovieMapper.class);
	MovieGenreMapMapper movieGenreMapMapper = MybatisUtils.getMapper(MovieGenreMapMapper.class);
	ReviewMapper reviewMapper = MybatisUtils.getMapper(ReviewMapper.class);
	WishMovieMapper wishMovieMapper = MybatisUtils.getMapper(WishMovieMapper.class);
	ReviewLikeMapper reviewLikeMapper = MybatisUtils.getMapper(ReviewLikeMapper.class);
	
	// 영화정보 받아오기
	List<Movie> movies = movieMapper.getMovies(movieCondition);
	Movie movie = movies.get(0);

	// 영화장르 받아오기
	List<Genre> genres = movieGenreMapMapper.getGenresByMovieNo(movieNo);
	
	// 리뷰수
	int totalRows = reviewMapper.getTotalRows(condition);
	
	// 해당 영화 리뷰 불러오기
	List<Review> reviews = reviewMapper.getReviews(condition);
	
	// 페이지네이션 객체 만들기
	Pagination pagination = new Pagination(pageNo, totalRows, 5);

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
  <link rel="icon" href="resources/images/common/favicon.ico">
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
	// 로그인 안됐을때
	if (loginUser == null) {
%>
	<div class="mb-auto">
          <!-- 별점과 한 줄 평 -->
          <div class="mb-3">
            <h3>내 별점: 로그인하세요</h3>
            <p><strong>코멘트:</strong> 로그인하세요 </p>
          </div>
<% 
	if (reviews.size() >= 1) {
%>
          <p>평균 별점: <%=String.format("%.1f", movie.getAvgStar()) %>점(<%= reviews.size()%>명)</p>
<%
	}
%>
          <!-- 평가/보고싶어요 버튼 -->
          <div class="action-buttons">
            <form id="test-form" action="../mypage/modal-login.jsp" method="post" class="d-inline-block me-2">
              <button type="submit" class="btn btn-lg btn-primary">로그인하고 평가하기</button>
            </form>
            <form id="test-form2" action="../mypage/modal-login.jsp" method="post" class="d-inline-block">
              <button type="submit" class="btn btn-lg btn-outline-secondary">로그인하고 찜하기</button>
            </form>
          </div>
        </div>
<%
	// 로그인 했을때
	} else {
		// 리뷰가져오기
		Review myReview = reviewMapper.getReviewByUserIdAndMovieNo(user.getId(), movieNo);
		// 찜(현재 로그인 유저, 현재 영화)가져오기
		WishMovie wishMovie = wishMovieMapper.getWishMovieByUserIdAndMovieNo(user.getId(), movieNo);
%>
        <!-- 이 div에 mt-auto 추가해서 아래로 밀기 -->
        <div class="mb-auto">
          <!-- 별점과 한 줄 평 -->
          <div class="mb-3">
<%	
		// 로그인한 유저의 리뷰가 없으면
		if (myReview == null) {
%>			<h3>내 별점: </h3>
			<p>아직 영화를 평가하지 않았습니다</p>
<%		
		// 로그인한 유저의 리뷰가 있으면
		} else {
%>
            <h3>내 별점:
<%
    		for (int i = 0; i < myReview.getStar(); i++) {
%>
    		<span class="star-icon">★</span>
<%
    		}
%>
			</h3>
            <p><strong>내 코멘트:</strong> <%=myReview.getComment() %></p>
<% 
		}
	
%>
          </div>
<% 
	if (reviews.size() >= 1) {
%>
          <p>평균 별점: <%=String.format("%.1f", movie.getAvgStar()) %>점(<%= reviews.size()%>명)</p>
<%
	}
%>
          <!-- 평가/보고싶어요 버튼 -->
          <div class="action-buttons">
            <form action="movie-review.jsp?movieNo=<%=movieNo %>" method="post" class="d-inline-block me-2">
              <input type="hidden" name="movieId" value="1">
              <button type="submit" class="btn btn-lg btn-primary">평가하기</button>
            </form>
            <form id="wish-form" action="<%= wishMovie != null ? "wish-delete.jsp" : "wish-add.jsp" %>" method="post" class="d-inline-block">
			  <input type="hidden" name="movieNo" value="<%= movieNo %>">
			  <input type="hidden" name="wishNo" value="<%= wishMovie != null ? wishMovie.getNo() : 0 %>">
			  <button type="submit" id="wish-button" class="btn btn-lg <%= wishMovie != null ? "btn btn-lg btn-primary" : "btn-no-hover" %>">
			    <%= wishMovie != null ? "찜해제" : "찜하기" %>
			  </button>
			</form>
		  </div>
    	</div>
<%
	}
%>
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
<%
	// 이 영화에 리뷰가 없으면
	if (reviews.isEmpty()) {
%>
		<div class="comment">
            <p>아직 이 영화에 작성된 리뷰가 없습니다</p>
          </div>
<%
	// 이 영화에 리뷰가 있으면
	} else {
%>		
		<div class="mb-3">
		<form action="movie-detail.jsp" method="get" class="d-flex justify-content-between mb-3">
		
			<input type="hidden" name="movieNo" value=<%=movieNo %>>
		  <select name="sort" id="review-sort" class="form-select form-select-sm" style="width:200px;" onchange="this.form.submit()">
		    <option value="date-desc" <%= "date-desc".equals(sort) ? "selected":"" %>>최신 순</option>
		    <option value="date-asc" <%= "date-asc".equals(sort)  ? "selected":"" %>>오래된 순</option>
		    <option value="star-desc" <%= "star-desc".equals(sort) ? "selected":"" %>>별점 높은 순</option>
		    <option value="star-asc" <%= "star-asc".equals(sort)  ? "selected":"" %>>별점 낮은 순</option>
		    <option value="like-desc" <%= "like-desc".equals(sort) ? "selected":"" %>>좋아요 많은 순</option>
		  </select>
		</form>
		</div>

<%		
		for (Review review : reviews) {
			// 이 리뷰의 좋아요 수
			int likeCnt = review.getLikeCnt();
%>
          <div class="comment" data-review-no="<%=review.getNo() %>">
            <p>
            	<strong><%=review.getUser().getNickname() %> </strong> 
            	<small class="text-muted"><%=review.getUpdatedDate() %></small>
            </p>
<%
    		for (int i = 0; i < review.getStar(); i++) {
%>
    		<span class="star-icon">★</span>
<%
    		}
		if (review.getComment() != null) {
%>
            <p><%=review.getComment() %></p>
<%
		} else {
%>
			<p>(코멘트가 없습니다.)</p>
<%
		}
%>
            <!-- 여기에 좋아요 버튼 & 카운트 -->
		    <button class="btn-like">
		      <span class="like-icon"><%=reviewLikeMapper.getReviewLikeByUserIdAndReviewNo(userId, review.getNo()) != null ? "💖" : "🤍" %></span>
		      <span class="like-count"><%=likeCnt %></span>
		    </button>
          </div>
<%
		}
	}
	
%>
        </section>
      </div>
    </div>
    <% 
	if (pagination.getTotalPages() > 0) { 
%>

    <div class="d-flex justify-content-center mt-4">
<%
	//이전 버튼
	if (!pagination.isFirst()) {
%>
	  <a href="movie-detail.jsp?movieNo=<%= movieNo %>&pageNo=<%=pagination.getPrevPage()%>&sort=<%=sort%>" class="btn btn-outline-secondary me-2">이전</a>
<%
	}
	
	// 페이지 번호들
	for (int i = pagination.getBeginPage(); i <= pagination.getEndPage(); i++) {
%>
	  <a href="movie-detail.jsp?movieNo=<%= movieNo %>&pageNo=<%=i%>&sort=<%=sort%>"
	     class="btn btn-outline-secondary me-2 <%= i == pagination.getCurrentPage() ? "active" : "" %>"><%=i%></a>
<%
	}
	
	// 다음 버튼
	if (!pagination.isLast()) {
%>
	  <a href="movie-detail.jsp?movieNo=<%= movieNo %>&pageNo=<%=pagination.getNextPage()%>&sort=<%=sort%>" class="btn btn-outline-secondary me-2">다음</a>
<%
	}
%>
</div>
<% 
	}
%>
  </div>
  </div>

  <%@ include file="../common/footer.jsp" %>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script type="text/javascript">
	  $("#test-form").submit(function() {
	         $("#btn-header-login").trigger("click");
	         return false;
	   });
	  $("#test-form2").submit(function() {
	         $("#btn-header-login").trigger("click");
	         return false;
	   });
	  $(function(){
		// (1) 테스트용 로그: 이게 찍히면 jQuery와 이 스크립트가 로드된 것
		  console.log('좋아요 스크립트 로드');

		  $(document).on('click', '.btn-like', function(){
			  console.log('버튼 클릭 리스너 진입');
			  let $btn = $(this);
			  let reviewNo = $btn.closest('.comment').data('review-no');
			  console.log('리뷰 번호:', reviewNo);
			  $.ajax({
				  url: 'review-like-toggle.jsp',
				  type: 'post',
				  data: { reviewNo },
				  dataType: 'json'
			  })
			  .done(function(res){
				  console.log('AJAX 성공, res=', res);
				  $btn.find('.like-icon')
				  	  .text(res.liked ? '💖' : '🤍');
				  $btn.find('.like-count')
				      .text(res.count);
			  })
			  .fail(function(xhr){
				  if (xhr.status === 401) {
				      alert('로그인이 필요합니다!');
				    } else {
				      console.error(xhr.responseText);
				      alert('요청 중 오류가 발생했습니다.');
				    }
				});
		  	});
		  });
  </script>
  
</body>
</html>