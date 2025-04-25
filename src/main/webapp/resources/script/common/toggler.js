document.addEventListener('DOMContentLoaded', function () {
  const toggle = document.getElementById('profile-toggle');
  const dropdown = document.getElementById('profile-dropdown');

  // 프로필 이미지 클릭 시 드롭다운 토글
  toggle.addEventListener('click', () => {
    dropdown.style.display = dropdown.style.display === 'none' ? 'block' : 'none';
  });
});
