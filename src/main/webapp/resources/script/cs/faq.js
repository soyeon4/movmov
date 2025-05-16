$(document).ready(function () {
  console.log("faq.js loaded");

  let currentCatId = "";
  let currentKeyword = "";

  // 탭 전환
  $(document).on('click', '.tab', function () {
    $('.tab').removeClass('active');
    $('.tab-content').removeClass('active');
    $(this).addClass('active');
    $('#' + $(this).data('tab')).addClass('active');
  });

  // FAQ 로딩 함수
  function loadFaqs(catId, page) {
    $.ajax({
      url: 'faq-ajax.jsp',
      method: 'GET',
      data: {
        catId: catId,
        page: page,
        keyword: currentKeyword
      },
      dataType: 'json',
      success: function (data) {
        const $faqList = $('.faq-list');
        $faqList.empty();

        data.faqs.forEach(function (faq) {
          const $li = $('<li>').addClass('faq-item');
          $li.html(`
            <span>[${faq.categoryName}]</span> ${faq.title}
            <div class="faq-answer">${faq.content}</div>
          `);
          $faqList.append($li);
        });

        // 아코디언 동작 재등록 (꼬임 방지 + stop 추가)
        $('.faq-item').off('click').on('click', function () {
          const $answer = $(this).find('.faq-answer');
          const isOpen = $answer.is(':visible');

          // 모든 답변 닫기 (stop으로 애니메이션 꼬임 방지)
          $('.faq-answer').stop(true, true).slideUp(200);

          // 클릭한 항목만 열기
          if (!isOpen) {
            $answer.stop(true, true).slideDown(200);
          }
        });

        drawPagination(data.totalRows, page);
      }
    });
  }

  // 페이지네이션 렌더링
  function drawPagination(totalRows, currentPage) {
    const pointColor = getComputedStyle(document.documentElement).getPropertyValue('--point-color').trim();

    const totalPages = Math.ceil(totalRows / 10);
    const $pagination = $('.pagination');
    $pagination.empty();

    for (let i = 1; i <= totalPages; i++) {
      const $a = $('<a href="#">')
        .text(i)
        .addClass('page-link')
        .data('page', i);

      // 현재 페이지는 배경색을 --point-color로, 글자는 흰색으로 변경
      if (i === currentPage) {
        $a.css({
          'font-weight': 'bold',
          'color': '#fff',               // 숫자 흰색
          'background-color': pointColor, // 배경색을 --point-color로
          'border-color': pointColor
        });
      }

      $pagination.append($a);
    }
  }

  // 카테고리 필터 클릭
  $(document).on('click', '.faq-category-btn', function () {
    currentCatId = $(this).data('cat-id') || "";
    currentKeyword = "";
    $('#search-keyword').val(""); // 검색창 비움

    loadFaqs(currentCatId, 1);

    $('.faq-category-btn').removeClass('active');
    $(this).addClass('active');
  });

  // 검색 버튼 클릭
  $('#btn-search').click(function () {
    currentKeyword = $('#search-keyword').val().trim();
    loadFaqs(currentCatId, 1);
  });

  // 검색창에서 Enter 키 눌렀을 때 검색
  $('#search-keyword').on('keyup', function (event) {
    if (event.key === 'Enter') {
      currentKeyword = $(this).val().trim();
      loadFaqs(currentCatId, 1);
    }
  });

  // 페이지 번호 클릭
  $(document).on('click', '.page-link', function (e) {
    e.preventDefault();
    const page = $(this).data('page');
    loadFaqs(currentCatId, page);
  });
  
  //Qna 탭 누를 경우 /movmov/pages/cs/inquiry.jsp로 전환
  window.loadQnaTab = function () {
      $("#inquiry").html('<div>로딩 중...</div>');
      $.ajax({
          url: '/movmov/pages/cs/inquiry.jsp', // Q&A 내용 JSP 경로
          method: 'GET',
          success: function (data) {
              $("#inquiry").html(data); // Q&A 콘텐츠 삽입
          },
          error: function () {
              $("#inquiry").html('<div>Q&A를 불러오는 데 실패했습니다.</div>');
          }
      });
  }

  window.goToTab = function (tabId) {
      $('.tab').removeClass('active');
      $('.tab-content').removeClass('active');

      $('.tab[data-tab="' + tabId + '"]').addClass('active');
      $('#' + tabId).addClass('active');
  }
  
  // 초기 FAQ 로딩
  loadFaqs("", 1);
});