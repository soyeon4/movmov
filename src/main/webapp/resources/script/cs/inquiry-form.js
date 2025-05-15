// 모달 요소 가져옴
var modal = document.getElementById("myModal");

// 모달 여는 버튼 가져옴
var btn = document.getElementById("myBtn");

// 모달 닫는 <span> 요소 가져옴
var span = document.getElementsByClassName("close")[0];

// 모달 안 취소 버튼, 제출 버튼 가져옴
var cancelBtn = document.querySelector('.cancel');
var submitBtn = document.querySelector('.submit');

// 버튼 클릭 시 모달 열림
btn.onclick = function() {
    modal.style.display = "flex";  // 모달 보이게 함
}

// <span> (x) 클릭 시 모달 닫힘
span.onclick = function() {
    modal.style.display = "none";  // 모달 숨김
}

// 취소 버튼 클릭 시 모달 닫힘
cancelBtn.onclick = function() {
    modal.style.display = "none";  // 모달 숨김
}

// 제출 버튼 클릭 시 폼 제출 시뮬레이션 후 모달 닫힘
submitBtn.onclick = function() {
    alert('Q&A 작성 완료됨');  // 알림 띄움
    modal.style.display = "none";  // 모달 숨김
}

// 모달 외부 클릭 시 모달 닫힘
window.onclick = function(event) {
    if (event.target === modal) {
        modal.style.display = "none";  // 모달 숨김
    }
}
