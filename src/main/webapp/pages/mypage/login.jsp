<%@page import="kr.co.movmov.vo.User"%>
<%@page import="kr.co.movmov.mapper.UserMapper"%>
<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<%
		/* 요청 파라미터
			id , password, redirectUrl (null 가능)
		*/
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String redirectUrl = "../../index.jsp";
	if (request.getParameter("redirectUrl") != null) {
		redirectUrl = request.getParameter("redirectUrl");
	}
	
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

	session.setAttribute("LOGIN_USER", userAllData);
	response.sendRedirect(redirectUrl);
%>