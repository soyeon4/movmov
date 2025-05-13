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
				/pages/community/edit-comment.jsp
			- 요청 파라미터
				name		value
				--------------------
				cno			댓글 번호
				content		댓글 내용
	*/
	
	int commentNo = StringUtils.strToInt(request.getParameter("cno"));
	String content = request.getParameter("content");
	
	CommentMapper commentMapper = MybatisUtils.getMapper(CommentMapper.class);
	Comment comment = commentMapper.getCommentByNo(commentNo);
	Date currentTime = new Date();
	
	comment.setContent(content);
	comment.setUpdatedDate(currentTime);
	commentMapper.updateComment(comment);
	String createdDate = StringUtils.simpleDateTimeFormat(comment.getCreatedDate());
	String updatedDate = StringUtils.simpleDateTimeFormat(comment.getUpdatedDate());
	
	Map<String, Object> commentInfoJson = new HashMap<>();
	commentInfoJson.put("cno", commentNo);
	commentInfoJson.put("userNickname", comment.getUser().getNickname());
	commentInfoJson.put("createdDate", createdDate);
	commentInfoJson.put("updatedDate", updatedDate);
	commentInfoJson.put("content", content);
	commentInfoJson.put("userId", comment.getUser().getId());
	
	Gson gson = new Gson();
	String jsonResponse = gson.toJson(commentInfoJson);
	out.print(jsonResponse);
%>

