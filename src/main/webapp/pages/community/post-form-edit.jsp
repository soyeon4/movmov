<%@page import="kr.co.movmov.vo.Post"%>
<%@page import="kr.co.movmov.mapper.PostMapper"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@ page import="kr.co.movmov.mapper.CategoryMapper" %>
<%@ page import="kr.co.movmov.vo.Category" %>
<%@ page import="kr.co.movmov.utils.MybatisUtils" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/*
		요청 정보
			- 요청 URL
				/pages/community/post-form.jsp?pno=xxx
			- 요청 파라미터
				name		value
				--------------------
				pno			게시글 번호
	*/
	
	int postNo = StringUtils.strToInt(request.getParameter("pno"));
	PostMapper postMapper = MybatisUtils.getMapper(PostMapper.class);
	Post post = postMapper.getPostByNo(postNo);
	int boardType = post.getBoardType().getId();
	CategoryMapper catMapper = MybatisUtils.getMapper(CategoryMapper.class);
	List<Category> movieHeaders = catMapper.getCategoriesByType("영화게시글");
	List<Category> freeHeaders = catMapper.getCategoriesByType("자유게시글");
	
	Gson gson = new Gson();
	String movieHeadersJson = gson.toJson(movieHeaders);
	String freeHeadersJson = gson.toJson(freeHeaders);

%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시글 수정</title>
<link rel="icon" href="../../resources/images/common/favicon.ico">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="../../resources/style/common/main.css">
<link rel="stylesheet" href="../../resources/style/community/post-form.css">
</head>
<body>
	<!-- 헤더 -->
	<%@ include file="../common/header.jsp"%>

	<section class="form-container">
		<form id="form-create-post" method="post" action="edit-post.jsp">
		<input type="hidden" name="pno" value="<%=post.getNo() %>">
			<!-- 🔷 게시판 이름 -->
			<div class="board-tab-container">
				<div class="board-label" board-type="300" style="cursor:default;">🎬 영화게시판</div>
				<div class="board-label" board-type="301" style="cursor:default;">🎬 자유게시판</div>
				<input type="hidden" name="boardType" id="board-type-id" value="<%=boardType %>">
			</div>

			<!-- ✍️ 글쓰기 폼 -->
			<div class="post-form">
				<h2>게시글 수정</h2>
				<!-- 스포일러 여부 선택 -->
				<div class="form-group">
					<div class="tooltip-group">
						<div class="field">스포일러</div>
						<div class="input-tooltip" id="spoiler-tooltip">스포일러 여부는 필수 선택사항입니다.</div>
					</div>
					<input type="hidden" name="spoiler" id="contains-spoiler">
					<div class="header-toggle-group">
						<button type="button"
							class="tag-toggle spoiler"
							data-value="Y">스포일러 있음</button>
						<button type="button"
							class="tag-toggle spoiler"
							data-value="N">스포일러 없음</button>
					</div>
				</div>
				<!-- 🔖 말머리 선택 -->
				<div class="form-group">
					<div class="tooltip-group">
						<div class="field">말머리</div>
						<div class="input-tooltip" id="header-tooltip">말머리는 필수 선택사항입니다.</div>
					</div>
					<input type="hidden" name="header" id="header-select">
					<div class="header-toggle-group" id="post-headers">
<%
	for (Category header : (boardType == 300 ? movieHeaders : freeHeaders)) {
%>
						<button type="button" class="tag-toggle header"
							data-value="<%=header.getId()%>"><%=header.getName()%></button>
<%
	}
%>
					</div>
				</div>

				<!-- 제목 입력 -->
				<div class="form-group">
					<div class="tooltip-group">
						<label>제목</label>
					</div>
					<input type="text" name="title" value="<%=post.getTitle() %>" disabled>
				</div>

				<!-- 내용 입력 -->
				<div class="form-group">
					<div class="tooltip-group">
						<label>내용</label>
						<div class="input-tooltip" id="content-tooltip">내용은 10 글자 이상이어야 합니다.</div>
					</div>
					<textarea name="content"><%=post.getContent() %></textarea>
				</div>
				<button type="submit" class="submit-btn">등록하기</button>
			</div>
		</form>
	</section>
</body>

	<!-- 푸터 -->
	<%@ include file="../common/footer.jsp"%>
	
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script type="text/javascript">
		function handleToggleClick(parentSelector, childSelector, attributeName, targetInputId) {
		    $(parentSelector).on("click", childSelector, function() {
		        $(parentSelector + " " + childSelector).removeClass("active");
		        $(this).addClass("active");
		        
		        let selectedValue = $(this).attr(attributeName);
		        $("#" + targetInputId).val(selectedValue);
		    });
		}
		
		// '글쓰기'를 클릭했던 게시판을 하이라이트한다.
		let boardType = <%=boardType %>;
		let isSpoiler = "<%=post.getIsSpoiler() %>";
		let headerId = <%=post.getHeader().getId() %>;
		$(".board-label[board-type=" + boardType + "]").addClass("active");
		$(".tag-toggle.spoiler[data-value=" + isSpoiler + "]").addClass("active");
		$("#contains-spoiler").val(isSpoiler);
		$(".tag-toggle.header[data-value=" + headerId + "]").addClass("active");
		$("#header-select").val(headerId);
		
		handleToggleClick(".header-toggle-group", ".tag-toggle.spoiler", "data-value", "contains-spoiler");
		handleToggleClick(".header-toggle-group", ".tag-toggle.header", "data-value", "header-select");
		
		let contentRegex = /^[\s\S]{10,}$/u
		let contentCheckPassed = false;
		
		$("#form-create-post").submit(function() {
			if ($("input[name=content]").val() == "" || !contentCheckPassed) {
				alert("내용은 10글자 이상이어야 합니다.");
				$("textarea[name=content]").focus();
				return false;
			}
			return true;
		});
		
		$("textarea[name=content]").keyup(function() {
			let content = $("textarea[name=content]").val().trim();
			
			if (!contentRegex.test(content)) {
				$("#content-tooltip").addClass("show");
			} else {
				$("#content-tooltip").removeClass("show")
				contentCheckPassed = true;
			};
		});
		
	</script>
</html>
