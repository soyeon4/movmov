<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="kr.co.movmov.vo.User"%>
<%@page import="kr.co.movmov.mapper.UserMapper"%>
<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<%
		/* 요청 파라미터
			id , password
		*/
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	
	boolean success = false;
	
	UserMapper userMapper = MybatisUtils.getMapper(UserMapper.class);
	
	User userAllData = userMapper.getIdByUser(id);

	
	if (userAllData == null) {
		// 로그인 실패 처리
		response.sendRedirect("login-fail.jsp?fail=id");
		return;
	}
	
	String secretPassword = DigestUtils.sha256Hex(password);
	
	
	if (!secretPassword.equals(userAllData.getPassword())) {
		response.sendRedirect("login-fail.jsp?fail=password");
		return;
	}


    if ("Y".equals(userAllData.getIsDeleted())) {
		response.sendRedirect("login-fail.jsp?fail=isDeleted");
        return;
    }

    success = true;
    Map<String, Object> result = new HashMap<>();
    result.put("success", success);
    
    Gson gson = new Gson();
    String jsonResponse = gson.toJson(result);
    
	session.setAttribute("LOGIN_USER", userAllData);
	out.print(jsonResponse);
%>