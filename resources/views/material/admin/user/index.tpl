{include file='admin/main.tpl'}







	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">用户列表</h1>
			</div>
		</div>
		<div class="container">
			<div class="col-lg-12 col-lg-push-0 col-sm-10 col-sm-push-1">
				<section class="content-inner margin-top-no">
					
					<div class="card">
						<div class="card-main">
							<div class="card-inner">
								<p>系统中所有用户的列表。</p>
							</div>
						</div>
					</div>
					
					<div class="table-responsive">
						{$users->render()}
                        <table class="table">
                            <tr>
								<th>操作</th>
                                <th>ID</th>
								<th>用户名(备注)</th> 
								<th>邮箱</th>
                                <th>端口</th>
                                <th>状态</th>
                                <th>加密方式</th>
                                <th>已用流量/总流量</th>
								<th>今日流量</th>
                                <th>最后在线时间</th>
                                <th>最后签到时间</th>
								<th>在线 IP</th>
								<th>联络方式</th>
								<th>注册时间和IP</th>
                                <th>邀请者</th>
                                
                            </tr>
                            {foreach $users as $user}
                            <tr>
								<td>
                                    <a class="btn btn-brand" href="/admin/user/{$user->id}/edit">编辑</a>
                                    <a class="btn btn-brand-accent" id="delete" value="{$user->id}" href="/admin/user/{$user->id}/delete">删除</a>
                                </td>
                                <td>#{$user->id}</td>
								<td>{$user->user_name}
								{if $user->remark!=""}
									({$user->remark})
								{/if}
								</td>
								
                                <td>{$user->email}</td>
                                <td>{$user->port}</td>
                                <td>{$user->enable}</td>
                                <td>{$user->method}</td>
                                <td>{$user->usedTraffic()}/{$user->enableTraffic()}</td>
								<td>{(($user->u+$user->d)-$user->last_day_t)/1024/1024}MB</td>
                                <td>{$user->lastSsTime()}</td>
                                <td>{$user->lastCheckInTime()}</td>
								<td>{foreach $userip[$user->id] as $singleip => $location}{$singleip} {$location}<br>{/foreach}</td>
								<th>
								{if $user->im_type==1}
								微信
								{/if}
								
								{if $user->im_type==2}
								QQ
								{/if}
								
								{if $user->im_type==3}
								Google+
								{/if}
								
								{$user->im_value}</th>
								<th>{$user->reg_date}<br>{$user->reg_ip}　{$regloc[$user->id]}</th>
                                <th>{$user->ref_by}</th>
                                
                            </tr>
                            {/foreach}
                        </table>
                        {$users->render()}
					</div>

							
			</div>
			
			
			
		</div>
	</main>






{include file='admin/footer.tpl'}









