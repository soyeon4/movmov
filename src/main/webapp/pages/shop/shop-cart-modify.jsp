<%@page import="kr.co.movmov.vo.ShopCartItem"%>
<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.mapper.ShopCartItemMapper"%>
<%@page import="kr.co.movmov.vo.User"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int itemNo = StringUtils.strToInt(request.getParameter("ino"));
	int optionNo = StringUtils.strToInt(request.getParameter("option"));
	int quantity = StringUtils.strToInt(request.getParameter("qty"));
	
	User loginedUser = (User) session.getAttribute("LOGIN_USER");
	if (loginedUser == null){
		response.sendRedirect("../mypage/modal-login.jsp");
	}
	else {
		String userId = loginedUser.getId();
		ShopCartItemMapper cartItemMapper = MybatisUtils.getMapper(ShopCartItemMapper.class);
		ShopCartItem item = cartItemMapper.getCartItem(userId, itemNo, optionNo);
		
		cartItemMapper.updateCartItemQuantity(userId, itemNo, quantity);
		
		response.sendRedirect("shop-cart.jsp");
	}
%>