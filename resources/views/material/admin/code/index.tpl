




{include file='admin/main.tpl'}







	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">充值码管理</h1>
			</div>
		</div>
		<div class="container">
			<div class="col-lg-12 col-lg-push-0 col-sm-10 col-sm-push-1">
				<section class="content-inner margin-top-no">
					
					<div class="card">
						<div class="card-main">
							<div class="card-inner">
								<p>系统中所有充值码。</p>
							</div>
						</div>
					</div>
					
					<div class="table-responsive">
						{$codes->render()}
                        <table class="table">
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
									{if $code->type==-1}
                                    <td>金额充值</td>
									{/if}
                                    {if $code->type==10001}
                                    <td>流量充值</td>
									{/if}
									{if $code->type==10002}
                                    <td>用户续期</td>
									{/if}
									{if $code->type>=1&&$code->type<=10000}
                                    <td>等级续期 - 等级{$code->type}</td>
									{/if}
									{if $code->type==-1}
                                    <td>充值 {$code->number} 元</td>
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
                        {$codes->render()}
					</div>
					
					
					<div class="fbtn-container">
						<div class="fbtn-inner">
							<a class="fbtn fbtn-lg fbtn-brand-accent waves-attach waves-circle waves-light" href="/admin/code/create">+</a>
							
						</div>
					</div>

							
			</div>
			
			
			
		</div>
	</main>






{include file='admin/footer.tpl'}










