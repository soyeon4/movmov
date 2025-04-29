<%@page import="kr.co.movmov.vo.User"%>
<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.mapper.UserMapper"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	/* 요청 파라미터 
		id, password, nickname, email, region
	*/
	
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String nickname = request.getParameter("nickname");
	String email = request.getParameter("email");
	String region = request.getParameter("region");
	String name = request.getParameter("name");
	
	UserMapper userMapper = MybatisUtils.getMapper(UserMapper.class);
	
	User userId = userMapper.getIdByUser(id);
	if (userId != null) {
		response.sendRedirect("register-fail.jsp?fail=id");
		return;
	}
	
	User userEmail = userMapper.getEmailByUser(email);
	if (userEmail != null) {
		response.sendRedirect("register-fail.jsp?fail=email");
		return;
	}
	
	User userNickName = userMapper.getNickName(nickname);
	if (userNickName != null) {
		response.sendRedirect("register-fail.jsp?fail=nickname");
		return;
	}
		
	String secretPassword = DigestUtils.sha256Hex(password);
	
	User user = new User();
	user.setId(id);
	user.setPassword(secretPassword);
	user.setNickname(nickname);
	user.setEmail(email);
	user.setRegion(region);
	user.setName(name);
	user.setPoint(0);
	
	userMapper.insertUser(user);
	response.sendRedirect("register-success-form.jsp");
%>