-- 创建表结构
DROP TABLE IF EXISTS `courses_students`;
DROP TABLE IF EXISTS `course_application`;
DROP TABLE IF EXISTS `course`;
DROP TABLE IF EXISTS `teacher`;
DROP TABLE IF EXISTS `student`;
DROP TABLE IF EXISTS `department`;
DROP TABLE IF EXISTS `place`;
DROP TABLE IF EXISTS `operation`;
DROP TABLE IF EXISTS `course_status`;
DROP TABLE IF EXISTS `course_examination`;
DROP TABLE IF EXISTS `course_switch`;
DROP TABLE IF EXISTS `administrator`;

-- 管理员表
CREATE TABLE `administrator` (
                                 `administrator_id` int AUTO_INCREMENT PRIMARY KEY,
                                 `name` varchar(15) NULL COMMENT '姓名',
                                 `account` varchar(45) NULL COMMENT '账号',
                                 `password` varchar(45) NULL COMMENT '密码'
) COMMENT '管理员（教务处）';

-- 课程审批状态表
CREATE TABLE `course_examination` (
                                      `course_examination_id` int AUTO_INCREMENT PRIMARY KEY,
                                      `name` varchar(20) NULL COMMENT '审批流程中的名称',
                                      CONSTRAINT `name_UNIQUE` UNIQUE (`name`)
) COMMENT '课程审批表';

-- 课程状态表
CREATE TABLE `course_status` (
                                 `course_status_id` int AUTO_INCREMENT PRIMARY KEY,
                                 `name` varchar(45) NULL COMMENT '状态名称'
) COMMENT '课程状态';

-- 选课开关表
CREATE TABLE `course_switch` (
                                 `course_switch_id` int AUTO_INCREMENT PRIMARY KEY,
                                 `status` int NOT NULL COMMENT '1代表启动选课，0代表关闭选课'
) COMMENT '课程的开启与关闭表';

-- 学院表
CREATE TABLE `department` (
                              `department_id` int AUTO_INCREMENT PRIMARY KEY,
                              `name` varchar(45) NULL COMMENT '学院名称',
                              CONSTRAINT `name_UNIQUE` UNIQUE (`name`)
) COMMENT '学院信息表';

-- 操作类型表
CREATE TABLE `operation` (
                             `operation_id` int AUTO_INCREMENT PRIMARY KEY,
                             `name` varchar(30) NULL COMMENT '操作名称'
) COMMENT '用户操作信息表，如新增，删除，修改等';

-- 地点表
CREATE TABLE `place` (
                         `place_id` int AUTO_INCREMENT PRIMARY KEY,
                         `name` varchar(45) NULL COMMENT '地点名称'
) COMMENT '地点';

-- 学生表
CREATE TABLE `student` (
                           `student_id` int AUTO_INCREMENT PRIMARY KEY,
                           `student_number` varchar(45) NULL COMMENT '学生学号',
                           `name` varchar(15) NULL COMMENT '学生姓名',
                           `student_class` varchar(45) NULL COMMENT '学生班级',
                           `date_time` datetime DEFAULT CURRENT_TIMESTAMP NULL COMMENT '最后操作时间',
                           `password` varchar(45) DEFAULT '123456' NULL COMMENT '密码',
                           CONSTRAINT `student_number_UNIQUE` UNIQUE (`student_number`)
) COMMENT '学生信息表';

