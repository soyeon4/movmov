<%@page import="kr.co.movmov.vo.ShopCartItem"%>
<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.mapper.ShopCartItemMapper"%>
<%@page import="kr.co.movmov.vo.User"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/*
		요청 정보
			- 요청 URL
				pages/shop/shop-cart-modify.jsp?ino=xxx&qty=xxx&option=xxx
			- 요청 파라미터
				name		value
				----------------------------
				ino			상품 번호
				qty			상품 수량
				option		상품 옵션
		요청처리 절차
			1. 요청파라미터로 전달된 상품의 번호, 수량, 옵션 정보를 획득한다.
			2. 세션에서 사용자 아이디를 획득한다.
			3. 사용자 아이디와 상품 정보로 장바구니 상품의 수량을 수정한다.
			4. shop-cart.jsp로 재요청하는 응답을 보낸다.
	*/
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
		ShopCartItem cartItem = cartItemMapper.getCartItem(userId, itemNo, optionNo);
		
		cartItemMapper.updateCartItemQuantityByCartNo(cartItem.getNo(), quantity);
		
		response.sendRedirect("shop-cart.jsp");
	}
%>