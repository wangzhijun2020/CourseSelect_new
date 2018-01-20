# 国科大教务在线 [![Build Status](https://travis-ci.org/PENGZhaoqing/CourseSelect.svg?branch=master)](https://travis-ci.org/PENGZhaoqing/CourseSelect)


这个样本系统是基于国科大研究生课程 (高级软件工程) 开发的项目，作为该课程的期末课程设计作业

本次的课程设计已经部署在了Heroku云平台 ([演示Demo戳这里](https://couseselect.herokuapp.com/ ))

###在进行优化之前，系统的功能包括：

- 查询成绩
- 选课退课
- 课程管理
- 用户管理
- 开课管理
- 添加成绩
- 多角色登陆（学生，老师，管理员）

### 修改完成后包含的功能：

* 教师开启/关闭选课按钮
* 查看课表
* 修改是/否学位课属性
* 通知管理
* 系统开关
* 活动管理
* 导出名单

### 截图

<img src="/lib/screenshot1.png" width="700">  

<img src="/lib/screenshot2.png" width="700">

<img src="/lib/screenshot3.png" width="700">   

<img src="/lib/screenshot4.png" width="700">

## 说明

目前使用的库和数据库：

* 使用[Bootstrap](http://getbootstrap.com/)作为前端库
* 使用[Rails_admin Gem](https://github.com/sferik/rails_admin)作为后台管理
* 使用[Postgresql](http://postgresapp.com/)作为数据库

使用前需要安装Bundler，Gem，Ruby，Rails等依赖环境。

请根据本地系统下载安装[postgresql](https://devcenter.heroku.com/articles/heroku-postgresql#local-setup)数据库，并运行`psql -h localhost`检查安装情况。


## 安装

在终端（MacOS或Linux）中执行以下代码

```
$ git clone https://github.com/PENGZhaoqing/CourseSelect
$ cd CourseSelect
$ bundle install
$ rake db:migrate
$ rake db:seed
$ rails s 
```

在浏览器中输入`localhost:3000`访问主页

## 使用

1.学生登陆：

账号：`student1@test.com`

密码：`password`

2.老师登陆：

账号：`teacher1@test.com`

密码：`password`


3.管理员登陆：

账号：`admin@test.com`

密码：`password`

账号中数字都可以替换成2,3...等等

## 功能测试及展示

### 管理员功能

- 发布通知以及校园活动公告

  <img src="/lib/admin_notice_1.png" width="700">

  <img src="/lib/admin_notice_2.png" width="700">

- 关闭选课系统

  <img src="/lib/admin_close_1.png" width="700">

  <img src="/lib/admin_close_2.png" width="700">

- 设置选课人数限制

  <img src="/lib/admin_limit_1.png" width="700">

  <img src="/lib/admin_limit_2.png" width="700">

### 教师功能

- Excel文件数据导入导出

  <img src="/lib/teacher_upload_1.png" width="700">

  <img src="/lib/teacher_upload_2.png" width="700">

  <img src="/lib/teacher_upload_3.png" width="700">

  <img src="/lib/teacher_upload_4.png" width="700">

- 查看通知

  <img src="/lib/teacher_notice.png" width="700">

### 学生功能

- 查看课程表

  <img src="/lib/student_schedule.png" width="700">

  <img src="/lib/student_conflict.png" width="700">

  <img src="/lib/student_credit.png" width="700">

- 设置学位课

  <img src="/lib/student_degree_1.png" width="700">

  <img src="/lib/student_degree_2.png" width="700">



## How to Contribute

先fork此项目，在分支修改后，pull request到主分支

提问请到issues里创建，欢迎contributor！

如果觉得好，给项目点颗星吧～


