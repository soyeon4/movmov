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
	String message = "";
	boolean success = false;
	
	UserMapper userMapper = MybatisUtils.getMapper(UserMapper.class);
	User userAllData = userMapper.getIdByUser(id);
	
	if (userAllData == null) {
		message = "id";
	} else {
		String secretPassword = DigestUtils.sha256Hex(password);
		if (!secretPassword.equals(userAllData.getPassword())) {
			message = "password";
		} else if ("Y".equals(userAllData.getIsDeleted())) {
				redirectUrl = "/movmov/pages/mypage/login-fail.jsp?fail=isDeleted";
		} else {
   			success = true;
   		}
	}

    Map<String, Object> result = new HashMap<>();
    result.put("success", success);
    result.put("message", message);
    result.put("redirectUrl", redirectUrl);

    if (success) {
		session.setAttribute("LOGIN_USER", userAllData);
    }
    
    Gson gson = new Gson();
    String jsonResponse = gson.toJson(result);
	out.print(jsonResponse);
%>