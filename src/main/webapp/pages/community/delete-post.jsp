<%@page import="kr.co.movmov.vo.Post"%>
<%@page import="kr.co.movmov.mapper.PostMapper"%>
<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/*
		요청 정보
			- 요청 url
				/pages/community/delete-post.jsp
			- 요청 파라미터
				name		value
				--------------------
				pno			게시글 번호
	
	*/
	int postNo = StringUtils.strToInt(request.getParameter("pno"));
	PostMapper postMapper = MybatisUtils.getMapper(PostMapper.class);
	Post post = postMapper.getPostByNo(postNo);
	post.setIsDeleted("Y");
	postMapper.updatePost(post);
	
	response.sendRedirect("community-main.jsp");

%>
