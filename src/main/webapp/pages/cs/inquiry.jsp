<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.mapper.CsInquiryMapper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>

<link rel="stylesheet" href="/movmov/resources/style/cs/inquiry.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/movmov/resources/script/cs/inquiry.js"></script>

<div class="qna-container">
  <h2>Q&A</h2>
  <p class="qna-guide-text">궁금하신 점이 있으신 경우 문의해주세요.</p>

  <div class="qna-write-wrap">
    <button class="qna-write-btn" onclick="location.href='inquiry-write.jsp'">Q&A 작성하기</button>
  </div>

  <div class="qna-filters">
    <label><input type="checkbox" id="excludeSecret"> 비밀글 제외</label>
    <label><input type="checkbox" id="myQnaOnly"> 내 Q&A 보기</label>

    <label>
      문의 유형
      <select id="categoryFilter">
        <option value="">전체</option>
		
		<% 
		
            // 서버에서 카테고리 목록 받아옴
            List<String> categories = (List<String>) request.getAttribute("categories");
            if (categories != null && !categories.isEmpty()) {
                for (String category : categories) {
        %>
            <option value="<%= category %>"><%= category %></option>
        <%
                }
            } else {
        %>
            <option value="">카테고리가 없습니다.</option>
        <%
            }
        %>
      </select>
    </label>

    <label>
      답변 상태
      <select id="statusFilter">
        <option value="">전체</option>
        <%
            // 서버에서 답변 상태 목록 받아옴
            List<String> statuses = (List<String>) request.getAttribute("statuses");
            if (statuses != null && !statuses.isEmpty()) {
                for (String status : statuses) {
        %>
            <option value="<%= status %>">
                <%= status.equals("answered") ? "답변 완료" : "미답변" %>
            </option>
        <%
                }
            } else {
        %>
            <option value="">답변 상태가 없습니다.</option>
        <%
            }
        %>

  <button type="button" onclick="applyFilters()">적용</button>
</div>
      </select>
    </label>
  </div>

  <div class="qna-list">
    <!-- Ajax 결과 삽입 위치 -->
    <div>로딩 중...</div>
  </div>

  <div class="pagination">
    <!-- 선택적으로 추가 가능 -->
  </div>
</div>
