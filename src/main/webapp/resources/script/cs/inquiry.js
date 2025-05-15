$(document).ready(function () {
  // 로딩 중 표시
  const loadingText = "<div>로딩 중...</div>";

  // 페이지 로딩 시 초기 데이터 로드
//  loadInquiries();

  $("#myQnaOnly").on("click", function(e) {  // 수정된 부분
    if (!isLoggedIn) { 
      e.preventDefault();
      $(".modal-background").fadeIn();
	  return;
    }
  });
  
  $(".qna-write-btn").on("click", function(e) {
	if (!isLoggedIn) {
		e.preventDefault();
		$(".modal-background").fadeIn();
		return;
	}
	$("#myModal").fadeIn();
  });
  
  $(".modal-header span.close").on("click", function() {
  	$("#myModal").fadeOut();
  });

  $(window).click(function(e) {
  	if ($(e.target).is(".modal")) {
  		$("#myModal").fadeOut();
  	}
  });
  
  $(".modal-footer button.cancel").on("click", function() {
  		$("#myModal").fadeOut();
  });

  $(".qna-item").on("click", function() {
	let qnaAnswerBlock = $(this).next(".qna-answer-block");
	qnaAnswerBlock.toggle();
  });
  
  // 필터 변경 시 Ajax로 데이터 로드
  $('.qna-filters input, .qna-filters select').on('change', function () {
    loadInquiries(); // 필터 변경 시마다 호출
  });

  // 문의 내역을 불러오는 함수
  function loadInquiries() {
    // 로딩 상태로 설정
    $('.qna-list').html(loadingText);

    // 필터 값들
    const excludeSecret = $('#excludeSecret').is(':checked');
    const myQnaOnly = $('#myQnaOnly').is(':checked');
    const category = $('#categoryFilter').val();
    const answerStatus = $('#statusFilter').val();

    // Ajax 요청
    $.ajax({
      url: '/movmov/pages/cs/inquiry-ajax.jsp',  // Ajax URL (inquiry-ajax.jsp)
      method: 'GET',  // GET 방식
      data: {
        excludeSecret: excludeSecret,
        myQnaOnly: myQnaOnly,
        category: category,
        answerStatus: answerStatus
      },
      success: function (html) {
        // 요청이 성공하면, 받은 HTML을 .qna-list에 삽입
        $('.qna-list').html(html);
      },
      error: function (jqXHR, textStatus, errorThrown) {
        // 오류가 발생하면 오류 메시지 출력
        console.error("AJAX error:", textStatus, errorThrown);
        $('.qna-list').html("<div>문의 내역을 불러오는 데 실패했습니다. 다시 시도해 주세요.</div>");
      }
    }); // $.ajax
  } // loadInquiries()
  
});
