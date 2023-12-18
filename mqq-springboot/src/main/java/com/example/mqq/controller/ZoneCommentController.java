package com.example.mqq.controller;


import com.example.mqq.entity.User;
import com.example.mqq.entity.ZoneComment;
import com.example.mqq.entity.ZoneCommentVo;
import com.example.mqq.entity.ZonePraise;
import com.example.mqq.service.ZoneCommentService;
import com.example.mqq.utils.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author zxw
 * @since 2023年11月20日
 */
@RestController
@RequestMapping("/zoneComment")
public class ZoneCommentController {
    @Autowired
    private ZoneCommentService zoneCommentService;
    @RequestMapping(value = "/commentZone",method = RequestMethod.POST)
    public Result<?> commentZone(@RequestBody ZoneComment zoneComment){
        Map<String, Object> infoMap = zoneCommentService.commentZone(zoneComment);
        if (infoMap != null){
            return Result.success(infoMap);
        }else {
            return Result.error("添加失败");
        }
    }
    @RequestMapping(value = "/getAllComment",method = RequestMethod.POST)
    public Result<?> getAllComment(@RequestBody int id){
        List<ZoneCommentVo> zonePraiseVos = zoneCommentService.getAllComment(id);
        if(zonePraiseVos!= null){
            return Result.success(zonePraiseVos);
        }else{
            return Result.error("没有该用户");
        }
    }

}

