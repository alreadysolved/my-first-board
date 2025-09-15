package kye.my_board.controller;

import jakarta.servlet.http.HttpSession;
import kye.my_board.domain.Member;
import kye.my_board.domain.Post;
import kye.my_board.service.PostService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class HomeController {

    private final PostService postService;

    @GetMapping({"/", "posts"})
    public String home(Model model) {
        List<Post> posts = postService.findAllPosts();
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
