<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>설정</title>
  <link rel="stylesheet" href="../style/watcha.css">
    <!-- ✅ 추가한 필수 링크들 -->
  <!-- 구글 폰트 (Noto Sans KR) -->
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">

  <!-- Font Awesome 아이콘 -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

  <!-- 메인 공통 CSS -->
  <link rel="stylesheet" href="/movmov/resources/style/common/main.css">

  <!-- 마이페이지 전용 watcha 스타일 -->
  <link rel="stylesheet" href="/movmov/resources/style/mypage/watcha.css">
  <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-100 text-gray-800">
  <div class="max-w-md mx-auto py-10">
    <h1 class="text-2xl font-bold mb-6">설정</h1>

    <!-- 설정 목록 박스 -->
    <div class="bg-white rounded-xl shadow divide-y">

      <div class="p-4 hover:bg-gray-50 cursor-pointer">공개 설정</div>

      <a href="change-password.html" class="block p-4 hover:bg-gray-50 cursor-pointer">비밀번호 변경</a>

      <!-- 언어 설정 -->
      <div class="flex justify-between items-center p-4">
        <span>언어</span>
        <span class="text-gray-700">한국어</span>
      </div>

      <!-- 국가 및 지역 설정 -->
      <form action="update-region.jsp" method="post" class="flex justify-between items-center p-4">
        <label for="region" class="mr-4">국가 및 지역</label>
        <select name="region" id="region" class="text-gray-700 border rounded px-2 py-1">
          <option value="KR" selected>대한민국</option>
          <option value="US">미국</option>
          <option value="JP">일본</option>
          <option value="CN">중국</option>
          <option value="FR">프랑스</option>
          <option value="GB">영국</option>
          <option value="BR">브라질</option>
          <option value="ETC">기타</option>
        </select>
        <button type="submit" class="ml-2 text-white bg-pink-500 px-3 py-1 rounded hover:bg-pink-600">변경</button>
      </form>

      <!-- 프로필 공개 여부 설정 -->
      <form action="update-privacy.jsp" method="post" class="flex justify-between items-center p-4">
        <label for="is_public" class="mr-4">프로필 공개</label>
        <select name="is_public" id="is_public" class="text-gray-700 border rounded px-2 py-1">
          <option value="Y">공개</option>
          <option value="N">비공개</option>
        </select>
        <button type="submit" class="ml-2 text-white bg-pink-500 px-3 py-1 rounded hover:bg-pink-600">저장</button>
      </form>

      <!-- ✅ 회원탈퇴 추가 (색 없는 버전) -->
      <form action="update-isdeleted.jsp" method="post" class="flex justify-between items-center p-4">
        <label for="delete_confirm" class="mr-4 font-semibold">회원 탈퇴</label>
        <button type="submit" class="ml-2 border border-gray-400 text-gray-700 px-3 py-1 rounded hover:bg-gray-100">탈퇴하기</button>
      </form>

    </div>

    <!-- 마이페이지로 돌아가기 -->
    <div class="mt-8 text-center">
      <a href="page.jsp" class="text-blue-600 hover:underline">← 마이페이지 홈으로</a>
    </div>
  </div>

  <!-- 푸터 include -->
  <%@ include file="../common/footer.jsp" %>
</body>
</html>
