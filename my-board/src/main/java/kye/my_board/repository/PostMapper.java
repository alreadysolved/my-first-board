package kye.my_board.repository;

import kye.my_board.domain.Post;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface PostMapper {

    List<Post> findAll();
    void save(Post post);
    void delete(Long id);
    Post findById(Long id);
    List<Post> findByAuthorId(Long authorId);
}
