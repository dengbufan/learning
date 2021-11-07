-- //1.基本创建
-- create database qianye;
-- drop database qianye;


-- //约束创建 设置编码格式和排序规则
-- CREATE DATABASE IF NOT EXISTS mini_goods;
-- DROP DATABASE IF EXISTS mini_goods;

-- CREATE DATABASE IF NOT EXISTS mini_goods DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

-- //修改字符集 和排序规则
-- ALTER DATABASE mini_goods CHARACTER SET=utf8 COLLATE=utf8_unicode_ci;
-- ALTER DATABASE mini_goods CHARACTER SET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
-- SHOW DATABASES;


-- //2.表操作 创建
-- USE mini_goods;
-- CREATE TABLE IF NOT EXISTS `goods_users` (
-- 	name VARCHAR(40)
-- );

-- CREATE TABLE IF NOT EXISTS `goods_users` (
-- 	id INT PRIMARY KEY AUTO_INCREMENT,
-- 	name VARCHAR(25) NOT NULL,
-- 	age INT DEFAULT 0,
-- 	phone VARCHAR(20) DEFAULT '' UNIQUE NOT NULL
-- );

-- CREATE TABLE IF NOT EXISTS `goods_list` (name VARCHAR(30),age INT,hieght DOUBLE);

-- //删除表
-- DROP TABLE IF EXISTS `goods_users`;
-- DROP TABLE IF EXISTS goods_list;
-- DROP TABLE IF EXISTS goods_users_copy,goods_users_copy_copy;


-- //复制一张表的结构创建一张新表
-- CREATE TABLE `goods_users_copy` LIKE `goods_users`; //拷贝的只是表的结构
-- CREATE TABLE `goods_users_copy_copy` LIKE `goods_users_copy`;

-- CREATE TABLE `users` LIKE `goods_users`;

-- CREATE TABLE `users1`  SELECT * FROM `goods_users`; //同时拷贝表的结构和内容
-- INSERT INTO `users` SELECT * FROM `goods_users` WHERE id=6; 拷贝内容
-- INSERT INTO `users` SELECT * FROM `goods_users` WHERE id!=6;
-- INSERT INTO table2 ( name , price ) SELECT name , price  FROM table1  WHERE id=5


 
-- //修改表名
-- ALTER TABLE `goods_users` RENAME `users`;
-- ALTER TABLE `users` RENAME `goods_users`;

-- //向表中添加字段
-- ALTER TABLE `goods_users` ADD `publishTime` DATETIME ;
-- ALTER TABLE `goods_users` ADD `updateTime` DATETIME;
-- ALTER TABLE `goods_users` ADD `sex` INT DEFAULT 0;
-- ALTER TABLE `goods_users` ADD `addr` VARCHAR(30); 

-- //删除一列数据
-- ALTER TABLE `goods_users` DROP `sex`; 

-- //修改列数据类型
-- ALTER TABLE `goods_users` MODIFY `addr` INT;
-- ALTER TABLE `goods_users` MODIFY `addr` VARCHAR(40);

-- //修改列名称
-- ALTER TABLE `goods_users` CHANGE `addr` `nickname` VARCHAR(25);


-- //插入数据
-- INSERT INTO `goods_users` (`id`,`name`,`age`,`phone`,`publishTime`,`updateTime`,`nickname`)  VALUES(4,"qinaye",26,"18XXXXXXX","2021-10-24","2021-10-24","fgdcyy");

-- INSERT INTO `goods_users`  VALUES(5,"qinaye",26,"18XXXXXX","2021-10-24","2021-10-24","fgdcyy");

#修改字段类型 时间自动插入
-- ALTER TABLE `goods_users` MODIFY `publishTime` TIMESTAMP DEFAULT CURRENT_TIMESTAMP; //自动插入当前时间
-- ALTER TABLE `goods_users` MODIFY  `updateTime` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP; //数据更新时自动插入当前时间


#删除数据
-- DELETE FROM `goods_users` WHERE id=4; 删除ID=4
-- DELETE FROM `goods_users`; 删除所有记录

