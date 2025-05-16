<%@page import="kr.co.movmov.dto.CartDto"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.movmov.vo.ShopCartItem"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@page import="kr.co.movmov.vo.ShopItem"%>
<%@page import="kr.co.movmov.mapper.ShopCartItemMapper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/*
		요청 정보
			- 요청 URL
				pages/shop/shop-cart.jsp
			- 요청 파라미터
				없음
		요청처리 절차
			1. 세션에서 사용자 아이디를 획득한다.
			2. 사용자 아이디를 전달해서 장바구니 목록을 조회한다.
	*/
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>장바구니</title>
<link rel="stylesheet" href="/movmov/resources/style/common/main.css" />
<link rel="stylesheet" href="/movmov/resources/style/shop/cart.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" />
<link rel="icon" href="resources/images/common/favicon.ico">
</head>
<body>
	<%@ include file="/pages/common/header.jsp" %>
<%
	User loginedUser = (User) session.getAttribute("LOGIN_USER");
	if (loginedUser == null) {
%>
	<script type="text/javascript">
		document.addEventListener("DOMContentLoaded", function() {
			document.querySelector("#btn-header-login")?.click();
		});
	</script>
<%
		return;
	}
	String userId = loginUser.getId();
	ShopCartItemMapper cartItemMapper = MybatisUtils.getMapper(ShopCartItemMapper.class);
	List<ShopCartItem> cartItems = cartItemMapper.getCartItemsByUserId(userId);
	CartDto cartDto = new CartDto(cartItems);
	
%>
	<main>
		<div class="cart-container">
		<form id="form-cart-items" method="get" action="shop-delete.jsp">
				<div class="cart-toolbar">
					<div class="cart-actions">
						<button type="button" onclick="deleteSelectedCartItems()">선택 상품 삭제</button>
						<button type="button" onclick="clearCart()">장바구니 비우기</button>
					</div>
				</div>

				<div class="cart-header">
					<div>
						<input type="checkbox" id="checkbox-select-all" checked />
					</div>
					<div>상품명</div>
					<div>판매금액</div>
					<div>수량</div>
					<div>구매금액</div>
					<div>삭제</div>
				</div>
				<%
	if (cartItems.isEmpty()) {
%>
			<div class="cart-empty">장바구니에 담긴 상품이 없습니다</div>
<%
	} else {
%>
<%
		for (ShopCartItem cartItem : cartItems) {
		
%>
			<div class="cart-row">
				<input type="hidden" class="item-no" value="<%=cartItem.getItem().getNo() %>" />
				<div>
					<input type="checkbox" 
					name="cno" 
					value="<%=cartItem.getNo() %>" checked />
				</div>
				<div style="display: flex; align-items: center; gap: 30px;">
				<a href="shop-detail.jsp?ino=<%=cartItem.getItem().getNo() %>" class="unstyled-link">
					<img src="/movmov/resources/images/shop/<%=cartItem.getItem().getImagePath() %>" 
						alt="<%=cartItem.getItem().getImagePath() %>"> 
				</a>
				<a href="shop-detail.jsp?ino=<%=cartItem.getItem().getNo() %>" class="unstyled-link">
					<span><%=cartItem.getItem().getName() %>
<%
			if (cartItem.getOption() != null) {
%>
					<br>/ 옵션 : <%=cartItem.getOption().getOptionName() %>
					<input type="hidden" class="option-no" value="<%=cartItem.getOption().getOptionNo() %>" />
<%	
			}
%>
					</span>
				</a>
				</div>
				<div>
					<span class="unit-price"><%=StringUtils.commaWithNumber(cartItem.getItem().getPrice()) %></span>원
				</div>
				<div class="qty-box">
					<button type="button" class="btn-decrease">-</button>
					<input type="text" class="qty" value="<%=cartItem.getQuantity() %>" readonly />
					<button type="button" class="btn-increase">+</button>
					<input type="hidden" name="qty" class="qty-hidden" value="<%=cartItem.getQuantity() %>" />
				</div>
				<div>
					<span class="item-order-price"><%=StringUtils.commaWithNumber(cartItem.getOrderPrice()) %></span>원
				</div>
				<div>
					<a href="shop-cart-delete.jsp?cno=<%=cartItem.getNo() %>" class="unstyled-link">
						<i class="bi bi-cart-x"></i>
					</a>
				</div>
				
			</div>
<%
		}
%>
			

			<footer class="cart-summary">
				<div class="price-info-left">
					상품 금액 <span id="total-item-price"><strong><%=StringUtils.commaWithNumber(cartDto.getTotalItemPrice()) %></strong></span> 원<i
						class="bi bi-plus"></i> 예상 배송비 <span id="delivery-fee"><strong><%=StringUtils.commaWithNumber(cartDto.getDeliveryFee()) %></strong></span> 원
				</div>
				<div class="price-info-right">
					총 예상 금액 <span id="total-order-price"><strong><%=StringUtils.commaWithNumber(cartDto.getTotalOrderPrice()) %></strong></span> 원
				</div>
				<div>
					<button class="btn-pay" type="button" onclick="moveToPurchase()">구매하기</button>
				</div>
			</footer>

<%
	} 
