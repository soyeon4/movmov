<%@page import="kr.co.movmov.vo.ShopItem"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.mapper.ShopItemMapper"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ShopItemMapper itemMapper = MybatisUtils.getMapper(ShopItemMapper.class);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>MovMov 스토어</title>
<link rel="stylesheet" href="/semiproject/resources/style/common/main.css" />
<link rel="stylesheet" href="/semiproject/resources/style/shop/shopmain.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" />
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap"
	href="../style/shopmain.css" rel="stylesheet" />
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
		<section class="menu-section">
			<button>🎟️ 관람권</button>
			<button>🍿 스낵음료</button>
			<button>🎁 굿즈</button>
		</section>

		<!-- 상품 카테고리 영역 -->
<%
	for (int i = 1; i <= 3; i++) {
		List<ShopItem> items = itemMapper.getShopItemByCategoryNo(i);
%>
		<section class="goods-section">
			<div class="section-inner">
				<div class="section-header">
<%
	if (i == 1) {
%>
				<h2>🎟️ 관람권</h2>
<%
	} else if (i == 2) {
%>
				<h2>🍿 푸드</h2>
<%
	} else if (i == 3) {
%>
				<h2>🎁 굿즈</h2>
<%
	}
%>
					<a class="more-link" href="shop-list.jsp?cno=<%=i%>">더보기 ></a>
				</div>
				<div class="goods-list">

<%
		for (int j = 0; j < items.size() && j < 4; j++) {
			ShopItem item = items.get(j);
%>
					<div class="goods-card">
						<div class="image-wrapper">
							<a href="shop-detail.jsp?id=<%=item.getId() %>"><img
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
<%
	}
%>
	</main>

	<!-- 푸터 -->
	<%@ include file="/pages/common/footer.jsp" %>
</body>
</html>