/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80030
 Source Host           : localhost:3306
 Source Schema         : mqq

 Target Server Type    : MySQL
 Target Server Version : 80030
 File Encoding         : 65001

 Date: 11/12/2023 13:35:07
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `menu_id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(0) NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int(0) NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '路由参数',
  `is_frame` int(0) NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int(0) NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menu
-- ----------------------------

-- ----------------------------
-- Table structure for menu_role
-- ----------------------------
DROP TABLE IF EXISTS `menu_role`;
CREATE TABLE `menu_role`  (
  `menu_id` int(0) NULL DEFAULT NULL,
  `role_id` int(0) NULL DEFAULT NULL,
  `created_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `updated_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menu_role
-- ----------------------------

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
  `uid` int(0) NULL DEFAULT NULL,
  `fid` int(0) NULL DEFAULT NULL,
  `message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `updated_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  `time` datetime(0) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES (100001, 100002, '你好', '2023-10-02 21:44:00', '2023-10-02 21:44:00', '2023-10-02 13:44:00');
INSERT INTO `message` VALUES (100002, 100001, '你好', '2023-10-02 21:44:04', '2023-10-02 21:44:04', '2023-10-02 13:44:04');
INSERT INTO `message` VALUES (100001, 100002, '在干什么', '2023-10-02 21:44:11', '2023-10-02 21:44:11', '2023-10-02 13:44:11');
INSERT INTO `message` VALUES (100002, 100001, '在打游戏', '2023-10-02 21:44:19', '2023-10-02 21:44:19', '2023-10-02 13:44:19');
INSERT INTO `message` VALUES (100001, 100002, '饭吃了吗', '2023-10-02 21:44:26', '2023-10-02 21:44:26', '2023-10-02 13:44:26');
INSERT INTO `message` VALUES (100002, 100001, '等会吃', '2023-10-02 21:44:33', '2023-10-02 21:44:33', '2023-10-02 13:44:33');
INSERT INTO `message` VALUES (100002, 100001, '你呢', '2023-10-02 21:44:37', '2023-10-02 21:44:37', '2023-10-02 13:44:37');
INSERT INTO `message` VALUES (100001, 100002, '我刚吃了', '2023-10-02 21:44:45', '2023-10-02 21:44:45', '2023-10-02 13:44:45');
INSERT INTO `message` VALUES (100001, 100002, '123\n12333111111', '2023-10-05 15:04:58', '2023-11-24 16:46:45', '2023-10-05 07:04:58');
INSERT INTO `message` VALUES (100001, 100002, '123\n12333\n111111', '2023-11-24 16:39:09', '2023-11-24 16:39:09', '2023-11-24 08:39:09');
INSERT INTO `message` VALUES (100002, 100001, '111', '2023-12-05 18:51:35', '2023-12-05 18:51:35', '2023-12-05 10:51:35');
INSERT INTO `message` VALUES (100002, 100001, '222', '2023-12-05 19:39:41', '2023-12-05 19:39:41', '2023-12-05 11:39:41');
INSERT INTO `message` VALUES (100001, 100002, '222', '2023-12-05 19:40:17', '2023-12-05 19:40:17', '2023-12-05 11:40:17');
INSERT INTO `message` VALUES (100002, 100001, '333', '2023-12-05 19:40:25', '2023-12-05 19:40:25', '2023-12-05 11:40:25');
INSERT INTO `message` VALUES (100002, 100001, '333', '2023-12-05 19:40:56', '2023-12-05 19:40:56', '2023-12-05 11:40:56');
INSERT INTO `message` VALUES (100002, 100001, '444', '2023-12-05 19:41:05', '2023-12-05 19:41:05', '2023-12-05 11:41:04');
INSERT INTO `message` VALUES (100002, 100001, '6666', '2023-12-05 19:41:14', '2023-12-05 19:41:14', '2023-12-05 11:41:14');
INSERT INTO `message` VALUES (100002, 100001, '7777', '2023-12-05 19:44:09', '2023-12-05 19:44:09', '2023-12-05 11:44:09');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `updated_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `phone` bigint(0) NULL DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `age` int(0) NULL DEFAULT NULL,
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `updated_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100005 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '1', 'e10adc3949ba59abbe56e057f20f883e', NULL, '1', NULL, NULL, NULL, '2023-07-21 10:39:15', '2023-09-09 08:08:36');
INSERT INTO `user` VALUES (2, NULL, '123456', NULL, NULL, NULL, NULL, NULL, '2023-07-21 11:10:53', '2023-07-21 11:10:53');
INSERT INTO `user` VALUES (3, NULL, '123456', NULL, '3', NULL, NULL, NULL, '2023-07-21 11:11:16', '2023-07-21 11:11:16');
INSERT INTO `user` VALUES (20, NULL, '123456', NULL, '111111', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user` VALUES (21, NULL, '123456', NULL, '111111', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user` VALUES (22, NULL, '123456', NULL, '111111', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user` VALUES (23, '', '123456', NULL, '1111111', NULL, NULL, NULL, NULL, '2023-09-09 08:08:28');
INSERT INTO `user` VALUES (24, '100001', 'e10adc3949ba59abbe56e057f20f883e', NULL, '100001', '/upload/3bb3d6bf-3c9f-44d3-9ac6-e38a1d1062a8.jpg', NULL, NULL, '2023-09-09 08:08:44', '2023-09-14 12:36:12');
INSERT INTO `user` VALUES (100001, '嘿嘿', 'e10adc3949ba59abbe56e057f20f883e', NULL, '嘿嘿', '/static/images/1695011410411.jpg', NULL, NULL, '2023-09-16 10:26:53', '2023-09-18 18:27:13');
INSERT INTO `user` VALUES (100002, NULL, 'e10adc3949ba59abbe56e057f20f883e', NULL, '哈哈', '/static/images/1695033526395.jpg', NULL, NULL, '2023-09-18 18:38:59', '2023-09-18 18:39:05');
INSERT INTO `user` VALUES (100004, NULL, '123456', NULL, '123111', NULL, NULL, NULL, '2023-09-20 08:53:41', '2023-09-20 08:53:41');
INSERT INTO `user` VALUES (100005, '嘻嘻', 'e10adc3949ba59abbe56e057f20f883e', NULL, '嘻嘻', '/static/images/1695033526395.jpg', NULL, NULL, '2023-10-21 18:11:58', '2023-10-21 18:12:27');

-- ----------------------------
-- Table structure for user_friend
-- ----------------------------
DROP TABLE IF EXISTS `user_friend`;
CREATE TABLE `user_friend`  (
  `uid` int(0) NOT NULL,
  `fid` int(0) NOT NULL,
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_friend
-- ----------------------------
INSERT INTO `user_friend` VALUES (100001, 100002, '哈哈');
INSERT INTO `user_friend` VALUES (100002, 100001, '嘿嘿');
INSERT INTO `user_friend` VALUES (100001, 100005, '嘻嘻');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `rid` int(0) NULL DEFAULT NULL,
  `uid` int(0) NULL DEFAULT NULL,
  `created_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `updated_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_role
-- ----------------------------

-- ----------------------------
-- Table structure for zone
-- ----------------------------
DROP TABLE IF EXISTS `zone`;
CREATE TABLE `zone`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `publisher_id` int(0) NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `pictures` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `created_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `updated_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of zone
-- ----------------------------
INSERT INTO `zone` VALUES (3, 100001, '123456', NULL, '2023-11-21 11:11:47', '2023-11-21 11:11:47');
INSERT INTO `zone` VALUES (4, 100002, '12344', NULL, '2023-11-23 09:17:27', '2023-11-23 09:17:32');
INSERT INTO `zone` VALUES (23, 100001, '111', NULL, '2023-12-04 19:40:38', '2023-12-04 19:48:49');
INSERT INTO `zone` VALUES (24, 100002, '1111', NULL, '2023-12-04 19:57:24', '2023-12-04 19:57:24');
INSERT INTO `zone` VALUES (26, 100005, '今天天气真好', NULL, '2023-12-04 21:06:35', '2023-12-04 21:06:35');
INSERT INTO `zone` VALUES (43, 100001, 'qwe', '[{\"url\":\"/static/images/1701754078830.jpg\",\"type\":\"image\",\"size\":\"heightFix\",\"width\":750,\"height\":252.7075812274368}]', '2023-12-05 13:27:59', '2023-12-05 13:27:59');
INSERT INTO `zone` VALUES (44, 100001, '1222', '[{\"url\":\"/static/images/1701754672995.jpg\",\"type\":\"image\",\"size\":\"heightFix\",\"width\":750,\"height\":252.7075812274368},{\"url\":\"/static/images/1701754705284.jpg\",\"type\":\"image\",\"size\":\"heightFix\",\"width\":750,\"height\":421.7948717948718},{\"url\":\"/static/images/1701754705302.jpg\",\"type\":\"image\",\"size\":\"heightFix\",\"width\":750,\"height\":421.7948717948718},{\"url\":\"/static/images/1701754705321.jpg\",\"type\":\"image\",\"size\":\"heightFix\",\"width\":750,\"height\":421.7948717948718}]', '2023-12-05 13:38:25', '2023-12-05 13:38:25');
INSERT INTO `zone` VALUES (45, 100001, '123', '[{\"url\":\"/static/images/1701757832934.jpg\",\"type\":\"image\",\"size\":\"heightFix\",\"width\":750,\"height\":421.7948717948718},{\"url\":\"/static/images/1701757832953.jpg\",\"type\":\"image\",\"size\":\"heightFix\",\"width\":750,\"height\":421.7948717948718},{\"url\":\"/static/images/1701757832970.jpg\",\"type\":\"image\",\"size\":\"heightFix\",\"width\":750,\"height\":421.7948717948718},{\"url\":\"/static/images/1701757832988.jpg\",\"type\":\"image\",\"size\":\"heightFix\",\"width\":750,\"height\":421.7948717948718}]', '2023-12-05 14:30:33', '2023-12-05 14:30:33');
INSERT INTO `zone` VALUES (46, 100001, '去232', '[{\"url\":\"/static/images/1701769205112.jpg\",\"type\":\"image\",\"size\":\"heightFix\",\"width\":750,\"height\":421.7948717948718},{\"url\":\"/static/images/1701769205130.jpg\",\"type\":\"image\",\"size\":\"heightFix\",\"width\":750,\"height\":421.7948717948718}]', '2023-12-05 17:40:05', '2023-12-05 17:40:05');
INSERT INTO `zone` VALUES (47, 100001, '12333', '[{\"url\":\"/static/images/1701780633880.jpg\",\"type\":\"image\",\"size\":\"heightFix\",\"width\":375,\"height\":210.8974358974359}]', '2023-12-05 20:50:34', '2023-12-05 20:50:34');
INSERT INTO `zone` VALUES (48, 100001, '111234', '[{\"url\":\"/static/images/1701780819008.jpg\",\"type\":\"image\",\"size\":\"heightFix\",\"width\":750,\"height\":252.7075812274368},{\"url\":\"/static/images/1701780836822.jpg\",\"type\":\"image\",\"size\":\"heightFix\",\"width\":750,\"height\":421.7948717948718}]', '2023-12-05 20:53:57', '2023-12-05 20:53:57');

-- ----------------------------
-- Table structure for zone_comment
-- ----------------------------
DROP TABLE IF EXISTS `zone_comment`;
CREATE TABLE `zone_comment`  (
  `zone_id` int(0) NOT NULL,
  `observer_id` int(0) NULL DEFAULT NULL,
  `replier_id` int(0) NULL DEFAULT NULL,
  `created_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `updated_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`zone_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of zone_comment
-- ----------------------------

-- ----------------------------
-- Table structure for zone_praise
-- ----------------------------
DROP TABLE IF EXISTS `zone_praise`;
CREATE TABLE `zone_praise`  (
  `zone_id` int(0) NOT NULL,
  `praiser_id` int(0) NULL DEFAULT NULL,
  `created_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `updated_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`zone_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of zone_praise
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
