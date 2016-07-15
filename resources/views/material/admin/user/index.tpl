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
					
					
					<div class="card">
						<div class="card-main">
							<div class="card-inner">
								<div class="form-group form-group-label">
									<label class="floating-label" for="search"> 输入邮箱或部分文字进行模糊搜索 </label>
									<input class="form-control" id="search" type="text">
								</div>
							</div>
							<div class="card-action">
								<div class="card-action-btn pull-left">
									<a class="btn btn-flat waves-attach waves-light" id="search_button"><span class="icon">search</span>&nbsp;搜索</a>
								</div>
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
                                    <a class="btn btn-brand-accent" href="javascript:void(0);" onClick="delete_modal_show('{$user->id}')">删除</a>
                                </td>
                                <td>#{$user->id}</td>
								<td>{$user->user_name}
								{if $user->remark!=""}
									({$user->remark})
								{/if}
								</td>
								
                                <td>{$user->email}</td>
                                <td>{$user->port}</td>
								{if $user->enable==1}
                                <td>可用</td>
								{else}
								<td>禁用</td>
								{/if}
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
					
					<div aria-hidden="true" class="modal fade" id="delete_modal" role="dialog" tabindex="-1">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-heading">
									<a class="modal-close" data-dismiss="modal">×</a>
									<h2 class="modal-title">确认要删除？</h2>
								</div>
								<div class="modal-inner">
									<p>请您确认。</p>
								</div>
								<div class="modal-footer">
									<p class="text-right"><button class="btn btn-flat btn-brand-accent waves-attach waves-effect" data-dismiss="modal" type="button">取消</button><button class="btn btn-flat btn-brand-accent waves-attach" data-dismiss="modal" id="delete_input" type="button">确定</button></p>
								</div>
							</div>
						</div>
					</div>
					
					{include file='dialog.tpl'}

							
			</div>
			
			
			
		</div>
	</main>






{include file='admin/footer.tpl'}


<script>
function delete_modal_show(id) {
	deleteid=id;
	$("#delete_modal").modal();
}


$(document).ready(function(){
	function delete_id(){
		$.ajax({
			type:"DELETE",
			url:"/admin/user",
			dataType:"json",
			data:{
				id: deleteid
			},
			success:function(data){
				if(data.ret){
					$("#result").modal();
					$("#msg").html(data.msg);
					window.setTimeout("location.href=window.location.href", {$config['jump_delay']});
				}else{
					$("#result").modal();
					$("#msg").html(data.msg);
				}
			},
			error:function(jqXHR){
				$("#result").modal();
				$("#msg").html(data.msg+"  发生错误了。");
			}
		});
	}
	
	function search(){
		window.location="/admin/user/search/"+$("#search").val();
	}
	
	$("#delete_input").click(function(){
		delete_id();
	});
	
	$("#search_button").click(function(){
		if($("#search").val()!="")
		{
			search();
		}
	});
})


</script>






