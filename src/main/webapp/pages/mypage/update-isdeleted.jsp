<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.mapper.UserMapper"%>
<%@page import="kr.co.movmov.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	User loginUsersData = (User) session.getAttribute("LOGIN_USER");
	String userId = loginUsersData.getId();
	UserMapper userMapper = MybatisUtils.getMapper(UserMapper.class);
	
	User user = new User();
	user.setId(userId);
	user.setIsDeleted("Y");
	
	userMapper.updateUserDelete(user);
	
	session.invalidate();
	response.sendRedirect("../../index.jsp");
	
%>