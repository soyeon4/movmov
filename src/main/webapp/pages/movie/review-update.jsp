<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.mapper.ReviewMapper"%>
<%@page import="kr.co.movmov.mapper.MovieMapper"%>
<%@page import="kr.co.movmov.vo.Review"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@page import="kr.co.movmov.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	User user = (User) session.getAttribute("LOGIN_USER");
	int reviewNo = StringUtils.strToInt(request.getParameter("reviewNo"));
	int movieNo = StringUtils.strToInt(request.getParameter("movieNo"));
	int star = StringUtils.strToInt(request.getParameter("star"));
	String comment = request.getParameter("comment");
	String openStatus = request.getParameter("openStatus");
	
	MovieMapper movieMapper = MybatisUtils.getMapper(MovieMapper.class);
	ReviewMapper reviewMapper = MybatisUtils.getMapper(ReviewMapper.class);
	
	Review review = new Review();
	review.setNo(reviewNo);
	review.setStar(star);
	review.setComment(comment);
	review.setMovie(movieMapper.getMovieByNo(movieNo));
	review.setOpenStatus(openStatus);
	
	// 리뷰 생성
	reviewMapper.updateReview(review);
	
	response.sendRedirect("movie-detail.jsp?movieNo=" + movieNo);
%>