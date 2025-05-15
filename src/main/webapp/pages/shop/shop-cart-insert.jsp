<%@page import="kr.co.movmov.vo.ShopCartItem"%>
<%@page import="kr.co.movmov.vo.User"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.mapper.ShopCartItemMapper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/*
		요청 정보
			- 요청 URL
				pages/shop/shop-cart-insert.jsp?ino=xxx&qty=xxx&option=xxx
			- 요청 파라미터
				name		value
				----------------------------
				ino			상품 번호
				qty			상품 수량
				option		상품 옵션
		요청처리 절차
			1. 요청파라미터로 전달된 상품의 번호, 수량, 옵션을 조회한다.
			2. 세션에서 사용자 아이디를 획득한다.
			3. 사용자 아이디로 장바구니를 조회해 이미 담긴 상품이라면 상품의 수량을 업데이트한다.
			4. 사용자의 아이디, 상품번호, 옵션, 수량을 전달해 장바구니에 추가한다.
			5. shop-detail.jsp?no=xxx를 재요청하는 응답을 보낸다.
	*/
	int itemNo = StringUtils.strToInt(request.getParameter("ino"));
	int optionNo = StringUtils.strToInt(request.getParameter("option"));
	int quantity = StringUtils.strToInt(request.getParameter("qty"));
	
	User loginedUser = (User) session.getAttribute("LOGIN_USER");
	if (loginedUser != null){
		String userId = loginedUser.getId();
		ShopCartItemMapper cartItemMapper = MybatisUtils.getMapper(ShopCartItemMapper.class);
		ShopCartItem cartItem = cartItemMapper.getCartItem(userId, itemNo, optionNo);
		if (cartItem != null) {
			int qty = cartItem.getQuantity() + quantity;
			cartItemMapper.updateCartItemQuantityByCartNo(cartItem.getNo(), qty);
		} else {
			cartItemMapper.insertCartItem(userId, itemNo, optionNo, quantity);
		}
		
		response.sendRedirect("shop-detail.jsp?ino=" + itemNo);
	}
%>