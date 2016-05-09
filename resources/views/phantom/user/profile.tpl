{include file='user/main.tpl'}


<div id="main">
	<div class="inner">
		<!-- Content Header (Page header) -->
			<h1>
				我的信息
			</h1>
	

	<section>
		<legend>我的帐号</legend>
		<dl class="dl-horizontal">
			<dt>用户名</dt>
			<dd>{$user->user_name}</dd>
			<dt>邮箱</dt>
			<dd>{$user->email}</dd>
		</dl>
		<button class="special fit" href="kill">删除我的账户</button>
		
		
	</section>
	
	</div>
</div>

{include file='user/footer.tpl'}