%>
			</form>
		</div>
	</main>

	<%@ include file="/pages/common/footer.jsp" %>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> 

	<script type="text/javascript">
		// 선택 삭제 / 전체 삭제
		function deleteSelectedCartItems() {
			$("#form-cart-items").trigger("submit");
		}
		function clearCart() {
			window.location.href = 'shop-cart-clear.jsp';
		}
		// 전체 선택/해제 체크박스의 체크가 변경될 때 실행되는 이벤트 핸들러 등록
		$("#checkbox-select-all").change(function() {
			let checkStatus = $(this).prop("checked");
			$(":checkbox[name=cno]").prop("checked", checkStatus);
			newCalculation();
		})
		// 장바구니 상품 체크가 변경됨에 따라 전체 선택/해제 체크박스 변경 이벤트 핸들러 등록
		$(":checkbox[name=cno]").change(function(){
			let checkboxLength = $(":checkbox[name=cno]").length;
			let checkedCheckboxLength = $(":checkbox[name=cno]:checked").length;
			$("#checkbox-select-all").prop("checked", checkboxLength == checkedCheckboxLength);
			newCalculation();
		});
		// 가격 계산
		function newCalculation() {
				let deliveryFee = 0;
				let totalItemPrice = 0;
				let totalOrderPrice = 0;
			$(":checkbox[name=cno]:checked")
			.closest(".cart-row")
			.find(".item-order-price")
			.each(function() {
				let itemPrice = parseInt($(this).text().replaceAll(",", ""));
				totalItemPrice += itemPrice;
//				console.log(itemPrice);
//				console.log(totalItemPrice);
			})
			
			if (totalItemPrice < 30000) {
				deliveryFee = 3000;
			}
			
			totalOrderPrice = totalItemPrice + deliveryFee;
			$("#total-item-price").text(totalItemPrice.toLocaleString());
			$("#delivery-fee").text(deliveryFee.toLocaleString());
			$("#total-order-price").text(totalOrderPrice.toLocaleString());
		}
		$(document).ready(function() {
		    // 수량 증가
		    $(".btn-increase").click(function() {
		        const row = $(this).closest(".cart-row");
		        let itemNo = parseInt(row.find(".item-no").val());
		        let optionNo = row.find(".option-no").val();
		        optionNo = optionNo ? parseInt(optionNo) : 0;
		        let unitPrice = parseInt(row.find(".unit-price").text().replaceAll(",", ""));
		        let qty = parseInt(row.find(".qty").val());
		        qty++;
		        let itemOrderPrice = unitPrice * qty;
		        row.find(".qty").val(qty);
		        row.find(".qty-hidden").val(qty);
		        row.find(".item-order-price").text(itemOrderPrice.toLocaleString());
		        updateCart(itemNo, optionNo, qty);
		        newCalculation();
		    });
		
		    // 수량 감소
		    $(".btn-decrease").click(function() {
		        const row = $(this).closest(".cart-row");
		        let itemNo = parseInt(row.find(".item-no").val());
		        let optionNo = row.find(".option-no").val();
		        optionNo = optionNo ? parseInt(optionNo) : 0;
		        let unitPrice = parseInt(row.find(".unit-price").text().replaceAll(",", ""));
		        let qty = parseInt(row.find(".qty").val());
		        if (qty > 1) {
		            qty--;
		            let itemOrderPrice = unitPrice * qty;
		            row.find(".qty").val(qty);
		            row.find(".qty-hidden").val(qty);
		            row.find(".item-order-price").text(itemOrderPrice.toLocaleString());
		            updateCart(itemNo, optionNo, qty);
		            newCalculation();
		        }
		    });
		});
		
		function updateCart(itemNo, optionNo, qty) {
//			console.log(itemNo);
//			console.log(optionNo);
//			console.log(qty);
			let url = "shop-cart-modify.jsp?ino=" + itemNo + "&qty=" + qty + "&option=" + optionNo;
			window.location.href = url;
		}
		
		function moveToPurchase() {
			if (confirm('결제 페이지로 이동하시겠습니까?')) {
				let selectedCnos = $(":checkbox[name=cno]:checked").map(function() {
					return $(this).val();
				}).get();

				if (selectedCnos.length === 0) {
					alert("선택된 상품이 없습니다.");
					return;
				}

				let queryString = selectedCnos.map(cno => "cno=" + cno).join("&");

				window.location.href = "../payment/payment.jsp?" + queryString;
			}
		}
	</script>
</body>
</html>