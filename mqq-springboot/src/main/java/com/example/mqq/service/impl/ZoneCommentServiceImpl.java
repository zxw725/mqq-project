package com.example.mqq.service.impl;

import com.example.mqq.entity.*;
import com.example.mqq.mapper.UserMapper;
import com.example.mqq.mapper.ZoneCommentMapper;
import com.example.mqq.service.ZoneCommentService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.yulichang.toolkit.JoinWrappers;
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
public class ZoneCommentServiceImpl extends ServiceImpl<ZoneCommentMapper, ZoneComment> implements ZoneCommentService {
    @Autowired
    private ZoneCommentMapper zoneCommentMapper;
    @Autowired
    private UserMapper userMapper;
    @Override
    public Map<String, Object> commentZone(ZoneComment zoneComment){
        int insert = zoneCommentMapper.insert(zoneComment);
        Map<String, Object> infoMap = new HashMap<>();
        if (insert >= 1) {
            infoMap.put("zoneComment", zoneComment);
            return infoMap;
        } else {
            return null;
        }
    }
    @Override
    public List<ZoneCommentVo> getAllComment(int id) {
        val wrapper1 = JoinWrappers.lambda(ZoneComment.class)
                .selectAll(ZoneComment.class)
                .eq(ZoneComment::getZoneId,id);
        List<ZoneComment> zoneComment = zoneCommentMapper.selectList(wrapper1);
        List<ZoneCommentVo> zoneComments=new ArrayList<>();
        System.out.println(id);
        for(ZoneComment zoneComment1:zoneComment){

            val wrapper2 = JoinWrappers.lambda(User.class)
                    .select(User::getUsername)
                    .eq(User::getId,zoneComment1.getObserverId());
            val wrapper3 = JoinWrappers.lambda(User.class)
                    .select(User::getUsername)
                    .eq(User::getId,zoneComment1.getReplierId());
            User observer = userMapper.selectOne(wrapper2);
            User replier = userMapper.selectOne(wrapper3);

            System.out.println(replier);
            if(replier!=null){
                ZoneCommentVo zoneCommentVo2 = new ZoneCommentVo(zoneComment1,observer.getUsername(),replier.getUsername());
                zoneComments.add(zoneCommentVo2);
            }else{
                ZoneCommentVo zoneCommentVo2 = new ZoneCommentVo(zoneComment1,observer.getUsername(),"");
                zoneComments.add(zoneCommentVo2);
            }

        }

//        List<ZoneCommentVo> zoneComments = userMapper.selectList(wrapper1);

//        Collections.sort(zoneVos, Comparator.comparing(zoneVos::getTime));
//        Collections.sort(zoneVos, Comparator.comparing(zoneVos::getTime));
        // 打印排序后的结果
//        System.out.println(Collections.toString(zoneVos));
        if (zoneComments != null) {
            return zoneComments;
        } else {
            return null;
        }
    }
}
