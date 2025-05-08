<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MovMov 결제내역</title>
<link rel="stylesheet" href="/movmov/resources/style/common/main.css">
<link rel="stylesheet"
	href="/movmov/resources/style/payment/payment-history.css">
<link rel="icon" href="/movmov/resources/images/common/favicon.ico">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>
<body>
	<%@ include file="/pages/common/header.jsp"%>
	
	<!-- Main Dashboard -->
	<main class="dashboard">
		<!-- 왼쪽 -->
		<div class="dashboard-left">
			<div class="box">
				<div class="section-title">
					최근 주문 내역<span><a href="/movmov/pages/payment/order-history.jsp">더보기</a></span>
				</div>
				<div class="order-item">
					<span>쉬리 굿즈 세트</span><span>결제완료</span>
				</div>
				<div class="order-item">
					<span>예매권 2매</span><span>배송중</span>
				</div>
				<div class="order-item">
					<span>CGV 스페셜 모하나</span><span>구매확정</span>
				</div>
				<div class="canceled-item">
					<span>기생충 포스터</span><span>결제 취소</span>
				</div>
			</div>

			<div class="box">
				<div class="section-title">
					포인트 적립 내역<span><a href="">더보기</a></span>
				</div>
				<div class="point-item">
					<span>출석 보상</span><span>+100P</span>
				</div>
				<div class="point-item">
					<span>상품 구매</span><span>+240P</span>
				</div>
				<div class="point-item">
					<span>리뷰 작성</span><span>+500P</span>
				</div>
			</div>
		</div>

		<!-- 오른쪽 -->
		<div class="dashboard-right">
			<div class="box user-summary">
				<img src="/movmov/resources/images/common/default-profile.png" alt="프로필">
				<div class="user-meta">
					<strong>홍길동</strong>
					<p>honggildong@movmov.com</p>
					잔여 포인트 <strong>11,527</strong>P
				</div>
			</div>

			<div class="box balance-container">
				<a href="">
				<button class="balance-box">
					<h3><i class="fa-solid fa-cart-shopping"></i> 장바구니</h3>
				</button>
				</a>
				<a href="">
				<button class="balance-box">
					<h3><i class="fa-solid fa-heart-circle-plus"></i> 찜한 상품</h3>
				</button>
				</a>
			</div>


			<div class="box">
				<div class="section-title">바로가기</div>
				<ul>
					<li><a href="#">주문 내역</a></li>
					<li><a href="#">포인트 관리</a></li>
					<li><a href="#">설정</a></li>
				</ul>
			</div>
		</div>
	</main>
	
	<%@ include file="/pages/common/footer.jsp"%>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>