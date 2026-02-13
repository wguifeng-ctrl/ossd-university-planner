<%
'========================================
' OSSD University Planner - 帮助中心 (Help Center)
' Updated: 2026-02-13
'========================================
%>
<!-- #include file="includes/db_conn.asp" -->
<!-- #include file="includes/functions.asp" -->
<!-- #include file="includes/header.asp" -->

<div class="container">
    <h1 style="color:var(--primary); margin-bottom:30px;">OSSD University Planner - 使用帮助</h1>
    
    <div class="card" style="background: #fff3cd; border-left: 5px solid #ffc107;">
        <strong style="color: #856404;">📢 重要提醒：大学数据的参考性质</strong>
        <p style="color: #856404; margin: 10px 0 0 0;">
            本系统中的大学录取数据为<strong>参考性数据</strong>，最后更新于2026年2月。<br>
            实际录取标准请以<strong>各大学官方网站</strong>和<strong>OUAC</strong>公布的最新信息为准。<br>
            <a href="disclaimer_full.asp" style="color: #856404; text-decoration: underline;">查看完整数据声明 &rarr;</a>
        </p>
    </div>

    <div class="card">
        <h2>🚀 快速开始</h2>
        <ol style="line-height:2;">
            <li><strong>设置数据库</strong>: 访问 <a href="create_database.asp">create_database.asp</a> 创建表结构</li>
            <li><strong>加载大学数据</strong>: 访问 <a href="universities/init_universities.asp">init_universities.asp</a></li>
            <li><strong>注册账户</strong>: 访问 <a href="register.asp">register.asp</a></li>
            <li><strong>开始使用</strong>: 登录后添加课程，追踪学分和申请</li>
        </ol>
    </div>

    <div class="card">
        <h2>📚 常用功能</h2>
        <table class="data-table">
            <tr>
                <th>功能</th>
                <th>访问路径</th>
                <th>说明</th>
            </tr>
            <tr>
                <td>我的学分</td>
                <td><a href="ossd/credits.asp">ossd/credits.asp</a></td>
                <td>查看30学分进度和OSSD要求</td>
            </tr>
            <tr>
                <td>添加课程</td>
                <td><a href="ossd/courses.asp">ossd/courses.asp</a></td>
                <td>录入课程成绩，计算GPA</td>
            </tr>
            <tr>
                <td>浏览大学</td>
                <td><a href="universities/list.asp">universities/list.asp</a></td>
                <td>查询安省22所大学信息</td>
            </tr>
            <tr>
                <td>大学详情</td>
                <td><a href="universities/detail.asp?id=1">detail.asp?id=1</a></td>
                <td>查看具体大学录取要求</td>
            </tr>
            <tr>
                <td>智能匹配</td>
                <td><a href="universities/matcher.asp">universities/matcher.asp</a></td>
                <td>根据GPA匹配适合的学校</td>
            </tr>
            <tr>
                <td>申请管理</td>
                <td><a href="applications/dashboard.asp">applications/dashboard.asp</a></td>
                <td>追踪申请状态和截止日期</td>
            </tr>
            <tr>
                <td>个人陈述编辑器</td>
                <td><a href="applications/ps_editor.asp">ps_editor.asp</a></td>
                <td>分段写作指导与版本管理</td>
            </tr>
        </table>
    </div>

    <div class="card">
        <h2>🔍 数据验证与维护工具 (New)</h2>
        <p style="color:#6c757d; margin-bottom:15px;">由于大学录取数据需定期从官网核实，系统提供以下辅助工具：</p>
        
        <table class="data-table">
            <tr>
                <th>工具</th>
                <th>访问路径</th>
                <th>功能说明</th>
            </tr>
            <tr>
                <td>数据验证控制台</td>
                <td><a href="data_verification.asp">data_verification.asp</a></td>
                <td>测试22所大学官网连通性，快捷跳转编辑</td>
            </tr>
            <tr>
                <td>数据编辑器</td>
                <td><a href="data_edit.asp?id=1">data_edit.asp?id=1</a></td>
                <td>修改特定大学的GPA、截止日期、课程要求</td>
            </tr>
            <tr>
                <td>官方链接导航</td>
                <td><a href="official_links.asp">official_links.asp</a></td>
                <td>直达22所大学官网招生页面及OUAC</td>
            </tr>
            <tr>
                <td>数据声明</td>
                <td><a href="disclaimer_full.asp">disclaimer_full.asp</a></td>
                <td>完整数据来源说明与责任声明</td>
            </tr>
        </table>

        <div style="background: #d4edda; border-left: 5px solid #28a745; padding: 15px; margin-top: 20px; border-radius: 8px;">
            <strong style="color: #155724;">📋 推荐使用流程：</strong>
            <ol style="color: #155724; margin: 10px 0 0 0; line-height: 1.8;">
                <li>访问 <a href="official_links.asp" style="color: #155724; text-decoration: underline;">官方链接导航</a> 找到目标大学</li>
                <li>点击链接进入大学官网 → Admissions/Future Students 页面</li>
                <li>记录最新要求（GPA、截止日期、必修课程）</li>
                <li>返回本系统，使用 <a href="data_edit.asp?id=1" style="color: #155724; text-decoration: underline;">数据编辑器</a> 更新</li>
                <li>查看 <a href="DATA_UPDATE_GUIDE.md" style="color: #155724; text-decoration: underline;">数据更新指南</a> 了解详细步骤</li>
            </ol>
        </div>
    </div>

    <div class="card">
        <h2>🌐 外部资源链接</h2>
        <div style="display:grid; grid-template-columns:repeat(auto-fit, minmax(300px, 1fr)); gap:15px;">
            <div style="padding:15px; background:#f8f9fa; border-radius:8px;">
                <strong>官方申请平台</strong>
                <ul style="margin:10px 0 0 0;">
                    <li><a href="https://www.ouac.on.ca" target="_blank">OUAC 官网</a> - 提交正式申请</li>
                    <li><a href="https://ouac.ouinfo.ca" target="_blank">OUInfo</a> - 大学信息查询</li>
                </ul>
            </div>
            <div style="padding:15px; background:#f8f9fa; border-radius:8px;">
                <strong>热门大学直达</strong>
                <ul style="margin:10px 0 0 0;">
                    <li><a href="https://future.utoronto.ca" target="_blank">多伦多大学</a></li>
                    <li><a href="https://uwaterloo.ca/future-students" target="_blank">滑铁卢大学</a></li>
                    <li><a href="https://future.mcmaster.ca" target="_blank">麦克马斯特大学</a></li>
                </ul>
            </div>
        </div>
    </div>

    <div class="card">
        <h2>❓ 常见问题 (FAQ)</h2>
        
        <h4>Q: GPA显示为0怎么办？</h4>
        <p>确保课程状态设置为 "Completed"，系统只计算已完成课程的GPA。未完成或计划的课程不计入。</p>
        
        <h4 style="margin-top:20px;">Q: Top 6 GPA是什么？</h4>
        <p>安省大学录取核心指标，取最高的6门U/M等级课程的平均成绩。需在课程管理中正确设置Course Type（U/M/C）。
        <br><strong>计算方式</strong>: 系统会自动识别Grade 12 (MK=12)的U/M课程，取最高的6门计算。</p>
        
        <h4 style="margin-top:20px;">Q: 如何添加课程？</h4>
        <p>访问 <a href="ossd/courses.asp">课程管理</a> → 点击"添加课程" → 填写:
        <br>- Course Code（如 ENG4U, MCV4U, SBI4U）
        <br>- Category（ENG/MTH/SCI等）
        <br>- Course Type（U=大学预备, M=大学/学院, C=学院, O=开放）
        <br>- Grade（成绩百分比）
        <br>- Status（Completed/In Progress/Planned）</p>
        
        <h4 style="margin-top:20px;">Q: 系统中的大学数据准确吗？</h4>
        <p>数据为<strong>参考性</strong>，来源于2026年2月的公开信息整合。录取标准每年变化，且因专业而异：
        <br>- 工程/CS通常要求3.9+ GPA
        <br>- 商科通常要求3.8+ GPA  
        <br>- 文科通常要求3.3-3.5 GPA
        <br>请以<a href="official_links.asp">大学官网</a>为准。</p>
        
        <h4 style="margin-top:20px;">Q: 如何更新大学数据？</h4>
        <p>管理员/学校顾问可访问 <a href="data_verification.asp">数据验证控制台</a> 进行批量检查，或使用 <a href="data_edit.asp?id=1">数据编辑器</a> 单独修改。建议每学期（10-11月）统一更新一次。</p>

        <h4 style="margin-top:20px;">Q: 截止日期提醒怎么看？</h4>
        <p>🔴 红色 = 紧急（≤3天）<br>
           🟡 黄色 = 警告（≤14天）<br>
           🔵 蓝色 = 正常（>14天）<br>
           <br>注意：OUAC 101通道（安省在读生）通常1月中旬截止，105通道（外省/国际生）各校不同。</p>
    </div>

    <div class="card">
        <h2>📝 常用课程代码参考</h2>
        <div style="display:grid; grid-template-columns:repeat(auto-fit, minmax(200px, 1fr)); gap:15px;">
            <div>
                <strong>英语/社科 (必选ENG4U)</strong><br>
                <small>
                ENG4U - 12年级英语<br>
                CIA4U - 经济<br>
                HHS4U - 社会<br>
                HZT4U - 哲学
                </small>
            </div>
            <div>
                <strong>数学 (申请工程/商科必选MCV4U)</strong><br>
                <small>
                MHF4U - 高等函数<br>
                MCV4U - 微积分与矢量<br>
                MDM4U - 数据管理<br>
                MGA4U - 数学建模
                </small>
            </div>
            <div>
                <strong>科学</strong><br>
                <small>
                SBI4U - 生物<br>
                SCH4U - 化学<br>
                SPH4U - 物理<br>
                SES4U - 地球与空间
                </small>
            </div>
            <div>
                <strong>计算机/技术</strong><br>
                <small>
                ICS4U - 计算机科学<br>
                ICS4C - 计算机编程<br>
                IDC4U - 跨学科研究<br>
                TGJ4M - 传媒技术
                </small>
            </div>
        </div>
    </div>

    <div class="card">
        <h2>📄 项目文档</h2>
        <table class="data-table">
            <tr>
                <th>文档</th>
                <th>用途</th>
                <th>查看</th>
            </tr>
            <tr>
                <td>用户手册</td>
                <td>完整中文使用指南</td>
                <td><a href="USER_MANUAL.md">USER_MANUAL.md</a></td>
            </tr>
            <tr>
                <td>数据更新指南</td>
                <td>如何核实和更新大学数据</td>
                <td><a href="DATA_UPDATE_GUIDE.md">DATA_UPDATE_GUIDE.md</a></td>
            </tr>
            <tr>
                <td>数据来源声明</td>
                <td>数据来源说明与限制</td>
                <td><a href="DATA_SOURCES_AND_DISCLAIMER.md">DATA_SOURCES.md</a></td>
            </tr>
            <tr>
                <td>项目说明书</td>
                <td>技术架构与功能清单</td>
                <td><a href="README.md">README.md</a></td>
            </tr>
            <tr>
                <td>Bug修复日志</td>
                <td>已知问题与修复记录</td>
                <td><a href="BUGFIX_LOG.md">BUGFIX_LOG.md</a></td>
            </tr>
            <tr>
                <td>代码审计报告</td>
                <td>代码质量检查报告</td>
                <td><a href="AUDIT_REPORT.md">AUDIT_REPORT.md</a></td>
            </tr>
        </table>
    </div>

    <div class="card">
        <h2>🔧 系统维护</h2>
        <ul>
            <li><a href="create_database.asp">重建数据库表</a> - 如需重置表结构（会清空所有数据！）</li>
            <li><a href="universities/init_universities.asp">刷新大学数据</a> - 恢复22所大学基础数据</li>
            <li><a href="data_verification.asp">验证数据状态</a> - 检查各大学官网连通性</li>
        </ul>
        <p style="color:#dc3545;"><strong>注意</strong>: "重建数据库表"会清空学生账户和所有数据，请绝对谨慎操作！</p>
    </div>

    <div style="text-align:center; margin-top:30px;">
        <a href="default.asp" class="btn btn-primary btn-lg">返回仪表盘</a>
        <a href="official_links.asp" class="btn btn-success btn-lg" style="margin-left:15px;">官方链接导航</a>
    </div>
</div>

<!-- #include file="includes/footer.asp" -->
