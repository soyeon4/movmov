<%@ page import="kr.co.movmov.mapper.FaqMapper" %>
<%@ page import="kr.co.movmov.utils.MybatisUtils" %>
<%@ page import="java.util.*" %>
<%@ page import="kr.co.movmov.vo.Faq" %>
<%@page import="kr.co.movmov.vo.Category"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
int pageNo = 1;
int rows = 10;
int offset = (pageNo - 1) * rows;

Map<String, Object> condition = new HashMap<>(); // 조건을 map으로 선언
condition.put("offset", offset);
condition.put("rows", rows);

FaqMapper faqMapper = MybatisUtils.getMapper(FaqMapper.class);
List<Faq> faqs = faqMapper.getFaqsByCategory(condition); // 조건을 받아 Faq 목록을 조회

int totalRows = faqMapper.getTotalRows(new HashMap<>());	// 전체 Faq 개수 계산
int totalPages = (int) Math.ceil((double) totalRows / rows); // 전체 Faq 페이지 수 계산
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>고객센터 FAQ</title>
<link rel="stylesheet" href="/movmov/resources/style/common/main.css">
<link rel="stylesheet" href="/movmov/resources/style/cs/faq.css">
<link rel="stylesheet" href="/movmov/resources/style/cs/inquiry.css"> <%-- Q&A용 스타일 --%>

<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>

<%@ include file="/pages/common/header.jsp"%>

<body>
<main>
    <div class="container">
        <h1>고객센터</h1>

        <div class="tabs">
            <div class="tab active" data-tab="faq">FAQ</div>
            <div class="tab" data-tab="notice">공지사항</div>
            <div class="tab" data-tab="inquiry">Q&A</div>
            <div class="tab" data-tab="myinquiry">내 문의</div>
        </div>

        <!-- FAQ 콘텐츠 -->
        <div class="tab-content active" id="faq">
            <div class="faq-categories">
                <button type="button" class="faq-category-btn" data-cat-id="">전체</button>
                <button type="button" class="faq-category-btn" data-cat-id="30">회원정보</button>
                <button type="button" class="faq-category-btn" data-cat-id="31">영화정보</button>
                <button type="button" class="faq-category-btn" data-cat-id="32">커뮤니티</button>
                <button type="button" class="faq-category-btn" data-cat-id="34">결제/환불</button>
                <button type="button" class="faq-category-btn" data-cat-id="35">이벤트</button>
                <button type="button" class="faq-category-btn" data-cat-id="36">기타</button>
            </div>

            <div class="faq-search" style="display: flex; justify-content: space-between; gap: 20px; align-items: center; flex-wrap: wrap; margin-bottom: 30px;">
                <div style="flex: 1; min-width: 250px; display: flex;">
                    <input id="search-keyword" type="text" placeholder="검색어를 입력하세요"
                        style="flex: 1; padding: 10px; border: 1px solid #ccc; border-radius: 5px 0 0 5px;">
                    <button id="btn-search"
                        style="padding: 10px 20px; border: none; background: var(--point-color); color: #fff; border-radius: 0 5px 5px 0; cursor: pointer;">검색</button>
                </div>
                <div style="font-size: 14px; color: #444; min-width: 280px; text-align: right;">
                    <span style="margin-right: 10px;">더 궁금한 점이 있다면?</span>
                    <a href="#inquiry" onclick="goToTab('inquiry')"
                        style="color: var(--point-color); font-weight: 600; text-decoration: underline; margin-right: 10px;">문의하기</a>
                    <a href="#myinquiry" onclick="goToTab('myinquiry')"
                        style="color: var(--point-color); font-weight: 600; text-decoration: underline;">my 문의내역</a>
                </div>
            </div>

            <ul class="faq-list">
                <% for (Faq faq : faqs) { %>
                <li class="faq-item">
                    <span>[<%=faq.getCategory().getName()%>]</span> <%=faq.getTitle()%>
                    <div class="faq-answer"><%=faq.getContent()%></div>
                </li>
                <% } %>
            </ul>

            <div class="pagination">
                <% for (int i = 1; i <= totalPages; i++) { %>
                <a href="#" class="page-link" data-page="<%=i%>"><%=i%></a>
                <% } %>
            </div>
        </div>

        <!-- Q&A 탭 콘텐츠 자리 -->
        <div class="tab-content" id="inquiry">
            <div id="qna-filters"></div> <!-- 필터 영역 -->
            <div id="qna-list"></div> <!-- Q&A 목록이 여기에 ajax로 로딩됨 -->
            <div class="pagination" id="qna-pagination"></div>
        </div>

    </div>
</main>

<%@ include file="/pages/common/footer.jsp"%>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/movmov/resources/script/cs/faq.js"></script>
<script src="/movmov/resources/script/cs/qna.js"></script> <%-- Q&A용 스크립트 --%>

</body>
</html>
