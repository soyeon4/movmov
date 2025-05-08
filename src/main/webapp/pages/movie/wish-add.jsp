<%@page import="kr.co.movmov.vo.Movie"%>
<%@page import="kr.co.movmov.mapper.MovieMapper"%>
<%@page import="kr.co.movmov.vo.WishMovie"%>
<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.mapper.WishMovieMapper"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@page import="kr.co.movmov.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	User user = (User) session.getAttribute("LOGIN_USER");
	int movieNo = StringUtils.strToInt(request.getParameter("movieNo"));
	
	WishMovieMapper wishMovieMapper = MybatisUtils.getMapper(WishMovieMapper.class);
	MovieMapper movieMapper = MybatisUtils.getMapper(MovieMapper.class);
	
	WishMovie wishMovie = new WishMovie();
	wishMovie.setMovie(movieMapper.getMovieByNo(movieNo));
	wishMovie.setUser(user);
	
	Movie movie = movieMapper.getMovieByNo(movieNo);
	
	// 찜 삽입
	wishMovieMapper.insertWishMovie(wishMovie);
	
	movie.setWishCnt(movie.getWishCnt() + 1);
	
	response.sendRedirect("movie-detail.jsp?movieNo=" + movieNo);
%>