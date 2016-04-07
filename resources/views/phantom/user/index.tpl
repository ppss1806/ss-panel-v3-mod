{include file='user/main.tpl'}



<div id="main">
	<div class="inner">
		<!-- Content Header (Page header) -->
		<section>
			<h1>
				用户中心
			</h1>
		</section>

		<!-- Main content -->
		<section>
			<!-- START PROGRESS BARS -->
			

				<div class="12u 12u$(medium)">
					<h3>公告</h3>
					<table class="table-wrapper" style="table-layout:fixed;word-wrap:break-word;word-break;break-all;">
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
				
				
				<div class="12u 12u$(medium)">
					<h3>FAQ</h3>
					
					<p>流量不会重置，可以通过续命获取流量。</p>

                    <p>每次续命可以获取{$config['checkinMin']}~{$config['checkinMax']}MB流量。</p>
				</div>
				
				<div class="12u 12u$(medium)">
					<h3>帐号使用情况</h3>

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
				
				
				<div class="12u 12u$(medium)">
					<h3>流量使用情况</h3>

                    <div class="progress progress-striped">
						<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="40"
							 aria-valuemin="0" aria-valuemax="100"
							 style="width: {$user->trafficUsagePercent()}%">
							<span class="sr-only">Transfer</span>
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
				
				
				<div class="12u 12u$(medium)">
					<h3>续命获取流量</h3>

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
				
				
				<div class="12u 12u$(medium)">
					<h3>连接信息</h3>

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
				
				{if $duoshuo_shortname!=""}
				<div class="12u 12u$(medium)">
					<h3>讨论区</h3>

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
				</div>
				{/if}
				
		</section>
		<!-- /.content -->

	</div>
</div>





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