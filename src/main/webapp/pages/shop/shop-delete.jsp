<%@page import="kr.co.movmov.vo.ShopCartItem"%>
<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.mapper.ShopCartItemMapper"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	int[] values = StringUtils.strToInt(request.getParameterValues("cno"));
	int length = values.length;
	
	ShopCartItemMapper cartMapper = MybatisUtils.getMapper(ShopCartItemMapper.class);
	
	
	for (int i = 0; i<length; i++) {
		int cno = values[i];
		cartMapper.deleteCartItemByCartNo(cno);
		
	}
	
	response.sendRedirect("shop-cart.jsp");

%>