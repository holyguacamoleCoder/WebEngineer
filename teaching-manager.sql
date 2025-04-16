-- ===================== 系统基础表 =====================
create table administrator
(
    administrator_id int auto_increment
        primary key,
    name             varchar(15) null comment '姓名',
    account          varchar(45) null comment '账号',
    password         varchar(45) null comment '密码'
)
    comment '管理员（教务处）';

-- ===================== 审批流程相关表 =====================
create table course_examination
(
    course_examination_id int auto_increment
        primary key,
    name                  varchar(20) null comment '审批流程中的名称',
    constraint name_UNIQUE
        unique (name)
)
    comment '课程审批表';

create table course_status
(
    course_status_id int auto_increment
        primary key,
    name             varchar(45) null comment '状态名称'
)
    comment '课程状态';

create table course_switch
(
    course_switch_id int auto_increment
        primary key,
    status           int not null comment '1代表启动选课，0代表关闭选课'
)
    comment '课程的开启与关闭表';

create table department
(
    department_id int auto_increment
        primary key,
    name          varchar(45) null comment '学院名称',
    constraint name_UNIQUE
        unique (name)
)
    comment '学院信息表';

create table operation
(
    operation_id int auto_increment
        primary key,
    name         varchar(30) null comment '操作名称'
)
    comment '用户操作信息表，如新增，删除，修改等';

create table place
(
    place_id int auto_increment
        primary key,
    name     varchar(45) null comment '地点名称'
)
    comment '地点';

create table student
(
    student_id     int auto_increment
        primary key,
    student_number varchar(45)                           null comment '学生学号',
    name           varchar(15)                           null comment '学生姓名',
    student_class  varchar(45)                           null comment '学生班级',
    date_time      datetime    default CURRENT_TIMESTAMP null comment '最后操作时间',
    password       varchar(45) default '123456'          null comment '密码',
    constraint student_number_UNIQUE
        unique (student_number)
)
    comment '学生信息表';

-- ===================== 关联关系表 =====================
create table courses_students
(
    courses_students_id int auto_increment
        primary key,
    course_id           int   null comment '课程id',
    student_id          int   null comment '学生id',
    score               float null comment '课程成绩',
    constraint students
        foreign key (student_id) references student (student_id)
            on update cascade on delete cascade
)
    comment '课程与学生之间的选择（学生选课，课程被选）';

create index students_idx
    on courses_students (student_id);

create table teacher
(
    teacher_id     int auto_increment
        primary key,
    name           varchar(15)                           null comment '教师姓名',
    teacher_number varchar(45)                           null comment '教师工号',
    department_id  int                                   null comment '学院id',
    date_time      datetime    default CURRENT_TIMESTAMP null comment '最后操作时间',
    password       varchar(45) default '123456'          null comment '密码',
    constraint teacher_number_UNIQUE
        unique (teacher_number),
    constraint teacher_department
        foreign key (department_id) references department (department_id)
)
    comment '教师信息表';

-- ===================== 课程核心表 =====================
create table course
(
    course_id        int auto_increment
        primary key,
    name             varchar(30)   null comment '课程名称',
    teacher_id       int           null comment '任课教师',
    credit           varchar(5)    null comment '学分',
    hour             varchar(20)   null comment '学时',
    time             varchar(45)   null comment '上课时间(可能需要改进)',
    place_id         int           null comment '地点id',
    description      text          null comment '简介描述',
    course_status_id int           null comment '课程状态',
    is_delete        int default 0 null comment '0代表没有删除，1代表已经删除了。',
    constraint course_place
        foreign key (place_id) references place (place_id)
            on update cascade on delete set null,
    constraint course_status
        foreign key (course_status_id) references course_status (course_status_id),
    constraint course_teacher
        foreign key (teacher_id) references teacher (teacher_id)
            on update cascade on delete set null
)
    comment '课程信息表';

create index course_place_idx
    on course (place_id);

create index course_status_idx
    on course (course_status_id);

create index course_teacher_idx
    on course (teacher_id);

