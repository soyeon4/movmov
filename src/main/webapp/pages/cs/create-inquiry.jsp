<%@page import="kr.co.movmov.mapper.CategoryMapper"%>
<%@page import="java.net.CacheRequest"%>
<%@page import="kr.co.movmov.vo.Inquiry"%>
<%@page import="org.apache.catalina.util.StringUtil"%>
<%@page import="kr.co.movmov.vo.Category"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@page import="kr.co.movmov.vo.User"%>
<%@page import="kr.co.movmov.mapper.CsInquiryMapper"%>
<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/*
		요청 파라미터
		name			value
		----------------------------
		category		카테고리id
		title		 	제목
		content			내용
		anonymous		비밀글 여부
	*/
	
	User loginUser = (User) session.getAttribute("LOGIN_USER");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	int isSecret = StringUtils.strToInt(request.getParameter("anonymous"));
	int categoryId = StringUtils.strToInt(request.getParameter("category"));
	
	CategoryMapper categoryMapper = MybatisUtils.getMapper(CategoryMapper.class);
	Category category = categoryMapper.getCategoryFromId(categoryId);
	
	Inquiry inquiry = new Inquiry();
	inquiry.setTitle(title);
	inquiry.setContent(content);
	inquiry.setIsSecret(isSecret);
	inquiry.setCategory(category);
	inquiry.setUser(loginUser);
	
	CsInquiryMapper csInquiryMapper = MybatisUtils.getMapper(CsInquiryMapper.class);
	csInquiryMapper.insertInquiry(inquiry);
	
	response.sendRedirect("inquiry.jsp");
%>