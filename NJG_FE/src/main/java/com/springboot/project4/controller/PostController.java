package com.springboot.project4.controller;

import com.springboot.project4.data.Post;
import com.springboot.project4.repository.PostRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDateTime;
import java.util.List;

@Controller
public class PostController {
    @Autowired
    private PostRepository postRepository;

    @PostMapping("/post")
    public String posting(@RequestParam String title, @RequestParam String userId, @RequestParam String content){
        Post post = new Post();
        post.setTitle(title);
        post.setUserId(userId);
        post.setContent(content);
        post.setCreatedAt(LocalDateTime.now());

        postRepository.save(post);

        return "redirect:/board_list";
    }

//    @GetMapping("/asdf")
//    public String index(Model model) {
//        List<Post> entities = postRepository.findAll();
//        model.addAttribute("entities", entities);
//        return "post_detail";
//    }
}
