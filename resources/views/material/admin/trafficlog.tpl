






{include file='admin/main.tpl'}







	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">流量使用记录</h1>
			</div>
		</div>
		<div class="container">
			<div class="col-lg-12 col-lg-push-0 col-sm-10 col-sm-push-1">
				<section class="content-inner margin-top-no">
				
					<div class="card">
						<div class="card-main">
							<div class="card-inner">
								<p>部分节点不支持流量记录.</p>
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
                                <th>使用节点</th>
                                <th>倍率</th>
                                <th>实际使用流量</th>
                                <th>结算流量</th>
                                <th>记录时间</th>
                            </tr>
                            {foreach $logs as $log}
								{if $log->user()!=NULL}
									<tr>
										<td>#{$log->id}</td>
										<td>{$log->user_id}</td>
										<td>{$log->user()->user_name}</td>
										<td>{$log->node()->name}</td>
										<td>{$log->rate}</td>
										<td>{$log->totalUsed()}</td>
										<td>{$log->traffic}</td>
										<td>{$log->logTime()}</td>
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



