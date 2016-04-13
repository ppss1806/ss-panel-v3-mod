{include file='admin/main.tpl'}


<div id="main">
	<div class="inner">
		<!-- Content Header (Page header) -->
		<section>
			<h1>
				节点在线IP
			</h1>
		</section>
		
		<div class="12u 12u$(xsmall)">
			<p>部分节点不支持记录 </p>
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
						<th>IP</th>
						<th>归属地</th>
						<th>节点ID</th>
						<th>节点名称</th>
					</tr>
					{foreach $logs as $log}
						<tr>
							<td>#{$log->id}</td>
							<td>{$log->userid}</td>
							<td>{$log->user()->user_name}</td>
							<td>{$log->ip}</td>
							<td>{$loc[$log->ip]}</td>
							<td>{$log->nodeid}</td>
							<td>{$log->node()->name}</td>
						</tr>
					{/foreach}
				</table>
			</div>
		</div>
		
		<div class="12u 12u$(xsmall)">
			{$logs->render()}
		</div>
		
	</div>
</div>




{include file='admin/footer.tpl'}