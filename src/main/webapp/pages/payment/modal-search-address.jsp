<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

			<ul id="guide">
				<li><p class="guide-title">이렇게 검색해보세요!</p></li>
				<li>도로명 + 건물번호<br> <span>예) 정자일로 95, 불정로 6</span></li>
				<li>동/읍/면/리 + 번지<br> <span>예) 정자동 178-4, 동면 만천리
						1000</span></li>
			</ul>
			<ul id="result-list"></ul>
		</div>
	</div>
</div>