-- ===================== 业务操作表 =====================
create table course_application
(
    course_application_id int auto_increment
        primary key,
    teacher_id            int                                null comment '教师的id(申请人)',
    course_id             int                                null comment '课程id',
    course_name           varchar(45)                        null comment '课程名称',
    course_credit         varchar(5)                         null comment '学分',
    course_hour           varchar(5)                         null comment '学时',
    course_time           varchar(45)                        null comment '上课时间（可能需要改进）',
    course_place_id       int                                null comment '上课地点id',
    course_description    text                               null comment '课程描述',
    course_examination_id int                                null comment '课程审批状态',
    operation_id          int                                null comment '申请的操作，有新增，修改和删除。',
    date_time             datetime default CURRENT_TIMESTAMP null comment '申请时间',
    constraint course_id_UNIQUE
        unique (course_id),
    constraint application_examination
        foreign key (course_examination_id) references course_examination (course_examination_id),
    constraint application_operation
        foreign key (operation_id) references operation (operation_id),
    constraint application_place
        foreign key (course_place_id) references place (place_id)
            on update cascade on delete set null,
    constraint application_teacher
        foreign key (teacher_id) references teacher (teacher_id)
            on update cascade on delete cascade
)
    comment '课程申请记录表';

create index application_examination_idx
    on course_application (course_examination_id);

create index application_operation_idx
    on course_application (operation_id);

create index application_place_idx
    on course_application (course_place_id);

create index application_teacher_idx
    on course_application (teacher_id);

create index teacher_department_idx
    on teacher (department_id);
    
    
-- INSERT INTO `administrator` (`administrator_id`, `name`, `account`, `password`) VALUES ('1', '管理员', 'root', '123456');
    
INSERT INTO `course_examination` (`course_examination_id`, `name`) VALUES ('1', '待审批'), ('2', '已通过'), ('3', '未通过');

INSERT INTO `course_status` (`course_status_id`, `name`) VALUES ('1', '等待课程安排'), ('2', '可选'), ('3', '已结课'), ('4', '授课中'), ('5', '待选');

--
-- INSERT INTO `course_switch` (`course_switch_id`, `status`) VALUES ('1', '0');

-- INSERT INTO `department` (`department_id`, `name`) VALUES ('1', '计算机科学与工程学院'), ('2', '人文学院'), ('3', '土木工程学院'), ('4', '商学院'), ('5', '地球信息与科学工程学院'), ('6', '外国语学院'), ('7', '艺术学院'), ('8', '马克思主义学院');

-- INSERT INTO `operation` (`operation_id`, `name`) VALUES ('1', '新增'), ('2', '修改'), ('3', '删除');

-- INSERT INTO `place` (`place_id`, `name`) VALUES ('1', '逸夫楼429'), ('2', '第八教学楼211'), ('3', '第九教学楼412'), ('4', '第九教学楼410'), ('5', '第九教学楼312'), ('6', '第九教学楼520'), ('7', '物理楼318'), ('8', '东附楼201'), ('9', '逸夫楼520'), ('10', '逸夫楼211');
--
-- truncate table department ;
-- truncate table place ;
-- truncate table operation  ;
-- truncate table teacher  ;
-- truncate table administrator  ;



INSERT INTO department (name) VALUES
('计算机学院'), ('电子信息学院'), ('机械工程学院'),
('材料科学与工程学院'),('理学院'),('经济管理学院'),
('外国语学院'),('艺术学院'),('法学院'),
('医学院'),('土木工程学院'),('环境与化学工程学院'),
('马克思主义学院'),('体育部'),('国际教育学院');

INSERT INTO place (name) VALUES
('教学楼101'),('教学楼201'),('实验楼A301'),
('计算机实验室'),('语音室3'),('艺术楼排练厅'),
('工程训练中心'),('图书馆报告厅'),('体育场看台'),
('国际会议中心'),('远程教室'),('化学实验室B'),
('金工实习车间'),('多功能厅'),('网络教室');

INSERT INTO operation (name) VALUES
('新增'),('修改'),('删除'),
('课程审批'),('成绩录入'),('选课管理'),
('系统配置'),('用户管理'),('数据统计'),
('通知发布'),('课表调整'),('考试安排'),
('教学评估'),('系统维护'),('日志查看');

