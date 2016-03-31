{include file='user/main.tpl'}


<div id="main">
	<div class="inner">
		<!-- Content Header (Page header) -->
		<section>
			<h1>
				流量使用记录
			</h1>
		</section>

		<!-- Main content -->
		<section>
			

				<div class="12u 12u$(medium)">
					<h4>注意!</h4>

                    <p>部分节点不支持流量记录.</p>
					<p>此处只展示最近 72 小时的记录.</p>
				</div>
				
				
				<div class="12u 12u$(medium)">
					<table class="table-wrapper">
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
				
				
				
				
		</section>
		<!-- /.content -->

	</div>
</div>


{include file='user/footer.tpl'}