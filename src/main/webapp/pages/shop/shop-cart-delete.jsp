<%@page import="kr.co.movmov.vo.ShopCartItem"%>
<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.mapper.ShopCartItemMapper"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/*
		요청 정보
			- 요청 URL
				pages/shop/shop-cart-delete.jsp?cno=xxx
			- 요청 파라미터
				name		value
				------------------------
				cno			장바구니 번호
		요청처리 절차
			1. 장바구니 번호를 전달해 장바구니 상품을 삭제한다.
			2. shop-cart.jsp를 재요청하는 응답을 보낸다.
	*/
	int cartNo = StringUtils.strToInt(request.getParameter("cno"));
	ShopCartItemMapper cartItemMapper = MybatisUtils.getMapper(ShopCartItemMapper.class);
	cartItemMapper.deleteCartItemByCartNo(cartNo);
	
	response.sendRedirect("shop-cart.jsp");

%>