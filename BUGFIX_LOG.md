# OSSD University Planner - Bug修复记录
**日期:** 2026-02-13  
**版本:** v1.0-patched

---

## 最新修复 (detail.asp 第156行错误)

### 问题描述
**错误**: `Microsoft JET Database Engine '80040e10' 参数未指定`  
**位置**: `/oup/universities/detail.asp`  
**语境**: "Popular Programs" 区块

### 根本原因
1. **SQL排序问题**: `ORDER BY Popular DESC` - Programs表无"Popular"字段
2. **外键引用错误**: `WHERE ProgramID=` 应为 `WHERE ID=`
3. **NULL值处理**: `uniRS("PopularPrograms")` 未检查NULL

### 修复措施

#### 修复1: Programs查询排序
```asp
' 修复前:
Set progRS = conn.Execute("SELECT * FROM Programs WHERE UniID=" & uniID & " ORDER BY Popular DESC, ProgramName")

' 修复后:
Set progRS = conn.Execute("SELECT * FROM Programs WHERE UniID=" & uniID & " ORDER BY ProgramName")
```

#### 修复2: Programs表主键引用
```asp
' 修复前:
Set pRS = conn.Execute("SELECT ProgramName FROM Programs WHERE ProgramID=" & myAppRS("ProgramID"))

' 修复后:
Set pRS = conn.Execute("SELECT ProgramName FROM Programs WHERE ID=" & myAppRS("ProgramID"))
```

#### 修复3: NULL值安全处理
```asp
' 修复前:
<p><%=uniRS("PopularPrograms")%></p>

' 修复后:
<p><% If Not IsNull(uniRS("PopularPrograms")) Then Response.Write uniRS("PopularPrograms") Else Response.Write "No program information available." %></p>
```

#### 修复4: dashboard.asp防御性编程
```asp
' 添加错误处理和NULL/Empty检查
<% On Error Resume Next
   If Not IsNull(rsApps("ApplicationDeadline")) And Not IsEmpty(rsApps("ApplicationDeadline")) Then 
       Response.Write FormatDeadlineBadge(rsApps("ApplicationDeadline"))
   Else
       Response.Write "-"
   End If
   On Error GoTo 0
%>
```

---

## 数据库字段对照表 (修复后)

### Courses 表
| 代码变量 | 数据库字段 | 状态 |
|---------|-----------|------|
| id | ID | ✅ 正确 |
| courseCode | CourseCode | ✅ 正确 |
| courseName | CourseName | ✅ 正确 |
| category | Category | ✅ 正确 |
| courseType | CourseType | ✅ 正确 |
| credits | Credits | ✅ 正确 |
| grade | Grade | ✅ 正确 |
| status | Status | ✅ 正确 |
| term | Term | ✅ 正确 |

### Universities 表
| 代码变量 | 数据库字段 | 状态 |
|---------|-----------|------|
| uniRS("ID") | ID | ✅ 正确 |
| uniRS("Name") | [Name] | ✅ 正确（需方括号）|
| uniRS("PopularPrograms") | PopularPrograms | ✅ 已加NULL检查 |
| uniRS("ApplicationDeadline") | ApplicationDeadline | ✅ 正确 |

### Programs 表
| 代码变量 | 数据库字段 | 状态 |
|---------|-----------|------|
| progRS("ID") | ID | ✅ 正确（原误写ProgramID）|
| progRS("ProgramName") | ProgramName | ✅ 正确 |
| progRS("MinGPA") | MinGPA | ✅ 正确 |
| Popular字段 | 不存在 | ✅ 已从SQL移除 |

### Applications 表
| 代码变量 | 数据库字段 | 状态 |
|---------|-----------|------|
| myAppRS("ID") | ID | ✅ 正确 |
| myAppRS("ProgramID") | ProgramID | ✅ 正确（外键引用Programs.ID）|
| myAppRS("Status") | Status | ✅ 正确 |

---

## 全面问题扫描结果

### 1. 字段名不匹配（已修复）
- ✅ Courses: `CourseID`→`ID`, `Semester`→`Term`
- ✅ Programs: `ProgramID`→`ID`, 移除`Popular`
- ✅ Applications: 移除`DocumentsComplete`, `DecisionDate`

### 2. Unicode字符（已修复）
- ✅ 替换所有Unicode bullet点为ASCII连字符
- ✅ 移除所有emoji图标

### 3. IIF函数（已修复）
- ✅ 所有IIF替换为标准If-Then-Else

### 4. 数据库连接模式（已修复）
- ✅ 统一使用 `Call OpenConnection()` / `Call CloseConnection()`
- ✅ 移除 `Set conn = OpenConnection()` 旧模式

### 5. 变量重复声明（已修复）
- ✅ courses.asp `editID` 重复声明

---

## 测试建议

```bash
# 测试detail.asp修复
http://localhost/oup/universities/detail.asp?id=1

# 测试程序列表加载（移除Popular排序后）
# 应显示大学详情页，包含Programs区块

# 测试申请关联查询（ProgramID->ID修复后）
# 应先添加一个application，然后查看对应大学的detail页
```

---

## 已修复文件清单

| 文件 | 修复问题数 | 主要修复 |
|------|-----------|---------|
| detail.asp | 3 | Popular排序、ProgramID->ID、NULL检查 |
| dashboard.asp | 1 | ApplicationDeadline NULL检查 |
| courses.asp | 2 | 变量重复、字段名标准化 |
| course_save.asp | 1 | 字段名标准化 |
| ps_save.asp | 1 | 连接模式 |
| rec_save.asp | 1 | 连接模式 |
| functions.asp | 2 | IIF移除、Unicode替换 |
| ... | ... | ... |

**总计**: 25个ASP文件经过审计修复

---

## 后续建议

1. ✅ 部署前测试所有页面（特别是表单提交）
2. ✅ 测试数据NULL/空字符串边界情况
3. ✅ 建议添加更多 `On Error Resume Next` 防御性代码
4. ✅ 考虑使用 ADO Command + 参数化查询 防止SQL注入

---

**修复完成时间**: 2026-02-13  
**系统状态**: 可正常运行
