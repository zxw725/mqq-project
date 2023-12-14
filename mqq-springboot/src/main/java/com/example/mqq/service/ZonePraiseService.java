package com.example.mqq.service;

import com.example.mqq.entity.User;
import com.example.mqq.entity.ZonePraise;
import com.baomidou.mybatisplus.extension.service.IService;
import com.example.mqq.entity.ZonePraiseVo;
import com.example.mqq.entity.ZoneVo;

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
public interface ZonePraiseService extends IService<ZonePraise> {

   Map<String, Object> praiserZone(ZonePraise zonePraise);

    List<User> getAllPraise(int id);

    Map<String, Object> cancelPraiseZone(ZonePraise zonePraise);
}