-- INSERT INTO `goods_users` (name,age,phone) VALUES('qinaye',26,'123xxxxxxx');
-- INSERT INTO `goods_users` (name,age,phone) VALUES('qinaye0',26,'123xxxxxx1');
-- INSERT INTO `goods_users` (name,age,phone) VALUES('qinaye1',26,'123xxxxxx2');
-- INSERT INTO `goods_users` (name,age,phone) VALUES('qinaye2',26,'123xxxxxx3');
-- INSERT INTO `goods_users` (name,age,phone) VALUES('qinaye3',26,'123xxxxxx4');


#修改 更新数据
-- UPDATE `goods_users` SET `nickname`='FGDCYY';
-- UPDATE `goods_users` SET `nickname`='FGDCYY' WHERE NAME!='qianye';


-- //3.单表查询
-- CREATE TABLE IF NOT EXISTS `products` (
-- 	id INT PRIMARY KEY  AUTO_INCREMENT,
-- 	brand VARCHAR(20),
-- 	title VARCHAR(100) NOT NULL,
-- 	price DOUBLE NOT NULL,
-- 	score DECIMAL(2,1),
-- 	voteCnt INT,
-- 	url VARCHAR(100),
-- 	pid INT
-- );
-- CREATE TABLE `goods_products` SELECT * FROM `products`;


#查询所有
-- SELECT * FROM `products`;
#查询选中字段
-- SELECT brand,title,price ,url,pid FROM `products` where id>=100;
#取别名
-- SELECT brand as 品牌,title as 配置 , price as 价格 FROM `products` WHERE price>=4000;

#查询结果排序
#按照价格升序
-- SELECT brand,title,price,url FROM `products` where price>2000 && price<5000 ORDER BY price ASC; 
#按照价格升序
-- SELECT brand,title,price FROM `products` WHERE price BETWEEN 2000 AND 6000  ORDER BY price DESC;


#分页查询 LIMIT 查询的数据条数  OFFSET 偏移量 从哪个位置（索引）开始查询

-- SELECT * FROM `products` LIMIT 40 OFFSET 0;
-- SELECT * FROM `products` LIMIT 40 OFFSET 40;
-- SELECT * FROM `products` LIMIT 40 OFFSET 80;


#聚合函数  对查询到的结果进行处理  例如 平均 求和 最大 最小 统计个数 去除重复
-- SELECT COUNT(DISTINCT price) FROM `products` WHERE brand='vivo';
-- 
-- SELECT AVG(price) FROM `products` WHERE brand='vivo';
--  
-- SELECT MAX(price) FROM `products` WHERE brand='vivo';
-- 
-- SELECT MIN(price) FROM `products` WHERE brand='vivo';
-- 
-- SELECT SUM(price) FROM `products` WHERE brand='vivo';

#分组查询 按需求进行分类 并删选
-- SELECT brand,COUNT(*), SUM(price),ROUND(AVG(price),4),MAX(price),MIN(price) FROM `products` GROUP BY brand;

-- 
-- SELECT brand,COUNT(*),SUM(price),ROUND(AVG(price),2) AS avgPrice,SUM(price),MIN(price),ROUND(AVG(score),2) AS avgScore FROM `products` GROUP BY brand HAVING avgScore>6 && avgPrice>1000;
-- 


-- //4.多表查询


-- CREATE TABLE IF NOT EXISTS `brand` (
-- 	id INT PRIMARY KEY AUTO_INCREMENT,
-- 	name VARCHAR(20) NOT NULL,
-- 	website VARCHAR(100),
-- 	worldRank INT
-- );
-- INSERT INTO `brand` (name,website,worldRank) VALUES('华为','htttp://www.huawei.com',1);
-- INSERT INTO `brand` (name,website,worldRank) VALUES('小米','htttp://www.mi.com',10);
-- INSERT INTO `brand` (name,website,worldRank) VALUES('iPhone','htttp://www.iphone.com',5);
-- INSERT INTO `brand` (name,website,worldRank) VALUES('oppo','htttp://www.oppo.com',15);
-- INSERT INTO `brand` (name,website,worldRank) VALUES('京东','htttp://www.jd.com',3);
-- INSERT INTO `brand` (name,website,worldRank) VALUES('google','htttp://www.google.com',8);

#创建外键
-- ALTER TABLE `products` ADD brand_id INT;  //需要先添加一个字段 在设置为外键
-- ALTER TABLE `products` ADD FOREIGN key (brand_id) REFERENCES brand(id);


