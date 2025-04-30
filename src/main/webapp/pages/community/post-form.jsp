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
				/pages/community/post-form.jsp?boardType=xxx
			- 요청 파라미터
				name		value
				--------------------
				boardType	300
							301
		게시글 작성 폼 설정
			1. boardType 값에 따라 기본 선택된 게시판을 설정하고 해당 말머리를 불러온다.
	*/
	
	int boardType = StringUtils.strToInt(request.getParameter("boardType"));
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
<title>MovMov Community</title>
<link rel="icon" href="../../resources/images/common/favicon.ico">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
<link rel="stylesheet" href="../../resources/style/common/main.css">
<link rel="stylesheet" href="../../resources/style/community/post-form.css">
</head>
<body>
	<!-- 헤더 -->
	<%@ include file="../common/header.jsp"%>

	<section class="form-container">
		<form id="form-create-post" method="post" action="create-post.jsp">
			<!-- 🔷 게시판 이름 -->
			<div class="board-tab-container">
				<div class="board-label" board-type="300">🎬 영화게시판</div>
				<div class="board-label" board-type="301">🎬 자유게시판</div>
				<input type="hidden" name="boardType" id="board-type-id" value="<%=boardType %>">
			</div>

			<!-- ✍️ 글쓰기 폼 -->
			<div class="post-form">
				<h2>게시글 작성</h2>
				<!-- 스포일러 여부 선택 -->
				<div class="form-group">
					<div class="tooltip-group">
						<label for="contains-spoiler">스포일러</label>
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
						<label for="header">말머리</label>
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
						<div class="input-tooltip" id="title-tooltip">제목은 두 글자 이상이어야 합니다.</div>
					</div>
						<input type="text" name="title" placeholder="제목을 입력하세요">
				</div>

				<!-- 내용 입력 -->
				<div class="form-group">
					<div class="tooltip-group">
						<label>내용</label>
						<div class="input-tooltip" id="content-tooltip">내용은 10 글자 이상이어야 합니다.</div>
					</div>
					<textarea name="content" placeholder="내용을 입력하세요"></textarea>
				</div>

				<button type="submit" class="submit-btn">등록하기</button>

			</div>
		</form>

		<!-- 📃 하단 관련 게시글 목록 -->
		<div class="related-posts">
			<h3>📋 영화게시판 다른 글</h3>
			<div class="post-preview">
				<div class="title">[후기] 전공의생활 2화</div>
				<div class="author">무비러버</div>
			</div>
			<div class="post-preview">
				<div class="title">[잡담] 오늘 뭐 봄?</div>
				<div class="author">영화덕후</div>
			</div>
			<div class="post-preview">
				<div class="title">[공지] 이번 주 굿즈 할인</div>
				<div class="author">관리자</div>
			</div>
		</div>
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
		        
		        // 미선택 툴팁이 표시되고 있는지 확인하고 삭제하기
		        let $currentTooltip = $(this).closest(".header-toggle-group")
		            .prevAll(".tooltip-group")
		            .find(".input-tooltip");
		        $currentTooltip.removeClass("show");
		        
		        let selectedValue = $(this).attr(attributeName);
		        $("#" + targetInputId).val(selectedValue);
		    });
		}
		
		// '글쓰기'를 클릭했던 게시판을 하이라이트한다.
		let boardType = <%=boardType %>;
		if (boardType) {
		    $(".board-label[board-type=" + boardType + "]").addClass("active");
		};
		
		$(".board-label").click(function() {
			let boardType = $(this).attr("board-type");
			let headers = (boardType == "300" ? <%=movieHeadersJson %> : <%=freeHeadersJson %>);
			// 스포일러가 선택되어 있다면 해제
			$(".tag-toggle.spoiler").removeClass("active");
			$("#post-headers").empty();

			headers.forEach(function(header) {
				let button = $('<button>')
			      .addClass('tag-toggle header')
			      .attr('type', 'button')
			      .attr('data-value', header.id)
			      .text(header.name);

			    $("#post-headers").append(button);
			});
		});
		
		handleToggleClick(".form-container", ".board-label", "board-type", "board-type-id");
		handleToggleClick(".header-toggle-group", ".tag-toggle.spoiler", "data-value", "contains-spoiler");
		handleToggleClick(".header-toggle-group", ".tag-toggle.header", "data-value", "header-select");
		
		let titleRegex = /^[a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣ\s]{2,}$/
		let contentRegex = /^[\.0-9a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣ\s]{10,}$/
		let titleCheckPassed = false;
		let contentCheckPassed = false;
		
		$("#form-create-post").submit(function() {
			if ($("input[name=title]").val() == "") {
				alert("제목은 필수입력값입니다.");
				$("input[name=title]").focus();
				return false;
			}
			if (!titleCheckPassed) {
				alert("제목은 두 글자 이상이어야 합니다.");
				$("input[name=title]").focus();
				return false;
			}
			if ($("input[name=content]").val() == "") {
				alert("내용은 10글자 이상이어야 합니다.");
				$("textarea[name=content]").focus();
				return false;
			}
			if (!contentCheckPassed) {
				alert("내용은 10글자 이상이어야 합니다.");
				$("textarea[name=content]").focus();
				return false;
			}
			if ($(".tag-toggle.spoiler.active").length == 0) {
				alert("스포일러 포함 여부를 반드시 표시하셔야 합니다.");
				$("#spoiler-tooltip").focus();
				$("#spoiler-tooltip").addClass("show");
				return false;
			}
			if ($(".tag-toggle.header.active").length == 0) {
				alert("말머리를 반드시 표시하셔야 합니다.");
				$("#header-tooltip").focus();
				$("#header-tooltip").addClass("show");
				return false;
			}
			return true;
		});
		
		$("input[name=title]").keyup(function() {
			let title = $("input[name=title]").val().trim();
			
			if (!titleRegex.test(title)) {
				$("#title-tooltip").addClass("show");
			} else {
				$("#title-tooltip").removeClass("show")
				titleCheckPassed = true;
			};
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
