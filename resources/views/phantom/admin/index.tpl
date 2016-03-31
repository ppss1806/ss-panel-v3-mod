{include file='admin/main.tpl'}
<div id="main">
	<div class="inner">
		<!-- Content Header (Page header) -->
		<section>
			<h1>
				管理中心
			</h1>
		</section>

		<!-- Main content -->
		<section>
			<!-- START PROGRESS BARS -->
			

				<div class="4u 12u$(medium)">
					<h3>总用户</h3>
					<ul>
						<li>{$sts->getTotalUser()}</li>
					</ul>
				</div>
				
				<div class="4u 12u$(medium)">
					<h3>签到用户</h3>
					<ul>
						<li>{$sts->getCheckinUser()}</li>
					</ul>
				</div>
			
			
				<div class="4u 12u$(medium)">
					<h3>前一分钟在线用户</h3>
					<ul>
						<li>{$sts->getOnlineUser(60)}</li>
					</ul>
				</div>
			
				<div class="4u 12u$(medium)">
					<h3>前一小时在线用户</h3>
					<ul>
						<li>{$sts->getOnlineUser(3600)}</li>
					</ul>
				</div>

				<div class="4u 12u$(medium)">
					<h3>前一天在线用户</h3>
					<ul>
						<li>{$sts->getOnlineUser(86400)}</li>
					</ul>
				</div>

				<div class="4u 12u$(medium)">
					<h3>节点数</h3>
					<ul>
						<li>{$sts->getTotalNode()}</li>
					</ul>
				</div>

				<div class="4u 12u$(medium)">
					<h3>产生流量</h3>
					<ul>
						<li>{$sts->getTrafficUsage()}</li>
					</ul>
				</div>
		</section>
		<!-- /.content -->

	</div>
</div>
{include file='admin/footer.tpl'}