-- 教师表
CREATE TABLE `teacher` (
                           `teacher_id` int AUTO_INCREMENT PRIMARY KEY,
                           `name` varchar(15) NULL COMMENT '教师姓名',
                           `teacher_number` varchar(45) NULL COMMENT '教师工号',
                           `department_id` int NULL COMMENT '学院id',
                           `date_time` datetime DEFAULT CURRENT_TIMESTAMP NULL COMMENT '最后操作时间',
                           `password` varchar(45) DEFAULT '123456' NULL COMMENT '密码',
                           CONSTRAINT `teacher_number_UNIQUE` UNIQUE (`teacher_number`),
                           CONSTRAINT `teacher_department` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`)
) COMMENT '教师信息表';

-- 课程表
CREATE TABLE `course` (
                          `course_id` int AUTO_INCREMENT PRIMARY KEY,
                          `name` varchar(30) NULL COMMENT '课程名称',
                          `teacher_id` int NULL COMMENT '任课教师',
                          `credit` varchar(5) NULL COMMENT '学分',
                          `hour` varchar(20) NULL COMMENT '学时',
                          `time` varchar(45) NULL COMMENT '上课时间(可能需要改进)',
                          `place_id` int NULL COMMENT '地点id',
                          `description` text NULL COMMENT '简介描述',
                          `course_status_id` int NULL COMMENT '课程状态',
                          `is_delete` int DEFAULT 0 NULL COMMENT '0代表没有删除，1代表已经删除了。',
                          CONSTRAINT `course_place` FOREIGN KEY (`place_id`) REFERENCES `place` (`place_id`) ON UPDATE CASCADE ON DELETE SET NULL,
                          CONSTRAINT `course_status` FOREIGN KEY (`course_status_id`) REFERENCES `course_status` (`course_status_id`),
                          CONSTRAINT `course_teacher` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`teacher_id`) ON UPDATE CASCADE ON DELETE SET NULL
) COMMENT '课程信息表';

-- 创建课程表的索引
CREATE INDEX `course_place_idx` ON `course` (`place_id`);
CREATE INDEX `course_status_idx` ON `course` (`course_status_id`);
CREATE INDEX `course_teacher_idx` ON `course` (`teacher_id`);

-- 课程申请表
CREATE TABLE `course_application` (
                                      `course_application_id` int AUTO_INCREMENT PRIMARY KEY,
                                      `teacher_id` int NULL COMMENT '教师的id(申请人)',
                                      `course_id` int NULL COMMENT '课程id',
                                      `course_name` varchar(45) NULL COMMENT '课程名称',
                                      `course_credit` varchar(5) NULL COMMENT '学分',
                                      `course_hour` varchar(5) NULL COMMENT '学时',
                                      `course_time` varchar(45) NULL COMMENT '上课时间（可能需要改进）',
                                      `course_place_id` int NULL COMMENT '上课地点id',
                                      `course_description` text NULL COMMENT '课程描述',
                                      `course_examination_id` int NULL COMMENT '课程审批状态',
                                      `operation_id` int NULL COMMENT '申请的操作，有新增，修改和删除。',
                                      `date_time` datetime DEFAULT CURRENT_TIMESTAMP NULL COMMENT '申请时间',
                                      CONSTRAINT `course_id_UNIQUE` UNIQUE (`course_id`),
                                      CONSTRAINT `application_examination` FOREIGN KEY (`course_examination_id`) REFERENCES `course_examination` (`course_examination_id`),
                                      CONSTRAINT `application_operation` FOREIGN KEY (`operation_id`) REFERENCES `operation` (`operation_id`),
                                      CONSTRAINT `application_place` FOREIGN KEY (`course_place_id`) REFERENCES `place` (`place_id`) ON UPDATE CASCADE ON DELETE SET NULL,
                                      CONSTRAINT `application_teacher` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`teacher_id`) ON UPDATE CASCADE ON DELETE CASCADE
) COMMENT '课程申请记录表';

-- 创建课程申请表的索引
CREATE INDEX `application_examination_idx` ON `course_application` (`course_examination_id`);
CREATE INDEX `application_operation_idx` ON `course_application` (`operation_id`);
CREATE INDEX `application_place_idx` ON `course_application` (`course_place_id`);
CREATE INDEX `application_teacher_idx` ON `course_application` (`teacher_id`);

-- 学生选课表
CREATE TABLE `courses_students` (
                                    `courses_students_id` int AUTO_INCREMENT PRIMARY KEY,
                                    `course_id` int NULL COMMENT '课程id',
                                    `student_id` int NULL COMMENT '学生id',
                                    `score` float NULL COMMENT '课程成绩',
                                    CONSTRAINT `students` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON UPDATE CASCADE ON DELETE CASCADE
) COMMENT '课程与学生之间的选择（学生选课，课程被选）';

-- 创建学生选课表的索引
CREATE INDEX `students_idx` ON `courses_students` (`student_id`);

-- 教师表的部门索引
CREATE INDEX `teacher_department_idx` ON `teacher` (`department_id`);

-- 插入基础数据
-- 管理员数据
INSERT INTO `administrator` (`name`, `account`, `password`) VALUES
                                                                ('张主任','admin1','A1b2c3'),('王老师','admin2','Qwe123'),
                                                                ('李督导','admin3','Admin@3'),('赵科长','admin4','Zh@o456'),
                                                                ('周督导','admin5','Zhou_789'),('孙老师','admin6','Sun666'),
                                                                ('吴主管','admin7','Wu_777'),('郑老师','admin8','Zheng88'),
                                                                ('冯主任','admin9','Feng999'),('陈督导','admin10','Chen000'),
                                                                ('楚老师','admin11','Chu111'),('魏科长','admin12','Wei222'),
                                                                ('蒋督导','admin13','Jiang333'),('沈老师','admin14','Shen444'),
                                                                ('韩主管','admin15','Han555');

-- 课程审批状态数据
INSERT INTO `course_examination` (`name`) VALUES
                                              ('待审批'),('已通过'),('未通过'),
                                              ('新课程申请'),('课程信息修改'),('学分调整申请'),
                                              ('学时变更审批'),('上课地点变更'),('教师更换申请'),
                                              ('课程停开申请'),('补选课程审批'),('重修课程申请'),
                                              ('调课时间申请'),('课程合并申请'),('教材变更审批'),
                                              ('考核方式调整'),('教学大纲更新'),('实践环节调整');

-- 课程状态数据
INSERT INTO `course_status` (`name`) VALUES
                                         ('等待课程安排'),('可选'),('已结课'),('授课中'),('待选'),
                                         ('待审批'),('已通过'),('已驳回'),('选课中'),('已满员'),
                                         ('成绩待录入'),('成绩已发布'),('课程调整中'),('暂停开课'),('补选阶段'),
                                         ('重修报名'),('调课申请'),('考试安排中'),('已归档');

-- 选课开关数据
INSERT INTO `course_switch` (`status`) VALUES
                                           (1),(0),(1),(0),(1),(1),(0),(1),(0),(1),(0),(1),(0),(1),(0);

-- 学院数据
INSERT INTO `department` (`name`) VALUES
                                      ('计算机科学与工程学院'),('人文学院'),('土木工程学院'),
                                      ('商学院'),('地球信息与科学工程学院'),('外国语学院'),
                                      ('艺术学院'),('马克思主义学院'),('计算机学院'),
                                      ('电子信息学院'),('机械工程学院'),('材料科学与工程学院'),
                                      ('理学院'),('经济管理学院'),('法学院'),
                                      ('医学院'),('环境与化学工程学院'),('体育部'),
                                      ('国际教育学院');

-- 操作类型数据
INSERT INTO `operation` (`name`) VALUES
                                     ('新增'),('修改'),('删除'),
                                     ('课程审批'),('成绩录入'),('选课管理'),
                                     ('系统配置'),('用户管理'),('数据统计'),
                                     ('通知发布'),('课表调整'),('考试安排'),
                                     ('教学评估'),('系统维护'),('日志查看');

-- 地点数据
INSERT INTO `place` (`name`) VALUES
                                 ('逸夫楼429'),('第八教学楼211'),('第九教学楼412'),
                                 ('第九教学楼410'),('第九教学楼312'),('第九教学楼520'),
                                 ('物理楼318'),('东附楼201'),('逸夫楼520'),('逸夫楼211'),
                                 ('教学楼101'),('教学楼201'),('实验楼A301'),
                                 ('计算机实验室'),('语音室3'),('艺术楼排练厅'),
                                 ('工程训练中心'),('图书馆报告厅'),('体育场看台'),
                                 ('国际会议中心'),('远程教室'),('化学实验室B'),
                                 ('金工实习车间'),('多功能厅'),('网络教室');

-- 教师数据
INSERT INTO `teacher` (`name`, `teacher_number`, `department_id`) VALUES
                                                                      ('张伟','T001',1),('王芳','T002',2),('李强','T003',3),
                                                                      ('赵敏','T004',4),('周杰','T005',5),('孙丽','T006',6),
                                                                      ('吴刚','T007',7),('郑雪','T008',8),('冯涛','T009',9),
                                                                      ('陈琳','T010',10),('楚云','T011',11),('魏东','T012',12),
                                                                      ('蒋欣','T013',13),('沈冰','T014',14),('韩梅','T015',15);

-- 学生数据
INSERT INTO `student` (`student_number`, `name`, `student_class`) VALUES
                                                                      ('S001','李明','计算机1801'),('S002','王磊','电子1902'),
                                                                      ('S003','张倩','机械2003'),('S004','周涛','材料2104'),
                                                                      ('S005','赵敏','数学2205'),('S006','孙伟','经管1706'),
                                                                      ('S007','吴婷','英语1807'),('S008','郑浩','艺术1908'),
                                                                      ('S009','冯雪','法学2009'),('S010','陈阳','临床2110'),
                                                                      ('S011','楚云','土木1711'),('S012','魏琳','环化1812'),
                                                                      ('S013','蒋芳','马院1913'),('S014','沈冰','体育2014'),
                                                                      ('S015','韩东','国教2115');

-- 课程数据
INSERT INTO `course` (`name`, `teacher_id`, `credit`, `hour`, `time`, `place_id`, `description`, `course_status_id`) VALUES
                                                                                                                         ('数据库原理',1,'3','48','周一1-3节',1,'关系型数据库基础课程',4),
                                                                                                                         ('电路分析',2,'4','64','周二5-8节',2,'电路基础理论与实验',4),
                                                                                                                         ('机械设计',3,'3','48','周三上午',3,'机械结构设计基础',4),
                                                                                                                         ('材料力学',4,'3','48','周四1-3节',4,'材料力学性能分析',4),
                                                                                                                         ('高等数学',5,'5','80','周五全天',5,'微积分与线性代数',4),
                                                                                                                         ('经济学原理',6,'2','32','周一晚',6,'微观经济学导论',4),
                                                                                                                         ('英语写作',7,'3','48','周二下午',7,'学术英语写作训练',4),
                                                                                                                         ('艺术鉴赏',8,'2','32','周三晚',8,'中外艺术史赏析',4),
                                                                                                                         ('宪法学',9,'3','48','周四下午',9,'宪法理论与实务',4),
                                                                                                                         ('解剖学',10,'4','64','周五上午',10,'人体解剖学基础',4),
                                                                                                                         ('结构力学',11,'3','48','周六上午',11,'建筑结构分析',4),
                                                                                                                         ('环境化学',12,'3','48','周日下午',12,'环境污染化学分析',4),
                                                                                                                         ('马克思主义原理',13,'3','48','周一上午',13,'辩证唯物主义原理',4),
                                                                                                                         ('篮球基础',14,'1','16','周三下午',14,'篮球运动基础教学',4),
                                                                                                                         ('汉语教学',15,'3','48','周五下午',15,'对外汉语教学方法',4);

-- 课程申请数据
INSERT INTO `course_application` (`teacher_id`, `course_id`, `course_name`, `course_credit`, `course_hour`, `course_time`, `course_place_id`, `course_description`, `course_examination_id`, `operation_id`) VALUES
                                                                                                                                                                                                                 (1,1,'数据库原理','3','48','增加实验环节',1,'增加Hadoop实验内容',1,2),
                                                                                                                                                                                                                 (2,NULL,'物联网基础','2','32','周三晚',2,'新开物联网技术课程',1,1),
                                                                                                                                                                                                                 (3,3,NULL,'4',NULL,NULL,NULL,'调整机械设计学分',NULL,2),
                                                                                                                                                                                                                 (6,6,'经济学原理','3','48',NULL,NULL,'扩展宏观经济学内容',3,2),
                                                                                                                                                                                                                 (10,10,NULL,NULL,'64',NULL,5,'增加解剖实验课时',2,2);

-- 学生选课数据
INSERT INTO `courses_students` (`course_id`, `student_id`, `score`) VALUES
                                                                        (1,3,85.5),(2,5,92.0),(3,7,78.5),
                                                                        (4,9,88.0),(5,11,76.5),(6,13,95.0),
                                                                        (7,15,81.5),(8,2,89.0),(9,4,73.5),
                                                                        (10,6,84.0),(11,8,79.5),(12,10,91.0),
                                                                        (13,12,82.5),(14,14,87.0),(15,1,68.5);