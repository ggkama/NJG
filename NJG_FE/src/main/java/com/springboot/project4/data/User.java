package com.springboot.project4.data;

import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.CreatedDate;

import javax.persistence.*;
import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@Table(name = "user_register")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idx;

    private String userId;

    private String userPwd;

    private String userName;

    private String userEmail;

    private String userPhone;

    private String addr;

    private String userGender;

    private String userBirth;

    @CreatedDate
    @Column(updatable = false)
    private LocalDateTime createdAt;
}
