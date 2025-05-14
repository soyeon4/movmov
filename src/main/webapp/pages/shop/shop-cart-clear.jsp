<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.mapper.ShopCartItemMapper"%>
<%@page import="kr.co.movmov.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	User loginedUser = (User) session.getAttribute("LOGIN_USER");
	String userId = loginedUser.getId();
	
	ShopCartItemMapper cartMapper = MybatisUtils.getMapper(ShopCartItemMapper.class);
	
	cartMapper.deleteCartItemByUserId(userId);
	
	response.sendRedirect("shop-cart.jsp");
%>