<%@page import="kr.co.movmov.vo.ShopItemOption"%>
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
			요청 URL
				/shop/shop-detail.jsp?id=xxx
			요청 파라미터
				name 	values
				------------------
				ino		상품 코드
		요청처리 절차
			1. 상품 번호를 전달받아 상품의 상세정보를 조회한다.
	*/
	int itemNo = StringUtils.strToInt(request.getParameter("ino"));
	ShopItemMapper itemMapper = MybatisUtils.getMapper(ShopItemMapper.class);
	ShopItem item = itemMapper.getShopItemByItemNo(itemNo);
	List<ShopItemOption> options = itemMapper.getOptionsByItemNo(itemNo);
	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1, maximum-scale=1" />
<title>상품 상세 페이지</title>
<link rel="stylesheet" href="/movmov/resources/style/common/main.css" />
<link rel="stylesheet" href="/movmov/resources/style/shop/detail-shop.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" />
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap"
	rel="stylesheet" />
<link rel="icon" href="resources/images/common/favicon.ico">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<style>
	.swiper {
	      width: 550px;
	      height: 400px;
	}
	
	.swiper-slide {
	      text-align: center;
	      font-size: 18px;
	      background: #fff;
	      display: flex;
	      justify-content: center;
	      align-items: center;
	}
	
	.swiper-slide img {
	      display: block;
	      width: 100%;
	      height: 100%;
	      object-fit: contain;
	}
</style>
</head>
<body>
	<!-- header -->
	<%@ include file="/pages/common/header.jsp" %>
	<main>
		<!-- ✅ 상단 메뉴 추가 -->
		
		<div class="section-inner" style="margin-top: 40px;">
		<%@ include file="shop-nav.jsp" %>
		</div>
		
		<div class="detail-container">
			<div class="swiper mySwiper">
			<%
			String baseImageName = item.getImagePath();
			String prefix = baseImageName.substring(0, baseImageName.lastIndexOf("."));
			String ext = baseImageName.substring(baseImageName.lastIndexOf("."));
			%>
			    <div class="swiper-wrapper">
			    <div class="swiper-slide">
			    	<img src="/movmov/resources/images/shop/<%=item.getImagePath() %>" alt="<%=item.getImagePath() %>" />
			    </div>
<%
	for (int i = 2; i <= item.getImageCount(); i++) {
		String imageFileName = prefix + i + ext;
%>
				<div class="swiper-slide">
					<img src="/movmov/resources/images/shop/<%=imageFileName %>" alt="<%=imageFileName %>" />
				</div>
<%
	}
%>
			    </div>
			    <div class="swiper-button-next"></div>
			    <div class="swiper-button-prev"></div>
			    <div class="swiper-pagination"></div>
			</div>
				<div class="detail-info">
				
				<h1><%=item.getName() %></h1>
				<div class="price"><span id="itemPrice"><%=StringUtils.commaWithNumber(item.getPrice()) %></span>원</div>
				<div class="meta">상품구성 : <%=item.getComponent() %></div>
				<div class="meta">유효기간 : 구매일로부터 24개월 이내</div>
				<div class="meta">
					상품교환 : <a href="#">사용가능 <%=item.getSeller().getName() %> 보기</a>
				</div>
				
				<form id="itemForm" method="post">
    			<input type="hidden" name="ino" value="<%=item.getNo()%>" />
    			
				<div class="meta option-area">
				
<%
	if (options != null && !options.isEmpty()) {
%>
					<label for="option">옵션 선택 : </label> 
					<select id="option" name="option">
<%
		for (ShopItemOption option : options) {
%>
						<option value="<%=option.getOptionNo()%>"><%=option.getOptionName()%></option>
<%
		}
%>
					</select>
<%
	}
%>
				</div>
				
				<div class="quantity-control">
				<label for="qty">수량 : </label> 
					<button type="button" onclick="decreaseQty()">-</button>
					<input type="text" id="qty" value="1" readonly />
					<button type="button" onclick="increaseQty()">+</button>
					<input type="hidden" name="qty" id="qty-hidden" value="1" />
				</div>

				<div class="total-price">
					총 구매금액 <span id="total"><%=StringUtils.commaWithNumber(item.getPrice()) %></span>원
				</div>

				<div class="detail-actions">
					<button type="button" onclick="moveToCart()">
						<i class="fa-solid fa-cart-shopping"> 장바구니</i> 
					</button>
					<button type="button" onclick="moveToPurchase()">구매하기</button>
				</div>
				
				</form>
			</div>
		</div>
		
		<div class="detail-description">
			<strong>[이용안내]</strong><br /> <%=item.getDescription() %>
		</div>
	</main>

	<!-- footer -->
	<%@ include file="/pages/common/footer.jsp" %>
	<%
		boolean isLoggedIn = loginUser != null;
	%>
	<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
	<script type="text/javascript">
		const isLoggedIn = <%= isLoggedIn %>;
		var swiper = new Swiper(".mySwiper", {
	      navigation: {
	        nextEl: ".swiper-button-next",
	        prevEl: ".swiper-button-prev",
	      },
	    });
	
		const itemPrice = document.getElementById('itemPrice');
		let unitPrice = parseInt(itemPrice.textContent.replaceAll(',', ''));
		let qty = 1;
		const qtyInput = document.getElementById('qty');
		const totalPrice = document.getElementById('total');

		function updateTotal() {
			totalPrice.textContent = (qty * unitPrice).toLocaleString();
			document.getElementById('qty-hidden').value = qty;
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
		
		function moveToCart() {
			if (!isLoggedIn) {
				$("#btn-header-login").trigger("click");
			} else {
				const form = document.getElementById("itemForm");
				const optionSelect = document.getElementById("option");
				
				let url = "shop-cart-insert.jsp?ino=" + form.ino.value
					+ "&qty=" + document.getElementById("qty-hidden").value; 
				
				if (optionSelect) {
				    url += "&option=" + optionSelect.value;
				} else {
				    url += "&option=0"; // 옵션이 없으면 0으로 초기화
				}
				window.location.href = url;
				
				if (confirm('장바구니로 이동하시겠습니까?')) {
					window.location.href = 'shop-cart.jsp';
				}
			}
		}
		function moveToPurchase() {
//			if (confirm('결제 페이지로 이동하시겠습니까?')) {
//				window.location.href = 'payment.html'; // 결제 페이지
//			}
		}
	</script>
</body>
</html>