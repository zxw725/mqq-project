package com.example.mqq.service;

import com.example.mqq.entity.User;
import com.example.mqq.entity.Zone;
import com.baomidou.mybatisplus.extension.service.IService;
import com.example.mqq.entity.ZoneVo;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author zxw
 * @since 2023年11月20日
 */
public interface ZoneService extends IService<Zone> {

    List<ZoneVo> getAllZones(int id);

    Map<String, Object> addZone(Zone zoneDetail);
}
