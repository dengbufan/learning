/*
 Navicat Premium Data Transfer

 Source Server         : test
 Source Server Type    : MySQL
 Source Server Version : 80022
 Source Host           : localhost:3306
 Source Schema         : mini_goods

 Target Server Type    : MySQL
 Target Server Version : 80022
 File Encoding         : 65001

 Date: 25/10/2021 15:49:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for brand
-- ----------------------------
DROP TABLE IF EXISTS `brand`;
CREATE TABLE `brand`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `website` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `worldRank` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of brand
-- ----------------------------
INSERT INTO `brand` VALUES (1, '华为', 'htttp://www.huawei.com', 1);
INSERT INTO `brand` VALUES (2, '小米', 'htttp://www.mi.com', 10);
INSERT INTO `brand` VALUES (3, '苹果', 'htttp://www.iphone.com', 5);
INSERT INTO `brand` VALUES (4, 'oppo', 'htttp://www.oppo.com', 15);
INSERT INTO `brand` VALUES (5, '京东', 'htttp://www.jd.com', 3);
INSERT INTO `brand` VALUES (6, 'google', 'htttp://www.google.com', 8);

SET FOREIGN_KEY_CHECKS = 1;
