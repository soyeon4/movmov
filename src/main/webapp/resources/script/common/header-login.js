$("#btn-header-login").click(function() {
	$(".modal-background").fadeIn();
});
$(".modal-close").click(function() {
	$(".modal-background").fadeOut();
});

$(window).click(function(e) {
	if ($(e.target).is(".modal-background")) {
		$(".modal-background").fadeOut();
	}
});
		
$("#login-form").on("submit", function(e) {
	e.preventDefault();
	// 로그인 성공 후 페이지 리로드를 했을 때
	// get 방식으로 전달된 쿼리스트링은 보존되지만
	// post 방식으로 전달된 값은 저장되지 않음.
	$.ajax({
		url: "/movmov/pages/mypage/login-ajax.jsp",
		method: "POST",
		data: $(this).serialize(), // 폼 입력값을 json 형식으로 변환
		dataType: "json",	// ajax-login.jsp의 응답이 json 형식임
		success: function(response) {
			if (response.success) {
				if (window.location.pathname === "/login.jsp" || window.location.pathname === "/") {
					window.location.href = "index.jsp";
				} else if (response.redirectUrl != "null") {
					window.location.href = response.redirectUrl;
				} else {
					location.reload();
				}
			} else {
				window.location.href = response.redirectUrl;
			}
		}
	});
});