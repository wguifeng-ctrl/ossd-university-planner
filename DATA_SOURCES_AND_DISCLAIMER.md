# 📢 数据来源说明与免责声明

## 重要提示

**OSSD University Planner 中的大学录取数据仅供参考，不构成官方录取标准。学生在做出升学决策前，务必直接查阅各大学官方网站的最新录取要求。**

---

## 数据来源说明

### 当前数据状态

| 项目 | 说明 |
|------|------|
| **数据位置** | 硬编码在 `universities/init_universities.asp` 文件中 |
| **数据性质** | 示例性参考数据，用于系统功能演示 |
| **更新时间** | 2026年2月（系统开发时） |
| **数据类型** | 静态数据，非实时API连接 |

### 22所大学列表

系统中包含以下安大略省大学的基础信息：
1. University of Toronto (多伦多大学)
2. University of Waterloo (滑铁卢大学)
3. McMaster University (麦克马斯特大学)
4. Western University (西安大略大学)
5. Queen's University (女王大学)
6. York University (约克大学)
7. University of Guelph (贵湖大学)
8. University of Ottawa (渥太华大学)
9. Carleton University (卡尔顿大学)
10. Wilfrid Laurier University (劳里埃大学)
11. Toronto Metropolitan University (多伦多都会大学)
12. University of Windsor (温莎大学)
13. Brock University (布鲁克大学)
14. Trent University (特伦特大学)
15. Ontario Tech University (安省理工大学)
16. Lakehead University (湖首大学)
17. Nipissing University (尼皮辛大学)
18. Laurentian University (劳伦森大学)
19. University of Ontario French (安省法文大学)
20. Algoma University (阿尔戈玛大学)
21. OCAD University (安省艺术设计大学)
22. Royal Military College (皇家军事学院)

### 数据包含字段

- 大学名称、位置、网站
- OUAC代码
- 预估最低GPA (Min GPA)
- 预估竞争GPA (Competitive GPA)
- 是否要求ENG4U
- 是否要求微积分
- 申请截止日期（统一设为2026-01-15，实际各校不同）
- 热门专业示例

---

## ⚠️ 数据准确性声明

### 局限性

1. **非官方数据源**：数据来源于公开信息的整合，**并非**直接来自各大学招生办公室的官方API

2. **时效性问题**：
   - 录取要求每年可能变化
   - 不同专业要求差异巨大（工程和文科的GPA要求可能完全不同）
   - 系统数据不会自动更新

3. **简化处理**：
   - 使用统一的申请截止日期（实际各校不同，通常在1月中-底）
   - GPA要求为粗略估计范围
   - 未区分具体专业（工程vs文科差异极大）

4. **录取复杂性**：
   - 实际录取考虑因素远超GPA：个人陈述、推荐信、面试、作品集、课外活动
   - "Competitive GPA"不等于录取保证
   - 国际生和本地生要求可能不同

---

## ✅ 官方核实渠道

学生**必须**通过以下官方渠道核实信息：

### 1. OUAC官网 (Ontario Universities' Application Centre)
- **网址**: https://www.ouac.on.ca
- **作用**: 安省大学申请官方平台，包含各校最新申请信息

### 2. 各大学官方网站招生页面
| 大学 | 官方招生链接 |
|------|-------------|
| 多伦多大学 | https://future.utoronto.ca |
| 滑铁卢大学 | https://uwaterloo.ca/future-students |
| 麦克马斯特 | https://future.mcmaster.ca |
| 女王大学 | https://www.queensu.ca/admission |
| 西安大略 | https://welcome.uwo.ca |
| ... | ... |

### 3. 学校升学指导办公室
- 与学校的Guidance Counselor定期会面
- 获取最新的招生简章

---

## 🔧 如何更新数据

如果您需要更正或更新某所大学的数据，有两种方式：

### 方式1：直接编辑数据库（推荐用于少量修改）

```sql
-- 示例：更新多伦多大学的最低GPA
UPDATE Universities 
SET MinGPA = 3.9, CompetitiveGPA = 4.0 
WHERE Name = 'University of Toronto'
```

### 方式2：修改 init_universities.asp 文件

1. 打开 `C:\inetpub\wwwroot\OUP\universities\init_universities.asp`
2. 找到对应大学的数组定义行
3. 修改数值
4. 重新运行 `init_universities.asp` 加载数据

**示例**（修改多伦多大学数据）：
```asp
' 修改前:
uniName(0) = "University of Toronto": uniMin(0) = 3.8: uniComp(0) = 3.9

' 修改后:
uniName(0) = "University of Toronto": uniMin(0) = 3.9: uniComp(0) = 4.0
```

---

## 📝 建议添加的系统免责声明

建议在系统首页或相关页面添加如下提示：

```html
<div class="alert alert-warning" style="border-left: 5px solid #ffc107; padding: 15px; background: #fff3cd;">
    <strong>⚠️ 重要声明</strong><br>
    本系统中的大学录取数据仅供参考，旨在帮助学生进行初步规划。<br>
    <strong>实际录取标准请以各大学官方网站为准：</strong>
    <ul style="margin-top: 10px;">
        <li>访问大学官网查看最新要求</li>
        <li>与学校Guidance Counselor确认申请策略</li>
        <li>不同专业的录取要求可能有显著差异</li>
    </ul>
    数据最后更新：2026年2月
</div>
```

---

## 🎯 系统的正确使用方式

1. **规划工具**：使用本系统追踪个人学分、计算GPA、管理申请截止日期

2. **参考而非依赖**：将系统中的大学GPA要求仅作为**粗略参考**
   - "Safe"学校 = 你有较高可能被录取
   - "Target"学校 = 你的背景与之匹配
   - "Reach"学校 = 需要更强的申请背景

3. **定期核实**：在提交申请前，**必须**上官网确认：
   - 最新的GPA要求
   - 所需课程（ENG4U、MCV4U等）
   - 补充材料（PS、推荐信、作品集）
   - 申请截止日期（OUAC有多个deadline）

4. **个性化调整**：系统中的数据是大学**整体**水平，具体专业（如滑铁卢CS vs Arts）差异巨大，需手动调整期望。

---

## 📊 数据质量改进建议

如果希望提升数据准确性，可考虑：

1. **添加数据来源标注**：为每所大学标注数据获取时间和来源URL

2. **分专业存储数据**：将笼统的"MinGPA"细化为各专业的具体要求

3. **定期更新机制**：每学期检查并更新数据

4. **用户反馈机制**：允许用户报告数据偏差

5. **链接到官网**：每个大学卡片直接链接到该校招生页面

---

## ❓ 为什么使用硬编码数据？

**设计考量**：
- Classic ASP + Access技术栈不支持现代API集成
- 安省大学没有统一的开放API供抓取
- 录取数据复杂（分专业、分年份、分国籍），难以标准化
- 定位是"个人规划工具"而非"官方信息平台"

---

## 责任声明

**开发者声明**：
- 本系统旨在帮助学生组织申请流程、管理个人进度
- 开发者不对因使用系统中数据而导致的申请决策错误承担责任
- 用户有责任核实所有关键信息并咨询专业升学顾问

**教育机构声明**（如学校部署使用）：
建议在系统首页明确标注：
> "本系统由[学校名称]维护，数据仅供参考。请以各大学官网和OUAC为准。"

---

**最后更新**: 2026-02-13  
**文档版本**: v1.0
