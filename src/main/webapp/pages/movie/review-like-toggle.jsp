<%@page import="kr.co.movmov.vo.Review"%>
<%@page import="kr.co.movmov.mapper.ReviewMapper"%>
<%@page import="kr.co.movmov.vo.ReviewLike"%>
<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.mapper.ReviewLikeMapper"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@page import="kr.co.movmov.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	User loginUser = (User) session.getAttribute("LOGIN_USER");
	if (loginUser == null) {
		response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
		out.print("로그인이 필요합니다!");
		return;
	}
	String userId = loginUser.getId();
	int reviewNo = StringUtils.strToInt(request.getParameter("reviewNo"));
	System.out.print("reviewNo: " + reviewNo);
	
	ReviewLikeMapper reviewLikeMapper = MybatisUtils.getMapper(ReviewLikeMapper.class);
	ReviewMapper reviewMapper = MybatisUtils.getMapper(ReviewMapper.class);
	
	// 해당 리뷰 조회
	Review review = reviewMapper.getReviewByReviewNo(reviewNo);
	
	// 이 아이디로 이 리뷰에 누른 좋아요 조회
	ReviewLike like = reviewLikeMapper.getReviewLikeByUserIdAndReviewNo(userId, reviewNo);
	
	// 작업 수행 후 전달할 좋아요 상태
	boolean nowLiked;
	
	// 좋아요 했었으면
	if (like != null) {
		reviewLikeMapper.deleteReviewLike(like.getNo());
		review.setLikeCnt(review.getLikeCnt() - 1);
		reviewMapper.updateReviewLikeCnt(review);
		nowLiked = false;
	// 좋아요 안했었으면
	} else {
		ReviewLike reviewLike = new ReviewLike();
		reviewLike.setReview(new Review());
		reviewLike.getReview().setNo(reviewNo);
		reviewLike.setUser(new User());
		reviewLike.getUser().setId(userId);
		reviewLikeMapper.insertReviewLike(reviewLike);
		review.setLikeCnt(review.getLikeCnt() + 1);
		reviewMapper.updateReviewLikeCnt(review);
		nowLiked = true;
	}
	
	// 작업수행 후 좋아요 개수
	int cnt = review.getLikeCnt();
	
	out.print("{"
		+ "\"liked\":" + nowLiked
		+ ",\"count\":" + cnt
		+ "}");
%>