<%@page import="kr.co.movmov.mapper.PostMapper"%>
<%@page import="kr.co.movmov.vo.Comment"%>
<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.mapper.CommentMapper"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/*
		요청 정보
			- 요청 url
				/pages/community/delete-comment.jsp
			- 요청 파라미터
				name		value
				--------------------
				cno			댓글 번호
	
	*/
	int commentNo = StringUtils.strToInt(request.getParameter("cno"));
	CommentMapper commentMapper = MybatisUtils.getMapper(CommentMapper.class);
	Comment comment = commentMapper.getCommentByNo(commentNo);
	comment.setIsDeleted("Y");
	commentMapper.updateComment(comment);
	
	int postNo = comment.getPostNo();
	PostMapper postMapper = MybatisUtils.getMapper(PostMapper.class);
	postMapper.updatePostCommentCount(postNo);
	response.sendRedirect("post-detail.jsp?pno=" + postNo);

%>
