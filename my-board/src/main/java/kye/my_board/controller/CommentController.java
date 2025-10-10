package kye.my_board.controller;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import kye.my_board.domain.Comment;
import kye.my_board.domain.Member;
import kye.my_board.dto.CommentForm;
import kye.my_board.service.CommentService;
import kye.my_board.service.PostService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.time.LocalDateTime;

@Controller
@RequiredArgsConstructor
public class CommentController {
    private final CommentService commentService;
    private final PostService postService;

    @PostMapping("/posts/{postId}/comments")
    public String createComment(@PathVariable Long postId, HttpSession session, @Valid CommentForm commentForm, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "redirect:/posts/{postId}";
        }

        Member loginMember = (Member) session.getAttribute("loginMember");

        Comment comment = new Comment();
        comment.setPostId(postId);
        comment.setAuthorId(loginMember.getId());
        comment.setAuthorNickname(loginMember.getNickname());
        comment.setContent(commentForm.getContent());
        comment.setCreatedAt(LocalDateTime.now());
        commentService.saveComment(comment);
        postService.updatePostComments(postId, 1);

        return "redirect:/posts/{postId}";
    }

    @PatchMapping("/posts/{postId}/comments/{commentId}")
    public String updateComment(@PathVariable Long postId, @PathVariable Long commentId, @Valid CommentForm commentForm, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "redirect:/posts/{postId}";
        }

        Comment comment = commentService.findCommentById(commentId);
        comment.setContent(commentForm.getContent());
        commentService.editComment(comment);

        return "redirect:/posts/{postId}";
    }

    @DeleteMapping("/posts/{postId}/comments/{id}")
    public String deleteComment(@PathVariable Long postId, @PathVariable Long id) {
        commentService.deleteCommentById(id);
        postService.updatePostComments(postId, -1);

        return "redirect:/posts/{postId}";
    }
}
