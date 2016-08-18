


{include file='admin/main.tpl'}







	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">审计记录查看</h1>
			</div>
		</div>
		<div class="container">
			<div class="col-lg-12 col-md-12">
				<section class="content-inner margin-top-no">
					
					<div class="card">
						<div class="card-main">
							<div class="card-inner">
								<p>系统中所有审计记录。</p>
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
						        <th>节点ID</th>
						        <th>节点名称</th>
						        <th>规则ID</th>
						        <th>名称</th>
						        <th>描述</th>
							<th>正则表达式</th>
							<th>类型</th>
							<th>时间</th>
								
						    </tr>
						    {foreach $logs as $log}
						        <tr>
								<td>#{$log->id}</td>
								<td>{$log->user_id}</td>
								<td>{$log->User()->user_name}</td>
								<td>{$log->node_id}</td>
								<td>{$log->Node()->name}</td>
								<td>{$log->list_id}</td>
								<td>{$log->DetectRule()->name}</td>
								<td>{$log->DetectRule()->text}</td>
								<td>{$log->DetectRule()->regex}</td>
								{if $log->DetectRule()->type == 1}
									<td>数据包明文匹配</td>
								{/if}		
								<td>{date('Y-m-d H:i:s',$log->datetime)}</td>						
						        </tr>
						    {/foreach}
						</table>
						{$logs->render()}
					</div>
					

							
			</div>
			
			
			
		</div>
	</main>






{include file='admin/footer.tpl'}








