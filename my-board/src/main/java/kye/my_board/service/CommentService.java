package kye.my_board.service;

import kye.my_board.domain.Comment;
import kye.my_board.repository.CommentMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class CommentService {
    private final CommentMapper commentMapper;

    public void saveComment(Comment comment) {
        commentMapper.save(comment);
    }

    public List<Comment> findCommentsByPostId(Long postId) {
        return commentMapper.findByPostId(postId);
    }
}
