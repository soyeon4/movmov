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
if (boardId) {
    $(".board-label[board-id=" + boardId + "]").addClass("active");
};

$(".board-label").on("click", function() {
	if (boardId != $(this).attr("board-id")) {
		boardId = $(this).attr("board-id");
		let headers = (boardId == "300" ? movieHeaders : freeHeaders);
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
	}
});

handleToggleClick(".form-container", ".board-label", "board-id", "board-type-id");
handleToggleClick(".header-toggle-group", ".tag-toggle.spoiler", "data-value", "contains-spoiler");
handleToggleClick(".header-toggle-group", ".tag-toggle.header", "data-value", "header-select");

let titleRegex = /^[\s\S]{2,}$/u
let contentRegex = /^[\s\S]{10,}$/u
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

$("#form-create-post input[name=title]").on("keydown", function(e) {
	if (e.key === 'Enter') {
		e.preventDefault();
	}
});

$(".button-return").on("click", function() {
	if (confirm("게시글 작성을 취소하고 돌아가시겠습니까?")) {
		window.location.href = "/movmov/pages/community/community-forum.jsp?bid=" + boardId;
	}
});
