<%-- <%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.movmov.vo.User"%>
<%@page import="kr.co.movmov.vo.Address"%>
<%@page import="kr.co.movmov.mapper.UserMapper"%>
<%@page import="kr.co.movmov.mapper.AddressMapper"%>
<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	//request parameters
	User user = (User) session.getAttribute("LOGIN_USER");
	String receiver_name = request.getParameter("receiver-name");
	String receiver_phone = request.getParameter("receiver-phone");
	String addr_explain = request.getParameter("explaination");
	String road = request.getParameter("address");
	String addr_detail = request.getParameter("detail");
	String zipcode = request.getParameter("zipcode");
	zipcode = zipcode.replaceAll("[^0-9]", "");
	String isDefault = request.getParameter("default-address");
	String valueOfID = request.getParameter("address-id");
	
	int addressID = -1;

	if (valueOfID != null && !valueOfID.trim().isEmpty()) {
        addressID = Integer.parseInt(valueOfID);
    }
	
	//get Mybatis mapper
	AddressMapper addressMapper = MybatisUtils.getMapper(AddressMapper.class);
	
	// validate values
	if (zipcode == null || zipcode.length() != 5 || !zipcode.matches("\\d{5}")) {
		out.println("<script>alert('우편번호는 5자리 숫자여야 합니다.'); history.back();</script>");
		return;
	}

	if (receiver_name == null || receiver_name.trim().isEmpty()) {
		out.println("<script>alert('받는 사람 이름을 입력해주세요.'); history.back();</script>");
		return;
	}

	if (receiver_phone == null || !receiver_phone.matches("^010-\\d{4}-\\d{4}$")) {
		out.println("<script>alert('연락처는 010-0000-0000 형식이어야 합니다.'); history.back();</script>");
		return;
	}

	if (addr_explain == null || addr_explain.trim().isEmpty()) {
		out.println("<script>alert('배송지명을 입력해주세요.'); history.back();</script>");
		return;
	}

	if (road == null || road.trim().isEmpty()) {
		out.println("<script>alert('도로명 주소를 입력해주세요.'); history.back();</script>");
		return;
	}

	if (addr_detail == null || addr_detail.trim().isEmpty()) {
		out.println("<script>alert('상세 주소를 입력해주세요.'); history.back();</script>");
		return;
	}

	if (user == null) {
		out.println("<script>alert('로그인이 필요합니다.'); history.back();</script>");
		return;
	}

	//generate VO(Value Object) and set
	Address address = new Address();
	address.setId(addressID);
	address.setAddressName(addr_explain);
	address.setRoad(road);
	address.setDetail(addr_detail);
	address.setUser(user);
	address.setReceiverName(receiver_name);
	address.setReceiverPhone(receiver_phone);
	address.setZipcode(zipcode);
	
	//insert or update address
	if(valueOfID.isEmpty() || "".equals(valueOfID)) {
		addressMapper.insertAddress(address);
	} else {
		addressMapper.updateAddress(address);
	}
	
	if("yes".equals(isDefault)) {
		addressMapper.updateDefaultAddress(addressID, user);
	}
	
	response.sendRedirect("payment.jsp");
	return;
%> --%>