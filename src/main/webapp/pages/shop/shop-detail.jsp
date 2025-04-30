<%@page import="kr.co.movmov.vo.ShopItem"%>
<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.mapper.ShopItemMapper"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/*
		요청 정보
			요청 URL
				/shop/shop-detail.jsp?id=xxx
			요청 파라미터
				name 	values
				------------------
				id		상품 코드
	*/
	int itemNo = StringUtils.strToInt(request.getParameter("id"));
	ShopItemMapper itemMapper = MybatisUtils.getMapper(ShopItemMapper.class);
	ShopItem item = itemMapper.getShopItemById(itemNo);
	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>상품 상세 페이지</title>
<link rel="stylesheet" href="/semiproject/resources/style/common/main.css" />
<link rel="stylesheet" href="/semiproject/resources/style/shop/detail-shop.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" />
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap"
	rel="stylesheet" />

</head>
<body>
	<!-- header -->
	<%@ include file="/pages/common/header.jsp" %>

	<main>
		<!-- ✅ 상단 메뉴 추가 -->
		<section class="menu-section"
			style="text-align: center; margin-top: 40px;">
			<button>🎟️ 관람권</button>
			<button>🍿 스낵음료</button>
			<button>🎁 굿즈</button>
		</section>
		<div class="detail-container">
			<div class="detail-image">
				<img src="/semiproject/resources/images/shop/<%=item.getImagePath() %>" alt="<%=item.getImagePath() %>" />
			</div>
			<div class="detail-info">
				<h1><%=item.getName() %></h1>
				<div class="price"><%=StringUtils.commaWithNumber(item.getPrice()) %>원</div>
				<div class="meta">상품구성: <%=item.getComponent() %></div>
				<div class="meta">유효기간: 구매일로부터 24개월 이내</div>
				<div class="meta">
					상품교환: <a href="#">사용가능 <%=item.getSeller().getName() %> 보기</a>
				</div>

				<div class="quantity-control">
					<button onclick="decreaseQty()">-</button>
					<input type="text" id="qty" value="1" readonly />
					<button onclick="increaseQty()">+</button>
				</div>

				<div class="total-price">
					총 구매금액 <span id="total">13,000</span>원
				</div>

				<div class="detail-actions">
					<button onclick="handleWishlist()">찜하기</button>
					<button onclick="moveToCart()">
						<i class="fa-solid fa-cart-shopping"></i> 장바구니
					</button>
					<button onclick="moveToPurchase()">구매하기</button>
				</div>
			</div>
		</div>

		<div class="detail-description">
			<strong>[이용안내]</strong><br /> <%=item.getDescription() %>
		</div>
	</main>

	<!-- footer -->
	<%@ include file="/pages/common/footer.jsp" %>

	<script>
		let unitPrice = 13000;
		let qty = 1;
		const qtyInput = document.getElementById('qty');
		const totalPrice = document.getElementById('total');

		function updateTotal() {
			totalPrice.textContent = (qty * unitPrice).toLocaleString();
		}

		function increaseQty() {
			qty++;
			qtyInput.value = qty;
			updateTotal();
		}

		function decreaseQty() {
			if (qty > 1) {
				qty--;
				qtyInput.value = qty;
				updateTotal();
			}
		}

		function handleWishlist() {
			if (confirm('찜한 상품으로 이동하시겠습니까?')) {
				window.location.href = 'wishlist.html';
			}
		}
		function moveToCart() {
			if (confirm('장바구니로 이동하시겠습니까?')) {
				window.location.href = 'cart.html';
			}
		}
		function moveToPurchase() {
			if (confirm('결제 페이지로 이동하시겠습니까?')) {
				window.location.href = 'payment.html'; // 결제 페이지
			}
		}
	</script>
</body>
</html>