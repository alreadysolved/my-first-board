package kye.my_board.repository;

import kye.my_board.domain.Comment;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Optional;

@Mapper
public interface CommentMapper {
    void save(Comment comment);
    Comment findById(Long id);
    List<Comment> findByPostId(Long postId);
    void update(Comment comment);
    void deleteByCommentId(Long id);
    void deleteByPostId(Long postId);
}
