<%
'========================================
' OSSD University Planner - 官方链接汇总
'========================================

'"--
%>
<!-- #include file="includes/db_conn.asp" -->
<!-- #include file="includes/functions.asp" -->
<!-- #include file="includes/header.asp" -->

<div class="container">
    <h1 style="color:var(--primary); margin-bottom:20px;">🔗 官方招生链接汇总</h1>
    
    <div class="card" style="background: #fff3cd; border-left: 5px solid #ffc107; margin-bottom: 20px;">
        <p style="color: #856404; margin: 0;">
            <strong>⚠️ 提醒：</strong>以下链接指向各校官方招生页面，请以官网信息为准。
        </p>
    </div>

    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(350px, 1fr)); gap: 20px;">
        
        <!-- Tier 1: 顶尖高竞争 -->
        <div class="card">
            <h3 style="color: #dc3545;">🔴 顶尖高竞争 (High Reach)</h3>
            <table class="data-table" style="font-size: 0.9rem;">
                <tr>
                    <td><strong>多伦多大学</strong><br><small>General: 3.8+ | 工程: 3.95+</small></td>
                    <td style="text-align: right;">
                        <a href="https://future.utoronto.ca" target="_blank" class="btn btn-sm btn-primary">官网</a>
                        <br><small style="color: #dc3545;">需核实专业要求</small>
                    </td>
                </tr>
                <tr>
                    <td><strong>滑铁卢大学</strong><br><small>工程/CS: 3.9+ | 其他: 3.7+</small></td>
                    <td style="text-align: right;">
                        <a href="https://uwaterloo.ca/future-students" target="_blank" class="btn btn-sm btn-primary">官网</a>
                        <br><small style="color: #dc3545;">部分需面试</small>
                    </td>
                </tr>
                <tr>
                    <td><strong>麦克马斯特大学</strong><br><small>健康科学: 3.9+ | 其他: 3.7+</small></td>
                    <td style="text-align: right;">
                        <a href="https://future.mcmaster.ca" target="_blank" class="btn btn-sm btn-primary">官网</a>
                    </td>
                </tr>
            </table>
        </div>

        <!-- Tier 2: 传统名校 -->
        <div class="card">
            <h3 style="color: #ffc107;">🟡 传统名校 (Moderate Reach)</h3>
            <table class="data-table" style="font-size: 0.9rem;">
                <tr>
                    <td><strong>女王大学</strong><br><small>商科: 3.9+ | 其他: 3.7+</small></td>
                    <td style="text-align: right;">
                        <a href="https://www.queensu.ca/admission" target="_blank" class="btn btn-sm btn-primary">官网</a>
                    </td>
                </tr>
                <tr>
                    <td><strong>西安大略大学</strong><br><small>Ivey AEO: 3.9+ | 其他: 3.6+</small></td>
                    <td style="text-align: right;">
                        <a href="https://welcome.uwo.ca" target="_blank" class="btn btn-sm btn-primary">官网</a>
                    </td>
                </tr>
            </table>
        </div>

        <!-- Tier 3: 综合类 -->
        <div class="card">
            <h3 style="color: #28a745;">🟢 综合类大学 (Target)</h3>
            <table class="data-table" style="font-size: 0.9rem;">
                <tr>
                    <td><strong>约克大学</strong><br><small>Schulich: 3.9+ | 其他: 3.0+</small></td>
                    <td style="text-align: right;">
                        <a href="https://futurestudents.yorku.ca" target="_blank" class="btn btn-sm btn-primary">官网</a>
                    </td>
                </tr>
                <tr>
                    <td><strong>渥太华大学</strong></td>
                    <td style="text-align: right;">
                        <a href="https://admission.uottawa.ca" target="_blank" class="btn btn-sm btn-primary">官网</a>
                    </td>
                </tr>
                <tr>
                    <td><strong>贵湖大学</strong></td>
                    <td style="text-align: right;">
                        <a href="https://www.uoguelph.ca/admission" target="_blank" class="btn btn-sm btn-primary">官网</a>
                    </td>
                </tr>
                <tr>
                    <td><strong>卡尔顿大学</strong></td>
                    <td style="text-align: right;">
                        <a href="https://admissions.carleton.ca" target="_blank" class="btn btn-sm btn-primary">官网</a>
                    </td>
                </tr>
            </table>
        </div>

        <!-- OUAC -->
        <div class="card" style="grid-column: 1 / -1; background: linear-gradient(135deg, #003366 0%, #004d99 100%); color: white;">
            <h2 style="color: white;">📋 OUAC 申请中心 (必用)</h2>
            <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 20px;">
                <div>
                    <p style="font-size: 1.1rem; margin-bottom: 10px;">
                        <strong>Ontario Universities' Application Centre</strong><br>
                        安省大学申请的官方平台
                    </p>
                    <ul style="opacity: 0.9; margin: 0;">
                        <li>提交正式申请</li>
                        <li>查看各大学最新截止日期</li>
                        <li>支付申请费用</li>
                        <li>查询申请状态</li>
                    </ul>
                </div>
                <a href="https://www.ouac.on.ca" target="_blank" style="background: #ffc107; color: #003366; padding: 15px 30px; border-radius: 8px; text-decoration: none; font-weight: bold; white-space: nowrap;">
                    访问 OUAC 官网 &rarr;
                </a>
            </div>
        </div>

        <!-- OUAC 重要日期提醒 -->
        <div class="card" style="grid-column: 1 / -1; background: #f8d7da; border-left: 5px solid #dc3545;">
            <h3 style="color: #721c24;">⏰ OUAC 关键日期参考 (2026年申请季)</h3>
            <p style="color: #721c24;">
                <strong>请以 OUAC 官网最新公布为准：</strong>
            </p>
            <table class="data-table" style="background: white;">
                <tr>
                    <th>通道</th>
                    <th>适用人群</th>
                    <th>截止日期</th>
                </tr>
                <tr>
                    <td>OUAC 101</td>
                    <td>安省在读高中学生</td>
                    <td style="color: #dc3545;"><strong>通常 1月15日左右</strong></td>
                </tr>
                <tr>
                    <td>OUAC 105</td>
                    <td>其他省份/国际学生</td>
                    <td style="color: #dc3545;"><strong>各校不同，通常1-3月</strong></td>
                </tr>
            </table>
            <p style="color: #856404; background: #fff3cd; padding: 15px; margin-top: 15px; border-radius: 8px;">
                <strong>⚠️ 注意：</strong>部分专业（如多伦多大学工程、滑铁卢CS）可能有<strong>特殊早截止日期</strong>，或<strong>补充申请</strong>（如视频面试）要求。
            </p>
        </div>
    </div>

    <div style="text-align: center; margin-top: 30px;">
        <a href="/oup/universities/list.asp" class="btn btn-primary btn-lg">返回大学列表</a>
        <a href="/oup/disclaimer_full.asp" class="btn btn-warning btn-lg" style="margin-left: 15px;">完整免责声明</a>
    </div>
</div>

<!-- #include file="includes/footer.asp" -->
