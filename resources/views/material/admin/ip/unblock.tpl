

{include file='admin/main.tpl'}







	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">解封IP记录</h1>
			</div>
		</div>
		<div class="container">
			<div class="col-lg-12 col-sm-12">
				<section class="content-inner margin-top-no">
					
					<div class="card">
						<div class="card-main">
							<div class="card-inner">
								<p>这里是最近的解封IP记录。</p>
							</div>
						</div>
					</div>
					
					<div class="table-responsive">
						{$logs->render()}
						
						<table class="table">
							<tr>
								<th>ID</th>
								<th>用户ID</th>
								<th>用户名</th>
								<th>IP</th>
								<th>归属地</th>
								<th>时间</th>
							</tr>
							{foreach $logs as $log}
								{if $log->user()!=NULL}
									<tr>
										<td>#{$log->id}</td>
										<td>{$log->user()->id}</td>
										<td>{$log->user()->user_name}</td>
										<td>{$log->ip}</td>
										<td>{$loc[$log->ip]}</td>
										<td>{$log->time()}</td>
									</tr>
								{/if}
							{/foreach}
						</table>
                        {$logs->render()}
					</div>

							
			</div>
			
			
			
		</div>
	</main>












{include file='admin/footer.tpl'}

