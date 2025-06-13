# WebEngineer

西安电子科技大学 Web 工程课程作业

## 项目简介

本项目为教学管理系统，包含前后端分离的架构，后端基于 Spring Boot，前端基于 Vue 2，数据库使用 MySQL。实现了学生选课、教师课程管理、管理员审批等功能。

## 技术栈

- **后端**：Spring Boot 3.1.5、MyBatis、JWT
- **前端**：Vue 2.x、Element UI、Vue Router、Vuex、Axios
- **数据库**：MySQL

## 项目结构

```
├── frontend-web/         # 前端项目目录
├── src/
│   └── main/
│       └── java/
│           └── group/teachingmanagerbk/  # 后端主代码
├── teaching-manager.sql  # 数据库建表及初始化脚本
├── team_task             # 项目汇报相关内容
|   ├── task1             # 包含项目组人员
|   ├── task2&3           # 项目建议&需求描述
|   ├── task1-6           # 项目阶段性汇报pdf，包含task1~6
|   ├── 测试&操作          # 项目验收内容pdf
│   └── main/
├── pom.xml               # 后端Maven依赖
└── README.md
```

## 环境准备

- JDK 17+
- Node.js 14+
- MySQL 5.7/8.0
- Maven 3.6+

## 数据库初始化

1. 新建数据库（如：`teaching_manager`）。
2. 执行根目录下 `teaching-manager.sql`，完成表结构和部分基础数据初始化。

## 后端启动

1. 进入项目根目录，配置数据库连接（`src/main/resources/application.yml`，如有）。
2. 使用IDEA等工具或命令行运行：

   ```bash
   mvn spring-boot:run
   ```

   或直接运行 `TeachingManagerBkApplication.java`。

## 前端启动

1. 进入 `frontend-web` 目录：

   ```bash
   cd frontend-web
   ```

2. 安装依赖：

   ```bash
   npm install
   ```

3. 启动开发服务器：

   ```bash
   npm run serve
   ```

4. 浏览器访问 [http://localhost:8081](http://localhost:8081)
    注意：先启动后端，默认配置端口为8080，再启动前端，占用8081端口
    如果要先启动前端，会占用8080端口，需要给后端配置8081启动端口

## 常用命令

- 前端打包：`npm run build`
- 前端代码检查：`npm run lint`
- 后端打包：`mvn package`

## 其他说明

- 前后端接口通过 RESTful API 交互，端口分别为 8080（前端）和 8081（后端，默认）。
- 如需修改端口或数据库配置，请分别调整 `vue.config.js` 和后端 `application.yml`。
- 详细接口文档项目内部有集成的 Swagger 访问
