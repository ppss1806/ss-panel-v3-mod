


{include file='admin/main.tpl'}







	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">工单</h1>
			</div>
		</div>
		<div class="container">
			<div class="col-lg-12 col-sm-12">
				<section class="content-inner margin-top-no">
					
					<div class="card">
						<div class="card-main">
							<div class="card-inner">
								<p>系统中的工单</p>
							</div>
						</div>
					</div>
					
					<div class="table-responsive">
						{$tickets->render()}
                        <table class="table">
                            <tr>
								<th>操作</th>
                                <th>ID</th>
                                <th>日期</th>
                                <th>标题</th>
								<th>用户ID</th>
								<th>用户名</th>
								<th>状态</th>
                            </tr>
                            {foreach $tickets as $ticket}
								{if $ticket->user()!=NULL}
									<tr>
										<td>
											<a class="btn btn-brand" href="/admin/ticket/{$ticket->id}/view">查看</a>
										</td>
										<td>#{$ticket->id}</td>
										<td>{$ticket->datetime()}</td>
										<td>{$ticket->title}</td>
										<td>{$ticket->User()->id}</td>
										<td>{$ticket->User()->user_name}</td>
										{if $ticket->status==1}
										<td>开启</td>
										{else}
										<td>关闭</td>
										{/if}
									</tr>
								{/if}
                            {/foreach}
                        </table>
                        {$tickets->render()}
					</div>
					

							
			</div>
			
			
			
		</div>
	</main>






{include file='admin/footer.tpl'}










