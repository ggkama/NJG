package com.springboot.project4.controller;

import java.io.*;
import java.time.LocalDateTime;

import com.springboot.project4.data.Image;
import com.springboot.project4.repository.ImageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class ImageController {
    @Autowired
    private ImageRepository imageRepository;

    @PostMapping("/upload")
    public String upload(@RequestParam("fileInput") MultipartFile file) throws IOException {
        if (!file.isEmpty()) {
            try (InputStream inputStream = file.getInputStream()) {
                Image image = new Image();
                byte[] data = inputStream.readAllBytes();
                image.setImage_path(data);
                image.setCreatedAt(LocalDateTime.now());
                imageRepository.save(image);
            } catch (IOException e) {
                // Handle exception
                e.printStackTrace();
                return "Error uploading image";
            }
        }
//      나의 아이피 입력
        return "redirect:http://192.168.219.100:8001/checks";
    }
}
