<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
/*
		요청 파라미터
	- redirectUrl (null 가능)
		- null 일 경우 request.getRequestURI() 로 응답 전송
	*/
	String redirectUrl = request.getParameter("redirectUrl");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>로그인</title>
</head>
<body>
	<div class="modal-background">
		<div class="modal-login">
			<span class="modal-close">&times;</span>

			<h2>로그인</h2>

			<!-- form 태그 추가로 로그인 처리 가능 -->
			<form id="login-form" action="/movmov/pages/mypage/login.jsp" method="post">
				<input type="text" name="id" placeholder="아이디" id="login-id-field"
					class="input-login" required />
				<input type="password" name="password" placeholder="비밀번호" id="login-pw-field"
					class="input-login" required />
				<input type="hidden" name="redirectUrl"
					value="<%=redirectUrl %>">
				<button type="submit" class="btn-login-submit">로그인</button>
			</form>

			<div class="link-small">
				<a href="#">비밀번호를 잊으셨나요?</a>
			</div>

			<div class="link-small">
				<a href="/movmov/pages/mypage/register-form.jsp">계정이 없으신가요? <strong>회원가입</strong></a>
			</div>
		</div>
	</div>
</body>
</html>
