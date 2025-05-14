<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="kr.co.movmov.vo.User" %>
<%@ page import="kr.co.movmov.mapper.AddressMapper"%>
<%@ page import="kr.co.movmov.utils.MybatisUtils" %>

<%
User user = (User) session.getAttribute("LOGIN_USER");
if (user == null) {
	response.sendRedirect("/movmov/pages/mypage/login.jsp");
	return;
}

String idParam = request.getParameter("addr_id");
if (idParam != null && idParam.matches("\\d+")) {
	int addrId = Integer.parseInt(idParam);

	AddressMapper addressMapper = MybatisUtils.getMapper(AddressMapper.class);
	addressMapper.deleteAddressById(addrId, user.getId()); // user 검증 포함된 SQL 추천
}

response.sendRedirect("/movmov/pages/payment/payment.jsp");
%>
