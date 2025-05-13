package kr.co.movmov.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("Inquiry")
public class Inquiry {
    private int InquiryId;
    private User userId;
    private Category categoryId;
    private String title;
    private String content;
    private Date createdDate;
    private Date answerDate;
    private int status;
    private String userName;
    private String userPhone;
    private String userEmail;
}