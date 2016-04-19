





{include file='user/main.tpl'}







	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">用户中心</h1>
			</div>
		</div>
		<div class="container">
			<section class="content-inner margin-top-no">
				<div class="row">
					<div class="col-lg-12 col-md-12">
						<div class="card margin-bottom-no">
							<div class="card-main">
								<div class="card-inner">
									<p>欢迎您。</p>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="ui-card-wrap">
					<div class="row">
						<div class="col-lg-12 col-sm-12">
							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<p class="card-heading">注意!</p>
										<p>部分节点不支持流量记录.</p>
										<p>此处只展示最近 72 小时的记录.</p>
									</div>
									
								</div>
							</div>
						</div>
						
						<div class="col-lg-12 col-sm-12">
							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<p class="card-heading">流量记录表</p>
										<div class="card-table">
											<div class="table-responsive">
												<table class="table">
													<tr>
														<th>ID</th>
														<th>使用节点</th>
														<th>结算流量(MB)</th>
														<th>记录时间</th>
													</tr>
													{foreach $logs as $log}
														<tr>
															<td>#{$log["id"]}</td>
															<td>{$log["node"]}</td>
															<td>{$log["d"]}</td>
															<td>{$log["time"]}</td>
														</tr>
													{/foreach}
												</table>
											</div>
										</div>
									</div>
									
								</div>
							</div>
						</div>
						
						
					</div>
				</div>
			</section>
		</div>
	</main>







{include file='user/footer.tpl'}