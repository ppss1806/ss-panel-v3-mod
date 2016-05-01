{include file='user/main.tpl'}

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            用户中心
            <small>User Center</small>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <!-- START PROGRESS BARS -->
        <div class="row">
		
		
			<div class="col-md-6">
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-bullhorn"></i>

                        <h3 class="box-title">公告</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <table class="table table-hover" style="table-layout:fixed;word-wrap:break-word;word-break;break-all;">
                            <tr>
                                <th>ID</th>
                                <th>日期</th>
                                <th>内容</th>
                            </tr>
                            {foreach $anns as $ann}
                                <tr>
                                    <td>#{$ann->id}</td>
                                    <td>{$ann->date}</td>
                                    <td>{$ann->content}</td>
                                </tr>
                            {/foreach}
                        </table>
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col (right) -->
			
			
			<div class="col-md-6">
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-lock" aria-hidden="true"></i>

                        <h3 class="box-title">最近一天使用IP</h3>
                    </div>
                    <!-- /.box-header -->
					
					<div class="box-body">
                        <p>请确认都为自己的IP，如有异常请及时修改连接密码。部分节点不支持记录。</p>

                    </div>
                    <div class="box-body">
                        <table class="table table-hover" style="table-layout:fixed;word-wrap:break-word;word-break;break-all;">
                            <tr>
                                
                                <th>IP</th>
                                <th>归属地</th>
                            </tr>
                            {foreach $userip as $single=>$location}
                                <tr>
                                    
                                    <td>{$single}</td>
                                    <td>{$location}</td>
                                </tr>
                            {/foreach}
                        </table>
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col (right) -->
			
			
			<div class="col-md-6">
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-lock" aria-hidden="true"></i>

                        <h3 class="box-title">最近10次登陆IP</h3>
                    </div>
                    <!-- /.box-header -->
					
					<div class="box-body">
                        <p>请确认都为自己的IP，如有异常请及时修改密码。</p>

                    </div>
                    <div class="box-body">
                        <table class="table table-hover" style="table-layout:fixed;word-wrap:break-word;word-break;break-all;">
                            <tr>
                                
                                <th>IP</th>
                                <th>归属地</th>
                            </tr>
                            {foreach $userloginip as $single=>$location}
                                <tr>
                                    
                                    <td>{$single}</td>
                                    <td>{$location}</td>
                                </tr>
                            {/foreach}
                        </table>
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col (right) -->
		
		
		
            <div class="col-md-6">
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-bullhorn"></i>

                        <h3 class="box-title">FAQ</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <p>流量不会重置，可以通过续命获取流量。</p>

                        <p>每次续命可以获取{$config['checkinMin']}~{$config['checkinMax']}MB流量。</p>

                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col (right) -->
			
			<div class="col-md-6">
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-clock-o"></i>

                        <h3 class="box-title">帐号使用情况</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                     
                        <dl class="dl-horizontal">
                            <dt>帐号等级</dt>
                            <dd>{$user->class}</dd>

							<dt>等级过期时间</dt>
                            <dd>{$user->class_expire}</dd>

                            <dt>帐号过期时间</dt>
                            <dd>{$user->expire_in}</dd>
							
							<dt>速度限制</dt>
							{if $user->node_speedlimit!=0}
							<dd>{$user->node_speedlimit}Mbps</dd>
							{else}
							<dd>不限速</dd>
							{/if}
                        </dl>
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col (left) -->
			

            <div class="col-md-6">
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-exchange"></i>

                        <h3 class="box-title">流量使用情况</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="progress progress-striped">
                                    <div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="40"
                                         aria-valuemin="0" aria-valuemax="100"
                                         style="width: {$user->trafficUsagePercent()}%">
                                        <span class="sr-only">Transfer</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <dl class="dl-horizontal">
                            <dt>总流量</dt>
                            <dd>{$user->enableTraffic()}</dd>

							<dt>今日使用流量</dt>
                            <dd>{(($user->u+$user->d)-$user->last_day_t)/1024/1024}MB</dd>

                            <dt>总已用流量</dt>
                            <dd>{$user->usedTraffic()}</dd>
                            <dt>剩余流量</dt>
                            <dd>{$user->unusedTraffic()}</dd>
                        </dl>
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col (left) -->

            <div class="col-md-6">
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-pencil"></i>

                        <h3 class="box-title">续命获取流量</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <p> 每天可以续命一次。</p>

                        <p>上次续命时间：<code>{$user->lastCheckInTime()}</code></p>
                        {if $user->isAbleToCheckin() }
                            <p id="checkin-btn">
                                <button id="checkin" class="btn btn-success  btn-flat">续命</button>
                            </p>
                        {else}
                            <p><a class="btn btn-success btn-flat disabled" href="#">不能续命</a></p>
                        {/if}
                        <p id="checkin-msg"></p>
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col (right) -->

            <div class="col-md-6">
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa  fa-paper-plane"></i>

                        <h3 class="box-title">连接信息</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <dl class="dl-horizontal">
                            <dt>端口</dt>
                            <dd>{$user->port}</dd>
                            <dt>密码</dt>
                            <dd>{$user->passwd}</dd>
                            <!--
                            <dt>加密方式</dt>
                            <dd>{$user->method}</dd>
                            -->
                            <dt>上次使用</dt>
                            <dd>{$user->lastSsTime()}</dd>
                        </dl>
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col (right) -->
        
			{if $duoshuo_shortname!=""}
			<div class="col-md-6">
							<div class="box box-primary">
								<div class="box-header">
									<i class="fa  fa-comment"></i>

									<h3 class="box-title">讨论区</h3>
								</div>
								<!-- /.box-header -->
								<div class="box-body">
									<dl class="dl-horizontal">
										


				<div class="ds-thread" data-thread-key="0" data-title="index" data-url="{$baseUrl}/user/"></div>
				<script type="text/javascript">
				var duoshuoQuery = {

				short_name:"{$duoshuo_shortname}"


				};
					(function() {
						var ds = document.createElement('script');
						ds.type = 'text/javascript';ds.async = true;
						ds.src = (document.location.protocol == 'https:' ? 'https:' : 'http:') + '//static.duoshuo.com/embed.js';
						ds.charset = 'UTF-8';
						(document.getElementsByTagName('head')[0] 
						 || document.getElementsByTagName('body')[0]).appendChild(ds);
					})();
				</script>




                        </dl>
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col (right) -->
			{/if}

</div>


        <!-- /.row --><!-- END PROGRESS BARS -->
    </section>
    <!-- /.content -->
</div><!-- /.content-wrapper -->

<script>
    $(document).ready(function () {
        $("#checkin").click(function () {
            $.ajax({
                type: "POST",
                url: "/user/checkin",
                dataType: "json",
                success: function (data) {
                    $("#checkin-msg").html(data.msg);
                    $("#checkin-btn").hide();
                },
                error: function (jqXHR) {
                    alert("发生错误：" + jqXHR.status);
                }
            })
        })
    })
</script>


{include file='user/footer.tpl'}