<%@page import="java.util.List"%>
<%@page import="kr.co.movmov.vo.ShopItem"%>
<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.mapper.ShopItemMapper"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/*
		요청 정보
			- 요청 URL
				/shop/shop-list.jsp?cno=xxx
			- 요청 파라미터
				name		value
				------------------------------
				cno			카테고리 번호
	*/
	
	int catNo = StringUtils.strToInt(request.getParameter("cno"));
	ShopItemMapper itemMapper = MybatisUtils.getMapper(ShopItemMapper.class);
	List<ShopItem> items = itemMapper.getShopItemByCategoryNo(catNo);
	
	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>관람권 상품 목록 - MovMov 스토어</title>
<link rel="stylesheet" href="/semiproject/resources/style/common/main.css">
<link rel="stylesheet" href="/semiproject/resources/style/shop/list.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
<script>
	function handleWishlist() {
		if (confirm('찜한 상품으로 이동하시겠습니까?')) {
			window.location.href = 'wishlist.html';
		}
	}
	function handleCart() {
		if (confirm('장바구니로 이동하시겠습니까?')) {
			window.location.href = 'cart.html';
		}
	}
</script>
</head>
<body>
	<!-- 네비게이션 바 -->
	<%@ include file="/pages/common/header.jsp" %>

	<main>
		<section class="goods-section">
			<div class="section-inner">
<%
	if (catNo == 1) {
%>
				<h2>🎟️ 관람권 전체 상품</h2>
<%
	} else if (catNo == 2) {
%>
				<h2>🍿 푸드 전체 상품</h2>
<%
	} else if (catNo == 3) {
%>
				<h2>🎁 굿즈 전체 상품</h2>
<%
	}
%>


				<div class="goods-list">
<%
	for (ShopItem item : items) {
%>
					<div class="goods-card">
						<div class="image-wrapper">
							<a href="shop-detail.jsp?id=<%=item.getId() %>"> <img
								src="/semiproject/resources/images/shop/<%=item.getImagePath() %>" alt="<%=item.getImagePath() %>" /></a>
							<div class="hover-actions">
								<button class="wishlist" onclick="handleWishlist()">❤️
									찜</button>
								<button class="cart" onclick="handleCart()">🛒 장바구니</button>
							</div>
						</div>
						<h4><%=item.getName() %></h4>
						<p>₩<%=StringUtils.commaWithNumber(item.getPrice()) %></p>
					</div>
<%
	}
%>
				</div>
			</div>
		</section>
	</main>

	<!-- 푸터 -->
	<%@ include file="/pages/common/footer.jsp" %>
</body>
</html>