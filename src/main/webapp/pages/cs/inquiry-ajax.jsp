<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@page import="kr.co.movmov.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, kr.co.movmov.vo.Inquiry" %>
<%@ page import="kr.co.movmov.mapper.CsInquiryMapper" %>
<%@ page import="kr.co.movmov.utils.MybatisUtils" %>

<%
    // 필터 파라미터 받기
    String categoryParam = request.getParameter("categoryId");
    String statusParam = request.getParameter("answerStatus");
    String excludeSecretParam = request.getParameter("excludeSecret");
    String myQnaOnlyParam = request.getParameter("myQnaOnly");

	User loginedUser = (User) session.getAttribute("LOGIN_USER");
	boolean isLoggedIn = loginedUser != null;
	String userId = "";
	if (isLoggedIn) {
		userId = loginedUser.getId();
	}
    // 필터 파라미터 처리
	int categoryId = StringUtils.strToInt(categoryParam, 0);
    int status = StringUtils.strToInt(statusParam, 0);
    String excludeSecret = ("true".equals(excludeSecretParam) ? "exclude" : "");
    String myQnaOnly = ("true".equals(myQnaOnlyParam) ? userId : "");

    Map<String, Object> condition = new HashMap<>();
    condition.put("categoryId", categoryParam);
    condition.put("status", statusParam);
    condition.put("excludeSecret", excludeSecret);
    condition.put("userId", myQnaOnly);
    System.out.println(condition);
    
    // MyBatis 매퍼 호출
    CsInquiryMapper mapper = MybatisUtils.getMapper(CsInquiryMapper.class);

    // 필터링된 문의 내역 조회
    List<Inquiry> inquiries = mapper.getFilteredInquiries(condition);

    // 결과 출력
    if (inquiries == null || inquiries.isEmpty()) {
%>
        <div>문의 내역이 없습니다.</div>
<%
    } else {
        for (Inquiry i : inquiries) {
        	if (i == null) continue;
%>
    <div class="qna-item">
        <div class="qna-title">
            <% if (i.getIsSecret() == 1) { %>
                <i class="fa fa-lock lock-icon"></i>비밀글입니다.
            <% } else { %>
                <%= i.getTitle() != null ? i.getTitle() : "" %>
            <% } %>
        </div>
        <div class="qna-meta">
            작성자: <%= (i.getUser().getId() != null && i.getUser().getId() != null) ? i.getUser().getId() : "알 수 없음" %> |
            <%= i.getCreatedDate() != null ? StringUtils.simpleDateTimeFormat(i.getCreatedDate()) : "" %>
        </div>
        <div class="qna-answer">
            <% if (i.getIsSecret() == 1) { %>
                <i>비밀글은 작성자만 확인할 수 있습니다.</i>
            <% } else { %>
                <%= i.getContent() != null ? i.getContent() : "" %>
            <% } %>
        </div>
    </div>
<%
        }
    }
%>
