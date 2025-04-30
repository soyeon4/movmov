package kr.co.movmov.vo;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Alias("User")
@Getter
@Setter
@NoArgsConstructor
public class User {    

   private String id;
   private String name;
    private String password;
    private String nickname;
    private String email;
    private Date createdDate;
    private String region;
    private String profileImage;
    private int point;
    private String isDeleted;
    private String isProfilePublic;
    private Address address;
}

