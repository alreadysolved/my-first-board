package kye.my_board.controller;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import kye.my_board.domain.Member;
import kye.my_board.dto.JoinForm;
import kye.my_board.dto.LoginForm;
import kye.my_board.service.AuthService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;
import java.util.Optional;

@Controller
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;
    private final PasswordEncoder passwordEncoder;

    @GetMapping("/login")
    public String loginForm(Model model) {
        model.addAttribute("loginForm", new LoginForm());
        return "login";
    }

    @PostMapping("/login")
    public String login(@Valid LoginForm loginForm, BindingResult result, HttpSession session) {
        List<Member> findMember = authService.findMemberByEmail(loginForm.getEmail());
        // 이메일 가입 여부 검증
        if (findMember.isEmpty()) {
            result.rejectValue("email", "error.email", "가입되지 않은 이메일입니다.");
            return "login";
        }

        Member member = findMember.get(0);
        if (!passwordEncoder.matches(loginForm.getPassword(), member.getPassword())) {
            result.rejectValue("password", "error.password", "비밀번호가 올바르지 않습니다.");
            return "login";
        }

        session.setAttribute("loginMember", member);
        return "redirect:/";
    }

    @GetMapping("/join")
    public String joinForm(Model model) {
        model.addAttribute("joinForm", new JoinForm());
        return "join";
    }

    @PostMapping("/join")
    public String join(@Valid JoinForm form, BindingResult result) {
        // 중복 이메일 검증
        if (!authService.findMemberByEmail(form.getEmail()).isEmpty()) {
            result.rejectValue("email", "error.email", "사용중인 이메일입니다.");
        }

        // 중복 별명 검증
        if (!authService.findMemberByNickname(form.getNickname()).isEmpty()) {
            result.rejectValue("nickname", "error.nickname", "사용중인 별명입니다.");
        }

        // 비밀번호 일치 검증 -> 불일치일 경우 hasErrors에서 걸림
        if (!form.getPassword().equals(form.getConfirmPassword())) {
            result.rejectValue("confirmPassword", "error.confirmPassword", "비밀번호가 일치하지 않습니다.");
        }

        if (result.hasErrors()) {
            return "join";
        }

        Member member = new Member();
        member.setEmail(form.getEmail());
        member.setNickname(form.getNickname());
        member.setPassword(passwordEncoder.encode(form.getPassword()));
        authService.join(member);

        return "redirect:/login";
    }
}
