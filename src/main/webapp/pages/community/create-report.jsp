<%@page import="kr.co.movmov.vo.Comment"%>
<%@page import="kr.co.movmov.mapper.CommentMapper"%>
<%@page import="kr.co.movmov.vo.Post"%>
<%@page import="kr.co.movmov.mapper.PostMapper"%>
<%@page import="kr.co.movmov.mapper.ReportMapper"%>
<%@page import="kr.co.movmov.vo.Category"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.mapper.CategoryMapper"%>
<%@page import="kr.co.movmov.vo.Report"%>
<%@page import="kr.co.movmov.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/*
		요청 파라미터
		name		value
		------------
		categoryId	신고사유 번호
		details		상세내용
		contentNo	게시글/댓글 번호
		reportType	"post" / "comment"
		
	*/
	
	User loginedUser = (User) session.getAttribute("LOGIN_USER");
	
	int categoryId = StringUtils.strToInt(request.getParameter("categoryId"));
	String details = request.getParameter("details");
	int contentNo = StringUtils.strToInt(request.getParameter("contentNo"));
	String reportType = request.getParameter("reportType");
	
	CategoryMapper catMapper = MybatisUtils.getMapper(CategoryMapper.class);
	Category category = catMapper.getCategoryFromId(categoryId);
	
	Report report = new Report();
	report.setCategory(category);
	report.setDetails(details);
	report.setUser(loginedUser);
	report.setType(reportType);
	report.setContentNo(contentNo);
	
	ReportMapper reportMapper = MybatisUtils.getMapper(ReportMapper.class);
	reportMapper.insertReport(report);
	
	if ("post".equals(reportType)) {
		PostMapper postMapper = MybatisUtils.getMapper(PostMapper.class);
		Post post = postMapper.getPostByNo(contentNo);
		postMapper.updatePostReportCount(contentNo);
	} else {
		CommentMapper commentMapper = MybatisUtils.getMapper(CommentMapper.class);
		Comment comment = commentMapper.getCommentByNo(contentNo);
		commentMapper.updateCommentReportCount(contentNo);
	}
	
	response.sendRedirect("report-success.jsp");
	
%>