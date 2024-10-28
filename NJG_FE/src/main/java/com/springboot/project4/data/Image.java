package com.springboot.project4.data;

import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.CreatedDate;

import javax.persistence.*;
import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@Table(name = "input_image")
public class Image {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

//    private String image_path;
    private byte[] image_path;
    @CreatedDate
    @Column(updatable = false)
    private LocalDateTime createdAt;
}