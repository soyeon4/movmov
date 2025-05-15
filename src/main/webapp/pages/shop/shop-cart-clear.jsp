<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.mapper.ShopCartItemMapper"%>
<%@page import="kr.co.movmov.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/*
		요청 정보
			- 요청 URL
				pages/shop/shop-cart-clear.jsp
			- 요청 파라미터	
				없음
		요청처리 절차
			1. 세션에서 사용자 아이디를 획득한다.
			2. 사용자의 아이디를 전달해 장바구니 목록을 전부 삭제시킨다.
			3.	shop-cart.jsp를 재요청하는 응답 보내기
	*/
	User loginedUser = (User) session.getAttribute("LOGIN_USER");
	String userId = loginedUser.getId();
	
	ShopCartItemMapper cartMapper = MybatisUtils.getMapper(ShopCartItemMapper.class);
	
	cartMapper.deleteCartItemByUserId(userId);
	
	response.sendRedirect("shop-cart.jsp");
%>