<%@page import="java.util.Date"%>
<%@page import="kr.co.movmov.vo.User"%>
<%@page import="kr.co.movmov.mapper.PostMapper"%>
<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.mapper.CategoryMapper"%>
<%@page import="kr.co.movmov.vo.Category"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@page import="kr.co.movmov.vo.Post"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/*
		요청 정보
			- 요청 url
				/pages/community/create-post.jsp
			- 요청 파라미터
				name		value
				--------------------
				title		제목
				content		내용
				spoiler		스포일러 여부
				header		머리말 아이디
				boardId		게시판 아이디
				
		게시글 등록 절차
		1. 요청 파라미터값을 조회한다.
		2. Post 객체를 생성해서 요청파라미터값(제목, 내용)을 담는다.
		3. 로그인된 세션의 유저 아이디 정보를 Post 객체의 User 객체의 id 필드에 담는다.
		4. 테이블에 게시글 정보를 저장시킨다.
		5. 생성된 게시글 상세 페이지를 요청하는 URL을 보낸다.
	
	*/
	
	User loginUser = (User) session.getAttribute("LOGIN_USER");		// 세션에 유저 객체 저장됨
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String spoiler = request.getParameter("spoiler");
	int headerId = StringUtils.strToInt(request.getParameter("header"));
	int boardId = StringUtils.strToInt(request.getParameter("boardId"));
	
	CategoryMapper categoryMapper = MybatisUtils.getMapper(CategoryMapper.class);
	Category header = categoryMapper.getCategoryFromId(headerId);
	Category boardType = categoryMapper.getCategoryFromId(boardId);

	Post post = new Post();
	post.setHeader(header);
	post.setBoardType(boardType);
	post.setTitle(title);
	post.setContent(content);
	post.setIsSpoiler(spoiler);
	post.setUser(loginUser);
	Date currentTime = new Date();
	post.setCreatedDate(currentTime);
	post.setUpdatedDate(currentTime);
	
	PostMapper postMapper = MybatisUtils.getMapper(PostMapper.class);
	postMapper.insertPost(post);
	int currentPostNo = postMapper.getCurrentPostNo();
	
	response.sendRedirect("post-detail.jsp?pno=" + currentPostNo);
%>
