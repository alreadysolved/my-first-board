package kye.my_board.controller;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import kye.my_board.domain.Member;
import kye.my_board.domain.Post;
import kye.my_board.dto.PostForm;
import kye.my_board.service.PostService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Date;

@Controller
@RequiredArgsConstructor
public class PostController {

    private final PostService postService;

    // 글 작성 폼
    @GetMapping("/posts/new")
    public String CreatePostForm(Model model) {
        model.addAttribute("PostForm", new PostForm());
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

        return "redirect:/posts";
    }

    // 글 조회
    @GetMapping("/posts/{id}")
    public String showPost(@PathVariable Long id, Model model) {
        Post post = postService.findPostById(id);
        Date createdAtAsDate = Timestamp.valueOf(post.getCreatedAt());

        model.addAttribute("post", post);
        model.addAttribute("createdAt", createdAtAsDate);

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
        if (loginMember.getId() != post.getAuthorId()) {
            redirectAttributes.addFlashAttribute("errorMessage", "삭제 권한이 없습니다.");
        }

        postService.deletePost(id);
        redirectAttributes.addFlashAttribute("successMessage", "글이 삭제되었습니다.");
        return "redirect:/posts";
    }
}
