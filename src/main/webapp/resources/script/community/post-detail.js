		function fadeInDialog(dialog) {
			dialog.classList.add("fade");
			dialog.showModal();
			requestAnimationFrame(() => {
				dialog.classList.add("showing");
			});
		}

		function fadeOutDialog(dialog) {
			dialog.classList.remove("showing");
			setTimeout(() => {
				dialog.close();
			}, 300);
		}
		
		let loginWarningDialog = document.getElementById("login-warning-dialog");
		
		$(".btn-upvote").on("click", function(e) {
			if (!isLoggedIn) {
				fadeInDialog(loginWarningDialog);
				return;
			}
			if (userId == postUserId) {
				alert("본인의 게시글을 추천할 수 없습니다.");
				// 본인 게시글 추천 눌렀을 때
				return;
			}
			if (upvoteIdList.includes(userId)) {
				alert("이미 추천한 게시글입니다.")
				// 이미 추천한 게시글일 때
				return;
			}
			$.ajax({
				url: "add-upvote.jsp",
				method: "POST",
				data: {
					postNo: postNo,
					userId: userId
				},
				success: function(response) {
					// 응답으로 업데이트된 추천 개수 받아옴
					$("#upvote-cnt").text(response);
					$(".upvote-icon").text("❤");
					upvoteIdList.push(userId);
				},
			    error: function () {
			    	alert("추천에 실패하였습니다.");
			    }
			});
		});
		
		$(".btn-create-comment").on("click", function(e) {
			if (!isLoggedIn) {
				e.preventDefault();
				fadeInDialog(loginWarningDialog);
				return;
			}
			if ($(this).prev('textarea').val() == "") {
				e.preventDefault();
				alert("댓글 내용을 입력해주세요.");
				return;
			}
		});
		
		$(".report-button").on("click", function(e) {
			e.preventDefault();
			let href = $(this).attr("href");
			if (!isLoggedIn) {
				fadeInDialog(loginWarningDialog);
				return;
			}
			if ($(this).hasClass("post") && userId == postUserId) {
				alert("본인의 게시글을 신고할 수 없습니다.");
				// 본인 게시글 신고 눌렀을 때
				return;
			}
			if ($(this).hasClass("comment") && userId == $(this).attr("data-user-id")) {
				alert("본인의 댓글을 신고할 수 없습니다.");
				// 본인 댓글 신고 눌렀을 때
				return;
			}
			window.location.href = href;
		});
		
		const originalCommentBlock = {};
		
		$(".comments-section").on("click", ".edit-comment", function(e) {
			e.preventDefault();
			
			let commentBlock = $(this).closest(".comment-block");
			let commentNo = commentBlock.data("comment-no");
			let commentContent = commentBlock.find(".content").text();
			let userNickname = commentBlock.find(".author-name").text();

			originalCommentBlock[commentNo] = commentBlock.clone();

			let editFormHtml = `
				<div class="comment-block" data-comment-no="${commentNo}">
					<div class="comment-form edit" data-comment-no="${commentNo}">
						<h4 style="margin: 3px;">댓글 수정</h4>
						<div class="comment-author">
							<img class="author-img" src="../../resources/images/common/default-profile.png" alt="profile-pic"/>
							<span class="author-name">${userNickname}</span>
						</div>
						<form action="edit-comment.jsp" method="post">
							<textarea name="content" rows="4">${commentContent}</textarea>
							<button type="submit">수정</button>
							<button type="button" class="cancel-edit">취소</button>
						</form>
					</div>
				</div>
			`;
			
			commentBlock.replaceWith(editFormHtml);
		});

		$(".comments-section").on("click", ".cancel-edit", function() {
			let commentBlock = $(this).closest(".comment-block");
			let commentNo = commentBlock.data("comment-no");

			// 원래 댓글 정보 저장
			let originalBlock = originalCommentBlock[commentNo];
			if (originalBlock) {
				commentBlock.replaceWith(originalBlock);
				delete originalCommentBlock[commentNo];
			} else {
				// 저장 실패 시 페이지 리로드
			    location.reload();
			}
		});
			
		// 수정한 댓글 ajax로 전송
		$(".comments-section").on("submit", ".comment-form.edit", function(e) {
			e.preventDefault();
			
			let commentBlock = $(this).closest(".comment-block");
			let commentNo = commentBlock.data("comment-no");
			let newContent = commentBlock.find("textarea").val();

			$.ajax({
				url: "/movmov/pages/community/edit-comment.jsp",
			    method: "POST",
			    data: {
			    	"cno": commentNo,
			    	"content": newContent
			    },
			    datatype: "json",
			    success: function(response) {
			    	let updatedBlock = `
			    		<div class="comment-block" data-comment-no="${response.cno}">
							<div class="comment-author">
								<img class="author-img" src="../../resources/images/common/default-profile.png" alt="profile-pic"/>
								<span class="author-name">${response.userNickname}</span>
								<div class="meta">작성일: ${response.createdDate} | 수정일: ${response.updatedDate}</div>
							</div>
							<div class="content">${response.content}</div>
							<div class="comment-options">
								<a href="#" class="edit-comment">수정</a>
								<a href="delete-comment.jsp?cno=${response.cno}" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>
								<a href="report-form.jsp?cno=${response.cno}"
									class="report-button comment"
									data-user-id="${response.userId}">신고하기</a>
							</div>
						</div>
					`;
					commentBlock.replaceWith(updatedBlock);
				},
			    error: function () {
			    	alert("댓글 수정에 실패했습니다.");
			    }
			});
		});

		$("#btn-page-first").on("click", function() {
			let params = $.param({
				pno: postNo,
				pg: 1
			});
			window.location.href = window.location.pathname + '?' + params;
		});
		
		$("#btn-page-last").on("click", function() {
			let params = $.param({
				pno: postNo,
				pg: totalPages
			});
			window.location.href = window.location.pathname + '?' + params;
		});
		
		$(".btn-page-no").on("click", function() {
			let params = $.param({
				pno: postNo,
				pg: $(this).text()
			});
			window.location.href = window.location.pathname + '?' + params;
		});
		
		$("#btn-close-warning").on("click", function() {
			fadeOutDialog(loginWarningDialog);
		});
		
		$("#btn-login-trigger").on("click", function() {
			loginWarningDialog.close();
			loginWarningDialog.classList.remove("showing");
			$("#btn-header-login").trigger("click");
		});
		
		loginWarningDialog.addEventListener("cancel", (e) => {
			e.preventDefault();
			fadeOutDialog(loginWarningDialog);
		});