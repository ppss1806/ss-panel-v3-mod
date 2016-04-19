


{include file='admin/main.tpl'}







	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">公告管理</h1>
			</div>
		</div>
		<div class="container">
			<div class="col-lg-12 col-lg-push-0 col-sm-10 col-sm-push-1">
				<section class="content-inner margin-top-no">
					
					<div class="card">
						<div class="card-main">
							<div class="card-inner">
								<p>系统中所有公告。</p>
							</div>
						</div>
					</div>
					
					<div class="table-responsive">
						{$logs->render()}
                        <table class="table">
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
										<a class="btn btn-brand" href="/admin/announcement/{$log->id}/edit">编辑</a>
										<a class="btn btn-brand-accent" id="delete" value="{$log->id}" href="/admin/announcement/{$log->id}/delete">删除</a>
									</td>
                                </tr>
                            {/foreach}
                        </table>
                        {$logs->render()}
					</div>
					
					<div class="fbtn-container">
						<div class="fbtn-inner">
							<a class="fbtn fbtn-lg fbtn-brand-accent waves-attach waves-circle waves-light" href="/admin/announcement/create">+</a>
							
						</div>
					</div>

							
			</div>
			
			
			
		</div>
	</main>






{include file='admin/footer.tpl'}










