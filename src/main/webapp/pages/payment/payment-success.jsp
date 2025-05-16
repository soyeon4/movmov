<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MovMov 결제완료</title>
<link rel="stylesheet" href="/movmov/resources/style/common/main.css">
<link rel="stylesheet"
	href="/movmov/resources/style/payment/payment-success.css">
<link rel="icon" href="/movmov/resources/images/common/favicon.ico">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>

<body>
	<%@ include file="/pages/common/header.jsp"%>
	<%
	%>
	<div class="success-container">
		<div class="success-card">
			<div class="success-icon">
				<i class="fa-regular fa-circle-check"></i>
			</div>
			<h1>결제가 완료되었습니다</h1>
			<p class="success-message">
				구매해 주셔서 감사합니다.<br>주문 내역은 마이페이지에서 확인하실 수 있습니다.
			</p>
			<div class="success-actions">
				<a href="/movmov/index.jsp" class="btn-home">홈으로 가기</a> <a
					href="/movmov/pages/payment/payment-history.jsp" class="btn-orders">주문 내역 보기</a>
			</div>
		</div>
	</div>
	
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

	<%@ include file="/pages/common/footer.jsp"%>
</body>
</html>