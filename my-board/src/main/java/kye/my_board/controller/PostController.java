package kye.my_board.controller;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import kye.my_board.domain.Comment;
import kye.my_board.domain.Member;
import kye.my_board.domain.Post;
import kye.my_board.dto.CommentForm;
import kye.my_board.dto.EditForm;
import kye.my_board.dto.PostForm;
import kye.my_board.service.CommentService;
import kye.my_board.service.PostService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Controller
@RequiredArgsConstructor
public class PostController {

    private final PostService postService;
    private final CommentService commentService;

    // 글 작성 폼
    @GetMapping("/posts/new")
    public String CreatePostForm(Model model) {
        model.addAttribute("postForm", new PostForm());
        return "createPost";
    }

    // 글 작성
    @PostMapping("/posts")
    public String createPost(@Valid PostForm postForm, BindingResult bindingResult, HttpSession session) {
        if (bindingResult.hasErrors()) {
            return "createPost";
        }

        Member loginMember = (Member) session.getAttribute("loginMember");
        Post post = new Post();
        post.setTitle(postForm.getTitle());
        post.setContent(postForm.getContent());
        post.setAuthorId(loginMember.getId());
        post.setAuthorNickname(loginMember.getNickname());
        post.setCreatedAt(LocalDateTime.now());
        postService.savePost(post);

        Long postId = post.getId();
        return "redirect:/posts/" + postId;
    }

    // 글 조회
    @GetMapping("/posts/{id}")
    public String showPost(@PathVariable Long id, HttpSession session, Model model) {
        Post post = postService.findPostById(id);
        postService.increasePostViews(id, session); // 조회수 증가
        Date createdAtAsDate = Timestamp.valueOf(post.getCreatedAt());
        List<Comment> commentsList = commentService.findCommentsByPostId(id);
        commentsList.forEach(comment -> {
            comment.setCreatedAtDate(Timestamp.valueOf(comment.getCreatedAt()));
        });

        model.addAttribute("post", post);
        model.addAttribute("createdAt", createdAtAsDate);
        model.addAttribute("commentForm", new CommentForm());
        model.addAttribute("commentsList", commentsList);

        return "post";
    }

    // 글 삭제
    @DeleteMapping("/posts/{id}")
    public String deletePost(@PathVariable Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        // 로그아웃 상태일 경우
        if (loginMember == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "로그인 후 이용 가능합니다.");
            return "redirect:/login";
        }
        // 내 글이 아닌 경우
        Post post = postService.findPostById(id);
        if (!loginMember.getId().equals(post.getAuthorId())) {
            redirectAttributes.addFlashAttribute("errorMessage", "삭제 권한이 없습니다.");
        }

        postService.deletePost(id);
        redirectAttributes.addFlashAttribute("successMessage", "글이 삭제되었습니다.");
        return "redirect:/posts";
    }

    // 글 수정
    @GetMapping("/posts/{id}/edit")
    public String editPostForm(@PathVariable Long id, Model model) {
        Post post = postService.findPostById(id);
        EditForm editForm = new EditForm();
        editForm.setId(id);
        editForm.setTitle(post.getTitle());
        editForm.setContent(post.getContent());
        model.addAttribute("editForm", editForm);

        return "editPost";
    }

    @PatchMapping("/posts/{id}")
    public String editPost(@PathVariable Long id, @Valid PostForm postForm, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "editPost";
        }

        Post post = postService.findPostById(id);
        post.setTitle(postForm.getTitle());
        post.setContent(postForm.getContent());
        postService.editPost(post);

        return "redirect:/posts/{id}";
    }
}
