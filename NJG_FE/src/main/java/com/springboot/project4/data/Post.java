package com.springboot.project4.data;

import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.CreatedDate;

import javax.persistence.*;
import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@Table(name = "post_list")
public class Post {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idx;

    private String title;

    private String content;

    private String userId;

    @CreatedDate
    @Column(updatable = false)
    private LocalDateTime createdAt;

    private byte[] image;
}
