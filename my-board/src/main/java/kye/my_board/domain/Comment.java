package kye.my_board.domain;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.Date;

@Data
public class Comment {
    private Long id;
    private Long postId;
    private Long authorId;
    private String authorNickname;
    private String content;
    private LocalDateTime createdAt;
    private Date createdAtDate;
}
