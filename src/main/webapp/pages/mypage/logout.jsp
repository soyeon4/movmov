<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
		String loginId = (String) session.getAttribute("LOGIN_USER_ID");


		session.invalidate();

		response.sendRedirect("../../index.jsp");
%> 