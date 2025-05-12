<%@page import="kr.co.movmov.mapper.CommentMapper"%>
<%@page import="kr.co.movmov.vo.Comment"%>
<%@page import="kr.co.movmov.vo.User"%>
<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/*
		요청 정보
			- 요청 url
				/pages/community/create-comment.jsp
			- 요청 파라미터
				name		value
				--------------------
				postNo				게시글 번호
				content				내용
				parentCommentNo		원댓글 번호
				
				
		게시글 등록 절차
		1. 요청 파라미터값을 조회한다.
		2. Comment 객체를 생성해서 요청파라미터값(내용)을 담는다.
		3. 로그인된 세션의 유저 아이디 정보를 Comment 객체의 User 객체에 담는다.
		4. 테이블에 댓글 정보를 저장시킨다.
		5. 해당 게시글 페이지의 댓글을 리로드하는 응답을 보낸다.
	
	*/
	
	int postNo = StringUtils.strToInt(request.getParameter("postNo"));
	User loginUser = (User) session.getAttribute("LOGIN_USER");		// 세션에 유저 객체 저장됨
	String userId = loginUser.getId();
	String content = request.getParameter("content");
	int parentCommentNo = StringUtils.strToInt(request.getParameter("parentCommentNo"), 0);
	
	Comment comment = new Comment();
	comment.setPostNo(postNo);
	comment.setContent(content);
	comment.setUser(loginUser);
	comment.setParentCommentNo(parentCommentNo);
	
	CommentMapper commentMapper = MybatisUtils.getMapper(CommentMapper.class);
	commentMapper.insertComment(comment);
	
	response.sendRedirect("post-detail.jsp?pno=" + postNo);

%>
