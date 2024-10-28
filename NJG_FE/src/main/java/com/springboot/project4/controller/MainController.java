package com.springboot.project4.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
    @GetMapping("/test")
    public String testpage() {
        return "plz";
    }

    @GetMapping("/")
    public String mainPage() {
        return "main"; // 메인 페이지
    }

    @GetMapping("/login")
    public String showLoginPage() {
        return "login"; // 로그인 페이지
    }

    @GetMapping("/register")
    public String showRegisterPage() {
        return "register"; // 회원가입 페이지
    }

    @GetMapping("/list")
    public String listPage() {
        return "list"; // 회원가입 페이지
    }

    @GetMapping("/detail")
    public String detailPage() {
        return "detail"; // 회원가입 페이지
    }

    @GetMapping("/board_list")
    public String boardList() {return "board_list";}

    @GetMapping("/board_write")
    public String boardWrite() {
        return "board_write";
    }

    @GetMapping("/post_detail")
    public String boardDetail() {
        return "post_detail";
    }

    @GetMapping("/post_delete")
    public String boardDelete() {
        return "post_delete";
    }

    @GetMapping("/findId")
    public String findId() { return "find_id"; }

    @GetMapping("/findPw")
    public String findPw() { return "find_pw"; }

    @GetMapping("/mypage")
    public String myPage() { return "mypage"; }
}
