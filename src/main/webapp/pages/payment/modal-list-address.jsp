<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
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
Address defaultAddress = addressMapper.getDefaultAddress(user);
%>

<div class="overlay" id="overlay-list-address">
	<div class="modal" id="modal-list-address">
		<div class="address-container">
			<h2>배송지 목록</h2>
			<button class="btn-new-address" id="btn-new-address">+ 배송지
				신규입력</button>
			<div class="address-list-container">
				<%
				if (defaultAddress != null) {
				%>
				<div class="address-card selected">
					<div class="address-header">
						<input type="hidden" id="address-id-0" name="address-id" value="<%=defaultAddress.getId()%>">
						<strong><%=defaultAddress.getReceiverName()%></strong>
						<span><%=defaultAddress.getAddressName()%></span> 
						<span class="selected-text">✓ 선택됨</span>
					</div>
					<div class="phone"><%=defaultAddress.getReceiverPhone()%></div>
					<div class="address-detail">
						<span class="address"><%=defaultAddress.getRoad()%></span> 
						<span class="detail"><%=defaultAddress.getDetail()%></span> 
						<span class="post-number"><%=defaultAddress.getZipcode()%></span>
					</div>
					<div class="address-actions">
						<button class="btn-edit">수정</button>
						<button class="btn-delete">삭제</button>
					</div>
				</div>
				<%
				}
				int index = 1;
				for (Address address : addressList) {
					if(defaultAddress != null && address.getId() == defaultAddress.getId()){ continue; }
				%>
				<div class="address-card">
					<div class="address-header">
						<input type="hidden" id="address-id-<%=index %>" name="address-id" value="<%=address.getId()%>">
						<strong><%=address.getReceiverName()%></strong>
						<span>(<%=address.getAddressName()%>)</span> 
						<span class="selected-text"></span>
					</div>
					<div class="phone"><%=address.getReceiverPhone()%></div>
					<div class="address-detail">
						<span class="address"><%=address.getRoad()%></span> 
						<span class="detail"><%=address.getDetail()%></span> 
						<span class="post-number"><%=address.getZipcode()%></span>
					</div>
					<div class="address-actions">
						<button class="btn-edit">수정</button>
						<button class="btn-delete">삭제</button>
					</div>
				</div>
				<%
					index++;
				}
				%>
			</div>
		</div>
	</div>
</div>
 --%>