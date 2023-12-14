package com.example.mqq.entity;

import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.time.LocalDateTime;

@Getter
@Setter
@Accessors(chain = true)
public class ZonePraiseVo implements Serializable {
    private String username;
    private String url;
    private ZonePraise zonePraise;
    //    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime time;



    public ZonePraiseVo() {
    }

    public ZonePraiseVo(String username, String url, ZonePraise zonePraise, LocalDateTime time) {
        this.username = username;
        this.url = url;
        this.zonePraise = zonePraise;
        this.time = time;
    }


}