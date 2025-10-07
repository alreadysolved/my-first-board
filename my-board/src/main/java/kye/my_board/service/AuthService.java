package kye.my_board.service;

import kye.my_board.domain.Member;
import kye.my_board.dto.JoinForm;
import kye.my_board.repository.MemberMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final MemberMapper memberMapper;

    public void join(Member member) {
        memberMapper.save(member);
    }

    public List<Member> findMemberByEmail(String email) {
        return memberMapper.findByEmail(email);
    }

    public List<Member> findMemberByNickname(String nickname) {
        return memberMapper.findByNickname(nickname);
    }

}
