package com.example.mqq.service;

import com.example.mqq.entity.User;
import com.example.mqq.entity.ZoneComment;
import com.baomidou.mybatisplus.extension.service.IService;
import com.example.mqq.entity.ZoneCommentVo;
import com.example.mqq.entity.ZonePraise;

import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author zxw
 * @since 2023年11月20日
 */
public interface ZoneCommentService extends IService<ZoneComment> {

    Map<String, Object> commentZone(ZoneComment zoneComment);

    List<ZoneCommentVo> getAllComment(int id);
}
