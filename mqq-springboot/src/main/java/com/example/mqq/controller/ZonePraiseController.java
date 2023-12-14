package com.example.mqq.controller;


import com.example.mqq.entity.*;
import com.example.mqq.service.ZonePraiseService;
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
@RequestMapping("/zonePraise")
public class ZonePraiseController {
    @Autowired
    private ZonePraiseService zonePraiseService;
    @RequestMapping(value = "/praiseZone",method = RequestMethod.POST)
    public Result<?> praiseZone(@RequestBody ZonePraise zonePraise){
        Map<String, Object> infoMap = zonePraiseService.praiserZone(zonePraise);
        if (infoMap != null){
            return Result.success(infoMap);
        }else {
            return Result.error("添加失败");
        }
    }

    @RequestMapping(value = "/getAllPraise",method = RequestMethod.POST)
    public Result<?> getAllPraise(@RequestBody int id){
        List<User> zonePraiseVos = zonePraiseService.getAllPraise(id);
        if(zonePraiseVos!= null){
            return Result.success(zonePraiseVos);
        }else{
            return Result.error("没有该用户");
        }
    }

    @RequestMapping(value = "/cancelPraiseZone",method = RequestMethod.POST)
    public Result<?> cancelPraiseZone(@RequestBody ZonePraise zonePraise){
        Map<String, Object> infoMap = zonePraiseService.cancelPraiseZone(zonePraise);
        if (infoMap != null){
            return Result.success(infoMap);
        }else {
            return Result.error("添加失败");
        }
    }

}

