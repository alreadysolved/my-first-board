package kye.my_board.repository;

import kye.my_board.domain.Member;
import org.apache.ibatis.annotations.Mapper;

import java.util.Optional;

@Mapper
public interface MemberMapper {
    void save(Member member);
    Optional<Member> findByEmail(String email);
    Optional<Member> findByNickname(String nickname);
}
