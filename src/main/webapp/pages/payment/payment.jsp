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
						<span id="receiver-address">서울특별시 종로구 율곡로10길 105 디아망 4층</span> <span
							id="receiver-address-detail">(공동현관 중3805)</span><br> <span
							id="post-number">(03033)</span>
					</p>


					<%
					// 배송지 목록이 나오는 모달창
					%>
					<div class="overlay" id="overlay-list-address">
						<div class="modal" id="modal-list-address">
							<div class="address-container">
								<h2>배송지 목록</h2>
								<button class="btn-new-address" id="btn-new-address">+
									배송지 신규입력</button>
								<div class="address-list-container">

									<div class="address-card selected">
										<div class="address-header">
											<strong>박형민</strong><span>(우리형 자취방)</span> <span
												class="selected-text">✓ 선택됨</span>
										</div>
										<div class="phone">010-9905-2427</div>
										<div class="address-detail">
											<span class="address">서울특별시 은평구 연서로 16 (역촌동)</span> <span
												class="detail">905호 (공동관 중3805)</span> <span
												class="post-number">(03409)</span>
										</div>
										<div class="address-actions">
											<button class="btn-edit">수정</button>
											<button class="btn-delete">삭제</button>
										</div>
									</div>

									<div class="address-card">
										<div class="address-header">
											<strong>박형민</strong><span>(우리형 자취방)</span> <span
												class="selected-text"></span>
										</div>
										<div class="phone">010-9905-2427</div>
										<div class="address-detail">
											<span class="address">서울특별시 은평구 연서로 16 (역촌동)</span> <span
												class="detail">905호 (공동관 중3805)</span> <span
												class="post-number">(03409)</span>
										</div>
										<div class="address-actions">
											<button class="btn-edit">수정</button>
											<button class="btn-delete">삭제</button>
										</div>
									</div>

									<div class="address-card">
										<div class="address-header">
											<strong>박형민</strong><span>(우리형 자취방)</span> <span
												class="selected-text"></span>
										</div>
										<div class="phone">010-9905-2427</div>
										<div class="address-detail">
											<span class="address">서울특별시 은평구 연서로 16 (역촌동)</span> <span
												class="detail">905호 (공동관 중3805)</span> <span
												class="post-number">(03409)</span>
										</div>
										<div class="address-actions">
											<button class="btn-edit">수정</button>
											<button class="btn-delete">삭제</button>
										</div>
									</div>

									<div class="address-card">
										<div class="address-header">
											<strong>박형민</strong><span>(우리형 자취방)</span> <span
												class="selected-text"></span>
										</div>
										<div class="phone">010-9905-2427</div>
										<div class="address-detail">
											<span class="address">서울특별시 은평구 연서로 16 (역촌동)</span> <span
												class="detail">905호 (공동관 중3805)</span> <span
												class="post-number">(03409)</span>
										</div>
										<div class="address-actions">
											<button class="btn-edit">수정</button>
											<button class="btn-delete">삭제</button>
										</div>
									</div>

									<div class="address-card">
										<div class="address-header">
											<strong>박형민</strong><span>(우리형 자취방)</span> <span
												class="selected-text"></span>
										</div>
										<div class="phone">010-9905-2427</div>
										<div class="address-detail">
											<span class="address">서울특별시 은평구 연서로 16 (역촌동)</span> <span
												class="detail">905호 (공동관 중3805)</span> <span
												class="post-number">(03409)</span>
										</div>
										<div class="address-actions">
											<button class="btn-edit">수정</button>
											<button class="btn-delete">삭제</button>
										</div>
									</div>

								</div>
							</div>
						</div>
					</div>

					<%
					//배송지 입력창
					%>

					<div class="overlay" id="overlay-enter-address">
						<div class="modal" id="modal-enter-address">
							<form id="address-form">
								<h2>입력한 정보를 확인 후 저장해주세요</h2>

								<!-- 받는 이 -->
								<div class="form-group">
									<label for="recipient">받는 이</label><br>
									<div class="input-with-button">
										<input type="text" id="recipient" placeholder="이름 입력" />
										<button type="button" class="btn-remove">✕</button>
									</div>
								</div>

								<!-- 연락처 -->
								<div class="form-group">
									<label for="phone">연락처</label><br>
									<div class="input-with-button">
										<input type="text" id="phone" placeholder="010-0000-0000" />
										<button type="button" class="btn-remove">✕</button>
									</div>
								</div>

								<!-- 배송지명 -->
								<div class="form-group">
									<label for="title">배송지명 (선택)</label><br>
									<div class="input-with-button">
										<input type="text" id="title" placeholder="배송지 별명" />
										<button type="button" class="btn-remove">✕</button>
									</div>
								</div>

								<!-- 주소 -->
								<div class="form-group">
									<div class="label-row">
										<label for="address">주소</label> 
										<span id="post-number-search">(03409)</span>
									</div>
									<div class="input-with-button">
										<input type="text" id="address" placeholder="주소를 입력하세요" />
										<button type="button" class="btn-post-search"
											id="btn-search-address">
											<i class="fa-solid fa-magnifying-glass"></i> 주소검색
										</button>
									</div>
								</div>

								<!-- 상세주소 -->
								<div class="form-group">
									<div class="input-with-button">
										<input type="text" id="detail-address"
											placeholder="상세 주소를 입력하세요" />
										<button type="button" class="btn-remove">✕</button>
									</div>
								</div>

								<!-- 기본 배송지 설정 -->
								<div class="checkbox-group">
									<input type="checkbox" id="default-address" /> <label
										for="default-address">기본 배송지로 설정</label>
								</div>

								<!-- 저장 버튼 -->
								<button type="submit" class="btn-new-address">저장하기</button>
							</form>
						</div>
					</div>

					<%
					//배송지 검색
					%>

					<div class="overlay" id="overlay-search-address">
						<div class="modal" id="modal-search-address">
							<div class="modal-header">
								<h2>주소를 검색해주세요</h2>
								<button class="btn-close" id="btn-close-search">×</button>
							</div>

							<div class="search-bar">
								<input type="text" id="address-input" placeholder="도로명, 지번, 건물명 검색" />
								<button type="button" class="btn-search" id="btn-api-search">검색</button>
							</div>

							<div class="search-guide">
								<p class="guide-title">이렇게 검색해보세요!</p>
								<ul id="guide">
									<li>도로명 + 건물번호<br> <span>예) 정자일로 95, 불정로 6</span></li>
									<li>동/읍/면/리 + 번지<br> <span>예) 정자동 178-4, 동면
											만천리 1000</span></li>
								</ul>
								<ul id="result-list"></ul>
							</div>
							
							
						</div>
					</div>
						

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
						<img src="" alt="상품 이미지">
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
						<img src="/movmov/resources/images/payment/logo_navergr_small.svg"
							alt="">
					</button>
					<button class="account">
						<img src="/movmov/resources/images/payment/Toss_Logo_Primary.png"
							alt="">
					</button>
					<button class="account">
						<img
							src="/movmov/resources/images/payment/payment_icon_yellow_medium.png"
							alt="">
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
</body>
</html>