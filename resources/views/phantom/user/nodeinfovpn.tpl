{include file='user/main.tpl'}

<div id="main">
	<div class="inner">
		<!-- Content Header (Page header) -->
		<section>
			<h1>
				节点信息
			</h1>
		</section>

		<!-- Main content -->
		<section>
			

				<div class="12u 12u$(medium)">
					<h4>注意!</h4>

                    <p>下面为您的 VPN 配置</p>
				</div>
				
				
				<div class="12u 12u$(medium)">
					<h3>配置信息</h3>
					
					{$json_show}
				</div>
				
				
				
				
		</section>
		<!-- /.content -->

	</div>
</div>

{include file='user/footer.tpl'}
