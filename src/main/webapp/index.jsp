<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>애플리케이션</title>
<title>MovMov</title>
<link rel="icon" href="resources/images/common/favicon.ico">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
<link rel="stylesheet" href="resources/style/common/main.css">
</head>
<%@ include file="pages/common/header.jsp"%>

<body>
	<h1>홈</h1>
	
	<main>
		<section class="top-section">
			<div class="article-card">
				<img
					src="https://ojsfile.ohmynews.com/down/images/1/patrick21_227969_1[316186].jpg"
					alt="쉬리 이미지">
				<div class="label">인기 아티클</div>
				<div class="content">
					<h3>한국 영화는 &lt;쉬리&gt; 전과 후로 나뉜다</h3>
					<p>한국 영화사의 터닝 포인트가 된 강제규 감독의 명작 🌍</p>
				</div>
			</div>

			<div class="hot-title-card">
				<div class="label black">지금 가장 핫한 작품</div>
				<img
					src="https://web-cf-image.cjenm.com/crop/520x748/public/share/metamng/programs/contentsdetailposterresidentplaybook01.jpg?v=1744902346"
					alt="전공의생활 포스터">
				<h4>언젠가는 슬기로운 전공의생활</h4>
				<p>평균⭐2.1 · tvN · 드라마</p>
			</div>

			<div class="trailer-card">
				<img
					src="https://cdn.mania.kr/dvdprime/file/2502/movie_3582861_20250227082114_ec5650d8b8718dd2.jpg"
					alt="해법 예고편">
				<div class="trailer-info">
					<div class="label">톰하디 x 레이드 감독</div>
					<h4>공식 예고편</h4>
					<p>해법 | 액션 · 미국</p>
				</div>
				<button>상세보기</button>
			</div>
		</section>

		<section class="menu-section">
			<button>🎬 영화</button>
			<button>⚡ 매거진</button>
			<button>🎁 Mov Commerce</button>
			<button>📊 커뮤니티</button>
			<button>🔮 추천</button>
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
			<li>🔥 [후기] 전공의생활 2화 개쩌네요</li>
			<li>🤔 [질문] 기생충 엔딩 해석 부탁드립니다</li>
			<li>🎉 [공지] 이번 주 굿즈 할인 이벤트!</li>
		</ul>
	</section>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	
	<%@ include file="pages/common/footer.jsp" %>
</body>
</html>