INSERT INTO course_status (name) VALUES
('待审批'),('已通过'),('已驳回'),
('选课中'),('已满员'),('已结课'),
('成绩待录入'),('成绩已发布'),('课程调整中'),
('暂停开课'),('补选阶段'),('重修报名'),
('调课申请'),('考试安排中'),('已归档');

INSERT INTO teacher (name, teacher_number, department_id) VALUES
('张伟','T001',1),('王芳','T002',2),('李强','T003',3),
('赵敏','T004',4),('周杰','T005',5),('孙丽','T006',6),
('吴刚','T007',7),('郑雪','T008',8),('冯涛','T009',9),
('陈琳','T010',10),('楚云','T011',11),('魏东','T012',12),
('蒋欣','T013',13),('沈冰','T014',14),('韩梅','T015',15);
-- 密码使用默认值123456‘

INSERT INTO student (student_number, name, student_class) VALUES
('S001','李明','计算机1801'),('S002','王磊','电子1902'),
('S003','张倩','机械2003'),('S004','周涛','材料2104'),
('S005','赵敏','数学2205'),('S006','孙伟','经管1706'),
('S007','吴婷','英语1807'),('S008','郑浩','艺术1908'),
('S009','冯雪','法学2009'),('S010','陈阳','临床2110'),
('S011','楚云','土木1711'),('S012','魏琳','环化1812'),
('S013','蒋芳','马院1913'),('S014','沈冰','体育2014'),
('S015','韩东','国教2115');
-- 密码和操作时间均使用默认值

INSERT INTO course_examination (name) VALUES
('新课程申请'),('课程信息修改'),('学分调整申请'),
('学时变更审批'),('上课地点变更'),('教师更换申请'),
('课程停开申请'),('补选课程审批'),('重修课程申请'),
('调课时间申请'),('课程合并申请'),('教材变更审批'),
('考核方式调整'),('教学大纲更新'),('实践环节调整');

INSERT INTO administrator (name, account, password) VALUES
('张主任','admin1','A1b2c3'),('王老师','admin2','Qwe123'),
('李督导','admin3','Admin@3'),('赵科长','admin4','Zh@o456'),
('周督导','admin5','Zhou_789'),('孙老师','admin6','Sun666'),
('吴主管','admin7','Wu_777'),('郑老师','admin8','Zheng88'),
('冯主任','admin9','Feng999'),('陈督导','admin10','Chen000'),
('楚老师','admin11','Chu111'),('魏科长','admin12','Wei222'),
('蒋督导','admin13','Jiang333'),('沈老师','admin14','Shen444'),
('韩主管','admin15','Han555');

INSERT INTO course (name, teacher_id, credit, hour, time, place_id, description, course_status_id) VALUES
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

INSERT INTO course_application (teacher_id, course_id, course_name, course_credit, course_hour, course_time, course_place_id, course_description, course_examination_id, operation_id) VALUES
(1,1,'数据库原理','3','48','增加实验环节',1,'增加Hadoop实验内容',1,2),
(2,NULL,'物联网基础','2','32','周三晚',2,'新开物联网技术课程',1,1),
(3,3,NULL,'4',NULL,NULL,NULL,'调整机械设计学分',NULL,2),
(6,6,'经济学原理','3','48',NULL,NULL,'扩展宏观经济学内容',3,2),
(10,10,NULL,NULL,'64',NULL,5,'增加解剖实验课时',2,2);

INSERT INTO course_switch (status) VALUES
(1),(0),(1),(0),(1),(1),(0),(1),(0),(1),(0),(1),(0),(1),(0);


INSERT INTO courses_students (course_id, student_id, score) VALUES
(1, 3, 85.5), (2, 5, 92.0), (3, 7, 78.5),
(4, 9, 88.0), (5, 11, 76.5), (6, 13, 95.0),
(7, 15, 81.5), (8, 2, 89.0), (9, 4, 73.5),
(10, 6, 84.0), (11, 8, 79.5), (12, 10, 91.0),
(13, 12, 82.5), (14, 14, 87.0), (15, 1, 68.5);
