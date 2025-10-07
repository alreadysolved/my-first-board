package kye.my_board.repository;

import kye.my_board.domain.Member;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Optional;

@Mapper
public interface MemberMapper {
    void save(Member member);
    List<Member> findByEmail(String email);
    List<Member> findByNickname(String nickname);
}
