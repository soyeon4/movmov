<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Q&A 작성하기</title>
    <link rel="stylesheet" href="/movmov/resources/style/cs/inquiry-register.css">
</head>
<body>

    <!-- Trigger/Open The Modal -->
    <button id="myBtn">Q&A 작성하기</button>

    <!-- The Modal -->
    <div id="myModal" class="modal">
        <!-- Modal Content -->
        <div class="modal-content">
            <div class="modal-header">
                <h2>Q&A 작성하기</h2>
                <span class="close">&times;</span>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="category">카테고리</label>
                    <select id="category" name="category">
                        <option value="general">일반</option>
                        <option value="tech">기술</option>
                        <option value="billing">청구</option>
                        <option value="other">기타</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="title">제목</label>
                    <input type="text" id="title" name="title" placeholder="Q&A 제목을 입력하세요">
                </div>
                <div class="form-group">
                    <label for="content">내용</label>
                    <textarea id="content" name="content" placeholder="Q&A 내용을 입력하세요"></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button class="cancel">취소</button>
                <button class="submit">작성 완료</button>
            </div>
        </div>
    </div>

    <script>
        // Get the modal
        var modal = document.getElementById("myModal");

        // Get the button that opens the modal
        var btn = document.getElementById("myBtn");

        // Get the <span> element that closes the modal
        var span = document.getElementsByClassName("close")[0];

        // Get the buttons inside the modal
        var cancelBtn = document.querySelector('.cancel');
        var submitBtn = document.querySelector('.submit');

        // When the user clicks the button, open the modal
        btn.onclick = function() {
            modal.style.display = "flex";
        }

        // When the user clicks on <span> (x), close the modal
        span.onclick = function() {
            modal.style.display = "none";
        }

        // When the user clicks on cancel, close the modal
        cancelBtn.onclick = function() {
            modal.style.display = "none";
        }

        // When the user clicks on submit (to simulate form submission)
        submitBtn.onclick = function() {
            alert('Q&A 작성이 완료되었습니다.');
            modal.style.display = "none";
        }

        // When the user clicks anywhere outside the modal, close it
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>

</body>
</html>
