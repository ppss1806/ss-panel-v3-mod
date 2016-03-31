{include file='admin/main.tpl'}


<div id="main">
	<div class="inner">
		<!-- Content Header (Page header) -->
		<section>
			<h1>
				兑换码管理
			</h1>
		</section>
		
		<div class="12u 12u$(xsmall)">
			<p> <a class="button special" href="/admin/code/create">添加</a> </p>
		</div>
		
		<div class="12u 12u$(xsmall)">
			{$codes->render()}
		</div>
		
		
		<div class="12u 12u$(xsmall)">
			<div class="table-wrapper">
				<table>
					<tr>
						<th>ID</th>
						<th>代码</th>
						<th>类型</th>
						<th>操作</th>
						<th>是否已被使用</th>
						<th>用户id</th>
						<th>使用时间</th>
						
					</tr>
					{foreach $codes as $code}
						<tr>
							<td>#{$code->id}</td>
							<td>{$code->code}</td>
							{if $code->type==10001}
							<td>流量充值</td>
							{/if}
							{if $code->type==10002}
							<td>用户续期</td>
							{/if}
							{if $code->type>=1&&$code->type<=10000}
							<td>等级续期 - 等级{$code->type}</td>
							{/if}
							{if $code->type==10001}
							<td>充值 {$code->number} GB 流量</td>
							{/if}
							{if $code->type==10002}
							<td>延长账户有效期 {$code->number} 天</td>
							{/if}
							{if $code->type>=1&&$code->type<=10000}
							<td>延长等级有效期 {$code->number} 天</td>
							{/if}
							{if $code->isused}
							<td>已使用</td>
							{else}
							<td>未使用</td>
							{/if}
							<td>{$code->userid}</td>
							{if $code->usedatetime=="1989-06-04 02:30:00"}
							<td>未使用</td>
							{else}
							<td>{$code->usedatetime}</td>
							{/if}
						</tr>
					{/foreach}
				</table>
			</div>
		</div>
		
		<div class="12u 12u$(xsmall)">
			{$codes->render()}
		</div>
		
	</div>
</div>


{include file='admin/footer.tpl'}