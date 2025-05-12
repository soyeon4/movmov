<%@page import="kr.co.movmov.vo.User"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.mapper.ShopCartItemMapper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int itemNo = StringUtils.strToInt(request.getParameter("ino"));
	int optionNo = StringUtils.strToInt(request.getParameter("option"));
	
	User loginedUser = (User) session.getAttribute("LOGIN_USER");
	if (loginedUser == null){
		response.sendRedirect("../mypage/modal-login.jsp");
	}
	else {
		String userId = loginedUser.getId();
		ShopCartItemMapper cartItemMapper = MybatisUtils.getMapper(ShopCartItemMapper.class);
		
		if (optionNo > 0) {
			cartItemMapper.updateCartItemOption(userId, itemNo, optionNo);
		}
		
		cartItemMapper.insertCartItem(userId, itemNo);
	
		response.sendRedirect("shop-detail.jsp?no=" + itemNo);
	}
%>