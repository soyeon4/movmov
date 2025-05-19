<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<div class="overlay" id="overlay-enter-address">
	<div class="modal" id="modal-enter-address">
		<form id="address-form" action="/movmov/pages/payment/insert-address.jsp" method="post">
			<h2>입력한 정보를 확인 후 저장해주세요</h2>
			
			<input type="hidden" name="address-id" id="address-id" value="">

			<!-- 받는 이 -->
			<div class="form-group">
				<label for="recipient">받는 이</label><br>
				<div class="input-with-button">
					<input type="text" name="receiver-name" id="recipient"
						placeholder="이름 입력" required />
					<button type="button" class="btn-remove">✕</button>
				</div>
			</div>

			<!-- 연락처 -->
			<div class="form-group">
				<label for="phone">연락처</label><br>
				<div class="input-with-button">
					<input type="text" name="receiver-phone" id="phone"
						placeholder="010-0000-0000" />
					<button type="button" class="btn-remove">✕</button>
				</div>
			</div>

			<!-- 배송지명 -->
			<div class="form-group">
				<label for="title">배송지명 (선택)</label><br>
				<div class="input-with-button">
					<input type="text" name="explaination" id="title"
						placeholder="배송지 별명" />
					<button type="button" class="btn-remove">✕</button>
				</div>
			</div>

			<!-- 주소 -->
			<div class="form-group">
				<div class="label-row">
					<label for="address">주소</label> <input name="zipcode"
						id="post-number-search" readonly />
				</div>
				<div class="input-with-button">
					<input type="text" name="address" id="address"
						placeholder="주소검색 버튼 이용하여 입력하세요" readonly />
					<button type="button" class="btn-post-search"
						id="btn-search-address">
						<i class="fa-solid fa-magnifying-glass"></i> 주소검색
					</button>
				</div>
			</div>

			<!-- 상세주소 -->
			<div class="form-group">
				<div class="input-with-button">
					<input type="text" name="detail" id="detail-address"
						placeholder="상세 주소를 입력하세요" />
					<button type="button" class="btn-remove">✕</button>
				</div>
			</div>

			<!-- 기본 배송지 설정 -->
			<div class="checkbox-group">
				<input type="checkbox" id="default-address" name="default-address" value="yes"/> <label
					for="default-address">기본 배송지로 설정</label>
			</div>

			<!-- 저장 버튼 -->
			<button type="submit" class="btn-new-address">저장하기</button>
		</form>
	</div>
</div>
