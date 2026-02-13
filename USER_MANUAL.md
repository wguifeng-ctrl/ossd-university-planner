# OSSD University Planner (OUP) 使用说明书

## 📋 系统概述

**OSSD University Planner** 是专为安大略省高中生设计的升学规划系统，帮助管理：
- 📊 OSSD 30学分毕业要求追踪
- 🎓 GPA计算（4.0制 + Top 6 U/M课程）
- 🏫 安省22所大学信息库
- 🎯 智能选校匹配（Safe/Target/Reach）
- 📝 大学申请追踪
- ✍️ 个人陈述写作助手
- 📨 推荐信管理

**技术规格**：Classic ASP + Microsoft Access 2007 (Jet 4.0)

---

## 🚀 快速开始

### 1. 系统访问

```
浏览器访问: http://localhost/oup/
```

### 2. 首次使用流程

```
1. 访问 http://localhost/oup/create_database.asp
   → 创建数据库表结构

2. 访问 http://localhost/oup/universities/init_universities.asp
   → 加载22所安省大学数据

3. 访问 http://localhost/oup/register.asp
   → 注册新账户

4. 登录 http://localhost/oup/login.asp
   → 开始使用
```

---

## 👤 用户管理

### 注册账户
- 访问 `/register.asp`
- 填写：姓名、邮箱、年级、目标入学年份
- 设置密码
- 系统自动创建学生档案

### 登录/登出
- **登录**: `/login.asp`
- **登出**: 点击导航栏右上角 "Logout"
- 会话保持：自动管理，关闭浏览器后需重新登录

---

## 📊 仪表盘 (Dashboard)

访问：`/default.asp`

### 功能模块

| 卡片 | 功能描述 |
|------|---------|
| **Credit Progress** | 30学分毕业进度条，分类显示各科目学分 |
| **GPA Summary** | 总体GPA(4.0制) + Top 6 U/M课程GPA |
| **Requirements Check** | OSSD毕业要求检查清单 |
| **My Applications** | 最新申请状态概览 |
| **Quick Stats** | 课程数、申请数、待修学分统计 |

### 学分分类显示
- English (4学分)
- Math (3学分)
- Science (2学分)
- Canadian Geo/Hist (1学分)
- Arts (1学分)
- Phys Ed (1学分)
- French (1学分)
- Civics/Careers (1学分)

---

## 📚 OSSD 学分管理

### 查看学分详情
访问：`/ossd/credits.asp`

**功能**：
- 可视化30学分进度条
- OSSD八大类必修要求检查
- GPA数字显示
- 直接链接到课程管理

### 添加/编辑课程
访问：`/ossd/courses.asp`

#### 添加新课程
1. 点击 "Add New Course"
2. 填写课程信息：

| 字段 | 说明 | 示例 |
|------|------|------|
| Course Code | 课程代码 | ENG4U, MHF4U |
| Course Name | 课程名称 | English Grade 12 |
| Category | 学科分类 | ENG/MTH/SCI/ART... |
| Course Type | 课程类型 | U=大学, M=大学/学院, C=学院 |
| Credits | 学分 | 通常1.0，少许0.5 |
| Current Mark | 当前分数 | 0-100，留空表示未完成 |
| Status | 完成状态 | Completed/In Progress/Planned |
| Term | 学期 | Fall 2025 |

#### 常用G12课程代码参考
```
ENG4U - 12年级英语（大学）
MHF4U - 高等函数
MCV4U - 微积分与向量
SBI4U - 生物学
SCH4U - 化学
SPH4U - 物理学
MDM4U - 数据管理
CIA4U - 经济
HHS4U - 家庭学
```

#### 编辑/删除
- 点击课程列表中的 **Edit** 修改
- 点击 **Delete** 删除（需确认）

---

## 🎓 GPA 计算说明

系统提供两种GPA计算方式：

### 1. 总体GPA (Cumulative GPA)
**范围**: 所有完成的课程
**用途**: 反映整体学业表现
**计算公式**: 加权平均（学分×等级分 ÷ 总学分）

### 2. Top 6 U/M GPA
**范围**: 最高的6门U/M等级课程
**用途**: 安省大学申请常用指标
**计算**: 仅适用于已标记为 **Completed** 的课程

