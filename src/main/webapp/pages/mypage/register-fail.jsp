<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String Type = request.getParameter("fail");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입 실패</title>
    <link rel="stylesheet" href="../../resources/style/mypage/error.css">
</head>
<body>

<div class="error-container">
    <h1>❌ 회원가입 실패</h1>
<%
	if (("id").equals(Type)) {
%>
    <p>이미 사용중인 아이디입니다.</p>
    
<%
	}
%>    
<%
	if (("email").equals(Type)) {
%>
    <p>이미 사용중인 이메일입니다.</p>
    
<%
	}
%>    
<%
	if (("nickname").equals(Type)) {
%>
    <p>이미 사용중인 닉네임입니다.</p>
    
<%
	}
%>    
    <a href="register-form.jsp" class="btn">회원가입 다시하기</a>
</div>

</body>
</html>
