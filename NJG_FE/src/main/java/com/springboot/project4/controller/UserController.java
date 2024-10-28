package com.springboot.project4.controller;

import com.springboot.project4.data.User;
import com.springboot.project4.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.util.Optional;

@Controller
public class UserController {

    @Autowired
    private UserRepository userRepository; // UserRepository는 MariaDB에 접근하여 데이터를 저장하기 위한 인터페이스입니다.

    @PostMapping("/registerConfirm")
    public String registerUser(@RequestParam String userId, @RequestParam String userPwd, @RequestParam String userPwdCheck,
                               @RequestParam String userName, @RequestParam String userEmail, @RequestParam String userPhone,
//                               @RequestParam String addNum, @RequestParam String userAdd, @RequestParam String userAddDetail,
                               @RequestParam String userGender, @RequestParam String userYear,
                               @RequestParam String userMonth, @RequestParam String userDay) {
        User user = new User();
        user.setUserId(userId);
        user.setUserPwd(userPwd);
        user.setUserName(userName);
        user.setUserEmail(userEmail);
        user.setUserPhone(userPhone);
//        user.setAddr(addr);
        user.setUserGender(userGender);
        user.setUserBirth(userYear + "-" + userMonth + "-" + userDay);
        user.setCreatedAt(LocalDateTime.now());
        // userRepository를 사용하여 사용자 정보 저장
        userRepository.save(user);
        System.out.println(userMonth);

        return "redirect:/";
    }

    @PostMapping("/loginConfirm")
    public String loginUser(@RequestParam String userId, @RequestParam String userPwd, HttpSession session, HttpServletResponse response) throws IOException {
        Optional<User> userOptional = userRepository.findByUserId(userId);

        if (userOptional.isPresent()) {
            User user = userOptional.get();
            if (user.getUserPwd().equals(userPwd)) {
                session.setAttribute("loggedInUser", user);
                // 비밀번호가 일치하면 로그인 성공
                return "redirect:/";
            } else {
                response.setContentType("text/html;charset=UTF-8");
                PrintWriter out = response.getWriter();
                out.println("<script>alert('아이디 또는 비밀번호가 일치하지 않습니다.'); location.href='/login';</script>");
                out.flush();
                // 비밀번호가 일치하지 않으면 로그인 실패
                //return "redirect:/login?error=incorrectPassword";
                return "redirect:/login";
            }
        } else {
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('아이디 또는 비밀번호가 일치하지 않습니다.'); location.href='/login';</script>");
            out.flush();
            // 사용자가 존재하지 않으면 로그인 실패
            //return "redirect:/login?error=nonexistentAccount";
            return "redirect:/login";
        }
    }

    @GetMapping("/logout_do")
    public String logout(HttpSession session) {
        // 세션 무효화
        session.invalidate();

        // 로그아웃 후 리다이렉트할 경로를 지정해주세요.
        return "redirect:/";
    }

    @PostMapping("/findId")
    public String findId(@RequestParam String userName, @RequestParam String userPhone) {
        Optional<User> userOptional = userRepository.findByUserName(userName);
        if(userOptional.isPresent()){
            User user = userOptional.get();
            if(user.getUserPhone().equals(userPhone)){
                System.out.println(user.getUserId() + " : " + user.getUserPwd());
            }
        }
        return "redirect:/login";
    }
//    @GetMapping("/test")
//    @ResponseBody
//    public String getUserRegisterData() {
//        Optional<User> userOptional = userRepository.findById(1L);
//
//        if (userOptional.isPresent()) {
//            User user = userOptional.get();
//            System.out.println("ID: " + user.getId());
//            System.out.println("Username: " + user.getPwd());
//            System.out.println("Email: " + user.getEmail());
//            // 필요한 다른 필드들을 출력하거나 처리할 수 있습니다.
//        } else {
//            System.out.println("해당 ID의 사용자를 찾을 수 없습니다.");
//        }
//        return "main";
//    }
}