### OSSD百分制转4.0制对照
| 百分制 | 4.0制 | 等级 |
|--------|-------|------|
| 80-100 | 4.0 | A |
| 75-79 | 3.7 | A- |
| 70-74 | 3.0 | B |
| 65-69 | 2.3 | C+ |
| 60-64 | 2.0 | C |
| 55-59 | 1.7 | D+ |
| 50-54 | 1.0 | D |
| <50 | 0.0 | F |

---

## 🏫 大学查询系统

### 浏览所有大学
访问：`/universities/list.asp`

**功能**：
- 搜索：按名称或城市搜索
- 筛选：按地理位置（Toronto/Waterloo/Ottawa等）
- GPA筛选：按最低GPA要求过滤
- 匹配度显示：根据你的GPA显示录取概率

### 大学详细信息
访问：`/universities/detail.asp?id=[大学ID]`

**显示内容**：
- 基本信息：名称、位置、网站
- 录取统计：最低GPA、竞争GPA、排名
- 录取预测：High Chance / Good Chance / Possible
- 申请要求：ENG4U要求、微积分要求
- 截止日期：申请截止时间
- 热门专业

---

## 🎯 智能选校匹配

访问：`/universities/matcher.asp`

### 录取概率分类
系统根据你的GPA将大学分为四类：

| 分类 | 条件 | 颜色 | 建议 |
|------|------|------|------|
| **Safe** | GPA > Min + 0.5 | 🟢 绿色 | 保底校，录取概率高 |
| **Target** | GPA ≈ Min | 🔵 蓝色 | 匹配校，合理目标 |
| **Reach** | GPA < Min + 0.3 | 🟡 黄色 | 冲刺校，需要补强 |
| **Hard Reach** | GPA < Min | 🔴 红色 | 高难度，谨慎选择 |

### 使用方法
1. 确保已添加足够的课程，GPA计算准确
2. 访问 matcher 页面
3. 按分类筛选查看推荐学校
4. 点击 "Apply" 直接开始申请

---

## 📝 申请管理

### 申请仪表板
访问：`/applications/dashboard.asp`

**显示**：
- 所有申请列表
- 状态追踪（Draft/In Progress/Submitted/Accepted/Rejected）
- 截止日期提醒（红色=紧急<3天，黄色=警告<14天）
- 个人陈述状态
- 推荐信状态

### 添加新申请
访问：`/applications/add.asp`

**步骤**：
1. 选择大学（下拉菜单）
2. 选择专业（自动加载该大学专业）或留空自定义
3. 设置状态（通常从 Draft 开始）
4. 添加备注
5. 保存

### 截止日期提醒系统
| 剩余时间 | 显示 | 含义 |
|---------|------|------|
| < 0天 | 🔴 OVERDUE | 已过期 |
| ≤ 3天 | 🔴 URGENT | 紧急 |
| ≤ 14天 | 🟡 WARNING | 警告 |
| > 14天 | 🔵 NORMAL | 正常 |

---

## ✍️ 个人陈述编辑器 (PS Editor)

访问：`/applications/ps_editor.asp?app=[申请ID]`

### 5段式结构指导

系统提供中英双语的写作框架：

#### 1. Opening Hook (引言) - 100-150词
- 用吸引人的开场抓住招生官
- 避免陈词滥调（如"从小想当医生"）
- 用具体细节展示而非告知

#### 2. Academic Interest (学术兴趣) - 200-250词
- 阐述专业兴趣的起源
- 连接具体课程和老师影响
- 展示对领域的深入理解
- 提及OSSD相关课程

#### 3. Relevant Experience (相关经历) - 200-250词
- 义工、实习、社团、竞赛经历
- 使用STAR法则：情境-任务-行动-结果
- 量化成果（如组织了50人活动）

#### 4. Career Goals (职业目标) - 150-200词
- 短期和长期职业目标
- 连接大学资源（实验室、教授、项目）
- 具体而非笼统

#### 5. Conclusion (结尾) - 100词
- 呼应开头主题
- 展望未来，表达期待
- 坚定而自信

### 版本管理功能
- **自动版本**: 每次保存生成新版本（v1, v2, v3...）
- **历史查看**: 可查看所有历史版本
- **字数统计**: 实时显示字数，建议800-1000总词数
- **最终确认**: 可标记为 Final 版本

---

## 📨 推荐信管理

