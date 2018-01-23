
# 国科大教务在线 [![Build Status](https://travis-ci.org/PENGZhaoqing/CourseSelect.svg?branch=master)](https://travis-ci.org/PENGZhaoqing/CourseSelect)


这个样本系统是基于国科大研究生课程 (高级软件工程) 开发的项目，作为该课程的期末课程设计作业

本次的课程设计已经部署在了Heroku云平台 ([演示Demo戳这里](https://couseselect.herokuapp.com/ ))

### 在进行优化之前，系统的功能包括：

- 查询成绩
- 选课退课
- 课程管理
- 用户管理
- 开课管理
- 添加成绩
- 多角色登陆（学生，老师，管理员）

### 修改完成后包含的功能：

* 管理员发布通知
* 管理员发布校园活动
* 管理员开放/关闭选课系统
* 管理员系统界面的汉化
* 教师对选课学生成绩单导入导出
* 教师开启/关闭选课按钮
* 学生查看课表
* 学生修改是/否学位课属性
* 学生显示修读课程成绩排名
* 学生查看成绩UI设计美化

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


## 将开发的选课系统部署到Heroku平台
```
 heroku login
 heroku cerate couseselect
 git commit -a -m '-version'
 git push heroku master
 heroku run rake db:migrate
 heroku run rake db:seed

 https://couseselect.herokuapp.com/
```

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

  <img src="/lib/admin_limit_3.png" width="700">

  <img src="/lib/admin_limit_2.png" width="700">

- 管理员用户界面汉化

  <img src="/lib/admin_translate.png" width="700">


### 教师功能

- Excel文件数据导入导出

  <img src="/lib/teacher_upload_1.png" width="700">

  点击导出后，系统将生成一个Excel文件并提示保存到本地

  <img src="/lib/teacher_upload_2.png" width="700">

  在Excel文件中修改学生选课成绩的数据

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

- 查看修读课程成绩排名

  <img src="/lib/student_rank.png" width="700">


## 测试用例
- 测试1:查看教务通知

  > Given 游客身份
  >
  > and 未登录
  >
  > when 用户点击通知栏的“选课通知”
  >
  > then 跳转页面，显示“选课通知”的详细情况

- 测试2：编辑或添加教务通知

  > Given 学生身份登录的student1
  >
  > when 学生点击“选课通知”
  >
  > then 跳转页面，显示“选课通知”的详细情况，但无“编辑”按钮
  >
  >  
  >
  >  
  >
  > Given 管理员身份登录的admin
  >
  > and 处于“选课通知”的详细情况页面
  >
  > when 管理员点击编辑按钮
  >
  > then 跳转到通知编辑页面，编辑完可选择保存
  >
  >  
  >
  >  
  >
  > Given 管理员身份登录的admin
  >
  > and 处于控制面板中教务通知界面
  >
  > when 管理员点击添加按钮
  >
  > then 跳转到通知编辑页面，保存后生成了新的教务通知

- 测试3：编辑或添加讲座信息

  > Given 学生身份登录的student1
  >
  > and 处于选课系统主页
  >
  > when 学生点击讲座信息
  >
  > then 无反应（学生无法修改讲座信息）
  >
  >  
  >
  >  
  >
  > Given 管理员身份登录的admin
  >
  > and 处于控制面板中讲座信息界面
  >
  > when 管理员点击添加按钮
  >
  > then 跳转到讲座信息编辑页面，保存后生成了新的讲座信息

- 测试4：关闭选课系统

  > Given 学生身份登录的student1
  >
  > and 选课系统处于关闭状态
  >
  > and 处于“我的课程”页面
  >
  > when 学生点击“选修课程”按钮
  >
  > then 弹出通知窗口“当前不在选课时间”
  >
  > when 学生点击“已选课程”按钮
  >
  > then 显示student1的已选课程，不显示“删除课程”按钮
  >
  >  
  >
  >  
  >
  > Given 管理员身份登录的admin
  >
  > and 处于控制面板中选课系统开放界面
  >
  > when 管理员点击编辑按钮
  >
  > then 跳转到选课系统开放编辑页面，管理员可更改选课系统是否开放并保存

- 测试5：开放选课系统

  > Given 学生身份登录的student1
  >
  > and 选课系统处于开放状态
  >
  > and 处于“我的课程”页面
  >
  > when 学生点击“选修课程”按钮
  >
  > then 跳转页面，显示student1可选的所有课程
  >
  > when 学生点击“已选课程”按钮
  >
  > then 显示student1的已选课程，同时显示“删除课程”按钮

- 测试6：设置课程限选人数

  > Given 管理员身份登录的admin
  >
  > and 处于控制面板中课程界面
  >
  > when 管理员点击课程“计算机体系结构”后的编辑按钮
  >
  > then 跳转到该课程编辑页面，管理员可更改课程限选人数并保存
  >
  >  
  >
  >  
  >
  > Given 老师身份登录的teacher1
  >
  > and 处于课程管理页面
  >
  > when 老师点击已授课程中“计算机体系结构”后的编辑按钮
  >
  > then 跳转到该课程编辑页面，老师可更改该课程限选人数并保存
  >
  >  
  >
  >  
  >
  > Given 学生身份登录的student1
  >
  > and 选课系统处于开放状态
  >
  > and “计算机体系结构”课程选课人数已达限选人数
  >
  > and 处于“选修课程”页面
  >
  > when 学生选课“计算机体系结构”
  >
  > then 弹出通知窗口“选课失败！选课人数已达上限！”

- 测试7：导入导出学生成绩

  > Given 教师身份登录的teacher1
  >
  > and 处于成绩管理界面
  >
  > when 教师点击成绩后的“导出”按钮
  >
  > then 生成以“计算机体系结构”为名的excel文件，其中包含界面上的所有信息
  >
  > when 教师点击“选择文件”按钮：
  >
  > then 打开本地文件管理器，可以让教师浏览要上传的成绩文件
  >
  > when 教师点击“导入”按钮
  >
  > then 根据教师选择的“计算机体系结构”表格文件内的成绩，将成绩显示在成绩管理界面

- 测试8：显示课程表

  > Given 学生身份登录的student1
  >
  > and 处于“已选课程”页面
  >
  > when 学生点击右侧“<”按钮
  >
  > then 以课程表的形式显示student1已选课程的课程名和上课教室
  >
  > when 学生再次点击课程表左侧的“>”按钮
  >
  > then 隐藏课程表界面

- 测试9：处理选课时间冲突

  > Given 学生身份登录的student1
  >
  > and student1已选一门与“模式识别与机器学习”时间冲突的课“编译程序高级原理”
  >
  > and 处于“选修课程”页面
  >
  > when 学生选择“模式识别与机器学习”这门课
  >
  > then 弹出通知窗口“选课失败！模式识别与机器学习 与 编译程序高级原理 上课时间冲突！”并跳转到已选课程界面

- 测试10：显示已选学分

  > Given 学生身份登录的student1
  >
  > and student1共选7门课，16学分
  >
  > and 处于“我的课程”页面
  >
  > when 学生点击已选课程
  >
  > then 在课程列表下方展示学生应选学分数20和已选学分数16

- 测试11：显示已获学分

  > Given 学生身份登录的student1
  >
  > and student1共选7门课
  >
  > and student1已有4门课已出成绩
  >
  > and 有3门课成绩不低于60分，共7学分
  >
  > and 处于“我的课程”页面
  >
  > when 学生点击所有成绩
  >
  > then 只显示已获成绩的4门课，并且在成绩列表下方展示学生应或学分数20，和已获学分数7（已获学分只统计成绩不低于60分的课程）

- 测试12：学位课设置

  > Given 学生身份登录的student1
  >
  > and 处于学位课页面
  >
  > and student1已选“计算机体系结构”课
  >
  > and student1将该课程设为非学位课
  >
  > when 学生点击该课程后方的设为学位课按钮
  >
  > then 修改该课程的学位课属性为“是”，并展示出来，同时将后面按钮修改为“设为非学位课”
  >
  >  
  >
  >  
  >
  > Given 学生身份登录的student1
  >
  > and 处于学位课页面
  >
  > and student1已选“计算机体系结构”课
  >
  > and student1将该课程设为学位课
  >
  > when 学生点击该课程后方的设为非学位课按钮
  >
  > then 修改该课程的学位课属性为“否”，并展示出来，同时将后面按钮修改为“设为学位课”


## How to Contribute

先fork此项目，在分支修改后，pull request到主分支

提问请到issues里创建，欢迎contributor！

如果觉得好，给项目点颗星吧～
