package com.example.mqq.service.impl;

import com.example.mqq.entity.User;
import com.example.mqq.entity.UserFriend;
import com.example.mqq.entity.Zone;
import com.example.mqq.entity.ZoneVo;
import com.example.mqq.mapper.UserFriendMapper;
import com.example.mqq.mapper.UserMapper;
import com.example.mqq.mapper.ZoneMapper;
import com.example.mqq.service.ZoneService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.yulichang.toolkit.JoinWrappers;
import lombok.val;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author zxw
 * @since 2023年11月20日
 */
@Service
public class ZoneServiceImpl extends ServiceImpl<ZoneMapper, Zone> implements ZoneService {
    @Autowired
    private ZoneMapper zoneMapper;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private UserFriendMapper userFriendMapper;

    @Override
    public List<ZoneVo> getAllZones(int id) {
        val wrapper1 = JoinWrappers.lambda(User.class)
                .selectAll(User.class)
                .leftJoin(UserFriend.class, UserFriend::getFid, User::getId)
                .eq(UserFriend::getUid, id);
        System.out.println(wrapper1);
        List<User> users = userMapper.selectList(wrapper1);
        List<ZoneVo> zoneVos = new ArrayList<>();
        List<Integer> ids = new ArrayList<>();
        ids.add(id);
        val wrapper2 = JoinWrappers.lambda(User.class)
                .selectAll(User.class)
                .eq(User::getId, id);
        User user = userMapper.selectOne(wrapper2);
        val wrapper3 = JoinWrappers.lambda(Zone.class)
                .selectAll(Zone.class)
                .select(User::getUsername)
                .leftJoin(User.class, User::getId, Zone::getPublisherId)
                .in(Zone::getPublisherId, user.getId());
        List<Zone> zone1 = zoneMapper.selectList(wrapper3);
        for (Zone zone : zone1) {
            ZoneVo zoneVo1 = new ZoneVo(user.getUsername(), user.getUrl(), zone,zone.getCreatedAt());
            zoneVos.add(zoneVo1);
        }


        for (User record : users) {
            ids.add(record.getId());
            val wrapper = JoinWrappers.lambda(Zone.class)
                    .selectAll(Zone.class)
                    .select(User::getUsername)
                    .leftJoin(User.class, User::getId, Zone::getPublisherId)
                    .in(Zone::getPublisherId, record.getId());
            List<Zone> zone2 = zoneMapper.selectList(wrapper);
            for (Zone zone : zone2) {
                ZoneVo zoneVo2 = new ZoneVo(record.getUsername(), record.getUrl(), zone,zone.getCreatedAt());
                zoneVos.add(zoneVo2);
            }

        }
//        Collections.sort(zoneVos, Comparator.comparing(zoneVos::getTime));
//        Collections.sort(zoneVos, Comparator.comparing(zoneVos::getTime));
        // 打印排序后的结果
//        System.out.println(Collections.toString(zoneVos));
        if (zoneVos != null) {
            return zoneVos;
        } else {
            return null;
        }
    }

    @Override
    public Map<String, Object> addZone(Zone zoneDetail) {
        int insert = zoneMapper.insert(zoneDetail);
        Map<String, Object> infoMap = new HashMap<>();
        if (insert >= 1) {
            infoMap.put("zone", zoneDetail);
            return infoMap;
        } else {
            return null;
        }
    }
}