-- UPDATE `products` SET `brand_id`=1 WHERE `brand`='华为';
-- UPDATE `products` SET `brand_id`=2 WHERE `brand`='小米';
-- UPDATE `products` SET `brand_id`=3 WHERE `brand`='苹果';
-- UPDATE `products` SET `brand_id`=4 WHERE `brand`='oppo';


#外键存在时修改数据
-- UPDATE `brand` SET id=100 WHERE id=1; 
-- Cannot delete or update a parent row: a foreign key constraint fails (`mini_goods`.`products`, CONSTRAINT `products_ibfk_1` FOREIGN KEY (`brand_id`) REFERENCES `brand` (`id`))
-- 
-- SHOW CREATE TABLE `products`; 
-- 如果要使得修改数据时外键关联的部分一起更新 需要设置外键 更新和删除时的状态值
 
 
 
 
-- //5.  sql joins 操作 
#多表查询 的默认值
-- SELECT * FROM `products`,`brand`; 此时会得到108*8（笛卡尔乘积） 条记录
-- SELECT  * FROM `products`,`brand` WHERE `products`.brand_id=`brand`.id;

#左连接
-- SELECT * FROM `products` LEFT JOIN `brand` ON `products`.brand_id=`brand`.id;
-- SELECT * FROM `products` LEFT JOIN `brand` ON `products`.brand_id=`brand`.id WHERE brand.id IS NOT NULL;
-- SELECT * FROM `products` LEFT JOIN `brand` ON `products`.brand_id=`brand`.id WHERE brand.id IS  NULL;

#右连接
-- SELECT * FROM `products` RIGHT JOIN `brand` ON `products`.brand_id=`brand`.id;
-- SELECT * FROM `products` RIGHT JOIN `brand` ON `products`.brand_id=`brand`.id WHERE products.id IS NULL;
-- SELECT * FROM `products` RIGHT JOIN `brand` ON `products`.brand_id=`brand`.id WHERE products.id IS NOT NULL;

#内连接 
-- SELECT * FROM `products` INNER JOIN `brand` ON `products`.brand_id=`brand`.id;


#全连接 相当于左连接和右连接的结合
-- (SELECT * FROM `products` LEFT JOIN `brand` ON `products`.brand_id=`brand`.id) UNION (SELECT * FROM `products` RIGHT JOIN `brand` ON `products`.brand_id=`brand`.id);

-- (SELECT * FROM `products` LEFT JOIN `brand` ON `products`.brand_id=`brand`.id WHERE brand.id IS NULL) UNION (SELECT * FROM `products` RIGHT JOIN `brand` ON `products`.brand_id=`brand`.id WHERE products.id IS NULL);


-- //6.多表操作 多对多的关系
#准备数据
-- CREATE TABLE IF NOT EXISTS `students` (
-- 	id INT PRIMARY KEY AUTO_INCREMENT,
-- 	name VARCHAR(20) NOT NULL,
-- 	age INT
-- );
-- 
-- CREATE TABLE IF NOT EXISTS `courses` (
-- 	id INT PRIMARY KEY AUTO_INCREMENT,
-- 	name VARCHAR(20) NOT NULL,
-- 	price DOUBLE NOT NULL
-- );


-- INSERT INTO `students` (name,age) VALUES('why',18);
-- INSERT INTO `students` (name,age) VALUES('tom',22);
-- INSERT INTO `students` (name,age) VALUES('lilei',25);
-- INSERT INTO `students` (name,age) VALUES('lucy',16);
-- INSERT INTO `students` (name,age) VALUES('lily',20);
-- 
-- INSERT INTO `courses` (name,price) VALUES('英语',100);
-- INSERT INTO `courses` (name,price) VALUES('语文',666);
-- INSERT INTO `courses` (name,price) VALUES('数学',888);
-- INSERT INTO `courses` (name,price) VALUES('历史',80);

#设计关系表 
-- CREATE TABLE IF NOT EXISTS `students_select_courses` (
-- 	id INT PRIMARY KEY AUTO_INCREMENT,
-- 	student_id INT NOT NULL,
-- 	course_id INT NOT NULL,
-- 	FOREIGN KEY (student_id) REFERENCES students(id) ON UPDATE CASCADE,
-- 	FOREIGN KEY (course_id) REFERENCES courses(id) ON  UPDATE CASCADE
-- );


