package com.example.mqq.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.time.LocalDateTime;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

/**
 * <p>
 * 
 * </p>
 *
 * @author zxw
 * @since 2023年11月20日
 */
@Getter
@Setter
@Accessors(chain = true)
@TableName("zone_comment")
public class ZoneComment implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "zone_id", type = IdType.AUTO)
    private Integer zoneId;

    @TableField("observer_id")
    private Integer observerId;

    @TableField("replier_id")
    private Integer replierId;

    @TableField("created_at")
    private LocalDateTime createdAt;

    @TableField("updated_at")
    private LocalDateTime updatedAt;


}
