<%@page import="kr.co.movmov.vo.User"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@page import="kr.co.movmov.vo.Comment"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    Comment comment = (Comment) request.getAttribute("comment");
    int level = (Integer) request.getAttribute("level");
	User loginedUser = (User) session.getAttribute("LOGIN_USER");
	boolean isLoggedIn = loginedUser != null;
	String userId = "";
	if (isLoggedIn) {
		userId = loginedUser.getId();
	}
%>

<div class="comment-block"
     data-comment-no="<%= comment.getNo() %>"
     data-level="<%= Math.min(level, 4) %>"
     parent-comment-no="<%= comment.getParentCommentNo() %>">
    
	<div class="comment-author">
		<img class="author-img" src="../../resources/images/common/default-profile.png" alt="profile-pic"/>
		<span class="author-name"><%=comment.getUser().getNickname() %></span>
		<div class="meta">작성일: <%=StringUtils.simpleDateTimeFormat(comment.getCreatedDate()) %>
			<%=(comment.getCreatedDate().compareTo(comment.getUpdatedDate()) != 0 ? 
			"| 수정일: " + StringUtils.simpleDateTimeFormat(comment.getUpdatedDate()) : "" ) %></div>
		</div>
		<div class="content"><%=comment.getContent() %></div>
		<div class="comment-options">
			<div class="comment-reply">
				<button type="button" class="btn-reply">답글</button>
			</div>
<%
		if (comment.getUser().getId().equals(userId)) {
%>
			<a href="#" class="edit-comment">수정</a>
			<a href="delete-comment.jsp?cno=<%=comment.getNo() %>"
				onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>
<%
		}
%>
			<a href="report-form.jsp?cno=<%=comment.getNo() %>"
				class="report-button comment"
				data-user-id="<%=comment.getUser().getId() %>">신고하기</a>
		</div>
</div>

<%
    if (!comment.getReplies().isEmpty()) {
        for (Comment reply : comment.getReplies()) {
        	request.setAttribute("comment", reply);
        	request.setAttribute("level", level + 1);
%>
            <jsp:include page="commentBlock.jsp" />
<%
        }
    }
%>
