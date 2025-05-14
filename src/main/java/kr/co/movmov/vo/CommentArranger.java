package kr.co.movmov.vo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("CommentArranger")
public class CommentArranger {
	
    public List<List<Comment>> paginateComments(List<Comment> flatComments, int pageLimit) {
        Map<Integer, Comment> commentMap = new HashMap<>();
        List<Comment> topLevelComments = new ArrayList<>();

        // 모든 댓글 맵 생성
        for (Comment comment : flatComments) {
        	comment.setReplies(new ArrayList<>());
            commentMap.put(comment.getNo(), comment);
        }

        // 원댓글과 원댓글의 답글 분류
        for (Comment comment : flatComments) {
            if (comment.getParentCommentNo() == 0) {
                topLevelComments.add(comment);
            } else {
                Comment parentComment = commentMap.get(comment.getParentCommentNo());
                if (parentComment != null) {
                	parentComment.getReplies().add(comment);
                }
            }
        }

        // 댓글과 답글, 페이지 표시 댓글 수에 따라 페이지네이션 처리
        // 페이지당 댓글 리스트를 담은 리스트 계산
        List<List<Comment>> commentPages = new ArrayList<>();
        List<Comment> currentPage = new ArrayList<>();
        int currentPageCommentCount = 0;

        for (Comment topComment : topLevelComments) {
            int nestedCount = topComment.getTotalNestedCount();

            if (currentPageCommentCount + nestedCount > pageLimit && !currentPage.isEmpty()) {
            	commentPages.add(new ArrayList<>(currentPage));
                currentPage.clear();
                currentPageCommentCount = 0;
            }

            currentPage.add(topComment);
            currentPageCommentCount += nestedCount;
        }

        // Add the last page
        if (!currentPage.isEmpty()) {
        	commentPages.add(currentPage);
        }

        // 댓글 리스트의 리스트.
        // 한 리스트가 한 페이지에 표시될 모든 부모/자식 댓글을 순서대로 가짐.
        return commentPages;
    }
}

