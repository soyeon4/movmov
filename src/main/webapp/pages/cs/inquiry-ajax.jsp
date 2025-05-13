<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, kr.co.movmov.vo.Inquiry" %>
<%@ page import="kr.co.movmov.mapper.CsInquiryMapper" %>
<%@ page import="kr.co.movmov.utils.MybatisUtils" %>

<%
    // 필터 파라미터 받기
    String categoryParam = request.getParameter("category");
    String statusParam = request.getParameter("answerStatus");
    String excludeSecretParam = request.getParameter("excludeSecret");
    String myQnaOnlyParam = request.getParameter("myQnaOnly");

    // 필터 파라미터 처리
    Integer categoryId = (categoryParam != null && !categoryParam.trim().isEmpty())
                         ? Integer.parseInt(categoryParam) : null;
    Integer status = "answered".equals(statusParam) ? 2 : ("unanswered".equals(statusParam) ? 1 : null);
    boolean excludeSecret = "true".equals(excludeSecretParam);
    boolean myQnaOnly = "true".equals(myQnaOnlyParam);
