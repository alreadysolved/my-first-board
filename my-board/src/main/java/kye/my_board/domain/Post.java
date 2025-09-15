package kye.my_board.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.Date;

@Getter
@Setter
public class Post {
    private Long id;
    private Long authorId;
    private String authorNickname;
    private String title;
    private String content;
    private LocalDateTime createdAt;
    private Date createdAtDate; // LocalDateTime -> Date 변환용(DB에는 X)
}
