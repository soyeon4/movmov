<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>장바구니</title>
<link rel="stylesheet" href="/semiproject/resources/style/common/main.css" />
<link rel="stylesheet" href="/semiproject/resources/style/shop/cart.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" />

</head>
<body>
	<%@ include file="/pages/common/header.jsp" %>

	<main>
		<div class="cart-container">
			<div class="cart-header">
				<div>
					<input type="checkbox" />
				</div>
				<div>상품명</div>
				<div>판매금액</div>
				<div>수량</div>
				<div>구매금액</div>
				<div>삭제</div>
			</div>

			<div class="cart-row">
				<div>
					<input type="checkbox" />
				</div>
				<div style="display: flex; align-items: center; gap: 10px;">
					<img src="/semiproject/resources/images/shop/CGV 영화관람권.jpg" alt="상품1"> <span>IMAX
						영화관람권</span>
				</div>
				<div>18,000원</div>
				<div class="qty-box">
					<button onclick="updateQty(this, -1)">-</button>
					<input type="text" value="1" readonly />
					<button onclick="updateQty(this, 1)">+</button>
				</div>
				<div>18,000원</div>
				<div>
					<i class="fa-solid fa-xmark cart-remove"></i>
				</div>
			</div>

			<div class="cart-row">
				<div>
					<input type="checkbox" />
				</div>
				<div style="display: flex; align-items: center; gap: 10px;">
					<img src="/semiproject/resources/images/shop/CGV 영화관람권.jpg" alt="상품2">
					<span>라지콤보 (팝콘+음료)</span>
				</div>
				<div>17,000원</div>
				<div class="qty-box">
					<button onclick="updateQty(this, -1)">-</button>
					<input type="text" value="1" readonly />
					<button onclick="updateQty(this, 1)">+</button>
				</div>
				<div>17,000원</div>
				<div>
					<i class="fa-solid fa-xmark cart-remove"></i>
				</div>
			</div>

			<div class="cart-summary">
				총 상품 금액: <span id="total-price">35,000</span>원
			</div>

			<div class="cart-actions">
				<button onclick="moveToPurchase()">구매하기</button>
			</div>
		</div>
	</main>

	<%@ include file="/pages/common/footer.jsp" %>

	<script>
		function updateQty(btn, delta) {
			const input = btn.parentElement.querySelector('input');
			let qty = parseInt(input.value);
			qty = Math.max(1, qty + delta);
			input.value = qty;
			// 실제로는 구매금액 / 총합 갱신 로직이 들어가야 함
		}
		function moveToPurchase() {
			if (confirm('결제 페이지로 이동하시겠습니까?')) {
				window.location.href = 'payment.html'; // 결제 페이지
			}
		}
	</script>
</body>
</html>