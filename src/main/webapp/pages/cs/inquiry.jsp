<%@page import="com.google.gson.Gson"%>
<%@page import="kr.co.movmov.vo.Category"%>
<%@page import="kr.co.movmov.mapper.CategoryMapper"%>
<%@page import="kr.co.movmov.vo.Inquiry"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>

<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.mapper.CsInquiryMapper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>

<%
CsInquiryMapper csInquiryMapper = MybatisUtils.getMapper(CsInquiryMapper.class); // 문의글 Mapper
List<Inquiry> inquiries = csInquiryMapper.getAllInquiries(); // 모든 문의글을 불러옴
Gson gson = new Gson();
String allInqs = gson.toJson(inquiries);
System.out.println(allInqs);

CategoryMapper categoryMapper = MybatisUtils.getMapper(CategoryMapper.class); // 카테고리 Mapper
List<Category> inquiryCategorys = categoryMapper.getCategoriesByType("문의유형"); // '문의유형' 카테고리에 해당하는 리스트를 불러옴
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>문의하기</title>
    <link rel="stylesheet" href="/movmov/resources/style/cs/inquiry.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="/movmov/resources/script/cs/inquiry.js"></script>
</head>
<body>

<div class="qna-container">
    <h2>Q&A</h2>
    <p class="qna-guide-text">궁금하신 점이 있으신 경우 문의해주세요.</p>

    <div class="qna-write-wrap">
        <button class="qna-write-btn" onclick="window.location='../cs/inquiry-register.jsp';">Q&A 작성하기</button>
    </div>

    <div class="qna-filters">
        <label><input type="checkbox" id="excludeSecret"> 비밀글 제외</label>
        <label><input type="checkbox" id="myQnaOnly"> 내 Q&A 보기</label>

        <label>
            문의 유형
            <select id="categoryFilter">
                <option value="">전체</option>
                <% for (Category category : inquiryCategorys) { 
                	System.out.println(category.getName());
                %>
                    <option value="<%= category.getName() %>"><%= category.getName() %></option>
                <% } %>
            </select>
        </label>

        <label>
            답변 상태
            <select id="statusFilter">
                <option value="">전체</option>
                <option value="1">미답변</option>
                <option value="2">답변완료</option>
            </select>
        </label>

        <button type="button" onclick="applyFilters()">적용</button>
    </div>

<div class="qna-list">
<%
	for (Inquiry inquiry : inquiries) { 
%>
        <div class="qna-item">
            <div class="qna-header">
                <span>답변상태: <%= inquiry.getStatus() == 1 ? "미답변" : "답변완료" %></span>
                <span class="qna-secret">
                    <% if (inquiry.getIsSecret() == 1) { %>
                        (비밀글)
                    <% } %>
                    <h3 class="qna-title"><%= inquiry.getTitle() %></h3>
                </span>
            </div>
            <div class="qna-body">
                <h3 class="qna-title"><%= inquiry.getTitle() %></h3>
                <div class="qna-meta">
                    <span>작성자: <%= inquiry.getUser().getId() %></span>
                    <span>작성일: <%= inquiry.getCreatedDate() %></span>

                </div>
                <p class="qna-content"><%= inquiry.getContent() %></p>
            </div>
        </div>
<% 
    }
%>
</div>

    <div class="pagination">
        <!-- 페이징 UI 삽입 예정 -->
    </div>
</div>

</body>
</html>
