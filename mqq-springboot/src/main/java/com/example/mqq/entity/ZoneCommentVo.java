package com.example.mqq.entity;


import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

@Getter
@Setter
@Accessors(chain = true)
public class ZoneCommentVo {
    private ZoneComment zoneComment;
    private String observeName;
    private String replierName;

    public ZoneCommentVo() {
    }

    public ZoneCommentVo(ZoneComment zoneComment, String observeName, String replierName) {
        this.zoneComment = zoneComment;
        this.observeName = observeName;
        this.replierName = replierName;
    }
}
