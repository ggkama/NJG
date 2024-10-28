package com.springboot.project4.repository;

import com.springboot.project4.data.Post;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PostRepository extends JpaRepository<Post, Long> {

}
