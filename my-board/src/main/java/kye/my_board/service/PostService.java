package kye.my_board.service;

import jakarta.servlet.http.HttpSession;
import kye.my_board.domain.Member;
import kye.my_board.domain.Post;
import kye.my_board.repository.PostMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class PostService {
    private final PostMapper postMapper;

    public List<Post> findAllPosts() {
        return postMapper.findAll();
    }

    public Post findPostById(Long id) {
        return postMapper.findById(id);
    }

    public void savePost(Post post) { postMapper.save(post);
    }

    public void deletePost(Long postId) {
        postMapper.delete(postId);
    }

    public List<Post> findPostsByAuthorId(Long authorId) {
        return postMapper.findByAuthorId(authorId);
    }

    public void editPost(Post post) {
        postMapper.update(post);
    }

    public void increasePostViews(Long id, HttpSession session) {
        Post post = findPostById(id);
        Member member = (Member) session.getAttribute("loginMember");
        if (!post.getAuthorId().equals(member.getId())) {
            post.setViews(post.getViews() + 1);
            postMapper.updateViews(post);
        }
    }
}
