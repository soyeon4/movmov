<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<link rel="stylesheet" href="../../resources/style/community/community.css">
</head>
<body>
	<!-- 헤더 -->
	<%@ include file="../common/header.jsp"%>

	<main class="forum-container">
    <section class="notice-area">
      <div class="popular-block">
        <h2>📢 공지사항</h2>
        <div class="board-header">
          <span>번호</span>
          <span>제목</span>
          <span>작성자</span>
          <span>조회수</span>
        </div>
        <div class="board-row">
          <span>1</span>
          <span>[공지] 정기 점검 안내</span>
          <span>운영자</span>
          <span>1325</span>
        </div>
        <div class="board-row">
          <span>2</span>
          <span>[공지] 이벤트 시작</span>
          <span>운영자</span>
          <span>98</span>
        </div>
        <div class="board-row">
          <span>3</span>
          <span>[공지] 이번 주 굿즈 할인 이벤트!</span>
          <span>운영자</span>
          <span>989</span>
        </div>
      </div>
    </section>
  
    <section class="popular-posts">
      <div class="popular-block">
        <h2>🔥 영화게시판 인기</h2>
          <div class="board-header">
            <span>번호</span>
            <span>제목</span>
            <span>작성자</span>
            <span>조회수</span>
          </div>
          <div class="board-row">
            <span>1</span>
            <span>[후기] 전공의생활 2화</span>
            <span>무비러버</span>
            <span>132</span>
          </div>
          <div class="board-row">
            <span>2</span>
            <span>[질문] 오늘 뭐 봄?</span>
            <span>영화덕후</span>
            <span>98</span>
          </div>
      </div>
      <div class="popular-block">
        <h2>🔥 자유게시판 인기</h2>
        <div class="post">
          <div class="board-header">
            <span>번호</span>
            <span>제목</span>
            <span>작성자</span>
            <span>조회수</span>
          </div>
          <div class="board-row">
            <span>14</span>
            <span>졸려디짐</span>
            <span>징징이</span>
            <span>123</span>
          </div>
          <div class="board-row">
            <span>2</span>
            <span>오늘 뭐 봄?</span>
            <span>영화덕후</span>
            <span>98</span>
          </div>
          <div class="board-row">
            <span>27</span>
            <span>제목2</span>
            <span>작성자3</span>
            <span>98</span>
          </div>
      	</div>
      </div>
    </section>

    <section class="forums-container">
      <div class="forum">
        <h2><a href="community-forum.jsp?btype=300">🎬 영화게시판</a></h2>
        <div class="board-header">
          <span>번호</span>
          <span>제목</span>
          <span>작성자</span>
          <span>조회수</span>
        </div>
        <div class="board-row">
          <span>26</span>
          <span>제목입니다.</span>
          <span>아이디2</span>
          <span>11</span>
        </div>
        <div class="board-row">
          <span>27</span>
          <span>제목2</span>
          <span>작성자3</span>
          <span>98</span>
        </div>
        <div class="board-row">
          <span>27</span>
          <span>제목2</span>
          <span>작성자3</span>
          <span>98</span>
        </div>
        <div class="board-row">
          <span>27</span>
          <span>제목2</span>
          <span>작성자3</span>
          <span>98</span>
        </div>
      </div>

      <div class="forum">
        <h2><a href="community-forum.jsp?btype=301">🎈 자유게시판</a></h2>
        <div class="board-header">
          <span>번호</span>
          <span>제목</span>
          <span>작성자</span>
          <span>조회수</span>
        </div>
        <div class="board-row">
          <span>26</span>
          <span>제목입니다.</span>
          <span>아이디2</span>
          <span>11</span>
        </div>
        <div class="board-row">
          <span>27</span>
          <span>제목2</span>
          <span>작성자3</span>
          <span>98</span>
        </div>
      </div>
    </section>
  </main>

	<!-- 푸터 -->
	<%@ include file="../common/footer.jsp"%>
</body>
</html>
