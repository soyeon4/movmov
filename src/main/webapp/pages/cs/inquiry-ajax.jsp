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

    // 로그인 여부 처리
    Integer loginUserId = null;
    if (myQnaOnly) {
        Object userObj = session.getAttribute("loginUserId");
        if (userObj != null) {
            try {
                loginUserId = Integer.parseInt(userObj.toString());
            } catch (Exception e) {
                out.print("<div style='color:red;'>로그인 정보 오류: " + e.getMessage() + "</div>");
                return;
            }
        } else {
            out.print("<div style='color:red;'>로그인이 필요합니다.</div>");
            return;
        }
    }

    // MyBatis 매퍼 호출
    CsInquiryMapper mapper = MybatisUtils.getMapper(CsInquiryMapper.class);

    // 필터링된 문의 내역 조회
    List<Inquiry> inquiries = myQnaOnly
        ? mapper.selectMyInquiries(excludeSecret, status, categoryId, loginUserId)
        : mapper.selectAllInquiries(excludeSecret, status, categoryId, 0, 50);

    // 결과 출력
    if (inquiries == null || inquiries.isEmpty()) {
%>
        <div>문의 내역이 없습니다.</div>
<%
    } else {
        for (Inquiry i : inquiries) {
            if (i == null) continue;  // null인 경우는 건너뛰기
%>
    <div class="qna-item">
        <div class="qna-title">
            <% if (i.isSecret()) { %>
                <i class="fa fa-lock lock-icon"></i>비밀글입니다.
            <% } else { %>
                <%= i.getTitle() != null ? i.getTitle() : "" %>
            <% } %>
        </div>
        <div class="qna-meta">
            작성자: <%= (i.getUserId() != null && i.getUserId().getId() != null) ? i.getUserId().getId() : "알 수 없음" %> |
            <%= i.getCreatedDate() != null ? i.getCreatedDate().toString() : "" %>
        </div>
        <div class="qna-answer">
            <% if (i.isSecret()) { %>
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
