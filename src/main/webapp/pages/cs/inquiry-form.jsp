<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@page import="kr.co.movmov.mapper.CsInquiryMapper"%>
<%@page import="kr.co.movmov.vo.Inquiry"%>
<%@page import="kr.co.movmov.vo.User"%>
<%@page import="kr.co.movmov.vo.Category"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.mapper.CategoryMapper"%>
<%@ page contentType="text/html; charset=UTF-8" language="java"%>

<%
User user = (User) session.getAttribute("LOGIN_USER"); // 로그인한 유저

CategoryMapper categoryMapper = MybatisUtils.getMapper(CategoryMapper.class); //카테고리 항목을 불러올 mapper
CsInquiryMapper csInquiryMapper = MybatisUtils.getMapper(CsInquiryMapper.class); //문의내역 mapper

List<Category> inquiryCategories = categoryMapper.getCategoriesByType("문의유형"); //'문의유형' 카테고리 타입을 받아서 카테고리 목록을 불러옴

%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Q&A 작성하기</title>
<link rel="stylesheet"
	href="/movmov/resources/style/cs/inquiry-form.css">

</head>
<body>

	<!-- Trigger/Open The Modal -->
	<button id="myBtn">Q&A 작성하기</button>

	<!-- 모달창 -->
	<div id="myModal" class="modal">
		<!-- Modal Content -->
		<div class="modal-content">
			<div class="modal-header">
				<h3>Q&A 작성하기</h3>
				<span class="close">&times;</span>
			</div>
		<form id="form-inquiry" action="create-inquiry.jsp" method="post">
			<div class="modal-body">
				<div class="form-group">
					<label for="category">카테고리</label> <select id="category"
						name="category">
						<%
						for (Category inquiryCategory : inquiryCategories) {
							String categoryName = inquiryCategory.getName(); // 문의유형 카테고리 항목 표시(categoryMapper로 불러옴)
							String categoryId = String.valueOf(inquiryCategory.getId()); // <option>사용하기 위해 categoryId(int형)를 문자열로 변환함
						%>
						<option value="<%=categoryId%>"><%=categoryName%></option>
						<%
						}
						%>
					</select>
				</div>
	
				<%-- 제목 입력 부분 --%>
				<div class="form-group">
					<label for="title">제목</label> <input type="text" id="title"
						name="title" placeholder="Q&A 제목을 입력하세요" required>
				</div>
	
				<div class="form-group">
					<label for="content">내용</label>
					<textarea id="content" name="content" placeholder="Q&A 내용을 입력하세요"
						required></textarea>
				</div>
	
				<!-- 비밀글 체크박스 추가 -->
				<div class="form-group">
					<input type="hidden" name="anonymous" value="0">
					<input type="checkbox" id="anonymous" name="anonymous" value="1"> <label
						for="anonymous">비밀글로 작성</label>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="cancel">취소</button>
				<button type="submit" class="submit">작성 완료</button>
			</div>
		</form>
	</div>
	</div>

	<script src="/movmov/resources/script/cs/inquiry-form.js"></script>
</body>

</html>
