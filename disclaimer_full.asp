<%
'========================================
' OSSD University Planner - 数据来源完整声明
'========================================

'"--
%>
<!-- #include file="includes/db_conn.asp" -->
<!-- #include file="includes/functions.asp" -->
<!-- #include file="includes/header.asp" -->

<div class="container">
    <h1 style="color:var(--danger); margin-bottom:30px;">⚠️ 数据来源与免责声明</h1>
    
    <div class="card" style="border-left: 5px solid #dc3545;">
        <h2 style="color: #dc3545;">重要提示</h2>
        <p style="font-size: 1.1rem; line-height: 1.8; color: #721c24; background: #f8d7da; padding: 15px; border-radius: 8px;">
            <strong>本系统中的大学录取数据仅供参考，不构成官方录取标准。</strong><br>
            学生在做出升学决策前，<strong>务必直接查阅各大学官方网站的最新录取要求</strong>。
        </p>
    </div>

    <div class="card">
        <h2>📊 数据来源说明</h2>
        <table class="data-table">
            <tr>
                <th>项目</th>
                <th>说明</th>
            </tr>
            <tr>
                <td>数据位置</td>
                <td>硬编码在系统文件中（非实时API）</td>
            </tr>
            <tr>
                <td>数据性质</td>
                <td>示例性参考数据，用于功能演示</td>
            </tr>
            <tr>
                <td>最后更新</td>
                <td>2026年2月</td>
            </tr>
            <tr>
                <td>准确性</td>
                <td>基于公开信息整合，<strong style="color:#dc3545;">不保证与官方一致</strong></td>
            </tr>
        </table>
    </div>

    <div class="card">
        <h2>⚡ 数据局限性</h2>
        <ol style="line-height: 2; font-size: 1.05rem;">
            <li><strong>非官方数据源</strong>：数据来源于公开信息整合，并非直接来自各大学招生办公室</li>
            <li><strong>时效性问题</strong>：录取要求每年变化，系统数据不会自动更新</li>
            <li><strong>专业差异未体现</strong>：工程、商科、文科的GPA要求差异巨大，系统内为统一估计值</li>
            <li><strong>简化处理</strong>：截止日期统一示例设置，实际各校不同</li>
            <li><strong>录取复杂性</strong>：实际录取远超GPA，还包括PS、推荐信、面试、课外活动等</li>
        </ol>
    </div>

    <div class="card" style="background: linear-gradient(135deg, #003366 0%, #004d99 100%); color: white;">
        <h2 style="color: white;">✅ 官方核实渠道（必读）</h2>
        <p style="opacity: 0.9; margin-bottom: 20px;">学生<strong>必须</strong>通过以下官方渠道核实信息：</p>
        
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px;">
            <div style="background: rgba(255,255,255,0.1); padding: 20px; border-radius: 8px;">
                <h4 style="color: white; margin-top: 0;">1. OUAC官网</h4>
                <p style="opacity: 0.9;">安省大学申请官方平台</p>
                <a href="https://www.ouac.on.ca" target="_blank" style="color: #ffc107; text-decoration: underline;">www.ouac.on.ca</a>
            </div>
            <div style="background: rgba(255,255,255,0.1); padding: 20px; border-radius: 8px;">
                <h4 style="color: white; margin-top: 0;">2. 各大学官网</h4>
                <p style="opacity: 0.9;">查看具体专业和最新要求</p>
                <a href="/oup/universities/list.asp" style="color: #ffc107; text-decoration: underline;">查看系统中的大学列表 &rarr;</a>
            </div>
            <div style="background: rgba(255,255,255,0.1); padding: 20px; border-radius: 8px;">
                <h4 style="color: white; margin-top: 0;">3. 学校升学指导</h4>
                <p style="opacity: 0.9;">与Guidance Counselor定期会面</p>
                <span style="color: #ffc107;">联系所在高中的升学办公室</span>
            </div>
        </div>
    </div>

    <div class="card">
        <h2>🎯 系统的正确使用方式</h2>
        <div style="background: #d4edda; padding: 20px; border-radius: 8px; border-left: 5px solid #28a745;">
            <p style="margin: 0; line-height: 1.8;"><strong>✓ 推荐使用：</strong></p>
            <ul style="margin-top: 10px; line-height: 1.8;">
                <li>追踪个人30学分进度和GPA</li>
                <li>管理申请截止日期和待办事项</li>
                <li>作为<strong>初步筛选</strong>工具快速了解22所大学</li>
                <li>记录和修改个人陈述草稿</li>
            </ul>
        </div>
        
        <div style="background: #f8d7da; padding: 20px; border-radius: 8px; border-left: 5px solid #dc3545; margin-top: 20px;">
            <p style="margin: 0; line-height: 1.8;"><strong>✗ 请勿单独依赖：</strong></p>
            <ul style="margin-top: 10px; line-height: 1.8;">
                <li>系统中的GPA要求决定申请策略</li>
                <li>系统中的截止日期作为最终参照</li>
                <li>系统中的专业列表作为完整信息</li>
            </ul>
        </div>
    </div>

    <div class="card">
        <h2>🏫 核实数据示例</h2>
        <p>以多伦多大学为例：</p>
        <table class="data-table">
            <tr>
                <th>项目</th>
                <th>系统中数据</th>
                <th>实际（2026年）需核实</th>
            </tr>
            <tr>
                <td>最低GPA</td>
                <td>3.8</td>
                <td>工程学院可能3.9+，文科可能3.5</td>
            </tr>
            <tr>
                <td>ENG4U</td>
                <td>必须</td>
                <td>大部分专业需要，但可能有例外</td>
            </tr>
            <tr>
                <td>截止日期</td>
                <td>2026-01-15</td>
                <td>OUAC 105通道通常是1月中，101通道可能不同</td>
            </tr>
            <tr>
                <td>补充材料</td>
                <td>未显示</td>
                <td>部分专业需要视频面试（如Rotman）</td>
            </tr>
        </table>
        <p style="margin-top: 15px; color: #856404; background: #fff3cd; padding: 15px; border-radius: 8px;">
            <strong>结论：</strong>即使是同一所大学，不同专业的要求差异巨大。系统提供的是大学整体水平估计，具体专业要求必须查看官网。
        </p>
    </div>

    <div class="card" style="background: #f8f9fa;">
        <h2>📞 责任声明</h2>
        <p style="line-height: 1.8;">
            <strong>开发者声明：</strong><br>
            本系统旨在帮助学生组织申请流程、管理个人进度。开发者不对因使用系统中数据而导致的申请决策错误承担责任。用户有责任核实所有关键信息并咨询专业升学顾问。
        </p>
    </div>

    <div style="text-align: center; margin-top: 30px;">
        <a href="/oup/default.asp" class="btn btn-primary btn-lg">返回仪表盘</a>
        <a href="/oup/universities/list.asp" class="btn btn-success btn-lg" style="margin-left: 15px;">查看大学列表</a>
    </div>
</div>

<!-- #include file="includes/footer.asp" -->
