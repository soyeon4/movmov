<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.mapper.PostMapper"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/*
		요청 파라미터
		postNo 혹은 commentNo, userId
	*/
	
	String userId = request.getParameter("userId");
	int postNo = StringUtils.strToInt(request.getParameter("postNo"), 0);
	int commentNo = StringUtils.strToInt(request.getParameter("commentNo"), 0);
	
	Map<String, Object> info = new HashMap<>();
	info.put("postNo", postNo);
	info.put("commentNo", commentNo);
	info.put("userId", userId);
	
	PostMapper postMapper = MybatisUtils.getMapper(PostMapper.class);
	postMapper.insertUpvote(info);
	postMapper.updatePostUpvoteCount(postNo);
	int upvoteCount = postMapper.getUpvoteCount(postNo);
	
	out.print(upvoteCount);

%>