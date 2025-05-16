<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@page import="kr.co.movmov.dto.CartDto"%>
<%@page import="kr.co.movmov.vo.ShopCartItem"%>
<%@page import="kr.co.movmov.mapper.ShopCartItemMapper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="kr.co.movmov.vo.Address"%>
<%@ page import="kr.co.movmov.mapper.AddressMapper"%>
<%@ page import="kr.co.movmov.utils.MybatisUtils"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MovMov 결제</title>
<link rel="stylesheet" href="/movmov/resources/style/common/main.css">
<link rel="stylesheet" href="/movmov/resources/style/payment/payment.css">
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
	AddressMapper addressMapperForMain = MybatisUtils.getMapper(AddressMapper.class);
	Address defaultAddressForMain = addressMapperForMain.getDefaultAddress(loginUser);
	ShopCartItemMapper shopCartItemMapper = MybatisUtils.getMapper(ShopCartItemMapper.class);
	int pointUsage = 0;
	int pointAmount = 1000;
	
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

					<%
					if (defaultAddressForMain != null) {
					%>
					<p id="address-header">
						<strong id="receiver-name"><%=defaultAddressForMain.getReceiverName()%></strong>
						<span id="address-comment"><%=defaultAddressForMain.getAddressName()%></span>
						<button class="tag" id="btn-list-address">주소지 선택</button>
					</p>
					<p id="receiver-phone">
						<%=defaultAddressForMain.getReceiverPhone()%>
					</p>
					<p>
						<span id="receiver-address"><%=defaultAddressForMain.getRoad()%></span>
						<span id="receiver-address-detail"><%=defaultAddressForMain.getDetail()%></span><br>
						<span id="post-number"><%=defaultAddressForMain.getZipcode()%></span>
					</p>
					<%
					} else {
					%>
					<script type="text/javascript">
						alert("기본 배송지를 저장하여 주세요!");
					</script>
					<p id="address-header">
						<strong id="receiver-name"></strong>
						<span id="address-comment"></span>
						<button class="tag" id="btn-list-address">주소지 선택</button>
					</p>
					<p id="receiver-phone">
						<button class="tag">안심번호 사용</button>
					</p>
					<p>
						<span id="receiver-address"></span>
						<span id="receiver-address-detail"></span><br>
						<span id="post-number"></span>
					</p>
					<%
					}
					%>


					<%
					// 배송지 목록이 나오는 모달창
					%>
					<%@ include file="modal-list-address.jsp"%>

					<%
					//배송지 입력창
					%>

					<%@ include file="modal-enter-address.jsp"%>

					<%
					//배송지 검색
					%>

					<%@ include file="modal-search-address.jsp"%>

					<select id="select-delivery-request" name="deliveryMemo">
						<option value="선택 안 함">선택 안 함</option>
						<option value="custom">직접 입력하기</option>
						<option value="문 앞에 놓아주세요">문 앞에 놓아주세요</option>
						<option value="경비실에 맡겨주세요">경비실에 맡겨주세요</option>
						<option value="부재 시 연락주세요">부재 시 연락주세요</option>
						<option value="배송 전 미리 연락주세요">배송 전 미리 연락주세요</option>
					</select>
					
					<div id="custom-memo-box" class="point-use">
						<input type="text" id="customer-request"  placeholder="배송 요청사항을 입력해주세요">
					</div>
				</div>
			</section>
			<section class="product-box">
				<h3>주문상품</h3>
			<%
			List<ShopCartItem> cartItems = new ArrayList<>();
			String[] cnos = request.getParameterValues("cno");
			if (cnos != null) {
			    for (String cno : cnos) {
			        int cartItemId = Integer.parseInt(cno);
			        ShopCartItem item = shopCartItemMapper.getCartItemByCartNo();
			        if(item != null)
			        	cartItems.add(item);
			    }
			}
			
			CartDto cartDto = new CartDto(cartItems);
			
			int totalPriceOfOrder = 0;
			for (ShopCartItem cartItem : cartItems) {
				int totalPriceOfItem = cartItem.getItem().getPrice()*cartItem.getQuantity();
			%>
				<div class="product-detail">
					<div class="product-summary">
						<img src="/movmov/resources/images/shop/<%=cartItem.getItem().getImagePath() %>" alt="상품 이미지">
						<div class="summary-text">
							<p>
								<strong><%=cartItem.getItem().getName() %></strong>
							</p>
							<p class="option">배송비 : <%=StringUtils.commaWithNumber(cartDto.getDeliveryFee()) %> / 수량 :<%=cartItem.getQuantity() %> </p>
							<p class="price">
								<del></del>
								<strong><%=StringUtils.commaWithNumber(totalPriceOfItem) %>원</strong>
							</p>
						</div>
					</div>
				</div>
				<br>
			<%
				totalPriceOfOrder += totalPriceOfItem;
			}
			%>
			</section>
			

			<section class="point-wallet">
				<h3>포인트 사용</h3>
				<div class="wallet-summary">
					<p>
						사용 가능: <strong><%=StringUtils.commaWithNumber(pointAmount) %>원</strong>
					</p>
					<ul>
						<li>포인트 사용<span id="point-usage"><%=StringUtils.commaWithNumber(pointUsage) %>원</span></li>
					</ul>
					<div class="point-use">
						<input type="number" id="point-input" placeholder="사용 금액 입력">
						<button class="btn-outline" id="btn-apply-point"> 적용 </button>
					</div>
				</div>
			</section>

			<section class="pay-method">
				<h3>
					결제수단 <span class="price-main"><%=StringUtils.commaWithNumber(totalPriceOfOrder - pointUsage) %>원</span>
				</h3>
				<h4>Pay 결제</h4>
				<label>
					<button type="button" class="account" data-value="1">
						<img src="/movmov/resources/images/payment/logo_navergr_small.svg"
							alt="">
					</button>
					<button type="button" class="account" data-value="2">
						<img src="/movmov/resources/images/payment/Toss_Logo_Primary.png"
							alt="">
					</button>
					<button type="button" class="account" data-value="3">
						<img
							src="/movmov/resources/images/payment/payment_icon_yellow_medium.png"
							alt="">
					</button>
					<button type="button" class="account" data-value="4">
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
					결제상세 <span class="price-main"><%=StringUtils.commaWithNumber(totalPriceOfOrder-pointUsage) %>원</span>
				</h3>
				<p>
					주문 금액 <span class="price"><%=StringUtils.commaWithNumber(totalPriceOfOrder) %>원</span>
				</p>
				<p>
					배송비 <span class="price"><%=StringUtils.commaWithNumber(cartDto.getDeliveryFee()) %>원</span>
				</p>
				<p>
					포인트 사용 <span class="price"><%=pointUsage %>원</span>
				</p>
				
			</section>
			<%
			double rewardRate = 0.05;
			int rewardOfPurchase = (int)(totalPriceOfOrder*rewardRate);
			int rewardOfMethod = 50;
			%>
			<section class="point-benefit">
				<h3>
					포인트 혜택 <span class="highlight">총 <%=StringUtils.commaWithNumber(rewardOfPurchase + rewardOfMethod) %>원</span>
					
				</h3>
				<div class="benefit-list">
					<ul>
						<li>기본적립 <span class="right"><%=StringUtils.commaWithNumber(rewardOfPurchase) %>원</span></li>
						<li>간편결제적립 <span class="right"><%=StringUtils.commaWithNumber(rewardOfMethod) %>원</span></li>
					</ul>
				</div>
			</section>

			<div class="payment-btn-container">
				<form id="order-form" action="/movmov/pages/payment/make-order.jsp" method="post">
					<input type="hidden" name="order-point-usage" id="order-point-usage" value="<%=pointUsage%>">
					<input type="hidden" name="order-point-earn" id="order-point-earn" value="<%=rewardOfPurchase + rewardOfMethod%>">
					<input type="hidden" name="order-address-id" id="order-address-id" value="<%=defaultAddressForMain.getId() %>">
					<input type="hidden" name="order-payment-method" id="order-payment-method" value="">
					<input type="hidden" name="customer-request" id="order-request" value="선택 안 함">
					<%
					for (ShopCartItem cartItem : cartItems) {
					
					%>
					<input type="hidden" name="cartItemIds" value="<%=cartItem.getNo()%>">
					<%
					} 
					%>
					<button type="submit" class="pay-btn" ><%=StringUtils.commaWithNumber(totalPriceOfOrder) %>원 결제하기</button>
				</form>
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