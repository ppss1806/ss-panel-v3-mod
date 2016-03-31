{include file='admin/main.tpl'}


<div id="main">
	<div class="inner">
		<!-- Content Header (Page header) -->
		<section>
			<h1>
				流量使用记录
			</h1>
		</section>
		
		<div class="12u 12u$(xsmall)">
				<h4>注意!</h4>
                <p>部分节点不支持流量记录.</p>
		</div>
		
		<div class="12u 12u$(xsmall)">
				{$logs->render()}
		</div>
		
		<div class="12u 12u$(xsmall)">
				<div class="table-wrapper">
					
					<table>
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
						{/foreach}
					</table>
					
				</div><!-- /.box-body -->
		</div>
		
		<div class="12u 12u$(xsmall)">
				{$logs->render()}
		</div>
		
	</div>
</div>


{include file='admin/footer.tpl'}