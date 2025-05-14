<%@page import="kr.co.movmov.vo.User"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Date"%>
<%@page import="kr.co.movmov.vo.Comment"%>
<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.mapper.CommentMapper"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/*
		요청 정보
			- 요청 URL
				/pages/community/create-comment-reply.jsp
			- 요청 파라미터
				name		value
				--------------------
				postNo			게시글 번호
				content			댓글 내용
				parentCommentNo	답글의 원댓글 번호
	*/
	
	User loginUser = (User) session.getAttribute("LOGIN_USER");
	int postNo = StringUtils.strToInt(request.getParameter("postNo"));
	String content = request.getParameter("content");
	int parentCommentNo = StringUtils.strToInt(request.getParameter("parentCommentNo"));
	
	Comment comment = new Comment();
	Date currentTime = new Date();
	
	comment.setPostNo(postNo);
	comment.setUser(loginUser);
	comment.setContent(content);
	comment.setCreatedDate(currentTime);
	comment.setUpdatedDate(currentTime);
	comment.setParentCommentNo(parentCommentNo);
	
	CommentMapper commentMapper = MybatisUtils.getMapper(CommentMapper.class);
	commentMapper.insertComment(comment);
	int currentCommentNo = commentMapper.getCurrentCommentNo();
	comment = commentMapper.getCommentByNo(currentCommentNo);
	
	Map<String, Object> commentInfoJson = new HashMap<>();
	commentInfoJson.put("cno", comment.getNo());
	commentInfoJson.put("userId", comment.getUser().getId());
	commentInfoJson.put("userNickname", comment.getUser().getNickname());
	commentInfoJson.put("createdDate", StringUtils.simpleDateTimeFormat(currentTime));
	commentInfoJson.put("content", content);
	commentInfoJson.put("parentCommentNo", parentCommentNo);
	
	Gson gson = new Gson();
	String jsonResponse = gson.toJson(commentInfoJson);
	out.print(jsonResponse);
%>

