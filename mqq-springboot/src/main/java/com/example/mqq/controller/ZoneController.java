package com.example.mqq.controller;


import com.example.mqq.entity.User;
import com.example.mqq.entity.Zone;
import com.example.mqq.entity.ZoneVo;
import com.example.mqq.service.UserService;
import com.example.mqq.service.ZoneService;
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
@RequestMapping("/zone")
public class ZoneController {
    @Autowired
    private ZoneService zoneService;
    @RequestMapping(value = "/addZone",method = RequestMethod.POST)
    public Result<?> addUserInfo(@RequestBody Zone zoneDetail){
        Map<String, Object> infoMap = zoneService.addZone(zoneDetail);
        if (infoMap != null){
            return Result.success(infoMap);
        }else {
            return Result.error("添加失败");
        }
    }

    @RequestMapping(value = "/getAllZones",method = RequestMethod.POST)
    public Result<?> getAllZones(@RequestBody int id){
        List<ZoneVo> zone = zoneService.getAllZones(id);
        if(zone!= null){
            return Result.success(zone);
        }else{
            return Result.error("没有该用户");
        }
    }
}

