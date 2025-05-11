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
	href="/movmov/resources/style/payment/order-history.css">
<link rel="icon" href="/movmov/resources/images/common/favicon.ico">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>
<body>
	<%@ include file="/pages/common/header.jsp"%>

	<main class="dashboard">
		<!-- 왼쪽 -->
		<div class="dashboard-left">
			<div class="box"></div>

			<div class="box"></div>
		</div>

		<!-- 오른쪽 -->
		<div class="dashboard-right">
			<div class="box user-summary">
				<img src="/movmov/resources/images/common/default-profile.png"
					alt="프로필">
				<div class="user-meta">
					<strong>홍길동</strong>
					<p>honggildong@movmov.com</p>
				</div>
			</div>

			<div class="box balance-container">
				<div class="balance-box">
					<strong>보유 포인트</strong><br> <span class="big-point">1,123P</span>
				</div>
				<div class="balance-box">
					<strong>보유 잔액</strong><br> <span class="big-point">15,530원</span>
				</div>
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