# 准备学生选课数据
-- INSERT INTO `students_select_courses` (student_id,course_id) VALUES(1,1);
-- INSERT INTO `students_select_courses` (student_id,course_id) VALUES(1,3);
-- INSERT INTO `students_select_courses` (student_id,course_id) VALUES(3,2);
-- INSERT INTO `students_select_courses` (student_id,course_id) VALUES(3,3);
-- INSERT INTO `students_select_courses` (student_id,course_id) VALUES(3,4);

#查询所有学生选的所有课程(内连接)
 
-- SELECT students.id ,students.name,courses.id,courses.name,courses.price 
-- FROM `students` 
-- JOIN `students_select_courses` ON students.id=students_select_courses.student_id 
-- JOIN `courses` ON students_select_courses.course_id=courses.id;
-- 


#查询所有的学生的选课情况（左连接）
-- SELECT students.id ,students.name,courses.id,courses.name,courses.price 
-- FROM `students` 
-- LEFT JOIN `students_select_courses` ON students.id=students_select_courses.student_id 
-- LEFT JOIN `courses` ON students_select_courses.course_id=courses.id;
-- 

#查询某个学生选了哪些课程
-- SELECT students.id ,students.name,courses.id,courses.name,courses.price 
-- FROM `students` 
-- LEFT JOIN `students_select_courses` ON students.id=students_select_courses.student_id 
-- LEFT JOIN `courses` ON students_select_courses.course_id=courses.id WHERE students.id=5;
-- 
-- 
-- SELECT students.id ,students.name,courses.id,courses.name,courses.price 
-- FROM `students` 
-- JOIN `students_select_courses` ON students.id=students_select_courses.student_id 
-- JOIN `courses` ON students_select_courses.course_id=courses.id WHERE students.id=5;
-- 

#查询哪些学生没有选课
-- SELECT students.id ,students.name,courses.id,courses.name,courses.price 
-- FROM `students` 
-- LEFT JOIN `students_select_courses` ON students.id=students_select_courses.student_id 
-- LEFT JOIN `courses` ON students_select_courses.course_id=courses.id WHERE courses.id IS NULL;



#查询哪些课程没有被选
-- INSERT INTO `courses` (name,price) VALUES('政治',66);
-- SELECT students.id ,students.name,courses.id,courses.name,courses.price 
-- FROM `students` 
-- RIGHT JOIN `students_select_courses` ON students.id=students_select_courses.student_id 
-- RIGHT JOIN `courses` ON students_select_courses.course_id=courses.id WHERE students.id IS NULL;


-- DELETE FROM `courses` WHERE name='政治';


-- //7.将数据转成对象 JSON_OBJECT()
-- SELECT products.id AS id,products.title AS title,products.price AS price,products.score AS score,
-- JSON_OBJECT('id',brand.id,'name',brand.name,'rank',brand.worldRank,'website',brand.website) as brand
-- FROM `products`
-- LEFT JOIN `brand` ON products.brand_id=brand.id;
-- 
-- SELECT products.id AS id,products.title AS title,products.price AS price,products.score AS score,
-- JSON_OBJECT('id',brand.id,'name',brand.name,'rank',brand.worldRank,'website',brand.website) as brand
-- FROM `products`
-- LEFT JOIN `brand` ON products.brand_id=brand.id WHERE brand.id IS NOT NULL ORDER BY id DESC;


#多对多转换成数组 JSON_ARRAYAGG

	SELECT students.id,students.name,students.age,
	JSON_ARRAYAGG(JSON_OBJECT('id',courses.id,'name',courses.name)) as courses
FROM `students`
LEFT JOIN `students_select_courses` ON students.id=students_select_courses.student_id
LEFT JOIN `courses` ON students_select_courses.course_id=courses.id  GROUP BY id;

-- 	SELECT students.id,students.name,students.age,
-- 	JSON_ARRAYAGG(JSON_OBJECT('id',courses.id,'name',courses.name)) as courses
-- FROM `students`
-- LEFT JOIN `students_select_courses` ON students.id=students_select_courses.student_id
-- LEFT JOIN `courses` ON students_select_courses.course_id=courses.id WHERE courses.id IS NOT NULL GROUP BY id;
-- 








