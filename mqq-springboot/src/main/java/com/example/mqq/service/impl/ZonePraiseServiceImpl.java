package com.example.mqq.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.mqq.entity.*;
import com.example.mqq.mapper.UserMapper;
import com.example.mqq.mapper.ZonePraiseMapper;
import com.example.mqq.service.ZonePraiseService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.yulichang.toolkit.JoinWrappers;
import com.github.yulichang.wrapper.MPJLambdaWrapper;
import lombok.val;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author zxw
 * @since 2023年11月20日
 */
@Service
public class ZonePraiseServiceImpl extends ServiceImpl<ZonePraiseMapper, ZonePraise> implements ZonePraiseService {
    @Autowired
    private ZonePraiseMapper zonePraiseMapper;

    @Autowired
    private UserMapper userMapper;
    @Override
    public Map<String, Object> praiserZone(ZonePraise zonePraise) {
        int insert = zonePraiseMapper.insert(zonePraise);
        Map<String, Object> infoMap = new HashMap<>();
        if (insert >= 1) {
            infoMap.put("zonePraise", zonePraise);
            return infoMap;
        } else {
            return null;
        }
    }

    public Map<String, Object> cancelPraiseZone(ZonePraise zonePraise){
        QueryWrapper<ZonePraise> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("zone_id", zonePraise.getZoneId()).eq("praiser_id", zonePraise.getPraiserId());
//        boolean success = zonePraiseMapper.deleteByMap(condition);
//        boolean success = zonePraiseMapper.deleteByMap(zonePraise);
        int insert = zonePraiseMapper.delete(queryWrapper);
        Map<String, Object> infoMap = new HashMap<>();
        if (insert >= 1) {
            infoMap.put("zonePraise", zonePraise);
            return infoMap;
        } else {
            return null;
        }
    }

    @Override
    public List<User> getAllPraise(int id) {


        val wrapper1 = JoinWrappers.lambda(User.class)
                .selectAll(User.class)
                .leftJoin(ZonePraise.class,ZonePraise::getPraiserId,User::getId)
                .leftJoin(Zone.class,Zone::getId,ZonePraise::getZoneId)
                .eq(Zone::getId, id);

        List<User> users = userMapper.selectList(wrapper1);

//        Collections.sort(zoneVos, Comparator.comparing(zoneVos::getTime));
//        Collections.sort(zoneVos, Comparator.comparing(zoneVos::getTime));
        // 打印排序后的结果
//        System.out.println(Collections.toString(zoneVos));
        if (users != null) {
            return users;
        } else {
            return null;
        }
    }

}
