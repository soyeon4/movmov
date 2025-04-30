<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/*
		요청 URL
			/pages/community/post-detail.jsp?bno=xxx
		
			name		value
			----------------
			bno			게시글 번호 post_id
	*/
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
<link rel="stylesheet" href="../../resources/style/community/post-detail.css">
</head>
<body>
	<!-- 헤더 -->
	<%@ include file="../common/header.jsp"%>
      
	<div class="container">
    
    <!-- 🔷 게시판 이름 -->
    <div class="board-label">🎬 영화게시판</div>

    <!-- 📌 상세 글 내용 -->
    <div class="post-detail">
        <div class="post-tag">[후기]</div> <!-- 말머리 -->
          <h2>영화 후기 공유합니다 🎬</h2>
          <div class="post-meta">작성자: movlover | 날짜: 2025.04.21 | 조회수: 234</div>
          <div class="post-content">
          오늘 본 영화 정말 재밌었어요! 캐릭터가 입체적이고, 연출도 최고였음. <br />
          여러분은 어떻게 보셨나요?
          </div>
        <!-- ❤️ 추천 버튼 -->
        <div class="recommend-button">
          <button class="btn-recommend">
            <img src="resources/favicon.ico" alt="추천" class="recommend-icon" />
            추천 0
          </button>
        </div>
      </div>
      <div>
        <a href="report-form.html" class="report-button">신고하기</a>
      </div>

    <!-- 💬 댓글 -->
    <div class="comments-section">
      <h3>💬 댓글 [1]</h3>
      <div class="comment">
        <div class="meta">filmfan · 2025.04.21 15:01</div>
        <div class="text">저도 완전 공감합니다!! 마지막 장면 진짜 👍</div>
      </div>

      <div class="comment-form">
        <h4>댓글 작성</h4>
        <form>
          <textarea rows="4" placeholder="댓글을 입력하세요..."></textarea>
          <br />
          <button type="submit">등록</button>
        </form>
      </div>
    </div>

    <!-- 📃 하단 관련 게시글 목록 -->
    <div class="related-posts">
      <h3>📋 영화게시판 다른 글</h3>
      <div class="post-preview">
        <div class="title">[잡담] 오늘 본 영화 공유해요</div>
        <div class="author">cinemania</div>
      </div>
      <div class="post-preview">
        <div class="title">[리뷰] 범죄도시3 개봉 후기</div>
        <div class="author">영화왕</div>
      </div>
      <div class="post-preview">
        <div class="title">[정보] 넷플릭스 신작 추천 목록</div>
        <div class="author">스트리머</div>
      </div>
    </div>
  </div>
</body>

	<!-- 푸터 -->
	<%@ include file="../common/footer.jsp"%>

</html>