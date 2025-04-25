<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	/*
		HttpSession에서 로그인된 정보를 조회해서
		로그인된 사용자 아이디가 조회되면 로그인된 상태다.
	*/
	String loginedUserId = (String) session.getAttribute("LOGINED_USER_ID");
%>

<header>
	<div class="logo">
		<img src="/movmov/resources/images/common/logo-primary.png"
			alt="MovMov 로고" class="logo-img">
	</div>
	<nav>
		<ul>
			<li><a href="/movmov/index.jsp">홈</a></li>
			<li><a href="/movmov/pages/movie/movie-list.jsp">영화</a></li>
			<li><a href="/movmov/pages/community/community.jsp">커뮤니티</a></li>
			<li><a href="/movmov/pages/commerce/shopmain.jsp">Mov Commerce</a></li>
		</ul>
	</nav>
	<%
	//로그인 완료
	if (loginedUserId != null) {
%>
	<div class="client">
		<button class="btn-cart">장바구니</button>
		<button class="btn-signout">로그아웃</button>
		<img src="/movmov/resources/images/common/default-profile.png" id="profile-toggle"
			alt="프로필">
		<div class="profile-dropdown" id="profile-dropdown">
			<div class="profile-info">
				<img src="/movmov/resources/images/common/default-profile.png" alt="프로필 이미지">
				<div class="user-meta">
					<strong>user12345</strong>님
					<p>example12345@gmail.com</p>
					<div class="actions">
						<a href="#">My Page</a> | <a href="#">이용약관</a>
					</div>
					<div class="balance">
						잔여 포인트 <strong>11,527</strong>P
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="/movmov/resources/script/common/toggler.js"></script>
	<%
	//비 로그인 상태
	} else {
%>
	<div class="client">
		<button class="btn-signin">로그인</button>
		<button class="btn-signup">회원가입</button>
	</div>
	<%
	}
%>
</header>
