{include file='admin/main.tpl'}







	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">汇总</h1>
			</div>
		</div>
		<div class="container">
			<section class="content-inner margin-top-no">
				<div class="row">
					<div class="col-lg-8 col-md-9">
						<div class="card margin-bottom-no">
							<div class="card-main">
								<div class="card-inner">
									<p>下面是系统运行情况简报。</p>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="ui-card-wrap">
					<div class="row">
						<div class="col-lg-4 col-sm-6">
							<div class="card">
								<div class="card-main">
									<div class="card-inner">
										<p class="card-heading">总用户</p>
										<p>
											{$sts->getTotalUser()}
										</p>
									</div>
								</div>
							</div>
						</div>
						
						
						<div class="col-lg-4 col-sm-6">
							<div class="card">
								<div class="card-main">
									<div class="card-inner">
										<p class="card-heading">签到用户</p>
										<p>
											{$sts->getCheckinUser()}
										</p>
									</div>
								</div>
							</div>
						</div>
						
						<div class="col-lg-4 col-sm-6">
							<div class="card">
								<div class="card-main">
									<div class="card-inner">
										<p class="card-heading">前一分钟在线用户</p>
										<p>
											{$sts->getOnlineUser(60)}
										</p>
									</div>
								</div>
							</div>
						</div>
						
						
						<div class="col-lg-4 col-sm-6">
							<div class="card">
								<div class="card-main">
									<div class="card-inner">
										<p class="card-heading">前一小时在线用户</p>
										<p>
											{$sts->getOnlineUser(3600)}
										</p>
									</div>
								</div>
							</div>
						</div>
						
						<div class="col-lg-4 col-sm-6">
							<div class="card">
								<div class="card-main">
									<div class="card-inner">
										<p class="card-heading">前一天在线用户</p>
										<p>
											{$sts->getOnlineUser(86400)}
										</p>
									</div>
								</div>
							</div>
						</div>
						
						<div class="col-lg-4 col-sm-6">
							<div class="card">
								<div class="card-main">
									<div class="card-inner">
										<p class="card-heading">节点数</p>
										<p>
											{$sts->getTotalNode()}
										</p>
									</div>
								</div>
							</div>
						</div>
						
						<div class="col-lg-4 col-sm-6">
							<div class="card">
								<div class="card-main">
									<div class="card-inner">
										<p class="card-heading">产生流量</p>
										<p>
											{$sts->getTrafficUsage()}
										</p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
	</main>














{include file='admin/footer.tpl'}