访问：`/applications/dashboard.asp` (推荐区块)

### 添加推荐人
1. 点击 "+ Add Referee"
2. 填写：
   - Referee Name: 推荐人姓名
   - Title/Role: 职位（如"Grade 11 Physics Teacher"）
   - Email: 联系邮箱
3. 保存

### 状态追踪
| 状态 | 含义 |
|------|------|
| **Pending** | 等待提交 |
| **Submitted** | 已提交 |
| **Waived** | 放弃查看权 |

### 更新状态
点击 "Mark Submitted" 更新为已提交状态

---

## 🔧 系统维护

### 刷新大学数据
访问：`/universities/init_universities.asp`

**用途**：
- 首次部署时加载22所大学
- 数据丢失时恢复
- 更新录取数据（需手动编辑脚本）

⚠️ 注意：此操作会清空并重建大学数据表！

### 数据库结构重建
访问：`/create_database.asp`

**用途**：
- 首次安装时创建所有表
- 检查表结构完整性

⚠️ 注意：不会删除已有数据，只是创建缺失的表

---

## ⚠️ 常见问题 (FAQ)

### Q1: 页面显示乱码
**原因**: Unicode字符编码问题
**解决**: 已修复，使用ASCII字符

### Q2: GPA显示为0
**原因**: 没有标记为 "Completed" 的课程
**解决**: 
1. 添加课程成绩
2. 将 Status 改为 "Completed"
3. 刷新Dashboard查看

### Q3: "参数未指定"错误 (80040e10)
**原因**: 引用了数据库中不存在的字段
**解决**: 已统一字段名，如还有问题联系管理员

### Q4: 无法添加课程
**检查项**：
- 是否已登录
- Course Code 不能为空
- Category 必须选择

### Q5: 如何计算Top 6 GPA？
**条件**：
- 课程类型必须是 U 或 M
- 状态必须是 Completed
- 系统取最高的6门计算

### Q6: 忘记密码怎么办？
当前版本：联系数据库管理员重置
（后续版本会增加自助重置功能）

---

## 📁 文件结构

```
C:\inetpub\wwwroot\OUP\
├── default.asp              # 主仪表盘
├── login.asp                # 登录页
├── register.asp             # 注册页
├── create_database.asp      # 数据库创建工具
│
├── css/
│   └── main.css             # 样式表
│
├── includes/                # 公共组件
│   ├── db_conn.asp          # 数据库连接
│   ├── functions.asp        # 核心函数库
│   ├── header.asp           # 页头导航
│   └── footer.asp           # 页脚
│
├── ossd/                    # OSSD学分模块
│   ├── credits.asp          # 学分总览
│   ├── courses.asp          # 课程管理
│   └── course_save.asp      # 保存处理
│
├── universities/            # 大学信息模块
│   ├── list.asp             # 大学列表
│   ├── detail.asp           # 大学详情
│   ├── matcher.asp          # 智能匹配
│   └── init_universities.asp # 数据初始化
│
└── applications/            # 申请管理模块
    ├── dashboard.asp        # 申请仪表板
    ├── add.asp              # 添加申请
    ├── save.asp             # 保存处理
    ├── ps_editor.asp        # PS编辑器
    ├── ps_save.asp          # PS保存
    └── rec_save.asp         # 推荐信保存
```

---

## 💡 使用技巧

1. **尽早录入课程** - 越早录入，GPA预测越准确
2. **定期更新成绩** - 期中/期末后及时更新
3. **善用筛选功能** - University列表支持多维度筛选
4. **PS分段写作** - 利用5段式结构逐步完成
5. **关注截止日期** - Dashboard有醒目的截止提醒
6. **保留历史版本** - PS自动版本管理，可随时回溯

---

## 🔐 数据备份建议

定期备份以下位置：
```
C:\inetpub\wwwroot\OUP\db\oup_data.mdb
```

备份脚本示例（Windows任务计划）：
```batch
@echo off
copy "C:\inetpub\wwwroot\OUP\db\oup_data.mdb" "D:\Backups\OUP_backup_%date:~0,4%%date:~5,2%%date:~8,2%.mdb"
```

---

## 📞 技术支持

**系统版本**: v1.0  
**最后更新**: 2026-02-13  
**支持**: Classic ASP + Access 2007

---

*祝申请顺利！🏆*
