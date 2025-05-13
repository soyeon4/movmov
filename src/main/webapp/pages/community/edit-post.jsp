<%@page import="java.util.Date"%>
<%@page import="kr.co.movmov.vo.Post"%>
<%@page import="kr.co.movmov.mapper.PostMapper"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@ page import="kr.co.movmov.mapper.CategoryMapper" %>
<%@ page import="kr.co.movmov.vo.Category" %>
<%@ page import="kr.co.movmov.utils.MybatisUtils" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/*
		요청 정보
			- 요청 URL
				/pages/community/edit-post.jsp
			- 요청 파라미터
				name		value
				--------------------
				pno			게시글 번호
				content		게시글 내용
				spoiler		스포일러 여부
				header		머리말 아이디
				
	*/
	
	int postNo = StringUtils.strToInt(request.getParameter("pno"));
	String content = request.getParameter("content");
	String isSpoiler = request.getParameter("spoiler");
	int headerId = StringUtils.strToInt(request.getParameter("header"));
	CategoryMapper catMapper = MybatisUtils.getMapper(CategoryMapper.class);
	Category header = catMapper.getCategoryFromId(headerId);
	Date currentTime = new Date();
	
	PostMapper postMapper = MybatisUtils.getMapper(PostMapper.class);
	Post post = postMapper.getPostByNo(postNo);
	post.setContent(content);
	post.setIsSpoiler(isSpoiler);
	post.setHeader(header);
	post.setUpdatedDate(currentTime);
	
	postMapper.updatePost(post);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>신고 완료</title>
<link rel="icon" href="../../resources/images/common/favicon.ico">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="../../resources/style/common/main.css">
<link rel="stylesheet" href="../../resources/style/community/post-detail.css">
</head>
<body>
	
	<dialog style="display: block; margin-top: 15%;" id="login-warning-dialog">
		<form action="post-detail.jsp?" method="get">
			<input type="hidden" name="pno" value="<%=postNo %>">
			<p>게시글이 수정되었습니다.</p>
			<menu>
				<button type="submit" id="btn-login-trigger">돌아가기</button>
			</menu>
		</form>
	</dialog>
	
</body>
</html>
