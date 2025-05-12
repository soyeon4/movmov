<%@page import="kr.co.movmov.vo.ShopCartItem"%>
<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.mapper.ShopCartItemMapper"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	int cartNo = StringUtils.strToInt(request.getParameter("cno"));
	ShopCartItemMapper cartItemMapper = MybatisUtils.getMapper(ShopCartItemMapper.class);
	cartItemMapper.deleteCartItemByCartNo(cartNo);
	
	response.sendRedirect("shop-cart.jsp");	// 이거하면 위에 실행되고 이 페이지로 이동하네 오케이

%>