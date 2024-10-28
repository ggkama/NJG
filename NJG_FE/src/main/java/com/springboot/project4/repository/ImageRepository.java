package com.springboot.project4.repository;

import com.springboot.project4.data.Image;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ImageRepository extends JpaRepository<Image, Long> {

}