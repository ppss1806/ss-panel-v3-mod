{include file='admin/main.tpl'}


<div id="main">
	<div class="inner">
		<!-- Content Header (Page header) -->
		<section>
			<h1>
				公告管理
			</h1>
		</section>
		
		<div class="12u 12u$(xsmall)">
			<p> <a class="button special" href="/admin/announcement/create">添加</a> </p>
		</div>
		
		<div class="12u 12u$(xsmall)">
			{$logs->render()}
		</div>
		
		
		<div class="12u 12u$(xsmall)">
			<div class="table-wrapper">
				<table>
					<tr>
						<th>ID</th>
						<th>日期</th>
						<th>内容</th>
						<th>操作</th>
					</tr>
					{foreach $logs as $log}
						<tr>
							<td>#{$log->id}</td>
							<td>{$log->date}</td>
							<td>{$log->content}</td>
							<td>
								<a class="btn btn-info btn-sm" href="/admin/announcement/{$log->id}/edit">编辑</a>
								<a class="btn btn-danger btn-sm" id="delete" value="{$log->id}" href="/admin/announcement/{$log->id}/delete">删除</a>
							</td>
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