


{include file='admin/main.tpl'}







	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">节点列表</h1>
			</div>
		</div>
		<div class="container">
			<div class="col-lg-12 col-sm-12">
				<section class="content-inner margin-top-no">
					
					<div class="card">
						<div class="card-main">
							<div class="card-inner">
								<p>系统中所有节点的列表。</p>
							</div>
						</div>
					</div>
					
					<div class="table-responsive">
						{$nodes->render()}
						<table class="table ">
                            <tr>
								<th>操作</th>
                                <th>ID</th>
                                <th>节点</th>
								<th>IP</th>
                                <th>加密</th>
                                <th>描述</th>
                                <th>类型</th>
                                
                            </tr>
                            {foreach $nodes as $node}
                            <tr>
								<td>
                                    <a class="btn btn-brand"  {if $node->sort==999}disabled{else}href="/admin/node/{$node->id}/edit"{/if}>编辑</a>
                                    <a class="btn btn-brand-accent" id="delete"  {if $node->sort==999}disabled{else}href="javascript:void(0);" onClick="delete_modal_show('{$node->id}')"{/if}>删除</a>
                                </td>
                                <td>#{$node->id}</td>
                                <td>{$node->name}</td>
								<td>{$node->node_ip}</td>
                                <td>{$node->method}</td>
                                <td>{$node->info}</td>
								{if $node->sort==0}
                                <td>Shadowsocks</td>
								{/if}
								
                                {if $node->sort==1}
                                <td>VPN/Radius基础</td>
								{/if}
								
                                {if $node->sort==2}
                                <td>SSH</td>
								{/if}
								
                                {if $node->sort==3}
                                <td>PAC</td>
								{/if}
								
                                {if $node->sort==4}
                                <td>APN文件外链</td>
								{/if}
								
                                {if $node->sort==5}
                                <td>Anyconnect</td>
								{/if}
								
                                {if $node->sort==6}
                                <td>APN</td>
								{/if}
								
                                {if $node->sort==7}
                                <td>PAC PLUS(Socks 代理生成 PAC文件)</td>
								{/if} 
								
								{if $node->sort==8}
                                <td>PAC PLUS PLUS(HTTPS 代理生成 PAC文件)</td>
								{/if}
								
								{if $node->sort==9}
                                <td>Shadowsocks - 单端口多用户</td>
								{/if}
								
								{if $node->sort==999}
                                <td>系统保留，请勿删除</td>
								{/if}
                                
                            </tr>
                            {/foreach}
                        </table>
						{$nodes->render()}
					</div>
					
					<div class="fbtn-container">
						<div class="fbtn-inner">
							<a class="fbtn fbtn-lg fbtn-brand-accent waves-attach waves-circle waves-light" href="/admin/node/create">+</a>
							
						</div>
					</div>
					
					<div aria-hidden="true" class="modal modal-va-middle fade" id="delete_modal" role="dialog" tabindex="-1">
						<div class="modal-dialog modal-xs">
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
			url:"/admin/node",
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
	$("#delete_input").click(function(){
		delete_id();
	});
})
	
</script>







