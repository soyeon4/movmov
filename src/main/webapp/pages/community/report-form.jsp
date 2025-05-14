<%@page import="kr.co.movmov.mapper.CategoryMapper"%>
<%@page import="kr.co.movmov.vo.Category"%>
<%@page import="java.util.List"%>
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
	Post post = new Post();
	Comment comment = new Comment();
	if (request.getParameter("pno") != null) {
		reportType = "post";
		contentNo = StringUtils.strToInt(request.getParameter("pno"));
		PostMapper postMapper = MybatisUtils.getMapper(PostMapper.class);
		post = postMapper.getPostByNo(contentNo);
	} else {
		reportType = "comment";
		contentNo = StringUtils.strToInt(request.getParameter("cno"));
		CommentMapper commentMapper = MybatisUtils.getMapper(CommentMapper.class);
		comment = commentMapper.getCommentByNo(contentNo);
	}
	User loginedUser = (User) session.getAttribute("LOGIN_USER");
	String userId = loginedUser.getId();
	
	CategoryMapper catMapper = MybatisUtils.getMapper(CategoryMapper.class);
	List<Category> reportHeaders = catMapper.getAllReportHeaders();
	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>신고하기</title>
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
	if ("post".equals(reportType)) {
%>
			<h3><strong>제목 | </strong><%=post.getTitle() %></h3>
			<p>작성자 | <%=post.getUser().getNickname() %></p>
<%
	} else {
%>
			<p>작성자 ㅣ <%=comment.getUser().getNickname() %></p>
<%
	}
%>
			</div>
			<hr class="divider">
			<div class="content-contents">
				<%=("post".equals(reportType) ? post.getContent() : comment.getContent()) %>
			</div>
		</div>
		<form action="create-report.jsp" method="post" id="form-create-report">
			<input type="hidden" name="contentNo" id="content-no" value="<%=contentNo %>">
			<input type="hidden" name="reportType" id="report-type" value="<%=reportType %>">
			<label for="category">신고 사유</label> <select id="category" name="categoryId" required>
				<option value="none">-- 선택해주세요 --</option>
<%
	for (Category option : reportHeaders) {
%>
				<option value="<%=option.getId() %>"><%=option.getName() %></option>
<%
	}
%>
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
	
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script type="text/javascript">
		$(".submit-btn").on("click", function(e) {
			if ($("#category").val() == "none") {
				e.preventDefault();
				alert("신고사유는 필수 선택사항입니다.")
				$("#category").focus();
				return;
			}
			if ($("#category").val() == "205" && $("#details").val().trim() == "") {
				e.preventDefault();
				alert("신고 상세내용을 적어주세요.")
				$("#details").focus();
				return;
			}
		});
	</script>
	
</html>
