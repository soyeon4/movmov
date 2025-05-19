<%@page import="kr.co.movmov.vo.ShopItem"%>
<%@page import="kr.co.movmov.mapper.ShopItemMapper"%>
<%@page import="java.time.ZoneId"%>
<%@page import="java.util.Date"%>
<%@page import="java.time.LocalDate"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@page import="kr.co.movmov.vo.Point"%>
<%@page import="kr.co.movmov.vo.Payment"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.movmov.mapper.PointMapper"%>
<%@page import="kr.co.movmov.mapper.PaymentMapper"%>
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

	<%
	User user = (User) session.getAttribute("LOGIN_USER");
	PaymentMapper paymentMapper = MybatisUtils.getMapper(PaymentMapper.class);
	PointMapper pointMapper = MybatisUtils.getMapper(PointMapper.class);
	ShopItemMapper shopItemMapper = MybatisUtils.getMapper(ShopItemMapper.class);

	List<Payment> recentPayment = paymentMapper.getRecentFivePayment(user);
	List<Point> recentPoint = pointMapper.getRecentFivePoint(user);
	%>
	<div class="dashboard">
		<div class="dashboard-left">
			<!-- 최근 주문 내역 -->
			<div class="box">
				<div class="section-title">
					최근 주문 내역 <span><a href="#">더보기</a></span>
				</div>
				<%
				for (Payment payment : recentPayment) {
					ShopItem item = shopItemMapper.getShopItemByItemNo(payment.getItem().getNo());
					Date date = payment.getPayDate();
					LocalDate localDate = date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
				%>
				<div class="order-item">
					<span><%=item.getName()%></span><span><%=StringUtils.commaWithNumber(item.getPrice() * payment.getItemQuantity())%>원
						| <%=localDate%></span>
				</div>
				<%
				}
				%>
			</div>
		

		<!-- 포인트 적립 내역 -->
			<div class="box">
				<div class="section-title">
					포인트 적립 내역 <span><a href="#">더보기</a></span>
				</div>
				<%
				for (Point point : recentPoint) {
					String strPointChanges = "";
					int pointChanges = point.getPointChangeAmount();
					if (point.getTypeId() == 100) {
						strPointChanges = StringUtils.commaWithNumber(pointChanges) + "P";
					} else {
						strPointChanges = "+" + StringUtils.commaWithNumber(pointChanges) + "P";
					}
	
					Date date = point.getCreatedAt();
	
					LocalDate localDate = date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
				%>
				<div class="point-item">
					<span><%=point.getPointType()%></span><span><%=strPointChanges%>
						| <%=localDate%></span>
				</div>
				<%
				}
				%>
			</div>
		</div>

		<div class="dashboard-right">
			<!-- 사용자 요약 정보 -->
			<div class="box user-summary">
				<img src="/movmov/resources/images/common/default-profile.png"
					alt="프로필">
				<div class="user-meta">
					<strong><%=loginUser.getName()%></strong>
					<p><%=loginUser.getEmail()%></p>
					잔여 포인트 <strong><%=pointMapper.getUserPoint(loginUser)%></strong>P
				</div>
			</div>

			<!-- 포인트 버튼 -->
			<div class="box balance-container">
				<a href="/movmov/pages/shop/shop-cart.jsp">
					<button class="balance-box">
						<h3>
							<i class="fa-solid fa-cart-shopping"></i> 장바구니
						</h3>
					</button>
				</a> <a href="">
					<button class="balance-box">
						<h3>
							<i class="fa-solid fa-heart-circle-plus"></i> 찜한 상품
						</h3>
					</button>
				</a>
			</div>

			<!-- 바로가기 -->
			<div class="box">
				<div class="section-title">바로가기</div>
				<ul>
					<li><a href="#">주문 내역</a></li>
					<li><a href="#">포인트 관리</a></li>
				</ul>
			</div>
		</div>
	</div>


	<%@ include file="/pages/common/footer.jsp"%>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>