package kye.my_board.controller;

import jakarta.servlet.http.HttpSession;
import kye.my_board.domain.Member;
import kye.my_board.domain.Post;
import kye.my_board.service.PostService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class HomeController {

    private final PostService postService;

    @GetMapping({"/", "posts"})
    public String home(@RequestParam(required = false) String type,
                       @RequestParam(required = false) String keyword,
                       Model model) {
        List<Post> posts;

        if (keyword != null && !keyword.isBlank()) {
            posts = postService.searchPosts(type, keyword);
        }
        else {
            posts = postService.findAllPosts();
        }

        if (posts.isEmpty()) posts = new ArrayList<>();
        posts.forEach(post -> {
            post.setCreatedAtDate(Timestamp.valueOf(post.getCreatedAt()));
        });
        model.addAttribute("posts", posts);

        return "home";
    }

    @GetMapping("/posts/mine")
    public String myPosts(HttpSession session, Model model) {
        Member member = (Member) session.getAttribute("loginMember");
        List<Post> posts = postService.findPostsByAuthorId(member.getId());
        if (posts.isEmpty()) posts = new ArrayList<>();

        posts.forEach(post -> {
            post.setCreatedAtDate(Timestamp.valueOf(post.getCreatedAt()));
        });

        model.addAttribute("posts", posts);

        return "myPosts";
    }

}
