<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="kr.co.movmov.vo.User"%>
<%@ page import="kr.co.movmov.vo.Address"%>
<%@ page import="kr.co.movmov.mapper.AddressMapper"%>
<%@ page import="kr.co.movmov.utils.MybatisUtils"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
	User user = (User) session.getAttribute("LOGIN_USER");

	AddressMapper addressMapper = MybatisUtils.getMapper(AddressMapper.class);
	List<Address> addressList = addressMapper.getAllAddressOfUser(user);
%>

<div class="overlay" id="overlay-list-address">
	<div class="modal" id="modal-list-address">
		<h2>배송지 목록</h2>

		<div class="address-list-wrapper">
			<% for (Address address : addressList) { %>
			<div class="address-card" data-id="<%=address.getId()%>">
				<div class="address-header">
					<strong><%= address.getReceiverName() %></strong> <span><%= address.getAddressName() %></span>
				</div>
				<div class="phone"><%= address.getReceiverPhone() %></div>
				<div class="address"><%= address.getRoad() %></div>
				<div class="detail"><%= address.getDetail() %></div>
				<div class="post-number"><%= address.getZipcode() %></div>
				<div class="btn-wrapper">
					<button class="btn-edit">수정</button>
					<button class="btn-delete">삭제</button>
				</div>
				<span class="selected-text"></span>
			</div>
			<% } %>
		</div>
	</div>
</div>
