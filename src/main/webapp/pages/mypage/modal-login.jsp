<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>로그인</title>
  <link rel="stylesheet" href="../../resources/style/mypage/modal-login.css" />
  <link rel="icon" href="resources/images/common/favicon.ico">
<link
   href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap"
   rel="stylesheet">
<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
<link rel="stylesheet" href="resources/style/common/main.css">
</head>
<body>

<div class="modal-background">
  <div class="modal-login">
    <h2>로그인</h2>

    <!-- ✅ form 태그 추가로 로그인 처리 가능 -->
    <form action="login.jsp" method="post">
      <input type="text" name="id" placeholder="아이디" class="input-login" required />
      <input type="password" name="password" placeholder="비밀번호" class="input-login" required />

      <button type="submit" class="btn-login-submit">로그인</button>
    </form>

    <div style="margin-top: 12px;">
      <a href="#" class="link-small">비밀번호를 잊으셨나요?</a>
    </div>

    <div style="margin-top: 16px;">
      <a href="register-form.jsp" class="link-small">계정이 없으신가요? <strong>회원가입</strong></a>
    </div>
  </div>
</div>

</body>
</html>
