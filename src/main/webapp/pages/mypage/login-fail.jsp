<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String type = request.getParameter("fail");
	session.invalidate();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>로그인 실패 | MovMov</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="../../resources/style/mypage/login-fail.css">
  <script src="https://kit.fontawesome.com/your-own-kit-code.js" crossorigin="anonymous"></script>
</head>

<body>

  <div class="alert-box">
    <div class="alert-icon">
      <i class="fa-solid fa-circle-exclamation"></i>
    </div>
    <h2>로그인 실패</h2>
    <hr>
<%
    if ("id".equals(type)) {
%>
    <p>존재하지 않는 아이디입니다.</p>
<%
    } else if ("password".equals(type)) {
%>	
    <p>비밀번호가 일치하지 않습니다.</p>
<%
    } else if ("isDeleted".equals(type)) {
%>	
    <p>탈퇴한 회원입니다. 고객센터에 문의해주세요.</p>
<%
    } else {
%>
    <p>알 수 없는 오류가 발생했습니다.</p>
<%
    }
%>
	
    <a href="../../index.jsp" class="btn btn-primary btn-login">다시 로그인</a>
  </div>

</body>
</html>
