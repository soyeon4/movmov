<%@page import="kr.co.movmov.vo.Movie"%>
<%@page import="kr.co.movmov.vo.WishMovie"%>
<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.mapper.MovieMapper"%>
<%@page import="kr.co.movmov.mapper.WishMovieMapper"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@page import="kr.co.movmov.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	User user = (User) session.getAttribute("LOGIN_USER");
	int movieNo = StringUtils.strToInt(request.getParameter("movieNo"));
	int wishNo = StringUtils.strToInt(request.getParameter("wishNo"));
	
	WishMovieMapper wishMovieMapper = MybatisUtils.getMapper(WishMovieMapper.class);
	MovieMapper movieMapper = MybatisUtils.getMapper(MovieMapper.class);
	
	Movie movie = movieMapper.getMovieByNo(movieNo);
	// 찜 삭제
	wishMovieMapper.deleteWishMovie(wishNo);
	
	System.out.println("wishCnt" + movie.getWishCnt());
	
	movie.setWishCnt(movie.getWishCnt() - 1);
	
	movieMapper.updateMovieReviewCntOrWishCnt(movie);
	
	response.sendRedirect("movie-detail.jsp?movieNo=" + movieNo);
%>