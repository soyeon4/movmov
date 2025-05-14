<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>회원가입</title>
  <link rel="icon" href="../../resources/images/common/favicon.ico">
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="../../resources/style/common/main.css">
</head>
<body>
  <div class="modal-background" style="display: block;">
    <div class="modal-login">
      <h2>회원가입</h2>

      <!-- 가입 후 성공 페이지로 이동 -->
      <form id="form-register" method="post" action="register.jsp">
        <div class="form-group">
          <input type="text" name="id" id="user-id" placeholder="아이디" class="input-login" required />
          <div id="form-text-id" class="form-text"></div>
        </div>

        <div class="form-group">
          <input type="password" name="password" id="user-password" placeholder="비밀번호" class="input-login" required />
        </div>

        <div class="form-group">
          <input type="text" name="nickname" id="user-nickname" placeholder="닉네임" class="input-login" required />
          <div id="form-text-nickname" class="form-text"></div>
        </div>

        <div class="form-group">
          <input type="email" name="email" id="user-email" placeholder="이메일" class="input-login" required />
          <div id="form-text-email" class="form-text"></div>
        </div>

        <div class="form-group">
          <input type="text" name="name" id="user-name" placeholder="이름" class="input-login" required />
        </div>

        <div class="form-group">
          <select name="region" id="user-region" class="input-login" required>
            <option value="">국가/지역 선택</option>
            <option value="KR">대한민국</option>
            <option value="US">미국</option>
            <option value="JP">일본</option>
            <option value="CN">중국</option>
            <option value="OTHER">기타</option>
          </select>
        </div>

        <button type="submit" class="btn-login-submit">가입하기</button>
      </form>

      <div class="link-small">
        <a href="/movmov/index.jsp">이미 계정이 있으신가요? <strong>로그인</strong></a>
      </div>
    </div>
  </div>

  <!-- 스크립트 영역 -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script>
    const idRegExp = /^[a-zA-Z0-9_]{4,}$/;
    let idCheckPassed = false;

    // 아이디 실시간 유효성 + 중복검사
    $("#user-id").keyup(function () {
      const value = $(this).val();
      const $div = $("#form-text-id").empty().removeClass("text-danger text-success");

      if (!idRegExp.test(value)) {
        $div.addClass("text-danger").text("아이디는 영어, 숫자, _로 4글자 이상 입력하세요.");
        idCheckPassed = false;
        return;
      }

      $.ajax({
        type: "get",
        url: "id-check.jsp", // AJAX용 JSP
        data: { id: value },
        dataType: "text",
        success: function (result) {
          if (result === "none") {
            $div.addClass("text-success").text("사용 가능한 아이디입니다.");
            idCheckPassed = true;
          } else if (result === "exists") {
            $div.addClass("text-danger").text("이미 사용중인 아이디입니다.");
            idCheckPassed = false;
          } 
        },
      });
    });

    // 최종 제출 시 검사
    $("#form-register").submit(function () {
      const value = $("#user-id").val();
      const $div = $("#form-text-id").empty().removeClass("text-danger text-success");

      if (!idRegExp.test(value)) {
        $div.addClass("text-danger").text("아이디는 영어, 숫자, _로 4글자 이상 입력하세요.");
        $("#user-id").focus();
        return false;
      }



      return true; // 모든 조건 통과 시 제출
    });
  </script>
</body>
</html>
