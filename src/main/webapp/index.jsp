<%@page import="kr.co.movmov.vo.Post"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.movmov.mapper.PostMapper"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	PostMapper postMapper = MybatisUtils.getMapper(PostMapper.class);
	Map<String, Object> conditionMoviePopular = new HashMap<>();
	conditionMoviePopular.put("sort", "views");
	conditionMoviePopular.put("rows", 5);
	List<Post> popularMoviePosts = postMapper.getPosts(conditionMoviePopular);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>MovMov</title>
<link rel="icon" href="resources/images/common/favicon.ico">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="resources/style/common/main.css">
</head>
<%@ include file="pages/common/header.jsp"%>

<body>
   <main>
      <section class="top-section">
         <div class="article-card">
            <a href="pages/movie/movie-detail.jsp?movieNo=88">
            <img
               src="resources/images/movie/88.webp"
               alt="역샤 이미지">
	         </a>
            <div class="label">고전 명작 재개봉</div>
            <div class="content">
               <h3>일본 애니메이션 고전 명작 &lt;기동 전사 건담 역습의 샤아&gt; 한국 개봉</h3>
            </div>
         </div>

         <div class="hot-title-card">
            <div class="label">지금 가장 핫한 작품</div>
            <a href="pages/movie/movie-detail.jsp?movieNo=82">
            <img
               src="resources/images/movie/82.webp"
               alt="콘클라베 포스터">
            </a>
            <h3>콘클라베</h3>
            <p>실제로 진행된 콘클라베로 인해 재조명!</p>
         </div>

         <div class="trailer-card">
         	<a href="pages/movie/movie-detail.jsp?movieNo=81">
            <img
               src="resources/images/movie/81.webp"
               alt="야당">
            </a>
            <div class="trailer-info">
               <div class="label">박스오피스 1위 영화</div>
               <h4>야당</h4>
            	<p>범죄 드라마 | 한국</p>
            </div>
         </div>
      </section>

		<section class="menu-section">
			<a href="pages/movie/movie-list.jsp">
				<button type="button">🎬 영화</button>
			</a>
			<a href="pages/shop/shop-main.jsp">
				<button type="button">🎁 Mov Commerce</button>
			</a>
			<a href="pages/community/community-main.jsp">
				<button type="button">📊 커뮤니티</button>
			</a>
		</section>
	</main>

   <!-- 영화 굿즈 베스트 섹션 -->
   <section class="goods-section">
      <h2>🎁 인기 영화 굿즈</h2>
      <div class="goods-list">
         <div class="goods-card">
            <img src="https://via.placeholder.com/200x200" alt="굿즈 이미지">
            <h4>쉬리 포스터</h4>
            <p>₩10,000</p>
         </div>
         <div class="goods-card">
            <img src="https://via.placeholder.com/200x200" alt="굿즈 이미지">
            <h4>기생충 피규어</h4>
            <p>₩25,000</p>
         </div>
         <!-- 추가 굿즈 항목들 -->
      </div>
   </section>

   <!-- 커뮤니티 인기 글 섹션 -->
   <section class="community-section">
      <h2>💬 커뮤니티 인기글</h2>
      <ul class="community-list">
<%
	for (Post post : popularMoviePosts) {
%>
		<a href="pages/community/post-detail.jsp?pno=<%=post.getNo() %>">
			<li>🔥 <span style="color:#FF498D;">[<%=post.getHeader().getName() %>]</span> <%=post.getTitle() %></li>
		</a>
<%
	}
%>
      </ul>
   </section>
   <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
   
   <%@ include file="pages/common/footer.jsp" %>
</body>
</html>