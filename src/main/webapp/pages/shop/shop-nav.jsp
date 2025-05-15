<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
  String cno = request.getParameter("cno");
%>
<!-- 탭 네비게이션 CSS -->
<style>
  .menu-sec {
    display: flex;
    justify-content: center;
    border-bottom: 2px solid #ddd;
    font-family: 'Noto Sans KR', sans-serif;
  }

  .menu-sec a {
    flex: 1;
    text-align: center;
    padding: 16px 0;
    text-decoration: none;
    color: #333;
    font-size: 16px;
    font-weight: 500;
    border-bottom: 3px solid transparent;
    transition: all 0.2s ease;
  }

  .menu-sec a:hover {
    background-color: #f9f9f9;
  }

  .menu-sec a.active {
    border-bottom: 3px solid #FF498D; /* 강조 컬러 */
    color: #5f3dc4;
    font-weight: 700;
  }
</style>

<!-- 탭 네비게이션 HTML -->
<section class="menu-sec">
  <a href="shop-list.jsp?cno=1" class="<%= "1".equals(cno) ? "active" : "" %>">🎟️ 관람권</a>
  <a href="shop-list.jsp?cno=2" class="<%= "2".equals(cno) ? "active" : "" %>">🍿 스낵/음료</a>
  <a href="shop-list.jsp?cno=3" class="<%= "3".equals(cno) ? "active" : "" %>">🎁 굿즈</a>
</section>