<%@page import="kr.co.movmov.vo.Movie"%>
<%@page import="kr.co.movmov.mapper.MovieMapper"%>
<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.mapper.ReviewMapper"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int reviewNo = StringUtils.strToInt(request.getParameter("reviewNo"));
	int movieNo = StringUtils.strToInt(request.getParameter("movieNo"));
	
	
	ReviewMapper reviewMapper = MybatisUtils.getMapper(ReviewMapper.class);
	MovieMapper movieMapper = MybatisUtils.getMapper(MovieMapper.class);
	
	Movie movie = movieMapper.getMovieByNo(movieNo);
	
	reviewMapper.deleteReview(reviewNo);
	
	movie.setReviewCnt(movie.getReviewCnt() - 1);
	
	movieMapper.updateMovieReviewCntOrWishCnt(movie);
	
	response.sendRedirect("movie-detail.jsp?movieNo=" + movieNo);

%>