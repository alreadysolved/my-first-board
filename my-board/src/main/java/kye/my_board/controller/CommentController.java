package kye.my_board.controller;

import jakarta.servlet.http.HttpSession;
import kye.my_board.domain.Comment;
import kye.my_board.domain.Member;
import kye.my_board.domain.Post;
import kye.my_board.dto.CommentForm;
import kye.my_board.service.CommentService;
import kye.my_board.service.PostService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.time.LocalDateTime;

@Controller
@RequiredArgsConstructor
public class CommentController {
    private final CommentService commentService;
    private final PostService postService;

    @PostMapping("/posts/{id}/comments")
    public String createComment(@PathVariable Long id, HttpSession session, CommentForm commentForm) {
        Member loginMember = (Member) session.getAttribute("loginMember");

        Comment comment = new Comment();
        comment.setPostId(id);
        comment.setAuthorId(loginMember.getId());
        comment.setAuthorNickname(loginMember.getNickname());
        comment.setContent(commentForm.getContent());
        comment.setCreatedAt(LocalDateTime.now());
        commentService.saveComment(comment);
        postService.updatePostComments(id, 1);

        return "redirect:/posts/{id}";
    }
}
