<%@page import="kr.co.movmov.vo.Comment"%>
<%@page import="kr.co.movmov.mapper.CommentMapper"%>
<%@page import="kr.co.movmov.mapper.PostMapper"%>
<%@page import="kr.co.movmov.vo.Post"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	/*
		/pages/community/report-form.jsp?pno=xxx
		/pages/community/report-form.jsp?cno=xxx
		요청 파라미터
		name	value
		----------------
		pno		게시글번호
		cno		댓글번호
	*/
	String reportType = "";
	int contentNo = 0;
	if (request.getParameter("pno") != null) {
		reportType = "post";
		contentNo = StringUtils.strToInt(request.getParameter("pno"));
		PostMapper postMapper = MybatisUtils.getMapper(PostMapper.class);
		Post post = postMapper.getPostByNo(contentNo);
		pageContext.setAttribute("content", post);
	} else {
		reportType = "comment";
		contentNo = StringUtils.strToInt(request.getParameter("cno"));
		CommentMapper commentMapper = MybatisUtils.getMapper(CommentMapper.class);
		Comment comment = commentMapper.getCommentByNo(contentNo);
		pageContext.setAttribute("content", comment);
	}
	User loginedUser = (User) session.getAttribute("LOGIN_USER");
	String userId = loginedUser.getId();
	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MovMov Community</title>
<link rel="icon" href="../../resources/images/common/favicon.ico">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="../../resources/style/common/main.css">
<link rel="stylesheet" href="../../resources/style/community/report-form.css">
</head>
<body>
	<!-- 헤더 -->
	<%@ include file="../common/header.jsp"%>
	
	<div class="report-container">
		<h2>🚨 <%= ("post".equals(reportType) ? "게시글" : "댓글") %> 신고하기</h2>
		<div class="content-preview">
			<div class="content-title">
<%
	if ("post".equals("post")) {
%>
			</div>
<%

%>
			<div class="content-contents">
			
			</div>
		</div>
		<form>
			<label for="reason">신고 사유</label> <select id="reason" name="reason"
				required>
				<option value="">-- 선택해주세요 --</option>
				<option value="spam">스팸 또는 광고</option>
				<option value="hate">혐오 발언 또는 괴롭힘</option>
				<option value="violence">폭력적인 내용</option>
				<option value="illegal">불법 정보 포함</option>
				<option value="etc">기타</option>
			</select> <label for="details">상세 내용</label>
			<textarea id="details" name="details"
				placeholder="신고 사유에 대한 자세한 설명을 입력해주세요."></textarea>

			<button type="submit" class="submit-btn">신고하기</button>
			<button type="button" class="return-btn">돌아가기</button>
		</form>
	</div>
</body>
	<!-- 푸터 -->
	<%@ include file="../common/footer.jsp"%>
</html>
