<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="kr.co.movmov.vo.User"%>
<%@page import="kr.co.movmov.mapper.UserMapper"%>
<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
		/* 요청 파라미터
			id , password, redirectUrl (null 가능)
		*/
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String redirectUrl = request.getParameter("redirectUrl");
	
	boolean success = false;
	
	UserMapper userMapper = MybatisUtils.getMapper(UserMapper.class);
	
	User userAllData = userMapper.getIdByUser(id);

	
	// 로그인 실패 처리
	if (userAllData == null) {
		redirectUrl = "/movmov/pages/mypage/login-fail.jsp?fail=id";
	} else {
		String secretPassword = DigestUtils.sha256Hex(password);
		if (!secretPassword.equals(userAllData.getPassword())) {
			redirectUrl = "/movmov/pages/mypage/login-fail.jsp?fail=password";
		} else if ("Y".equals(userAllData.getIsDeleted())) {
				redirectUrl = "/movmov/pages/mypage/login-fail.jsp?fail=isDeleted";
		} else {
   			success = true;
   		}
	}

    Map<String, Object> result = new HashMap<>();
    result.put("success", success);
    result.put("redirectUrl", redirectUrl);
    
    Gson gson = new Gson();
    String jsonResponse = gson.toJson(result);
    
	session.setAttribute("LOGIN_USER", userAllData);
	out.print(jsonResponse);
%>