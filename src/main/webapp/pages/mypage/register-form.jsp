<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입</title>
<link rel="icon" href="../../resources/images/common/favicon.ico">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="../../resources/style/common/main.css">
</head>
<body>
	<div class="modal-background" style="display: block;">
		<div class="modal-login">
			<h2>회원가입</h2>

			<!-- 가입 후 성공 페이지로 이동 -->
			<form action="register.jsp" method="post">
				<input type="text" name="id" placeholder="아이디"
					class="input-login" required />
				<input type="password" name="password" placeholder="비밀번호"
					class="input-login" required />
				<input type="text" name="nickname" placeholder="닉네임"
					class="input-login" required />
				<input type="email" name="email" placeholder="이메일"
					class="input-login" required />
				<input type="text" name="name" placeholder="이름"
					class="input-login" required />
				<select name="region" class="input-login" required>
					<option value="">국가/지역 선택</option>
					<option value="KR">대한민국</option>
					<option value="US">미국</option>
					<option value="JP">일본</option>
					<option value="CN">중국</option>
					<option value="OTHER">기타</option>
				</select>
				<button type="submit" class="btn-login-submit">가입하기</button>
			</form>

			<div class="link-small">
				<a href="modal-login.jsp">이미 계정이 있으신가요? <strong>로그인</strong></a>
			</div>
		</div>
	</div>
</body>
</html>
