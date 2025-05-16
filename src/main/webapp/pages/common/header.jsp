<%@page import="kr.co.movmov.vo.User"%>
<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.mapper.UserMapper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	/*
		HttpSession에서 로그인된 정보를 조회해서
		로그인된 사용자 아이디가 조회되면 로그인된 상태다.
	*/
	User loginUser = (User) session.getAttribute("LOGIN_USER");
	
%>
	<!-- 로그인 모달 포함  -->
	<%@ include file="../mypage/modal-login.jsp" %>

<header>
	<div class="logo">
		<img src="/movmov/resources/images/common/logo-primary.png"
			alt="MovMov 로고" class="logo-img">
	</div>
	<nav>
		<ul>
			<li><a href="/movmov/index.jsp">홈</a></li>
			<li><a href="/movmov/pages/movie/movie-list.jsp">영화</a></li>
			<li><a href="/movmov/pages/community/community-main.jsp">커뮤니티</a></li>
			<li><a href="/movmov/pages/shop/shop-main.jsp">Mov Commerce</a></li>
		</ul>
	</nav>
<%
	//비로그인 상태
	if (loginUser == null) {
%>
		<div class="client">
	     	<button type="button" class="btn-signin"
	     		id="btn-header-login">로그인</button>
	     	<a href="/movmov/pages/mypage/register-form.jsp">
	     		<button type="button" class="btn-signin">회원가입</button>
	     	</a>
	    </div>
	
<%
	//로그인 상태
	} else {
%>
		<div class="client">
		<a href="/movmov/pages/mypage/page.jsp">
			<button type="button" class="btn-signin"><%=loginUser.getNickname() %></button>
		</a>
		<a href="/movmov/pages/shop/shop-cart.jsp">
			<button type="button" class="btn-cart">장바구니</button>
		</a>
		<a href="/movmov/pages/mypage/logout.jsp">
			<button type="button" class="btn-signin">로그아웃</button>
		</a>
		<img src="/movmov/resources/images/common/default-profile.png" id="profile-toggle"
			alt="프로필">
		<div class="profile-dropdown" id="profile-dropdown">
			<div class="profile-info">
  					<img src="/movmov/resources/images/common/default-profile.png" alt="프로필 이미지">
				<div class="user-meta">
					<strong><%=loginUser.getNickname() %></strong>님
					<p><%=loginUser.getEmail() %></p>
					<div class="actions">
						<a href="/movmov/pages/mypage/page.jsp">My Page</a> | <a href="/movmov/pages/cs/faq.jsp">고객센터</a>
					</div>
					<div class="balance">
						잔여 포인트 <strong><%=loginUser.getPoint() %></strong>P
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="/movmov/resources/script/common/toggler.js"></script>	
<%
	}
%>
</header>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/movmov/resources/script/common/header-login.js"></script>
	