<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MovMov 결제</title>
<link rel="stylesheet" href="/movmov/resources/style/common/main.css">
<link rel="stylesheet"
	href="/movmov/resources/style/payment/payment.css">
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
	// 미 로그인 상태인 경우 홈으로 이동
	if (loginUser == null) {
	%>
	<script type="text/javascript">
		alert("로그인 후 이용가능한 페이지 입니다.");
		window.location.href = "/movmov/index.jsp";
	</script>
	<%
	}
	
	%>

	<main class="payment-wrapper">
		<div class="payment-left">
			<section class="shipping-box">
				<h3>배송 정보</h3>
				<div class="shipping-info">

					<p id="address-header">
						<strong id="receiver-name">송하영</strong><span id="address-comment">(우리
							집)</span>
						<button class="tag" id="btn-list-address">주소지 선택</button>
					</p>
					<p id="receiver-phone">
						010-0000-1111
						<button class="tag">안심번호 사용</button>
					</p>
					<p>
						<span id="receiver-address">서울특별시 종로구 율곡로10길 105 디아망 4층</span> 
						<span id="receiver-address-detail">(공동현관 중3805)</span><br> 
						<span id="post-number">(03033)</span>
					</p>


					<%
					// 배송지 목록이 나오는 모달창
					%>
					<%@ include file="modal-list-address.jsp"%>

					<%
					//배송지 입력창
					%>

					<%@ include file="modal-enter-address.jsp" %>

					<%
					//배송지 검색
					%>			
					
					<%@ include file="modal-search-address.jsp" %>

					<select>
						<option>선택 안 함</option>
						<option>직접 입력하기</option>
						<option>문 앞에 놓아주세요</option>
						<option>경비실에 맡겨주세요</option>
						<option>부재 시 연락주세요</option>
						<option>배송 전 미리 연락주세요</option>
					</select> <label class="checkbox"> <input type="checkbox" checked>
						다음에도 사용할게요
					</label>
				</div>
			</section>

			<section class="product-box">
				<h3>주문상품</h3>
				<div class="product-detail">
					<div class="store-name">CGV</div>
					<div class="product-summary">
						<img src="/movmov/resources/images/shop/" alt="상품 이미지">
						<div class="summary-text">
							<p>
								<strong>MovMov 상품권 50,000원 권</strong>
							</p>
							<p class="option">무료 배송 / 수량 : 1개</p>
							<p class="price">
								<del>50,000원</del>
								<strong>49,560원</strong>
							</p>
						</div>
					</div>
				</div>
			</section>

			<section class="point-wallet">
				<h3>포인트 사용</h3>
				<div class="wallet-summary">
					<p>
						사용 가능: <strong>11,527원</strong>
					</p>
					<ul>
						<li>포인트 <span>1,477원</span></li>
					</ul>
					<div class="point-use">
						<input type="number" placeholder="사용 금액 입력">
						<button class="btn-outline">전액사용</button>
					</div>
					<label class="checkbox"> <input type="checkbox" checked>
						항상 잔여 사용
					</label>
				</div>
			</section>

			<section class="pay-method">
				<h3>
					결제수단 <span class="price-main">49,560원</span>
				</h3>
				<h4>Pay 결제</h4>
				<label>
					<button class="account">
						<img src="/movmov/resources/images/payment/logo_navergr_small.svg" alt="">
					</button>
					<button class="account">
						<img src="/movmov/resources/images/payment/Toss_Logo_Primary.png" alt="">
					</button>
					<button class="account">
						<img
							src="/movmov/resources/images/payment/payment_icon_yellow_medium.png" alt="">
					</button>
					<button class="account">
						<img src="/movmov/resources/images/payment/payco_logo.png" alt="">
					</button>
				</label>

				<h4>계좌 간편결제</h4>
				<div class="account-select">
					<p class="dimmed">계좌를 결제 수단에 등록해 주세요</p>
				</div>

				<h4>카드 간편결제</h4>
				<p class="dimmed">카드를 결제 수단에 등록해 주세요</p>

				<h4>일반결제</h4>
				<p class="dimmed">선결제 전용 카드 사용 시 변경 가능합니다.</p>
			</section>

		</div>

		<div class="payment-right">
			<section class="summary-box">
				<h3>
					결제상세 <span class="price-main">49,560원</span>
				</h3>
				<p>
					포인트 사용 <span class="price">49,560원</span>
				</p>
			</section>

			<section class="point-benefit">
				<h3>
					포인트 혜택 <span class="highlight">최대 2,833원</span>
				</h3>
				<div class="benefit-list">
					<p>
						구매적립 <span class="right">총 1,283원</span>
					</p>
					<ul>
						<li>기본적립 <span class="right">513원</span></li>
						<li>카카오페이 결제적립 <span class="right">770원</span></li>
					</ul>
					<p>
						리뷰적립 <span class="right">최대 1,550원</span>
					</p>
				</div>
				<button class="benefit-btn">+2,054원 구매 감사 포인트 받기</button>
			</section>

			<div class="payment-btn-container">
				<button type="submit" class="pay-btn">49,560원 결제하기</button>
			</div>
		</div>
	</main>
	
	<%@ include file="/pages/common/footer.jsp"%>

	<script type="text/javascript"
		src="/movmov/resources/script/payment/payment.mjs"></script>
	<script
		src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</body>
</html>
</html>