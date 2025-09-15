package kye.my_board.service;

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

    public void savePost(Post post) {
        postMapper.save(post);
    }

    public void deletePost(Long postId) {
        postMapper.delete(postId);
    }

    public List<Post> findPostsByAuthorId(Long authorId) {
        return postMapper.findByAuthorId(authorId);
    }
}
